# 🧭 AWS Onboarding – pierwsza instancja EC2 z dostępem SSH

Krótki przewodnik jak utworzyć maszynę EC2 w AWS z dostępem przez SSH, otwartym portem (np. do aplikacji) i minimalnym bezpieczeństwem.

---

## 📦 Wymagania wstępne

- Konto AWS
- Zainstalowane i skonfigurowane AWS CLI (`aws configure`)
- Klucz SSH (`.pem`) stworzony lub gotowy

---

## 🛠️ Krok 1: Tworzymy parę kluczy (jeśli nie masz)

```bash
aws ec2 create-key-pair \
  --key-name my-key \
  --query "KeyMaterial" \
  --output text > my-key.pem
chmod 400 my-key.pem
```

🔐 Klucz prywatny zostanie zapisany lokalnie → potrzebny do SSH

---

## ☁️ Krok 2: Tworzymy Security Group

```bash
aws ec2 create-security-group \
  --group-name web-access \
  --description "Allow SSH and app port" \
  --vpc-id vpc-xxxxxxxx
```

📄 Dodajemy reguły:

```bash
aws ec2 authorize-security-group-ingress \
  --group-name web-access \
  --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-name web-access \
  --protocol tcp --port 3000 --cidr 0.0.0.0/0
```

---

## 🚀 Krok 3: Tworzymy instancję EC2

```bash
aws ec2 run-instances \
  --image-id ami-xxxxxx \
  --count 1 \
  --instance-type t2.micro \
  --key-name my-key \
  --security-groups web-access \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=my-first-ec2}]'
```

📌 `--image-id`: użyj np. Ubuntu 22.04 (sprawdź aktualny AMI ID dla regionu)

---

## 🔍 Krok 4: Pobieramy IP i łączymy się

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=my-first-ec2" \
  --query "Reservations[].Instances[].PublicIpAddress" \
  --output text
```

Potem:

```bash
ssh -i my-key.pem ubuntu@X.X.X.X
```

✅ Masz dostęp do maszyny!

---

## 🛠️ Krok 5: Uruchamianie aplikacji

```bash
sudo apt update && sudo apt install -y python3
python3 -m http.server 3000
```

Z innego komputera:

```bash
curl http://X.X.X.X:3000
```

---

## 🧠 Wskazówki

- Publiczny IP możesz zablokować po testach
- Porty warto ograniczyć do znanych adresów (`--cidr 1.2.3.4/32`)
- Zawsze używaj `.pem` z `chmod 400`

---

> To jest mój podstawowy setup startowy w AWS – idealny do testów i nauki.  
> Dla produkcji – używaj Elastic IP, lepszych reguł SG i IAM.

Autor: dawkosz  
