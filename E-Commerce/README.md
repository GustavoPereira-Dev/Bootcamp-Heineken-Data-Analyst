# Projeto de E-Commerce

Esse projeto consiste em desenvolver uma modelagem de um E-Commerce com as seguintes propriedades abaixo: 

- Escopo: Produto, Estoque, Cliente, Pedido e Fornecedor

- Narrativa - Produto
  - Os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros)
  - Cada produto possui um fornecedor
  - Um ou mais produtos podem compor um pedido

- Narrativa - Cliente
  - O cliente pode se cadastrar no site com seu CPF ou CNPJ
  - O Endereço do cliente irá determinar o valor do frete
  - Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto

- Narrativa - Pedido
   - O pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega
  - Um produto ou mais compoem o pedido
  - O pedido pode ser cancelado

- Narrativa - Outros
  - Cliente PJ e PF - Uma conta pode ser PJ ou PF, mas não pode ter as duas informações
  - Pagamento - Pode ter cadastrado mais de uma forma de pagamento
  - Entrega - Possui status e código de rastreio

## Resultado da Modelagem: 

![alt text](Ecommerce.jpg)