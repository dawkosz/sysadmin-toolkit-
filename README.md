# 🧰 Sysadmin Toolkit

Zestaw narzędzi, scenariuszy, skryptów i post-mortemów oparty na realnych incydentach z życia administratora sieci i systemów.

Stworzony z myślą o tym, żeby nie tylko **naprawiać**, ale też **uczyć się, dokumentować i przewidywać.**  
To repozytorium rośnie wraz z doświadczeniem.

---

## 📁 Zawartość

| Folder | Zawartość |
|--------|-----------|
| `cron/` | Crontaby, automatyczne backupy i czyszczenie |
| `scripts/` | Skrypty administracyjne: backupy, cleanupy, testy |
| `postmortems/` | Opisane incydenty z życia – objawy, przyczyny, rozwiązania |
| `docs/` | Checklisty, dobre praktyki, dokumentacja |

## 🌩️ Cloud – GCP + AWS

Repozytorium zawiera rzeczywiste i symulowane przypadki związane z debugowaniem, konfiguracją i utrzymaniem infrastruktury chmurowej.

Obecnie rozwijam swój DevOpsowy toolset z naciskiem na GCP oraz AWS – pracuję m.in. z:
- dostępem do instancji EC2 i Compute Engine
- firewallami (Security Groups, VPC Rules)
- procesami odzyskiwania systemów (snapshot, EBS recovery)
- SSH/keypair logic
- CLI (`gcloud`, `aws`)

Wszystkie scenariusze w repo dokumentują typowe problemy i rozwiązania, z którymi może zetknąć się DevOps pracujący z maszynami wirtualnymi w chmurze.


---

## 📚 Przykładowe incydenty

- **#001 – Apache vs Nginx**: Konflikt o port 80, walka certbota z cronem  
- **#002 – Gunicorn CPU 200%** *(coming soon...)*  
- **#003 – Backupy zjadły cały dysk** *(work in progress)*  

---

## 💡 Po co to?

- 🧠 Żeby pokazać, jak myślę i działam w sytuacjach kryzysowych  
- 🛠️ Żeby tworzyć własną bazę wiedzy i doświadczenia  
- 📂 Żeby inni mogli się zainspirować lub skorzystać  
- 💼 Dla przyszłego pracodawcy — lub obecnego zespołu  

---

## 📣 Kontakt / autor

**Autor:** dawkosz  
**GitHub:** [github.com/dawkosz](https://github.com/dawkosz)

> *“To nie bug, to feature… którego nie opisałem jeszcze w README.”*
