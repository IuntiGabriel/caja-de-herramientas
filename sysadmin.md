# 📝 Linux – SysAdmin 🚀

## 🔎 Diagnóstico rápido del sistema
```bash
uptime               # carga del sistema
top / htop           # procesos en tiempo real
free -h              # memoria usada/libre
df -h                # espacio en disco
du -sh *             # tamaño de carpetas
lsblk                # discos y particiones
uname -a             # versión kernel
cat /etc/os-release  # versión del SO
```

## ⚙️ Procesos y servicios
```bash
ps aux | grep <proc>             # buscar proceso
kill -9 <PID>                    # matar proceso
nice/renice                      # ajustar prioridad

systemctl status <servicio>      # estado servicio
systemctl start|stop|restart <svc>
systemctl enable|disable <svc>   # activar/desactivar en boot
journalctl -xe                   # logs del sistema
journalctl -u <servicio>         # logs de servicio
```

## 🌐 Red
```bash
ip a                             # interfaces y IPs
ip route                         # rutas
ping <host>                      # prueba conectividad
traceroute <host>                # salto por salto
ss -tulnp                        # puertos escuchando
curl -I http://<host>            # probar servicio HTTP
dig <host>                       # resolver DNS
```

## 📂 Usuarios y seguridad
```bash
whoami                           # usuario actual
id                               # UID/GID
cat /etc/passwd                  # lista de usuarios
cat /etc/group                   # lista de grupos
sudo -l                          # privilegios sudo
last                             # últimos accesos
lastlog                          # accesos históricos
```

## 🔒 Firewall
```bash
firewall-cmd --list-all          # reglas en firewalld
iptables -L -n -v                # reglas iptables
ss -antp                         # conexiones activas
```

## 📜 Logs importantes
```bash
/var/log/messages                # mensajes generales
/var/log/syslog                  # sistema (Debian/Ubuntu)
/var/log/secure                  # accesos (RedHat)
/var/log/auth.log                # accesos (Debian)
```

## 📦 Paquetes y actualizaciones
```bash
# RedHat / CentOS / Rocky
yum list installed | grep <pkg>
dnf update

# Debian / Ubuntu
dpkg -l | grep <pkg>
apt update && apt upgrade
```

## ⚡ Performance tuning básico
```bash
vmstat 1                         # visión rápida CPU/mem/IO
iostat -xz 1                     # uso de disco
iotop                            # IO por proceso
iftop                            # tráfico de red
nload                            # tráfico de red total
```
