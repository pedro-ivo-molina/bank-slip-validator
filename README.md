# Validador de boletos
Este projeto é basicamente um validador de boleto, no formado do CNAB400, que é basicamente.

## Tecnologias usadas
 - Ruby e sinatra como linguagem e framework;
 - Docker para rodar o projeto;
 - Command como design pattern;
 
## Como rodar?
Há duas maneiras de rodar, a primeira maneira é instalando o Docker e Docker-Compose. Com eles instalados na sua máquina, basta rodar: `docker-compose build && docker-compose up` para a primeira vez que estiver rodando o projeto e `docker-compose up` nas próximas vezes.

A segunda maneira é instalando o rvm, após ele instalado entre na pasta do projeto e rode o comando que o rvm recomendar. Depois disso só rodar `rvm bundle install && rackup` na primeira vez que estiver rodando o projeto e nas próximas vezes somente `rackup`.

## Como funciona?
Há somente um endpoint no projeto inteiro, ele foi declarado no arquivo `app.rb`. A rota para ele é `/validate` e deverá se mandado com o verbo http `post`, no body da requisição deverá vir um form-data com um arquivo possuindo as linhas do boleto a ser validado.

Quando a requisição chegar, a action do endpoint irá fazer o trabalho de instanciar a classe `BookOfRules`, que conhece todas as regras de validações, e irá separar cada vetor retornado pelas funções nessa classe em três variáveis diferentes. Após isso, será instanciado a classe `Validator`, que é nosso Command.

Com isso feito, será chamado três funçoes, `validate_header`, `validate_body` e `validate_footer`. Cada uma dessas funções basicamente é um `each` de cada vetor de regra, chamando o método `validate` da regra que ele está lendo no momento. Isso foi feito para que a manutenção e adição de novas regras de negócio seja bastante simples, basta implementar a classe da regra no seu módulo específico `header, body ou footer` e colocar ela na sua inicialização correta no `BookOfRules`.

Cada uma dessas funções irá retornar um array de erros, junto com um array extra retornado pelo `Validator` chamado de `body_annotations`, que basicamente é um vetor que possuirá todas informações sobre campos opcionais no boleto. Sendo assim, com os retornos será chamado o `Serializer` que irá transformar em um `JSON`, retornando o mesmo.

Assim, chegamos ao fim do que o endpoint faz, que é retornar o `JSON` que foi serializado, para que fique fácil a iteração sobre ele no frontend.
