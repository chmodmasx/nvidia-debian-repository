# Nvidia Repo e instalción del driver

Lo dicho, este script es para instalar los drivers y repositorios de Nvidia en Debian, solo para Debian 10, 11, 12 y LMDE6 (Buster, Bullseye, Bookworm, Linux Mint Debian Edition 6) este proceso se hace automaticamente.
Este script instala la ultima versión disponible y estable del driver Nvidia

Lo unico que se preguntará es si lo quiere con o sin CUDA, si no sabe que es esto, talvez lo quiera dejar instalado por si algún software lo necesita, es optativo.

**Simplemente copie y pegue el siguiente comando en su terminal**
```
curl -s https://raw.githubusercontent.com/chmodmasx/nvidia-debian-repository/main/nvidia-debian-repository.sh >tmp.sh && bash tmp.sh
```
