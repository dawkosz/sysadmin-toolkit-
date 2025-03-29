# 💥 Incydent #004: Aplikacja działa lokalnie, ale z zewnątrz nie

## 🔍 Objawy
- Na serwerze: `curl localhost` → aplikacja odpowiada
- Z zewnątrz: timeout, brak odpowiedzi, brak strony
- Brak błędów w logach aplikacji
- Porty otwarte lokalnie (`ss -tuln`), ale `nmap` z zewnątrz nie pokazuje portu
- `ping` działa, `curl` nie

## 💣 Przyczyna
- Aplikacja (np. backend) działała tylko na `127.0.0.1`, nie `0.0.0.0`
- `nginx` reverse proxy nasłuchiwał na `0.0.0.0`, ale nie przekierowywał poprawnie
- Firewall (np. `ufw`) miał otwarty tylko port 22
- Brak reguły dla 80/443

## 🔧 Rozwiązanie
1. Zmieniono `gunicorn`/`uvicorn` bind na `0.0.0.0`  
2. Dodano reguły do firewalla:
   ```bash
   ufw allow 80
   ufw allow 443
   ufw reload

