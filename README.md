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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCibIsaqY7lwA3ZxLaFUT1/UroxYK35ptCX
2+pinj1jS9d60KuqiSWM2JmvwgijB3Wt7HhL2TfH6KdQAeNK1EIcUaxowkyVJlwk
35cr9DVEY5MH3te/rrZNyC4hUlvcwL/Ik2zFcVV5D9/J9ZlKWI/MKUY5shSmwz6V
PHdO+Ucfdlj8eLySYajlYXSE8ygml0tCO36c7p+WHfymKVWxMMhBTJ9QVFxzse/9
GUy12hNHDqRWyA84GfXaLDJTOSsPZb7skm5dS9FAESbyg+vRsVPx6pCLrCYkG4pY
zUg7HnzuAUFOAqPeX/oZRH3a1VsXrv+ydg7EE2PJ4hg23VyUK/E9 aws-key       
ssh_pwauth: false # Passwortauthorisierung per ssh
disable_root: false # Disable root login
package_update: true # Autoupdate von Packages
packages: # Packagereferenzen
  - curl 
  - wget
```
![[Pasted image 20230523103614.png]]
![[Pasted image 20230523103821.png]]![[Pasted image 20230523103854.png]]