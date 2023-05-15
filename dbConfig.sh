#!/bin/bash

# Serviço utilizado
    # Amazon DynamoDB
    # Amazon CLI para execução em linha de comando

# Comandos para execução do experimento:


# Criar uma tabela


aws dynamodb create-table \
    --table-name Users \
    --attribute-definitions \
        AttributeName=FullName,AttributeType=S \
        AttributeName=UserName,AttributeType=S \
        AttributeName=Email,AttributeType=S \
        AttributeName=Password,AttributeType=S \
    --key-schema \
        AttributeName=FullName,KeyType=HASH \
        AttributeName=UserName,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=10,WriteCapacityUnits=5 \
    --global-secondary-indexes \
        "[
            {
                \"IndexName\":\"Email-index\",
                \"KeySchema\":[
                    {
                        \"AttributeName\":\"Email\",
                        \"KeyType\":\"HASH\"
                    }
                ],
                \"ProvisionedThroughput\":{
                    \"ReadCapacityUnits\":10,
                    \"WriteCapacityUnits\":5
                },
                \"Projection\":{
                    \"ProjectionType\":\"ALL\"
                }
            },
            {
                \"IndexName\":\"FullNameEmail-index\",
                \"KeySchema\":[
                    {
                        \"AttributeName\":\"FullName\",
                        \"KeyType\":\"HASH\"
                    },
                    {
                        \"AttributeName\":\"Email\",
                        \"KeyType\":\"RANGE\"
                    }
                ],
                \"ProvisionedThroughput\":{
                    \"ReadCapacityUnits\":10,
                    \"WriteCapacityUnits\":5
                },
                \"Projection\":{
                    \"ProjectionType\":\"ALL\"
                }
            },
            {
                \"IndexName\": \"Password-index\",
                \"KeySchema\": [
                    {
                        \"AttributeName\": \"Password\",
                        \"KeyType\": \"HASH\"
                    }
                ],
                \"Projection\": {
                    \"ProjectionType\": \"ALL\"
                },
                \"ProvisionedThroughput\": {
                    \"ReadCapacityUnits\": 10,
                    \"WriteCapacityUnits\": 5
                }
            }
        ]"

# Aguarda a entrada do usuário

read -n 1 -s -r -p "Pressione qualquer tecla para continuar...\n"

# Inserir um item

aws dynamodb put-item \
    --table-name Users \
    --item file://./src/itemUser.json

# Aguarda a entrada do usuário

read -n 1 -s -r -p "Pressione qualquer tecla para continuar..."

# Inserir múltiplos itens

aws dynamodb batch-write-item \
    --request-items file://./src/batchUsers.json