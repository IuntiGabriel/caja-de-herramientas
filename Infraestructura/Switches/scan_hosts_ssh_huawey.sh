# Definir rango de IPs
IP_PREFIX="192.168.1"  # Cambia según tu red
START=111              # IP inicial
END=255                # IP final

# Usuario SSH
USER="admin"           # Usuario del switch

# Pedir la contraseña sin mostrarla en pantalla
read -s -p "Ingrese la contraseña SSH: " PASSWORD
echo ""

# Archivo de salida
OUTPUT_FILE="switches_huawei_info.txt"
echo "IP, Nombre del Switch, VLANs, Puertos y VLANs, Descripción de Puertos" > "$OUTPUT_FILE"

# Iterar sobre el rango de IPs
for i in $(seq $START $END); do
    IP="$IP_PREFIX.$i"
    echo "Intentando conectar a $IP..."

    # Obtener sysname
    HOSTNAME=$(sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 "$USER@$IP" "display current-configuration | include sysname" 2>/dev/null | awk '{print $2}')

    if [[ -z "$HOSTNAME" ]]; then
        echo "$IP no responde o no se pudo obtener el nombre."
        continue
    fi

    echo "Switch encontrado: $HOSTNAME ($IP)"

    # Obtener VLANs configuradas
    VLAN_INFO=$(sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 "$USER@$IP" "display vlan brief" 2>/dev/null)

    # Obtener VLANs por puerto
    PORT_VLAN_INFO=$(sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 "$USER@$IP" "display port vlan" 2>/dev/null)

    # Obtener descripción de los puertos
    PORT_DESCRIPTION=$(sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 "$USER@$IP" "display interface description" 2>/dev/null)

    # Guardar en archivo
    {
        echo "----------------------------------------------------"
        echo "IP: $IP"
        echo "Nombre del Switch: $HOSTNAME"
        echo "----------------------------------------------------"
        echo "▒~_~T▒ VLANs Configuradas:"
        echo "$VLAN_INFO"
        echo ""
        echo "▒~_~T▒ VLANs por Puerto:"
        echo "$PORT_VLAN_INFO"
        echo ""
        echo "▒~_~T▒ Descripción de Puertos:"
        echo "$PORT_DESCRIPTION"
        echo "----------------------------------------------------"
    } >> "$OUTPUT_FILE"

    echo "Información guardada para $IP."
done

echo "Proceso finalizado. Resultados guardados en $OUTPUT_FILE"
