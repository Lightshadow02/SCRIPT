Import-Module DhcpServer

# Ajout DHCP nommée "Administration" pour des adresses de gestion
Add-DhcpServerv4Scope -Name "Administration" -StartRange "192.168.1.10" -EndRange "192.168.1.200" -SubnetMask "255.255.255.0" -State Active

# Ajout DHCP nommée "DMZ" pour des adresses de la zone démilitarisée
Add-DhcpServerv4Scope -Name "DMZ" -StartRange "10.0.0.40" -EndRange "10.0.0.200" -SubnetMask "255.255.255.0" -State Active

# Ajout DHCP nommée "Gestion" pour des adresses de gestion
Add-DhcpServerv4Scope -Name "Gestion" -StartRange "192.168.10.10" -EndRange "192.168.10.200" -SubnetMask "255.255.255.0" -State Active

# Ajout DHCP nommée "Medical" pour des adresses médicales
Add-DhcpServerv4Scope -Name "Medical" -StartRange "192.168.12.10" -EndRange "192.168.12.200" -SubnetMask "255.255.255.0" -State Active

# Assignation de la route par défaut à chaque étendue
Set-DhcpServerv4OptionValue -OptionID 003 -ScopeId 192.168.1.0 -Value "192.168.1.254"
Set-DhcpServerv4OptionValue -OptionID 003 -ScopeId 192.168.10.0 -Value "192.168.10.254"
Set-DhcpServerv4OptionValue -OptionID 003 -ScopeId 192.168.12.0 -Value "192.168.12.254"
