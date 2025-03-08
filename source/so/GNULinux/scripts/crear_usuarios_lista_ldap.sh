#!/bin/bash

LDAP="dc=ldap,dc=tunombre,dc=local"
LDAPadmin="cn=admin,$LDAP"
password=alumno
passwd_defecto_usuario=cambiame

function crear_grupo(){
NAMEG=$1       #GA
NUMBERGID=$2   #501

cat << EOF > grupo.ldif
dn: cn=${NAMEG},ou=grupos,$LDAP
objectClass: posixGroup
cn: ${NAMEG}
gidNumber: ${NUMBERGID}
EOF

ldapadd -x -D $LDAPadmin -w $password -f grupo.ldif
rm -fr grupo.ldif
}

function crear_usuario(){
NAME=$1      #tunombre1
NUMBERID=$2  #1001
NUMBERGID=$(ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP cn=$3 gidNumber | grep  gid | cut -d':' -f2)
echo ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP cn=$3 gidNumber | grep  gid | cut -d':' -f2
echo NUMBERGID=$NUMBERGID
cat << EOF > usuarios.ldif
dn: uid=${NAME},ou=usuarios,$LDAP
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: ${NAME}
cn: ${NAME}
sn: ${NAME}
gidNumber: ${NUMBERGID}
uidNumber: ${NUMBERID}
userPassword: $passwd_defecto_usuario
homeDirectory: /home/$NAME
loginShell: /bin/bash
EOF

ldapadd -x -D $LDAPadmin -w $password -f usuarios.ldif
rm -fr usuarios.ldif
}


function show_help() {
  echo -e "\033[34m
  ./usuarios_lista_ldap.sh -help
  ./usuarios_lista_ldap.sh -crear <archivo.dat>
  ./usuarios_lista_ldap.sh -borrar <archivo.dat>
  \033[0m"
  }


if [[ $# -gt 0 ]]
then
  if [[ $1 == "-help" ]]
  then
    show_help
  fi

  if [[ $1 == "-crear" ]]
  then
    if test -n "$2"
    then
      archivo=$2
      grupo=$(echo $archivo | sed 's/.dat//')
      if test -f $archivo
      then
        #echo -e "\033[32m Creamos los usuarios en el grupo $grupo \033[0m"
        if [[ $(ldapsearch -xLLL -b $LDAP cn=$grupo | grep -c 'ldap') -gt 0 ]]
        then
          echo -e "\033[31m No se crea el grupo, el grupo $grupo existe. \033[0m"
        else
          echo -e "\033[34m Primero creamos el grupo $grupo \033[0m"
          #tomamos el ultimo gidNumbrer:
          gidN=$(ldapsearch -xLLL -b $LDAP | grep gidNumber | cut -d':' -f2 | tail -1)
          if [ -z "$gidN" ] #-z indica que la variable esta vacía
          then
            gidN=500
          fi
          gidN=$((gidN+1))
          crear_grupo $grupo $gidN
        fi
        for((i=1;i<=$(wc -l $archivo | cut -d' ' -f1);i++))
        do
          usuario=$(head -$i $archivo | tail -1 | cut -d'@' -f1)
          if [[ $(ldapsearch -xLLL -b $LDAP cn=$usuario | grep -c 'ldap') -gt 0 ]]
          then
            echo -e "\033[31m No se crea el usuario, $usuario existe. \033[0m"
          else
            #tomamos el ultimo gidNumbrer:
            uidN=$(ldapsearch -xLLL -b $LDAP | grep uidNumber | cut -d':' -f2 | tail -1)
            if [ -z "$uidN" ] #-z indica que la variable esta vacía
            then
              uidN=1000
            fi
            uidN=$((uidN+1))
            echo -e "\033[34m Creamos el usuario $usuario \033[0m"
            crear_usuario $usuario $uidN $grupo
          fi
        done
      else
        echo -e "\033[31m El archvio $archivo no existe \033[0m"
      fi
    else
      echo -e "\033[31m Proporcionar el <archvio.dat> \033[0m"
      show_help
    fi
  fi

  if [[ $1 == "-borrar" ]]
  then
    if test -n "$2"
    then
      archivo=$2
      grupo=$(echo $archivo | sed 's/.dat//')
      if test -f $archivo
      then
        for((i=1;i<=$(wc -l $archivo | cut -d' ' -f1);i++))
        do
          usuario=$(head -$i $archivo | tail -1 | cut -d'@' -f1)
          if [[ $(ldapsearch -xLLL -b $LDAP cn=$usuario | grep -c 'ldap') -gt 0 ]]
          then
            ldapdelete -x -w $password -D $LDAPadmin "uid=$usuario,ou=usuarios,$LDAP"
            echo -e "\033[34m Borramos el usuario $usuario \033[0m"
          else
            echo -e "\033[31m El usuario $usuario no existe \033[0m"
          fi
        done
        if [[ $(ldapsearch -xLLL -b $LDAP cn=$grupo | grep -c 'ldap') -eq 0 ]]
        then
          echo -e "\033[31m El grupo $grupo no existe. \033[0m"
        else
          #si el grupo no tiene usuarios borrarlo
          NUMBERGID=$( ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP cn=$grupo gidNumber | grep  gid | cut -d':' -f2)
          if [[ $(ldapsearch -xLLL -b $LDAP | grep -c $NUMBERGID) -eq 1 ]]
          then
            ldapdelete -x -w $password -D $LDAPadmin "cn=$grupo,ou=grupos,$LDAP"
            echo -e "\033[34m Borramos el grupo $grupo sin usuarios \033[0m"
          fi
        fi
      else
        echo -e "\033[31m El archvio $archivo no existe \033[0m"
      fi
    else
      echo -e "\033[31m Proporcionar el <archvio.dat> \033[0m"
      show_help
    fi
  fi


else
  show_help
fi


