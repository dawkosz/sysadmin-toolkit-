# 🧭 Admin Quick Onboarding – Mini wersja

Cześć!  
Jeśli masz dostęp do tego repo lub serwera – oto kilka rzeczy, które powinieneś znać na dzień dobry:

---

## 📁 Główne foldery repo

- `cron/` – Crontaby: backup, cleanup
- `scripts/` – Skrypty do ręcznego odpalenia
- `postmortems/` – Nasze lekcje po incydentach
- `docs/` – Checklisty, onboarding, dobre praktyki

---

## 🛠️ Podstawowe komendy na start

```bash
df -h                # Sprawdź, czy nie kończy się miejsce
ss -tuln             # Kto trzyma jakie porty
ps aux --sort=-%cpu  # Co zjada CPU
journalctl -xe       # Ostatnie błędy w systemie

🔐 Zasady bezpieczeństwa
	•	🔑 Używamy tylko kluczy SSH
	•	🔒 Brak root logowania przez hasło
	•	🔁 Cron ma rotację plików – nie ruszaj jeśli nie rozumiesz 😉
✅ Co warto wiedzieć
	•	Skrypty backupu → cron/web-backup-cleanup.cron
	•	Setup nowego usera i ssh → scripts/first-login-setup.sh
	•	Wszystkie incydenty opisujemy w postmortems/
“Zapytaj zanim klikniesz, bo czasem klik to 4 godziny nocnej walki z portem 80 😅”

--dejvvv
