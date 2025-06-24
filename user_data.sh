#!/bin/bash

# Actualizar el sistema
yum update -y

# Instalar Apache HTTP Server
yum install -y httpd

# Crear página web personalizada
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Bienvenido a ${project_name}</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background-color: #f5f5f5; 
        }
        .container { 
            background-color: white; 
            padding: 20px; 
            border-radius: 8px; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.1); 
        }
        h1 { color: #333; }
        .info { 
            background-color: #e7f3ff; 
            padding: 15px; 
            border-left: 4px solid #2196F3; 
            margin: 20px 0; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>¡Hola desde ${project_name}!</h1>
        <p>Esta página fue creada automáticamente por Terraform usando módulos locales.</p>
        
        <div class="info">
            <h3>Información del servidor:</h3>
            <p><strong>Proyecto:</strong> ${project_name}</p>
            <p><strong>Servidor:</strong> Apache HTTP Server</p>
            <p><strong>Sistema:</strong> Amazon Linux 2</p>
            <p><strong>Fecha de creación:</strong> $(date)</p>
        </div>
        
        <p>Esta infraestructura fue desplegada usando módulos de Terraform que incluyen:</p>
        <ul>
            <li>Módulo VPC - Red virtual privada</li>
            <li>Módulo Security Group - Reglas de seguridad</li>
            <li>Módulo EC2 - Instancia de servidor</li>
        </ul>
    </div>
</body>
</html>
EOF

# Iniciar y habilitar Apache
systemctl start httpd
systemctl enable httpd

# Configurar firewall local (por si acaso)
systemctl start firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --reload

# Log de finalización
echo "$(date): User data script completed successfully" >> /var/log/user-data.log
