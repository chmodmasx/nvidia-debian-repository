#!/bin/bash

# Función para mostrar el menú de opciones
show_menu() {
    echo "Seleccione una opción:"
    echo "1) Instalar NVIDIA sin CUDA"
    echo "2) Instalar NVIDIA con CUDA"
    echo "3) Salir"
}

# Función para instalar NVIDIA sin CUDA
install_without_cuda() {
    echo "Instalando NVIDIA sin CUDA..."
    sudo apt install -y nvidia-driver nvidia-smi nvidia-settings
}

# Función para instalar NVIDIA con CUDA
install_with_cuda() {
    echo "Instalando NVIDIA con CUDA..."
    sudo apt install -y nvidia-driver cuda nvidia-smi nvidia-settings
}

# Actualizamos los repositorios
sudo apt update

# Mostramos el menú y le pedimos al usuario que elija una opción
while true; do
    show_menu
    read -p "Ingrese su opción [1-3]: " OPTION
    case $OPTION in
        1)
            install_without_cuda
            break
            ;;
        2)
            install_with_cuda
            break
            ;;
        3)
            echo "Saliendo del script."
            exit 0
            ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done

# Instalamos los paquetes necesarios
sudo apt install dirmngr ca-certificates software-properties-common apt-transport-https dkms curl -y

# Agregamos soporte para arquitectura i386
sudo dpkg --add-architecture i386

# Detectamos la versión de Debian
VERSION=$(lsb_release -cs)

# Ajustamos la URL del repositorio según la versión de Debian
case $VERSION in
    bookworm|faye)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/"
        ;;
    bullseye)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/"
        ;;
    buster)
        REPO_URL="https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/"
        ;;
    *)
        echo "Versión de Debian no soportada: $VERSION"
        exit 1
        ;;
esac

# Importamos la clave GPG
curl -fSsL "${REPO_URL}3bf863cc.pub" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1

# Añadimos el repositorio de NVIDIA
echo "deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] $REPO_URL /" | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

# Actualizamos los repositorios nuevamente
sudo apt update

# Instalamos los paquetes adicionales
echo "Instalando paquetes adicionales..."
sudo apt install -y libcuda1-i386 nvidia-driver-libs-i386

echo "Instalación completa."
