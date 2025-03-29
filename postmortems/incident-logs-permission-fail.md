# 💥 Incydent #006: Cisza w logach – katalog nie ten

## 🔍 Objawy
- Aplikacja działa, odpowiada, ale… nie zapisuje żadnych logów
- Brak błędów w `journalctl` ani `systemctl status`
- Katalog `/var/log/myapp/` istnieje, ale plik `app.log` się nie tworzy
- Użytkownik aplikacji to `myapp`

## 💣 Przyczyna
- Katalog `/var/log/myapp/` należał do `root:root`
- Aplikacja jako `myapp` nie miała uprawnień do pisania
- Pythonowy logger próbował pisać, ale nie mógł — i nie logował błędu
- W efekcie: cisza, ale zero logów

## 🔧 Rozwiązanie
1. Zmieniono właściciela katalogu logów:
   ```bash
   chown -R myapp:myapp /var/log/myapp/
