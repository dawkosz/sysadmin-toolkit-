# 🧠 Git Cheatsheet – najważniejsze komendy (DevOps / SysAdmin)

Praktyczna ściąga z komend Git, których używam w codziennej pracy z repozytorium.  
Idealna do dokumentowania incydentów, pisania skryptów, backupów i pracy z GitHubem.

---

## 📋 Podstawowe komendy

### 🔍 Zobacz status plików
```bash
git status
```

### ➕ Dodaj pliki do commita
```bash
git add nazwa_pliku
git add .            # dodaj wszystko
```

### ✅ Zrób commit (z opisem)
```bash
git commit -m "Opis zmiany"
```

### ☁️ Wyślij zmiany do zdalnego repozytorium
```bash
git push
```

### 🔄 Pobierz zmiany z GitHuba
```bash
git pull
```

---

## 📜 Historia

### 📖 Pokaż historię commitów
```bash
git log
git log --oneline    # skrócona wersja
```

---

## 🔎 Porównywanie zmian

### 🧾 Co się zmieniło od ostatniego commita?
```bash
git diff
```

---

## 🚀 Start projektu

### 🔧 Utwórz nowe repo lokalnie
```bash
git init
```

### 🌐 Skopiuj repo z GitHub
```bash
git clone git@github.com:user/repo.git
```

---

## 🌿 Branch (opcjonalnie)

```bash
git branch              # pokaż aktualną gałąź
git checkout -b nazwa   # utwórz i przejdź do nowej gałęzi
```

---

## 📦 Typowy DevOps workflow

```bash
git status
git add .
git commit -m "Dodano nowy skrypt backupu"
git push
```

---

> 💬 Nie musisz znać wszystkiego. Te 10-12 komend to 90% realnej pracy z Gitem. ;))

Autor: dawkosz  
Data: 2025-03-27
