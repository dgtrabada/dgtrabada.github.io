$X="tunombre"
$X1=$X+"1"
$X2=$X+"2"
$X3=$X+"3"

Write-Host  "Muestra la ayuda" -ForegroundColor DarkGray
.\AD.ps1 -help

Write-Host  "Creamos una nueva OU" -ForegroundColor DarkGray
.\AD.ps1 -nueva_OU Despacho_01

Write-Host  "Intentamos crear una nueva OU que ya existe" -ForegroundColor DarkGray
.\AD.ps1 -nueva_OU Despacho_01

Write-Host  "Borramos una nueva OU" -ForegroundColor DarkGray
.\AD.ps1 -eliminar_OU Despacho_01


Write-Host  "Intentamos borrar una nueva OU que ya existe" -ForegroundColor DarkGray
.\AD.ps1 -eliminar_OU Despacho_01

Write-Host  "Lista los grupos" -ForegroundColor DarkGray
.\AD.ps1 -listar_grupos 

Write-Host  "Creamos un usuario con la password por defecto" -ForegroundColor DarkGray
.\AD.ps1 -nuevo_usuario $X

Write-Host  "Intentamos crear un usuario con una password no valida" -ForegroundColor DarkGray
.\AD.ps1 -nuevo_usuario $X1 -password "hola"

Write-Host  "Creamos un usuario con la password correcta" -ForegroundColor DarkGray
.\AD.ps1 -nuevo_usuario $X1 -password "@lumn0"

Write-Host  "Intentamos crear un usuario con una password no valida en el grupo G2" -ForegroundColor DarkGray
.\AD.ps1 -nuevo_usuario $X2 -password "hola" -grupo G2

Write-Host  "Creamos otro usuario con la password correcta en grupo G2, al no exsitir este grupo lo crea de forma automática" -ForegroundColor DarkGray
.\AD.ps1 -nuevo_usuario $X2 -password "@lumn0" -grupo G2

Write-Host  "Listamos los miembreos del grupo G2" -ForegroundColor DarkGray
.\AD.ps1 -listar_miembros_grupo G2

Write-Host  "Intentamos meter el usuario $X3 en grupo G3, sin usar -usuario" -ForegroundColor DarkGray
.\AD.ps1 -meter_usuario_grupo $X3 -grupo G3

Write-Host  "Intentamos meter el usuario $X3 en grupo G3, sin usar -grupo" -ForegroundColor DarkGray
.\AD.ps1 -meter_usuario_grupo -usuario $X3 G3

Write-Host  "Intentamos meter el usuario $X3 en grupo G3 que no existe" -ForegroundColor DarkGray
.\AD.ps1 -meter_usuario_grupo -usuario $X3 -grupo G3

Write-Host  "Intentamos meter el grupo G3" -ForegroundColor DarkGray  
.\AD.ps1 -nuevo_grupo G3

.\AD.ps1 -meter_usuario_grupo -usuario $X3 -grupo G3

.\AD.ps1 -listar_miembros_grupo G2

.\AD.ps1 -listar_miembros_grupo G3

#cuando termina borra todos los usuarios y grupos creados
.\AD.ps1 -eliminar_usuario $X
.\AD.ps1 -eliminar_usuario $X1
.\AD.ps1 -eliminar_usuario $X2
.\AD.ps1 -eliminar_usuario $X3
.\AD.ps1 -eliminar_grupo G2
.\AD.ps1 -eliminar_grupo G3