# Guía Rápida de SSH: Creación y Copia de Claves

Esta guía cubre los pasos esenciales para crear una clave SSH (RSA) en tu máquina local y copiarla a un servidor remoto para habilitar la autenticación sin contraseña.

## Parte 1: Creación de Claves SSH (RSA)

Una clave SSH es un método de autenticación seguro que consta de dos partes:

* **Clave Privada (`id_rsa`):** Se almacena en tu computadora local. **Nunca debes compartirla**.
* **Clave Pública (`id_rsa.pub`):** Se instala en los servidores a los que quieres acceder.

---

### Opción A: Desde Linux (o una terminal tipo Linux en Windows)

Este método funciona en cualquier distribución de Linux, macOS, o terminales como Git Bash o WSL (Subsistema de Windows para Linux).

1.  **Abre tu terminal.**

2.  **Ejecuta el generador de claves:**
    ```bash
    ssh-keygen -t rsa -b 4096
    ```
    * `-t rsa`: Especifica que el tipo de clave sea RSA.
    * `-b 4096`: Establece una longitud de 4096 bits para la clave, un estándar muy seguro.

3.  **Elige la ubicación:**
    Presiona **Enter** para aceptar la ubicación por defecto (`~/.ssh/id_rsa`).

4.  **Establece una "Passphrase" (Opcional pero recomendado):**
    Puedes añadir una frase de contraseña para una capa extra de seguridad. Si alguien obtuviera tu clave privada, aún necesitaría esta frase para usarla. Puedes dejarla en blanco presionando **Enter** dos veces.

5.  **Obtén tu clave pública:**
    Para ver y copiar tu clave pública, usa el comando `cat`:
    ```bash
    cat ~/.ssh/id_rsa.pub
    ```
    Copia todo el texto que se muestra, desde `ssh-rsa` hasta el final.

---

### Opción B: Desde Windows (PowerShell o CMD)

Las versiones modernas de Windows 10 y 11 ya incluyen el cliente OpenSSH.

1.  **Abre PowerShell** o el **Símbolo del sistema (CMD)**.

2.  **Ejecuta el generador de claves:**
    ```powershell
    ssh-keygen -t rsa -b 4096
    ```

3.  **Sigue los mismos pasos:**
    El proceso es idéntico al de Linux. Te preguntará la ubicación (la ruta por defecto será `C:\Users\tu_usuario\.ssh\id_rsa`) y te pedirá la passphrase opcional.

4.  **Obtén tu clave pública:**
    Para ver y copiar tu clave pública, usa el comando `type`:
    ```powershell
    type $env:USERPROFILE\.ssh\id_rsa.pub
    ```
    Copia todo el contenido que te muestre la terminal.

---

## Parte 2: Copiar la Clave Pública al Servidor

La forma más sencilla y recomendada de instalar tu clave pública en un servidor es usando la utilidad `ssh-copy-id`.

### Requisito Previo

Para que este método funcione, necesitas tener **acceso inicial al servidor mediante contraseña**. El comando usará esta contraseña una única vez para configurar el acceso sin clave.

### Uso del Comando `ssh-copy-id`

1.  **Abre tu terminal** en tu máquina local (Linux, macOS, o Git Bash/WSL en Windows).

2.  **Ejecuta el siguiente comando**, reemplazando `usuario` y `direccion_del_servidor` con tus datos reales:
    ```bash
    ssh-copy-id usuario@direccion_del_servidor
    ```
    * **`usuario`**: Es tu nombre de usuario en el servidor remoto.
    * **`direccion_del_servidor`**: Puede ser la dirección IP (ej: `192.168.1.100`) o un nombre de dominio (ej: `servidor.empresa.com`).

3.  **Ingresa tu contraseña:**
    La terminal te pedirá la contraseña del `usuario` en el servidor remoto. Escríbela y presiona **Enter**.

4.  **¡Listo!**
    Una vez que la contraseña es aceptada, el script se encarga de todo. A partir de este momento, cuando intentes conectarte con `ssh usuario@direccion_del_servidor`, ya no te pedirá la contraseña.

### ¿Qué hace `ssh-copy-id`?

El comando se conecta al servidor y de forma segura:
1.  Crea la carpeta `~/.ssh` si no existe (con permisos `700`).
2.  Crea el archivo `~/.ssh/authorized_keys` si no existe.
3.  Añade tu clave pública al final de este archivo.
4.  Asegura que los permisos del archivo `authorized_keys` sean los correctos (`600`).
