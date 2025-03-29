# Incydent #007: Aplikacja działa ręcznie, ale nie startuje przez systemd

## Objawy

- Po restarcie serwera aplikacja się nie uruchomiła automatycznie
- `systemctl status myapp` zwracał błąd
- Ręczne uruchomienie `python3 main.py` działało bez problemu
- QA zgłosiło: „Aplikacja nie działa po nocnym update”

## Przyczyna

- W pliku `myapp.service`, pole `ExecStart` miało:

  ```ini
  ExecStart=/usr/bin/python3 main.py
  ```

- Systemd nie wykonuje `cd` do `WorkingDirectory`, dlatego `main.py` nie został znaleziony:

  ```
  /usr/bin/python3: can't open file 'main.py': [Errno 2] No such file or directory
  ```

- Brak pełnej ścieżki spowodował błąd `status=2/INVALIDARGUMENT`

## Rozwiązanie

1. Edytowano plik serwisu:

   ```bash
   nano /etc/systemd/system/myapp.service
   ```

   Zmieniono:
   ```ini
   ExecStart=/usr/bin/python3 main.py
   ```
   na:
   ```ini
   ExecStart=/usr/bin/python3 /opt/myapp/main.py
   ```

2. Przeładowano konfigurację:

   ```bash
   systemctl daemon-reexec
   systemctl daemon-reload
   ```

3. Uruchomiono usługę:

   ```bash
   systemctl restart myapp
   ```

4. Zweryfikowano działanie:

   ```bash
   systemctl status myapp
   journalctl -u myapp --since "5 min ago"
   ```

5. Wynik:
   - Aplikacja wystartowała poprawnie
   - Logi potwierdziły uruchomienie
   - QA zgłosiło rozwiązanie problemu

## Wnioski

- `ExecStart` w systemd musi mieć absolutną ścieżkę do pliku wykonywalnego
- `WorkingDirectory` nie zastępuje konieczności podania pełnej ścieżki
- `journalctl -u [nazwa]` to podstawowe źródło diagnostyki
- Po każdej zmianie pliku `.service` trzeba wykonać `daemon-reload`
- Warto testować jednostki systemd przed restartem serwera

Autor: dawkosz  
Data: 2025-03-27
