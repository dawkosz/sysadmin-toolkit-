# 🔐 Security Checklist – Linux Server

Podstawowa lista rzeczy do sprawdzenia / wdrożenia na serwerze produkcyjnym lub VPS.

## 🛠️ System & Uprawnienia

- [ ] Zaktualizowany system (`apt update && apt upgrade`)
- [ ] Usunięcie nieużywanych pakietów (`apt autoremove`)
- [ ] Wyłączone konto `root` (lub tylko klucz, bez hasła)
- [ ] Zmiana domyślnych portów (SSH itd.)
- [ ] Ograniczenie `sudo` tylko do zaufanych użytkowników

## 🔑 SSH & Dostęp

- [ ] Tylko uwierzytelnianie przez klucz (`PasswordAuthentication no`)
- [ ] Zmieniony port SSH (opcjonalnie)
- [ ] Fail2Ban skonfigurowany
- [ ] Logowanie wszystkich prób SSH (`/var/log/auth.log`)
- [ ] `AllowUsers` lub `AllowGroups` w `sshd_config`

## 🔒 Aplikacje i sieć

- [ ] Firewalle (`ufw` / `iptables`)
- [ ] Blokada nieużywanych portów
- [ ] Ograniczony dostęp do paneli admina (np. tylko z VPN)
- [ ] TLS/SSL z certyfikatami Let’s Encrypt
- [ ] Monitoring ruchu (`netstat`, `ss`, `iftop`, `nethogs`)

## 📦 Dodatki

- [ ] Regularne backupy (i test ich przywracania)
- [ ] Zaszyfrowany dysk (jeśli to laptop / lokalna maszyna)
- [ ] System plików z `noexec` / `nosuid` tam, gdzie ma sens
