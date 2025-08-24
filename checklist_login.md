# 🔑 Checklist – Primer Login en un Servidor Linux

## 1. Identidad y versión del sistema
```bash
whoami
hostname -f
uname -a
cat /etc/os-release
```

## 2. Revisar uptime y recursos
```bash
uptime
free -h
df -h
```

## 3. Revisar red
```bash
ip a
ip route
ss -tulnp
ping -c 4 8.8.8.8
```

## 4. Usuarios y accesos recientes
```bash
last -n 5
lastlog | head
```

## 5. Servicios críticos
```bash
systemctl list-units --type=service --state=running
```

## 6. Logs rápidos de salud
```bash
tail -n 50 /var/log/messages   # RedHat
tail -n 50 /var/log/syslog     # Debian
journalctl -p 3 -xb            # errores críticos
```

## 7. Seguridad
```bash
sudo -l
firewall-cmd --list-all   # si usa firewalld
iptables -L -n -v         # si usa iptables
```
