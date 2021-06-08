//DEVE SER LIBERADO O ENVIO DE EMAILS POR APLICACOES TERCEIRAS NO DOMINIO DE SERVIDOR DE ENVIO - PARA CASO DE USO DE EMAILS QUE SEJAM DE MERCADO - GMAIL/OUTLOOK e etc.

const nodemailer = require('nodemailer');
const emailEnvio = 'Informe aqui'; //Campos devem ser preenchidos antes da execução
const emailEnvioSenha = 'Informe aqui'; //Campos devem ser preenchidos antes da execução
const emailDestino = 'Informe aqui'; //Deve ser informado o email de abertura de Tickets no Zendesk support@nomeCliente.zendesk.com
const emailAssunto = 'Informe aqui';
const emailTexto = 'Informe aqui';

function resolveAfter5Seconds(x) {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve(x);
      }, 5000);
    });
  }

const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 587,
    secure: false, // verdadeiro para 465, falso para outras portas
    auth: {
        user: emailEnvio,
        pass: emailEnvioSenha
    },
    tls: { rejectUnauthorized: false }
  });


  async function f1() {
    var x = await resolveAfter5Seconds(3);
    const mailOptions = {
        from: emailEnvio,
        to: emailDestino,
        subject: emailAssunto,
        text: emailTexto
      };
      
    transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
          return(x);
        } else {
          console.log('Email enviado: ' + info.response);
          return(x);
        }
      });
  }
  f1();
