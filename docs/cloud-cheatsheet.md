# ☁️ Cloud Cheatsheet – GCP + AWS (DevOps Toolkit)

Zestaw praktycznych komend i notatek, które wykorzystuję podczas pracy z maszynami wirtualnymi, siecią i usługami chmurowymi w GCP i AWS.

Skupiam się na warstwie:
- infrastrukturalnej (VM, networking, firewall)
- systemowej (debug, deployment, dostęp)
- oraz automatyzacyjnej (CLI, tagging, provisioning)

Repozytorium rozwijam jako część mojego DevOps toolsetu – dokumentując to, czego faktycznie używam i z czym pracuję.

---

## 🌩️ GCP – Google Cloud Platform

### 🔐 Autoryzacja i konfiguracja

```bash
gcloud auth login
gcloud config set project [PROJECT_ID]
```

### 🖥️ VM – Compute Engine

```bash
gcloud compute instances list
gcloud compute ssh instance-name --zone=zone
gcloud compute start instance-name --zone=zone
gcloud compute stop instance-name --zone=zone
```

### 🔥 Firewall

```bash
gcloud compute firewall-rules list
gcloud compute firewall-rules create allow-http-custom \
  --allow tcp:80 \
  --direction=INGRESS \
  --target-tags=web \
  --network=default
```

### 🏷️ Tagi instancji

```bash
gcloud compute instances add-tags instance-name \
  --tags=web \
  --zone=zone
```

---

## ☁️ AWS – Amazon Web Services

### 🛠️ EC2 – maszyny wirtualne

```bash
aws ec2 describe-instances
aws ec2 start-instances --instance-ids i-xxxxx
aws ec2 stop-instances --instance-ids i-xxxxx
```

### 🔐 Klucze SSH (Key Pairs)

```bash
aws ec2 describe-key-pairs
```

### 🔥 Security Groups (firewall)

```bash
aws ec2 describe-security-groups
```

### 🌐 Adresy IP

```bash
aws ec2 describe-addresses
```

---

## 🧠 Ważne różnice

| Element             | GCP                            | AWS                     |
|---------------------|--------------------------------|--------------------------|
| VM                  | Compute Engine                 | EC2                      |
| Firewall            | VPC Firewall (tags)            | Security Groups          |
| Public IP           | External IP (czasem ephemeral) | Elastic IP (rezerwowany) |
| Terminal CLI        | `gcloud`                       | `aws`                    |

---

> Pracuję z GCP i AWS z perspektywy DevOpsa.  
> Fokusuję się na niezawodności, automatyzacji i warstwie operacyjnej.

Autor: dawkosz  
