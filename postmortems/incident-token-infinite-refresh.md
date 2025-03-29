# 💥 Incydent #005: Zapętlony token refresher – 300% CPU i brak snu

## 🔍 Objawy
- Użytkownicy zgłaszali "lagi" i niestabilność aplikacji
- `htop` pokazał 3 procesy `api_worker.py` z >100% CPU każdy
- `df -h` i `swap` były w normie
- Monitoring Prometheus pokazywał skoki load average powyżej 7.0
- Aplikacja działała, ale z ogromnymi opóźnieniami

## 💣 Przyczyna
- Skrypt `api_worker.py` miał nieskończoną pętlę (`while True`) z zapytaniem do `/refresh-token`
- Cron odpalał ten skrypt co minutę + przy każdym restarcie systemu
- Brak timeoutów w zapytaniu → wiszące requesty
- Brak limitu prób
- Skrypt pobrany przez `curl` z Gist i zapisany ręcznie do `/opt/app/workers`

## 🔧 Rozwiązanie
1. Zidentyfikowano procesy przez `ps aux | grep api_worker.py`  
2. `crontab -e` → zakomentowano wpisy `@reboot` i `* * * * *`  
3. `kill` trzech procesów `api_worker.py`  
4. Kod został poprawiony:
   - dodano timeout
   - maksymalna liczba prób = 10
   - `break` przy sukcesie
5. Zaktualizowano wersję na serwerze
6. Monitoring load average wrócił do normy

## ✅ Wnioski
- `while True` + brak kontroli = gotowy przepis na katastrofę
- Cron bez logiki w kodzie może dosłownie zabić serwer
- `grep`, `htop`, `bash_history` – szybka diagnostyka zagrożenia
- Warto przeglądać i walidować zewnętrzne skrypty PRZED uruchomieniem
- ChatGPT jako „dev z zewnątrz” = realne narzędzie do kod-review w sytuacji kryzysowej 😏

---

📅 Data: 2025-03-27
