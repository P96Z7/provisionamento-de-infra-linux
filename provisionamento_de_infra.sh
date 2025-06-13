#! /bin/bash

echo "criando pastas"

mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec


echo "criando grupos"

groupadd  GRP_ADM
groupadd  GRP_VEN
groupadd  GRP_SEC

echo "criando usuarios"

useradd adm1 -c "carlos" -m  -s /bin/bash -G GRP_ADM
useradd adm2 -c "maria" -m  -s /bin/bash -G GRP_ADM
useradd adm3 -c "joao" -m -s /bin/bash -G GRP_ADM
useradd ven1 -c "debora" -m -s /bin/bash -G GRP_VEN
useradd ven2 -c "sebastiana" -m -s /bin/bash -G GRP_VEN
useradd ven3 -c "roberto" -m -s /bin/bash -G GRP_VEN
useradd sec1 -c "josefina" -m -s /bin/bash -G GRP_SEC
useradd sec2 -c "amanda" -m -s /bin/bash -G GRP_SEC
useradd sec3 -c "rogerio" -m -s /bin/bash -G GRP_SEC


echo "modificando dono e grupo"

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

echo "alterando permissões"

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo " finalizado"
