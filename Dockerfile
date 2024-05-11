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
