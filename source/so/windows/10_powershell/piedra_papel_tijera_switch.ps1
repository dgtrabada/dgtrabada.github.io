param (
#   [Parameter(Mandatory=$true, HelpMessage="Que eliges piedra papel o tijeras?: ")]
    [string]$OpcionUsuario = "tijeras"
)

$OpcionCPU  = "piedra", "papel", "tijeras" | Get-Random
$OpcionUsuario=$Opcion_usuario.ToLower() 
Write-Output "CPU: $OpcionCPU "
Write-Output "Usuario : $OpcionUsuario"

 switch  ($OpcionCPU){
    "piedra"  {
         switch ($OpcionUsuario){ 
             "piedra"  {echo "Empate"      } 
             "papel"   {echo "Gana usuario"} 
             "tijeras" {echo "Gana CPU"    }
             }
         }

    "papel" {
         switch($OpcionUsuario) {
             "piedra"  {echo "Gana CPU"    }  
             "papel"   {echo "Empate"      } 
             "tijeras" {echo "Gana usuario"} 
             }
         }

    "tijeras" {
         switch($OpcionUsuario) {
             "piedra"  {echo "Gana usuario"} 
             "papel"   {echo "Gana CPU"    } 
             "tijeras" {echo "Empate"      }
             }
         }
    }