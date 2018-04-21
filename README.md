# zabbix-agent-on-RasPi
Script and template for zabbix-agent to run on raspberryPi.
I assume you already installed zabbix-agent
`sudo apt install zabbix-agent`

Fetch script from GitHub:
```
wget https://raw.githubusercontent.com/bobbolous/zabbix-agent-on-RasPi/master/raspberrypi.sh
```

Create script location:
```
sudo mkdir /etc/zabbix/scripts
```

Move script to new location:
```
sudo mv raspberrypi.sh /etc/zabbix/scripts
```

Change permissions for script:
```
sudo chmod 755 /etc/zabbix/scripts/raspberrypi.sh
```

Add zabbix user to video group to get required permissions.
```
sudo usermod -aG video zabbix
```

Test script:
```
$ /etc/zabbix/scripts/raspberrypi.sh temperature
50464
```

Add script to zabbix configuration file:
```
sudo nano /etc/zabbix/zabbix_agentd.conf
```

Adding the following line:
```
UserParameter=raspberrypi.sh[*],/etc/zabbix/scripts/raspberrypi.sh $1
```

Restart the zabbix agent:
```
sudo service zabbix-agent restart
```

Import the Template in your Zabbix Server frontend.
Assign it to the host.

# Thanks to 
Bernhard Linz for his Tutorial and Script on [http://znil.net/index.php/Zabbix:Template_Raspberry_Pi]
