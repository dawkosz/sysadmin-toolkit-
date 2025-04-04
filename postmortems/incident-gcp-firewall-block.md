# Incydent #009: GCP – aplikacja działa lokalnie, ale nie odpowiada z zewnątrz po restarcie

## Objawy

- Aplikacja działająca na porcie 80 w GCP VM przestaje odpowiadać po restarcie maszyny
- `curl localhost` zwraca poprawny wynik
- `ss -tuln` pokazuje nasłuchiwanie na porcie 80
- `curl public_ip` z zewnątrz → timeout
- `systemctl status`, `journalctl` – brak błędów

## Przyczyna

- GCP posiada własny firewall na poziomie sieci (VPC Firewall Rules)
- Reguły przypisane są do maszyn poprzez **network tags**
- Reguła `allow-http` istniała, ale była przypisana do taga `http-server`
- Maszyna miała inny tag (np. `web`) lub **nie miała żadnych**
- Po restarcie instancji tagi nie zostały odtworzone lub źle przypisane

## Rozwiązanie

1. Zweryfikowano istniejące reguły:

   ```bash
   gcloud compute firewall-rules list
   ```

2. Dodano nową regułę dla taga przypisanego do maszyny:

   ```bash
   gcloud compute firewall-rules create allow-http-custom \
     --allow tcp:80 \
     --direction=INGRESS \
     --target-tags=web \
     --priority=1000 \
     --network=default
   ```

3. Upewniono się, że maszyna posiada właściwy tag `web`:

   ```bash
   gcloud compute instances add-tags instance-name \
     --tags=web \
     --zone=your-instance-zone
   ```

4. Zweryfikowano dostępność aplikacji z zewnątrz:

   ```bash
   curl http://external_ip
   ```

## Wnioski

- GCP Firewall działa poza systemem operacyjnym – lokalne `ss` i `curl` mogą być mylące
- Kluczowe znaczenie mają **network tags**, które łączą maszyny z regułami dostępu
- Restart maszyny nie zawsze przywraca stan reguł – warto weryfikować po deployu
- `gcloud compute firewall-rules list` i `describe` to podstawowe narzędzia diagnostyczne

Autor: dawkosz  
Data: 2025-03-27
