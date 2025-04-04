# Incydent #012: EC2 z publicznym IP, ale brak dostępu przez SSH (timeout)

## Objawy

- Nowo utworzona instancja EC2 (np. Ubuntu) w AWS
- Ma przypisany publiczny adres IP
- Klucz PEM poprawny
- Próba połączenia:

  ```bash
  ssh -i my-key.pem ubuntu@x.x.x.x
  ```

  ❌ Wynik:

  ```
  ssh: connect to host x.x.x.x port 22: Connection timed out
  ```

- Na samej instancji `curl localhost` działa
- Aplikacja działa, ale nie można połączyć się z zewnątrz

---

## Przyczyna

Brak reguły w **Security Group AWS**, która pozwala na połączenie na port 22 z zewnątrz.

> W AWS każdy EC2 ma przypisaną Security Group – to taki wbudowany firewall na poziomie sieci.  
> Jeśli nie dodasz do niej reguły `tcp:22` (SSH) z `0.0.0.0/0`, nikt nie połączy się przez SSH – nawet jeśli masz publiczne IP.

---

## Rozwiązanie

### 1. Sprawdzono przypisaną Security Group

```bash
aws ec2 describe-instances \
  --instance-ids i-xxxxxxxxxxxxxxxxx \
  --query "Reservations[].Instances[].SecurityGroups" \
  --region eu-central-1
```

📄 Wynik:

```json
[
  {
    "GroupName": "default",
    "GroupId": "sg-0123abc456def"
  }
]
```

---

### 2. Sprawdzono reguły Security Group

```bash
aws ec2 describe-security-groups \
  --group-ids sg-0123abc456def \
  --region eu-central-1 \
  --query "SecurityGroups[].IpPermissions"
```

📄 Wynik:

```json
[]
```

❌ Brak reguł = wszystko zablokowane

---

### 3. Dodano regułę dla portu 22 (SSH)

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-0123abc456def \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0 \
  --region eu-central-1
```

🟢 `--cidr 0.0.0.0/0` = pozwala wszystkim (z internetu) na połączenie przez port 22  
🛡️ W produkcji można to ograniczyć np. do IP biura: `--cidr 123.123.123.0/24`

---

## Wnioski

- Publiczny IP ≠ dostęp do maszyny
- W AWS wszystko jest domyślnie zamknięte – potrzebne reguły w Security Groups
- Brak reguły `tcp:22` w SG = brak SSH
- `describe-instances` + `describe-security-groups` to podstawowe komendy diagnostyczne

Autor: dawkosz  
Data: 2025-03-27
