# Terraform con Módulos Locales - Lab Básico

Este proyecto demuestra cómo estructurar código de Terraform usando **módulos locales** para crear una infraestructura básica en AWS que incluye VPC, Security Group y una instancia EC2 con Apache.

## 🏗️ Arquitectura

La infraestructura desplegada incluye:

- **VPC** con subnet pública
- **Internet Gateway** y tabla de rutas
- **Security Group** con reglas configurables
- **Instancia EC2** con Apache HTTP Server
- **Configuración automática** del servidor web

## 📁 Estructura del Proyecto

```
.
├── main.tf                    # Configuración principal que usa los módulos
├── provider.tf                # Configuración de Terraform y providers
├── variables.tf               # Variables de entrada
├── outputs.tf                 # Valores de salida
├── user_data.sh               # Script de inicialización de la instancia
├── terraform.tfvars.example   # Ejemplo de configuración de variables
├── README.md                  # Este archivo
└── modules/                   # Directorio de módulos locales
    ├── vpc/                   # Módulo para VPC y networking
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_group/        # Módulo para Security Groups
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2/                   # Módulo para instancias EC2
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 📋 Organización de Archivos

### **Archivos Principales:**
- **`main.tf`** - Orquesta todos los módulos y define data sources
- **`provider.tf`** - Configuración de Terraform, providers AWS y default tags
- **`variables.tf`** - Variables centralizadas y configurables
- **`outputs.tf`** - Información útil post-despliegue
- **`user_data.sh`** - Script mejorado para configurar Apache
- **`terraform.tfvars.example`** - Plantilla de configuración

### **Ventajas de la Separación:**
- **Claridad**: Cada archivo tiene una responsabilidad específica
- **Mantenimiento**: Fácil localización de configuraciones
- **Reutilización**: Los módulos son completamente independientes
- **Default Tags**: Aplicación automática de tags a todos los recursos

## 🚀 Uso Rápido

### 1. Preparación

```bash
# Clonar o descargar el proyecto
cd terraform-modules-lab

# Copiar el archivo de variables de ejemplo
cp terraform.tfvars.example terraform.tfvars

# Editar las variables según tus necesidades
nano terraform.tfvars
```

### 2. Despliegue

```bash
# Inicializar Terraform
terraform init

# Revisar el plan de ejecución
terraform plan

# Aplicar los cambios
terraform apply
```

### 3. Verificación

Después del despliegue, Terraform mostrará:
- La IP pública de la instancia
- El comando SSH para conectarse
- La URL del servidor web

```bash
# Ejemplo de salida
instance_public_ip = "54.123.45.67"
ssh_connection_command = "ssh -i ~/.ssh/mi-key.pem ec2-user@54.123.45.67"
web_url = "http://54.123.45.67"
```

### 4. Limpieza

```bash
# Destruir toda la infraestructura
terraform destroy
```

## ⚙️ Configuración

### Variables Principales

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `project_name` | Nombre del proyecto | `"lab-terraform"` |
| `region` | Región de AWS | `"us-east-1"` |
| `vpc_cidr` | CIDR de la VPC | `"10.0.0.0/16"` |
| `instance_type` | Tipo de instancia EC2 | `"t2.micro"` |
| `install_apache` | Instalar Apache automáticamente | `true` |
| `key_name` | Key pair para SSH | `null` |

### Configuración de Seguridad

Por defecto, el Security Group permite:
- **SSH (puerto 22)**: Desde cualquier IP (0.0.0.0/0)
- **HTTP (puerto 80)**: Desde cualquier IP (0.0.0.0/0)
- **Todo el tráfico saliente**

⚠️ **Para producción**, restringe el acceso SSH a tu IP específica:

```hcl
ssh_cidr_blocks = ["TU.IP.PUBLICA.AQUI/32"]
```

## 📦 Módulos Incluidos

### Módulo VPC (`modules/vpc/`)

Crea la infraestructura de red:
- VPC con DNS habilitado
- Subnet pública
- Internet Gateway
- Tabla de rutas con ruta por defecto

**Inputs principales:**
- `vpc_cidr`: CIDR de la VPC
- `subnet_cidr`: CIDR de la subnet
- `availability_zone`: Zona de disponibilidad

**Outputs:**
- `vpc_id`: ID de la VPC
- `subnet_id`: ID de la subnet pública

### Módulo Security Group (`modules/security_group/`)

Gestiona las reglas de seguridad:
- Security Group configurable
- Reglas para SSH, HTTP, HTTPS
- Tráfico saliente permitido

**Inputs principales:**
- `vpc_id`: ID de la VPC
- `enable_ssh_access`: Habilitar SSH
- `ssh_cidr_blocks`: IPs permitidas para SSH

**Outputs:**
- `security_group_id`: ID del Security Group

### Módulo EC2 (`modules/ec2/`)

Despliega la instancia de servidor:
- Instancia EC2 configurable
- Volumen EBS encriptado
- User data personalizable
- IP pública automática

**Inputs principales:**
- `ami_id`: AMI a usar (auto-detecta si está vacío)
- `instance_type`: Tipo de instancia
- `subnet_id`: Subnet donde desplegar
- `security_group_ids`: Security Groups a aplicar

**Outputs:**
- `instance_id`: ID de la instancia
- `instance_public_ip`: IP pública
- `instance_private_ip`: IP privada

## 🔧 Personalización

### Cambiar la Región

```hcl
# En terraform.tfvars
region = "eu-west-1"
```

### Usar una AMI Específica

```hcl
# En terraform.tfvars
ami_id = "ami-0abcdef1234567890"
```

### Configurar Key Pair para SSH

1. Crear un key pair en AWS Console
2. Configurar en `terraform.tfvars`:

```hcl
key_name = "mi-key-pair"
```

### Personalizar el User Data

Edita el archivo `user_data.sh` para cambiar la configuración inicial de la instancia.

## 🛡️ Mejores Prácticas Implementadas

- **Módulos reutilizables**: Código organizado en módulos independientes
- **Variables parametrizadas**: Configuración flexible sin hardcodear valores
- **Outputs informativos**: Información útil después del despliegue
- **Tags consistentes**: Etiquetado automático de recursos
- **Seguridad por defecto**: Volúmenes encriptados, reglas de seguridad configurables
- **AMI automática**: Usa la AMI más reciente de Amazon Linux 2
- **Documentación completa**: README detallado y comentarios en el código

## 🔍 Troubleshooting

### Error: "No default VPC"
Si tu cuenta AWS no tiene VPC por defecto, este código creará una nueva VPC automáticamente.

### Error: "Invalid AMI ID"
Si especificas un `ami_id` manualmente, asegúrate de que esté disponible en la región seleccionada.

### No puedo conectarme por SSH
1. Verifica que hayas configurado un `key_name` válido
2. Asegúrate de que tu IP esté en `ssh_cidr_blocks`
3. Confirma que el Security Group permite el puerto 22

### La página web no carga
1. Verifica que `install_apache = true`
2. Confirma que el Security Group permite el puerto 80
3. Espera unos minutos para que el user data termine de ejecutarse

## 📚 Recursos Adicionales

- [Documentación oficial de Terraform](https://www.terraform.io/docs)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Terraform Modules Guide](https://www.terraform.io/docs/language/modules/index.html)

## 🤝 Contribuciones

Este es un proyecto de laboratorio. Siéntete libre de:
- Reportar issues
- Sugerir mejoras
- Crear pull requests
- Usar como base para tus propios proyectos

---

**Nota**: Este proyecto está diseñado para fines educativos y de laboratorio. Para uso en producción, considera implementar medidas adicionales de seguridad y monitoreo.
