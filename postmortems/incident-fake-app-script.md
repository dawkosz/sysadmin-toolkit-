# Incydent #008: Aplikacja wyglądała jak aplikacja, ale była skryptem demo

## Objawy

- Aplikacja działała po deployu, ale tylko przez ~30 sekund
- `systemctl status myapp` → stan: `exited`
- `journalctl` nie wykazywał błędów, tylko:
  ```
  myapp.service: Succeeded.
  ```
- Ręczne uruchomienie `python3 main.py` działało — ale... też kończyło się po chwili

## Przyczyna

- Plik `main.py` zawierał kod testowy:

  ```python
  import time

  def startup():
      print("App starting...")
      time.sleep(3)
      print("Listening on port 8000")
      time.sleep(30)
      print("Shutting down...")
  ```

- Skrypt nie tworzył serwera, nie nasłuchiwał, nie miał `while`, `app.run()` ani `uvicorn`
- Systemd widział „poprawne zakończenie” i uznawał usługę za zakończoną sukcesem
- Finalnie: zamiast backendu z endpointami dostaliśmy demówkę z `sleep()`

## Rozwiązanie

1. Przejrzano zawartość `main.py`
2. Wysłano pytanie do devów → potwierdzenie: *“to placeholder, zapomnieliśmy podmienić”*
3. Wgrano właściwą wersję aplikacji
4. Restart:

   ```bash
   systemctl restart myapp
   systemctl status myapp
   ```

5. Aplikacja działa poprawnie i pozostaje aktywna

## Wnioski

- Pliki `.py` nie muszą być tym, czym się wydają
- `systemctl status` + `journalctl` to fundament przy „cichym exit”
- Kod mockujący backend powinien być oznaczony
- Nie deployuj demówek jako produkcyjny `main.py`

Autor: dawkosz  
Data: 2025-03-27
