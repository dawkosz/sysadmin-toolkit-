# 🧰 sysadmin-toolkit

Zestaw narzędzi, skryptów i udokumentowanych incydentów z życia administratora systemów / DevOpsa.

To moje prywatne repozytorium, które rozwijam jako dokumentację przypadków, z jakimi pracuję lub które analizuję. Znajdziesz tu:
- skrypty (bash, crontab, systemd)
- gotowe rozwiązania typowych problemów
- postmortemy (analiza + rozwiązanie + wnioski)
- elementy DevOpsowe, chmurowe i infrastrukturalne

Repozytorium służy mi jako:
- notatnik i baza wiedzy
- proof-of-skill
- portfolio DevOps / SysAdmin

---

## 📂 Struktura repozytorium

```
postmortems/         # opisy incydentów + ich analiza
scripts/             # skrypty narzędziowe (bash, cron, deploy)
docs/                # cheatsheet'y, checklisty, notatki
```

---

## 💥 Incydenty techniczne

✅ Oparte o rzeczywiste scenariusze  
✅ Pokazują jak diagnozować, a nie tylko „naprawiać”  
✅ Każdy ma: Objawy / Przyczynę / Rozwiązanie / Wnioski

Przykłady:

- #001 – Cron zapętla skrypt tokenów
- #005 – `while True` + brak limitów = 300% CPU
- #006 – brak logów przez `chmod 700` na katalogu
- #007 – `ExecStart` bez ścieżki w systemd
- #008 – skrypt `sleep(30)` zamiast backendu 🤯
- #009 – GCP firewall zablokował aplikację po restarcie
- #010 – EC2 bez key-pair → odzysk przez snapshot

📄 Zobacz wszystkie: [`postmortems/`](postmortems/)

---

## 🛠️ Skrypty

Znajdują się w `scripts/`.  
Zawierają:

- `backup-and-clean.sh` – cron backup z automatycznym czyszczeniem starszych archiwów
- `daily-check.sh` – (w planach) diagnostyka CPU, RAM, usługi, porty

---

## 🌩️ Cloud – GCP + AWS

Repozytorium zawiera rzeczywiste i symulowane przypadki związane z debugowaniem, konfiguracją i utrzymaniem infrastruktury chmurowej.

Obecnie rozwijam swój DevOpsowy toolset z naciskiem na GCP oraz AWS – pracuję m.in. z:
- dostępem do instancji EC2 i Compute Engine
- firewallami (Security Groups, VPC Rules)
- procesami odzyskiwania systemów (snapshot, EBS recovery)
- SSH/keypair logic
- CLI (`gcloud`, `aws`)

📘 [Cloud Cheatsheet – GCP + AWS](docs/cloud-cheatsheet.md)  
📄 [Postmortem #009 – GCP Firewall](postmortems/incident-gcp-firewall-block.md)  
📄 [Postmortem #010 – AWS EC2 key-pair recovery](postmortems/incident-ec2-keypair-lost.md)

---

## 🧠 Stack i narzędzia

- Bash, crontab
- systemd
- `ss`, `ps`, `htop`, `journalctl`
- `aws` CLI, `gcloud` CLI
- Linux (Debian/Ubuntu), SSH, VM
- Markdown jako forma dokumentacji technicznej

---

## 🧾 Licencja

MIT – możesz korzystać, inspirować się, rozwijać dalej.  
Będę wdzięczny za kredyt/autora jeśli coś wykorzystasz 🙏

---

## 🤖 Wsparcie AI

Część treści (formatowanie, cheatsheety, porządkowanie struktury plików, przykładowe opisy) została przygotowana lub dopracowana przy wsparciu ChatGPT.

To nadal moje repozytorium, pomysły i doświadczenia – ChatGPT służył jako narzędzie wspierające pisanie techniczne, diagnostykę i organizację wiedzy.

---


## ✍️ Autor

**dawkosz**  
sysadmin → devops-in-progress  
dokumentuję, debuguję, działam
