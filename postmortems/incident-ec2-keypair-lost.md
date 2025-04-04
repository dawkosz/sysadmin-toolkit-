# Incydent #010: AWS EC2 – brak key-pair, brak dostępu, odzysk przez snapshot

## Objawy

- Brak możliwości zalogowania się do instancji EC2 po restarcie
- Komunikat SSH: `Permission denied (publickey)`
- Klucz PEM wcześniej działał, ale instancja nie przyjmuje połączenia

## Przyczyna

- Instancja EC2 (`i-0a1b2c3d4e5f`) nie miała przypisanego key-pair (`KeyName: null`)
- W logach instancji (`get-console-output`) pojawił się komunikat:

  ```
  WARNING: No SSH public key found in instance metadata.
  ```

- AWS nie miał jak dodać klucza do `authorized_keys`, więc SSH został zablokowany
- Najprawdopodobniej key-pair nie został przypisany przy tworzeniu instancji lub cloud-init został pominięty

## Rozwiązanie (opcja: odzysk przez snapshot)

1. Zidentyfikowano ID wolumenu root (EBS):

   ```bash
   aws ec2 describe-instances \
     --instance-ids i-0a1b2c3d4e5f \
     --query "Reservations[].Instances[].BlockDeviceMappings[].Ebs.VolumeId"
   ```

2. Utworzono snapshot:

   ```bash
   aws ec2 create-snapshot \
     --volume-id vol-xxxx \
     --description "Backup for keypair recovery"
   ```

3. Utworzono nową instancję z przypisanym key-pair:

   ```bash
   aws ec2 run-instances \
     --image-id ami-xxxxx \
     --key-name my-key \
     ...
   ```

4. Odłączono root volume nowej instancji i podłączono nowy wolumen ze snapshota:

   ```bash
   aws ec2 detach-volume --volume-id vol-newroot
   aws ec2 create-volume --snapshot-id snap-xxxx ...
   aws ec2 attach-volume --volume-id vol-recovered --device /dev/xvda
   ```

5. Uruchomiono instancję i zalogowano się przez SSH:

   ```bash
   ssh -i my-key.pem ec2-user@PUBLIC_IP
   ```

## Wnioski

- Brak key-pair = natychmiastowa utrata dostępu do instancji
- Zawsze sprawdzaj pole `KeyName` w `describe-instances` po utworzeniu EC2
- `get-console-output` to kluczowe źródło informacji przy braku dostępu
- Snapshot + nowa instancja z poprawnym kluczem = bezpieczna metoda odzysku

Autor: dawkosz  
Data: 2025-03-27
