# M346-Cloudloesungen
#readme #ops #tbz

## KN01
![p1](./KN01/Screenshot%202023-05-16%20102703.png)
![p2](./KN01/Screenshot%202023-05-16%20102746.png)
![p2](./KN01/Screenshot%202023-05-16%20102848.png)

## KN2

### a)
![[Screenshot 2023-05-23 084738.png]]![[Screenshot 2023-05-23 084823.png]]![[Screenshot 2023-05-23 084847.png]]
*(Connection hat nicht funktioniert.)*

### b)
![[Screenshot 2023-05-23 092032.png]]![[Screenshot 2023-05-23 092012.png]]![[Screenshot 2023-05-23 091954.png]]![[Screenshot 2023-05-23 091934.png]]

# B) -> SSH
![[Pasted image 20230523094146.png]]![[Pasted image 20230523094441.png]]![[Pasted image 20230523094535.png]]

# C) -> YAML
```yaml
#cloud-config
users: # Liste von usen
  - name: ubuntu # Erstes Entry in der Liste (username ubuntu)
    sudo: ALL=(ALL) NOPASSWD:ALL # Sudocommands für diesen Benutzer
    groups: users, admin # Gruppenzuweisungen
    home: /home/ubuntu # Das Homeverzeichnis des Benutzers
    shell: /bin/bash # Shell configuration
    ssh_authorized_keys: # Mit dem Benutzer assoziierte SSH-Keys
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0WGP1EZykEtv5YGC9nMiPFW3U3DmZNzKFO5nEu6uozEHh4jLZzPNHSrfFTuQ2GnRDSt+XbOtTLdcj26+iPNiFoFha42aCIzYjt6V8Z+SQ9pzF4jPPzxwXfDdkEWylgoNnZ+4MG1lNFqa8aO7F62tX0Yj5khjC0Bs7Mb2cHLx1XZaxJV6qSaulDuBbLYe8QUZXkMc7wmob3PM0kflfolR3LE7LResIHWa4j4FL6r5cQmFlDU2BDPpKMFMGUfRSFiUtaWBNXFOWHQBC2+uKmuMPYP4vJC9sBgqMvPN/X2KyemqdMvdKXnCfrzadHuSSJYEzD64Cve5Zl9yVvY4AqyBD aws-key       
ssh_pwauth: false # Passwortauthorisierung per ssh
disable_root: false # Disable root login
package_update: true # Autoupdate von Packages
packages: # Packagereferenzen
  - curl 
  - wget
```
