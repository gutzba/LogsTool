#!/bin/bash

#Calculo de EPS por Logs
#Uso se reciben 3 valores la fecha que sera en el formato en el que viene el Log
# el segundo valor es el nombre ubicacion del Log a evaluar
# el tercer valor es un patron debido a que los logs no siempre llegan con el mismo formato de fecha es necesario definir cual es el patron con el que se va a evaluar
# Patron = al valor que exista antes de la Fecha
# cisco= ^   <-Inicio de Linea
# apache= \[    <- \[2012-05-03]
# checkpoint=time=
# snare
#
# En caso de no definir un patron se buscara solamente la linea que haga match con el formato de fecha ingresado
#
#
# se necesitan minimo 2 parametros para su funcionamiento
#### 
patron="" #Tomando en cuenta el log
separador="T" #formato de separacion entre dia y hora
####
usage ()
{
     echo "Se necesitan dos parametros"
     echo "Uso: $0 [fecha] [archivo] [separador (opcional)]"
     echo "$0 2012-05-09 /var/log/syslog ^"
}
# se revisan que sean minimo 2 parametros
if [ $# -lt 2 ]
then
    usage
    exit
fi
fecha=$1
log=$2

DAY=$fecha ; 
for h in `seq -w 0 23` ;do echo -n "$DAY $h:00:00 ->";EVENTS=$(grep "$patron$fecha$separador$h:" $log | wc -l); eps=$(echo "scale=4; $EVENTS/3600" | bc); echo "EVENTS=$EVENTS ; eps=$eps"; done
echo "El grep para la separacion de fechas y horas fue:"
salida="$patron$fecha$separador$h:"
echo $salida
