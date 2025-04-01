#!/bin/bash

# Configuración
USER="root"
OLD_PASS="viejo_password"
NEW_PASS="nuevo_password"
LOG_FILE=ssh_password_change.log
IP_LIST=( "192.168.1.10" "192.168.1.20" ) # Puedes reemplazar con un rango dinámico
SSH_PORT=2222  # Reemplaza 2222 con tu puerto real

# Limpiar log anterior
echo "Inicio del cambio de contraseñas - $(date)" > "$LOG_FILE"

echo "Procesando IPs..."
for IP in "${IP_LIST[@]}"; do
    echo "Verificando $IP..." | tee -a "$LOG_FILE"
    
    # Intentar obtener el hostname
    HOSTNAME=$(sshpass -p "$OLD_PASS" ssh -p $SSH_PORT -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$USER@$IP" "hostname" 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "[$IP] Hostname: $HOSTNAME" | tee -a "$LOG_FILE"
        
        # Intentar cambiar la contraseña usando chpasswd
        sshpass -p "$OLD_PASS" ssh -p $SSH_PORT "$USER@$IP" "echo 'root:$NEW_PASS' | chpasswd" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "[$IP] Contraseña cambiada exitosamente." | tee -a "$LOG_FILE"
        else
            echo "[$IP] Error al cambiar la contraseña." | tee -a "$LOG_FILE"
        fi
    else
        echo "[$IP] No se pudo conectar o credenciales incorrectas." | tee -a "$LOG_FILE"
    fi
done

echo "Proceso finalizado - $(date)" | tee -a "$LOG_FILE"
