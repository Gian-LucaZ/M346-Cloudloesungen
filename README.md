# M346-Cloudloesungen
#readme #ops #tbz

## KN01
![p1](./KN01/Screenshot%202023-05-16%20102703.png)
![p2](./KN01/Screenshot%202023-05-16%20102746.png)
![p2](./KN01/Screenshot%202023-05-16%20102848.png)

## KN2

### a)
![324](./KN02/Screenshot%202023-05-23%20084738.png)
![234](./KN02/Screenshot%202023-05-23%20084823.png)
![](./KN02/Screenshot%202023-05-23%20084847.png)
*(Connection hat nicht funktioniert.)*

### b)
![](./KN02/Screenshot%202023-05-23%20092032.png)
![](./KN02/Screenshot%202023-05-23%20092012.png)
![](./KN02/Screenshot%202023-05-23%20091954.png)
![](./KN02/Screenshot%202023-05-23%20091934.png)

# B) -> SSH
![](./KN02/Pasted%20image%2020230523094146.png)
![](./KN02/Pasted%20image%2020230523094441.png)
![](./KN02/Pasted%20image%2020230523094535.png)

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
![](./KN02/Pasted%20image%2020230523103614.png)
![](./KN02/Pasted%20image%2020230523103821.png)
![](./KN02/Pasted%20image%2020230523103854.png)

# KN03
![](./KN03/Pasted%20image%2020230523113737.png)

-> Telnet klappt trotz Rules nicht.

Webserver:
![](./KN03/Pasted%20image%2020230530084453.png)
![](./KN03/Pasted%20image%2020230530084514.png)

-> Connection zu DB-Server nicht mögl. Trotz folgenden Einstellungen ![](Pasted%20image%2020230530102511.png)
Connection per ssh funktioniert und telnet nur lokal, trotz offener security group etc:
![](./KN03/Pasted%20image%2020230530102557.png)

## b)
Bei S3 handelt es sich um einen Hot-Datenspeicher, da S3 viele für häufige Read und Write Prozesse gedacht ist. Wenn diese Daten dann "cold" werden, so benutzt man für diese oft glacier.

![](./KN03/Pasted%20image%2020230530104115.png)
![](./KN03/Pasted%20image%2020230530104958.png)

-> Beim Löschen der VM wird nur das Stamm volume gelöscht. Das macht vor allem dann sinn, wenn die im Nachhinein hinzugefügten Volumes zur Resourcenverwaltung genutzt werden und so von immer anderen Vm's genutzt werden können.

![](./KN03/Pasted%20image%2020230530105100.png)

# KN04

![](./KN04/Pasted%20image%2020230613081241.png)

![](./KN04/Pasted%20image%2020230613081434.png)

![](./KN04/Pasted%20image%2020230613081730.png)

![](./KN04/Pasted%20image%2020230613082109.png)

![](./KN04/Pasted%20image%2020230704101630.png)
![](./KN04/Pasted%20image%2020230704101653.png)

![](./KN04/Pasted%20image%2020230613100428.png)
![](./KN04/Pasted%20image%2020230613100507.png)
![](./KN04/Pasted%20image%2020230613102437.png)
-> db. php kann zwar aufgerufen werden, script failed aber, trotz richtiger konfiguration.

# KN05

![](./KN04/Pasted%20image%2020230613110758.png)

![](./KN05/Pasted%20image%2020230620084140.png)

![](./KN05/Pasted%20image%2020230620084726.png)
![](Pasted%20image%2020230620085202.png)
![](./KN05/Pasted%20image%2020230620104858.png)

## KN06

![](./KN06/Pasted%20image%2020230627083124.png)
![](./KN06/Pasted%20image%2020230627083925.png)
![](./KN06/Pasted%20image%2020230627084054.png)
-> Zoho ist overall etwas günstiger und kann auch Monatlich gekündet werden, was es zum momentanen Favoriten macht. Die vorherige IaaS / PaaS Infrastruktur ist zwar monatlich billiger, muss aber auch selber geupdated und maintained werden. So ist es am Anfang einfacher und auch billiger mit einem SaaS Modell einzusteigen, mit der zeit wird es aber immer teurer, da zwar der Vorab-Preis sehr billig ist die Monatliche miete jedoch diese eines Iaas modells übertrifft.

# KN07
![](./KN07/Pasted%20image%2020230627091609.png)
![](./KN07/Pasted%20image%2020230627091836.png)
![](./KN07/Pasted%20image%2020230627091903.png)
![](./KN07/Pasted%20image%2020230627092123.png)
![](./KN07/Pasted%20image%2020230627095118.png)![](./KN07/Pasted%20image%2020230627095202.png)
![](./KN07/Pasted%20image%2020230627095240.png)

# KN08

![](./KN08/Pasted%20image%2020230627103609.png)

-> [Commands](./KN08/COMMANDS)