@echo off

REM Serviço utilizado
    REM Amazon DynamoDB
    REM Amazon CLI para execução em linha de comando

REM Comandos para execução do experimento:


REM Criar uma tabela


aws dynamodb create-table ^
    --table-name Users ^
    --attribute-definitions ^
        AttributeName=FullName,AttributeType=S ^
        AttributeName=UserName,AttributeType=S ^
        AttributeName=Email,AttributeType=S ^
        AttributeName=Password,AttributeType=S ^
    --key-schema ^
        AttributeName=FullName,KeyType=HASH ^
        AttributeName=UserName,KeyType=RANGE ^
    --provisioned-throughput ^
        ReadCapacityUnits=10,WriteCapacityUnits=5 ^
    --cli-input-json ^
        file://./src/globalSecondaryIndexes.json

REM Aguarda a entrada do usuário

echo "Pressione qualquer tecla para continuar...\n"
pause

REM Inserir um item

aws dynamodb put-item ^
    --table-name Users ^
    --item file://./src/itemUser.json

REM Aguarda a entrada do usuário

echo "Pressione qualquer tecla para continuar..."
pause

REM Inserir múltiplos itens

aws dynamodb batch-write-item ^
    --request-items file://./src/batchUsers.json