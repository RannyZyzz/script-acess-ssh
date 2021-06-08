#!/bin/bash
#!/usr/bin/env node

### Verifica se o SSHPASS está instalado ###
if ! command -v sshpass &> /dev/null
then
    echo "SSHPASS não foi encontrado!"
    echo "Será instalado e encerrado!"
    echo "Depois rode o script novamente!"
    sleep 1;
    sudo apt-get install sshpass -y
    exit
fi

### Verifica se existe o nodemailer instalado no projeto ###
local_1=`pwd`;
local_2='/node_modules/nodemailer';
DIR="${local_1}${local_2}";
echo "$DIR";
if [ -d "$DIR" ]; then
  echo "nodemailer instalado! É possível prosseguir."
  sleep 1;
else
  ###  Caso não exista vamos instalar ###
  echo "Error: ${DIR} não encontrado. Não é possivel prosseguir.";
  echo "Instalando nodemailer";
  sleep 1;
  npm init -y
  npm install nodemailer
  echo "Podemos prosseguir";
  echo "Execute o programa novamente"
  sleep 1;
  exit
fi


##Execução do Script
echo "Acesso ao servidor";
echo "Informe a conta de acesso ao servidor SSH";
read contaSsh;
echo "Informe a senha para acesso a conta: $contaSsh";
read senhaContaSsh;


##Acesso a maquina
svrms2=`sshpass -p $senhaContaSsh ssh -o StrictHostKeyChecking=no $contaSsh "df -h | grep -e '/dev/vda1'"`;

##Salva em arquivo temporario (lembrar de excluir este arquivo ao final da execução do script)
echo "$svrms2" > txt_temp.txt;

##Atribui resultado do servidor em variável
analise=`cat txt_temp.txt | awk '{ print $5 }'`;
sleep 1;

rm txt_temp.txt;

case "$analise" in 
    90%)
        espaco="90%";
    ;;
    91%)
        espaco="91%";
    ;;
    92%)
        espaco="92%";
    ;;
    93%)
        espaco="93%"
    ;;
    94%)
        espaco="94%"
    ;;
    95%)
        espaco="95%"
    ;;
esac


if [ -z $espaco ]
then
    echo "Espaço ocupado: $analise"
else
    echo "Espaço ocupado: $espaco";
    ##Abertura de Ticket para o time de Suporte na plataforma Zendesk;
    node Zendesk_Ticket.js
    exit
fi
