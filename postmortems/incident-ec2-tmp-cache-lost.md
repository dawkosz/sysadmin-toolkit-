# Incydent #013: EC2 – Aplikacja działa, ale dane zniknęły po restarcie

## Objawy

- Po restarcie EC2 aplikacja uruchamia się poprawnie
- Ale: cache, pliki tymczasowe lub dane aplikacji zniknęły
- Aplikacja np. loguje brak danych albo tworzy wszystko od zera

## Przyczyna

1. Instancja EC2 została zrestartowana przez `stop/start`, a nie `reboot`
2. Aplikacja zapisywała dane tymczasowe do:
   - `/tmp` (często czyszczone przy starcie)
   - `tmpfs` (RAM dysk – reset = dane znikają)
3. Nie było trwałego storage (EBS lub S3) przypisanego do zapisu danych

## Diagnoza – krok po kroku

### 1. Sprawdzono, czy EC2 była zatrzymana (stop/start)

```bash
aws ec2 describe-instances \
  --instance-ids i-xxxxxxx \
  --query "Reservations[].Instances[].StateTransitionReason"
```

📄 Wynik:

```
"User initiated (2025-03-27 15:07:24 GMT)"
```

✅ To był `stop/start` – dane w `/tmp` lub RAM nie są gwarantowane

---

### 2. Sprawdzono, gdzie aplikacja zapisuje dane

```bash
cat /etc/systemd/system/myapp.service
```

📄 Wskazuje na katalog `/tmp/myapp-cache` → potencjalnie nietrwały

---

### 3. Sprawdzono, czy `/tmp` to RAM-dysk

```bash
mount | grep /tmp
```

📄 Wynik:

```
tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
```

🟥 To RAM – dane tracone przy każdym restarcie

---

## Rozwiązanie

- Zmieniono lokalizację cache z `/tmp` → `/var/lib/myapp/`
- Zweryfikowano, że `/var/lib` znajduje się na trwałym dysku (EBS)
- Alternatywnie: skonfigurowano zewnętrzny cache (Redis/S3)

---

## Wnioski

- EC2 „restart” przez `stop/start` może przenieść instancję na inny host → nie ma gwarancji zachowania danych tymczasowych
- `tmpfs` to RAM, nie dysk – idealne na szybkość, nie do przechowywania
- Aplikacje powinny:
  - korzystać z trwałego storage (`/var/lib`, `/mnt/data`, EBS, S3)
  - traktować `/tmp` tylko jako miejsce *tymczasowe i jednorazowe*
- Warto dokumentować, gdzie aplikacja zapisuje pliki i jak się zachowuje po restarcie

Autor: dawkosz  
Data: 2025-03-27
