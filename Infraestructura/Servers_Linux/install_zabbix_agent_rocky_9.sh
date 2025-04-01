#!/bin/bash

# Variables
ZABBIX_SERVER_IP="10.5.0.56"
ZABBIX_REPO_URL="https://repo.zabbix.com/zabbix/6.0/rhel/9/x86_64/zabbix-release-6.0-5.el9.noarch.rpm"
ZABBIX_AGENT_CONF="/etc/zabbix/zabbix_agentd.conf"

# Deshabilitar paquetes de Zabbix proporcionados por EPEL
echo "Deshabilitando paquetes de Zabbix en EPEL si existen..."
if grep -q "excludepkgs=zabbix*" /etc/yum.repos.d/epel.repo; then
  echo "Los paquetes Zabbix ya están excluidos de EPEL."
else
  sudo sed -i '/\[epel\]/a excludepkgs=zabbix*' /etc/yum.repos.d/epel.repo
  echo "Paquetes Zabbix excluidos de EPEL."
fi

# Instalar el repositorio de Zabbix
echo "Instalando repositorio de Zabbix..."
sudo rpm -Uvh $ZABBIX_REPO_URL
sudo dnf clean all

# Instalar el agente de Zabbix
echo "Instalando Zabbix agent..."
sudo dnf install -y zabbix-agent

# Configurar la IP del servidor Zabbix
echo "Configurando la IP del servidor Zabbix..."
sudo sed -i "s/^Server=127.0.0.1/Server=$ZABBIX_SERVER_IP/" $ZABBIX_AGENT_CONF
sudo sed -i "s/^ServerActive=127.0.0.1/ServerActive=$ZABBIX_SERVER_IP/" $ZABBIX_AGENT_CONF

# Iniciar y habilitar el servicio de Zabbix
echo "Iniciando y habilitando el agente Zabbix..."
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

echo "Instalación y configuración completadas."

