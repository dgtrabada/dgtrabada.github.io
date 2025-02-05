
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
NUMBERGID=$( ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP cn=$3 gidNumber | grep  gid | cut -d':' -f2)

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
#rm -fr usuarios.ldif
}

function show_help() {
    echo -e "\033[34m Uso del script:\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -addgroup <grupo>         : Crea un grupo si no existe\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -delgroup <grupo>         : Elimina un grupo si existe\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -lsgroup                  : Elimina un grupo si existe\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -adduser <usuario> [grupo]: Crea un usuario en el grupo especificado \033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -deluser <usuario>        : Elimina un usuario si existe\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -lista                    : Lista todos los grupos y sus usuarios\033[0m"
    echo -e "\033[34m ./usuarios_ldap.sh -lsuser                  : Elimina un grupo si existe\033[0m"
}


if [[ $# -gt 0 ]]
then
  if [[ $1 == "-addgroup" ]]
  then
    if [[ $(ldapsearch -xLLL -b $LDAP cn=$2 | grep -c 'ldap') -gt 0 ]]
    then
      echo -e "\033[31m No se crea el grupo, el grupo $2 existe. \033[0m"
    else
      echo -e "\033[34m Creamos el grupo $2 \033[0m"
      #tomamos el ultimo gidNumbrer:
      gidN=$(ldapsearch -xLLL -b $LDAP | grep gidNumber | cut -d':' -f2 | tail -1)
      if [ -z $gidN ] #-z indica que la variable esta vacía
      then
        gidN=500
      fi
      gidN=$((gidN+1))
      crear_grupo $2 $gidN
    fi
  fi


  if [[ $1 == "-delgroup" ]]
  then
    if [[ $(ldapsearch -xLLL -b $LDAP cn=$2 | grep -c 'ldap') -gt 0 ]]
    then
      ldapdelete -x -w $password -D $LDAPadmin "cn=$2,ou=grupos,$LDAP"
      echo -e "\033[34m Borramos el grupo $2 \033[0m"
    else
      echo -e "\033[31m No se borra el grupo, el grupo $2 no existe. \033[0m"
    fi
  fi

  if [[ $1 == "-lsgroup" ]]
  then
    ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP "(objectClass=posixGroup)" cn gidNumber
  fi
  if [[ $1 == "-adduser" ]]
  then
    if [[ $(ldapsearch -xLLL -b $LDAP cn=$2 | grep -c 'ldap') -gt 0 ]]
    then
      echo -e "\033[31m No se crea el usuario, $2 existe. \033[0m"
    else
      #tomamos el ultimo gidNumbrer:
      uidN=$(ldapsearch -xLLL -b $LDAP | grep uidNumber | cut -d':' -f2 | tail -1)
      if [ -z $uidN ] #-z indica que la variable esta vacía
      then
        uidN=1000
      fi
      uidN=$((uidN+1))
      grupo=$3
      if [ -z $grupo ]
      then
        echo -e "\033[31m No se crea el usuario, necesitamos un grupo. \033[0m"
      else
        echo -e "\033[34m Creamos el usuario $2 \033[0m"
        crear_usuario $2 $uidN $grupo
      fi
    fi
  fi


  if [[ $1 == "-deluser" ]]
  then
    if [[ $(ldapsearch -xLLL -b $LDAP uid=$2 | grep -c 'ldap') -gt 0 ]]
    then
      ldapdelete -x -w $password -D $LDAPadmin "uid=$2,ou=usuarios,$LDAP"
      echo -e "\033[34m Borramos el usuario $2 \033[0m"
    else
      echo -e "\033[31m No se borra el usuario, el usuario $2 no existe. \033[0m"
    fi
  fi



  if [[ $1 == "-lsuser" ]]
  then
    ldapsearch -xLLL -D $LDAPadmin -w $password -b $LDAP "(objectClass=posixAccount)" cn uidNumber
  fi

else
  show_help
fi

