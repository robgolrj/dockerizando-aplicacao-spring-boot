# Dockerizando uma aplicação Spring Boot com Maven

Este é um exemplo de como Dockerizar uma aplicação Spring Boot com Maven e usar o Docker Compose para orquestrar vários contêineres em um ambiente de desenvolvimento local.

## Estrutura do Projeto

```
poc-teste/
  ├── src/
  │   ├── main/
  │   │   ├── java/
  │   │   │   └── com/
  │   │   │       └── exemple/  
  │   │   │           └── pocteste/  
  │   │   │               └── Controller.java
  │   │   │               └── PocTesteApplication.java
  │   │   └── resources/
  │   │       └── application.properties
  │   └── test/
  ├── Dockerfile
  ├── docker-compose.yml
  └── pom.xml
```

## Conteúdo dos Arquivos

`Controller.java`:
```java
package com.example.pocteste;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class Controller {

    @GetMapping("/")
    public String getHello() {
        return "Serviço subiu com sucesso";
    }    
    
}
```

`PocTesteApplication.java`:
```java
package com.example.pocteste;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PocTesteApplication {

	public static void main(String[] args) {
		SpringApplication.run(PocTesteApplication.class, args);
	}

}
```

`application.properties`:
```
server.port=8080
spring.application.name=poc-teste
```

`Dockerfile`:
```Dockerfile
# Use a imagem base do OpenJDK 21 slim
FROM openjdk:21-slim

# Define o diretório de trabalho dentro do contêiner como /app
WORKDIR /app

# Copia todos os arquivos do diretório local para o diretório /app no contêiner
COPY . .

# Executa o comando Maven para compilar e empacotar a aplicação Java, ignorando os testes
RUN ./mvnw package -DskipTests

# Expõe a porta 8080 do contêiner, para permitir conexões externas à aplicação
EXPOSE 8080

# Define um argumento JAR_FILE que representa o caminho para o arquivo JAR da aplicação
ARG JAR_FILE=target/*.jar

# Copia o arquivo JAR especificado para app.jar dentro do contêiner
COPY ${JAR_FILE} app.jar

# Define o comando padrão a ser executado quando o contêiner for iniciado
CMD ["java", "-jar", "app.jar"]

```

`docker-compose.yml`:
```yaml
version: '3'
services:
  spring-boot-app:
    build: .
    ports:
      - "8080:8080"
```

`pom.xml`:
```xml
<project>
    <!-- Configuração do Maven -->
</project>
```

## Executando a Aplicação Dockerizada

1. Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

2. Navegue até o diretório raiz do seu projeto Spring Boot.

3. Execute o seguinte comando para construir a imagem Docker da sua aplicação:

   ```
   docker-compose build
   ```

4. Após a construção da imagem, execute o seguinte comando para iniciar os contêineres:

   ```
   docker-compose up
   ```

   Isso iniciará seu contêiner Spring Boot e o exporá na porta 8080 de sua máquina local.

5. Você pode acessar sua aplicação em `http://localhost:8080` e verá a mensagem "Serviço subiu com sucesso".

Esse é um exemplo básico de como Dockerizar uma aplicação Spring Boot com Maven e orquestrar os contêineres com Docker Compose em um ambiente de desenvolvimento local. Certifique-se de adaptar a estrutura do projeto e os arquivos de acordo com as necessidades específicas do seu projeto.
