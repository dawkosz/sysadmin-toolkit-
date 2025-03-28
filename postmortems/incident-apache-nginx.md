# 💥 Incydent #001: Apache vs Nginx – Konflikt o port 80

## 🔍 Objawy
- Aplikacja na `https://portal.klientcorp.io` przestała działać
- Użytkownicy widzieli timeout (brak odpowiedzi z serwera)
- `ping` do hosta: brak odpowiedzi  
- `nmap -p 22`: port otwarty, host działa  
- `systemctl status apache2`: Apache nie działa  
- `ss -tuln`: port 80 zajęty przez nginx

## 💣 Przyczyna
- Cron certbota wykonywał `systemctl reload nginx` po odnowieniu certów  
- Apache miał osobny cron do reloadu co 5 minut  
- Port 80 zajęty, obie usługi restartowały się i blokowały nawzajem  
- Aplikacja nie mogła wystartować poprawnie

## 🔧 Rozwiązanie
1. `kill nginx` – zatrzymanie nginx, który trzymał port 80  
2. `systemctl reload apache2` – uruchomienie Apache  
3. `apt purge nginx` – usunięcie nginx z systemu  
4. Usunięcie crona `apache-reloader`  
5. Ustawienie bezpiecznego crona na reload Apache raz w tygodniu o 3:30

## ✅ Wnioski
- Certbot powinien być przypisany do konkretnego webserwera (apache/nginx)  
- Port 80 nie wybacza konfliktów  
- Cron może robić ciche zamieszanie, jeśli nie jest monitorowany  
- Dokumentacja zmian w cronie = złoto  
