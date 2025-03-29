# 💥 Incydent #003: Backupy zjadły cały dysk – 100% na /dev/sda1

## 🔍 Objawy
- Aplikacja przestała zapisywać dane
- `500 Internal Server Error` na endpointach API
- W logach aplikacji: `IOError: No space left on device`
- `df -h` pokazuje 100% zajętości `/`
- Działająca sieć, porty aktywne, CPU spokojne

## 💣 Przyczyna
- Codzienny `cron` robił backup bazy i plików aplikacji do katalogu `/opt`
- Brak rotacji backupów → backupy z 30 dni × 2GB = 😬
- Brak alertu na zapełnienie dysku
- Pliki `dbdump-*.sql` i `backup-*.tar.gz` zalegały bez limitu

## 🔧 Rozwiązanie
1. `du -sh /opt/*` → zidentyfikowano backupy jako główne źródło problemu  
2. Tymczasowo usunięto najstarsze backupy (ręcznie `rm`)  
3. Dodano rotację przez `find` i `-mtime +7 -delete`  
4. Skrypt backupu został poprawiony: kompresja SQL (`gzip`) + retencja  
5. Dodano alertowanie w monitoringu na zajętość dysku powyżej 85%

## ✅ Wnioski
- Backupy są super… dopóki nie robią DoS-a na `df -h`
- Retencja i `find -delete` to absolutny mus w cronie
- `df -h`, `du -sh *` i `ncdu` – szybka diagnoza jak dysk płonie
- Nie trzymaj backupów w `/` jeśli nie masz osobnego mounta

---

🧠 Autor: dawkosz  
📅 Data: 2025-03-27  
