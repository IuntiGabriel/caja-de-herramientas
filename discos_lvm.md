# 💽 Manejo de Discos en Linux (Con y Sin LVM)

## 📦 Opción 1: Montar disco **sin LVM**
1. **Identificar disco nuevo**
```bash
lsblk
fdisk -l
```

2. **Crear partición**
```bash
fdisk /dev/sdb
# n → nueva partición
# p → primaria
# 1 → número de partición
# enter enter → usar todo el disco
# w → guardar cambios
```

3. **Formatear con sistema de archivos**
```bash
mkfs.ext4 /dev/sdb1
```

4. **Montar**
```bash
mkdir /mnt/data
mount /dev/sdb1 /mnt/data
```

5. **Persistencia en fstab**
```bash
blkid /dev/sdb1
```
Editar `/etc/fstab` y agregar:
```
UUID=<uuid>   /mnt/data   ext4   defaults   0 0
```

---

## 📦 Opción 2: Montar disco **con LVM**
1. **Identificar disco**
```bash
lsblk
fdisk -l
```

2. **Crear partición tipo LVM**
```bash
fdisk /dev/sdb
# n → nueva
# p → primaria
# 1 → número
# enter enter
# t → cambiar tipo
# 8e → Linux LVM
# w → guardar
```

3. **Crear Physical Volume**
```bash
pvcreate /dev/sdb1
```

4. **Crear o extender Volume Group**
```bash
# Nuevo VG
vgcreate vgdata /dev/sdb1

# O agregar a un VG existente
vgextend vgdata /dev/sdb1
```

5. **Crear Logical Volume**
```bash
lvcreate -n lvdata -L 20G vgdata
# o usar todo el disco
lvcreate -n lvdata -l 100%FREE vgdata
```

6. **Formatear LV**
```bash
mkfs.ext4 /dev/vgdata/lvdata
```

7. **Montar**
```bash
mkdir /mnt/data
mount /dev/vgdata/lvdata /mnt/data
```

8. **Persistencia en fstab**
```
/dev/vgdata/lvdata   /mnt/data   ext4   defaults   0 0
```

---

## 📊 Comandos útiles de verificación
```bash
lsblk                 # ver jerarquía de discos
df -h                 # ver discos montados
pvs                   # listar Physical Volumes
vgs                   # listar Volume Groups
lvs                   # listar Logical Volumes
```

👉 Sin LVM: más simple pero rígido.  
👉 Con LVM: más flexible (crecimiento, reducción, snapshots).
