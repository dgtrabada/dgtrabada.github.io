.. Tabla compartida: se incluye desde so/particiones.rst y so/fundamentos/sistema_archivos.rst

+----------+--------------+---------------+-------------+----------+
| Sistema  | archivo      | partición     | SO          | Permisos |
| archivos | (máx.)       | (máx.)        | Utilizado   |          |
+==========+==============+===============+=============+==========+
|  FAT16   |      2GB     |     2GB       | Windows     |    NO    |
+----------+--------------+---------------+-------------+----------+
|**FAT32** |    **4GB**   |     2TB       |**Windows**  |  **NO**  |
+----------+--------------+---------------+-------------+----------+
|**exFAT** |  **16 EB**   |   128 PB      |**Windows,** |  **NO**  |
|          |              |               |**macOS,**   |          |
|          |              |               |**GNU/Linux**|          |
+----------+--------------+---------------+-------------+----------+
|**NTFS**  |   **~ TB**   |    ~ EB       |**Windows**  |  **SÍ**  |
+----------+--------------+---------------+-------------+----------+
|  EXT3    |     2 TB     |    16TB       | GNU/Linux   |    SÍ    |
+----------+--------------+---------------+-------------+----------+
|**EXT4**  |   **~ TB**   |    ~ EB       |**GNU/Linux**|  **SÍ**  |
+----------+--------------+---------------+-------------+----------+

La columna **Permisos** indica si el sistema de archivos guarda propietarios y permisos para cada archivo, necesarios en un sistema con varios usuarios. Aunque FAT32 admite particiones de hasta 2 TB, Windows solo deja formatear en FAT32 particiones de hasta 32 GB; para pendrives y discos externos más grandes propone exFAT. Los tamaños de EXT3 son con bloques de 4 KiB.
