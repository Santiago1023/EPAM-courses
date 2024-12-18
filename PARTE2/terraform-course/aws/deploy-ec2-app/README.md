# Ejemplo 

Creamos una instancia EC2 en la free tier con un security group que permita el trafico a los puertos 3000 (backend), 3030(frontend), y 22(ssh).

Debemos crear un key-pair en la consola de aws, guardar el .pem en la raíz del proyecto (no recomendado), y si necesitas conectarte a la ec2 por ssh debes copiar algo así: ssh -i "my-terraform-key.pem" ec2-user@ec2-3-95-166-100.compute-1.amazonaws.com

El archivo init-script.sh es la configuración para la máquina ec2.