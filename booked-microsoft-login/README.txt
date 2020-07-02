/--------------Instalação-----------------/

Para ativar o microsoft login na aplicação Booked, basta colocar estes ficheiros na pasta de raiz e aceitar quando for pedido para substituir os ficheiros.

De seguida, deverá mudar a constante "ROOT" no ficheiro WebServices/MicrosoftLogin/microsoftConfig.php para a directoria de raiz onde se encontra a aplicação booked.

Se correr tudo bem, deverá aparecer uma imagem do office na página inicial de login. 

Se não aparecer, deverá apagar o ficheiro de cache "tpl_c/b5554bab8287232775be7b0969c62495b0011649_0.file.login.tpl.php".

É de notar que a aplicação só vai funcionar em localhost até ser criado um serviço Microsoft específico para versão online. 


/------------Serviço de terceiro Microsoft----------/


Para estabelecer conexão aos serviços da Microsoft, foi necessário registar uma aplicação no site "portal.azure.com".

De momento, esta conexão é feita através de uma aplicação feita numa conta pessoal minha, que foi utilizada para testes.

Convém que seja criada uma nova conta, com uma aplicação específica para o booked. Eu detalhei estas instruções
neste documento:

https://docs.google.com/document/d/18gnqV6xzCnSdqWAdpNXDpTR16YTZYKagjuQRRsUIFPQ/edit?usp=sharing