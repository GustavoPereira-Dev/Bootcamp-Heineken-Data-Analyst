# Projeto de Oficina

Esse projeto consiste em desenvolver uma modelagem de uma Oficina com as seguintes propriedades abaixo: 

- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
  - Clientes levam veículos à oficina mêcanica para serem consertados ou para passarem por revisões periódicas
  - Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
  - A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
  - O valor de cada peça também irá compor a OS
  - O cliente autoriza a execução dos serviços
  - A mesma equipe avalia e executa os serviços
  - Os mecânicos possuem código, nome, endereço e especialidade
  - Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.
  - Um OS pode ser composto por vários serviços e um mesmo serviço pode estar contido em mais de um OS.
  - Uma OS pode ter vários tipos de peça e uma peça pode estar presente em mais de uma OS

## Resultado da Modelagem
  ![alt text](Oficina.jpg)