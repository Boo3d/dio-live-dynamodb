#!/bin/bash

echo "Pesquisar item por artista"

aws dynamodb query \
    --table-name Users \
    --key-condition-expression "FullName = :fullname" \
    --expression-attribute-values  '{":fullname":{"S":"Juliana"}}'

echo "Pesquisar item por nome e nome de usuario"

aws dynamodb query \
    --table-name Users \
    --key-condition-expression "FullName = :fullname and UserName = :username" \
    --expression-attribute-values file://./src/keyConditions.json

echo "Pesquisa pelo index secundário baseado no Email do usuário"

aws dynamodb query \
    --table-name Users \
    --index-name Email-index \
    --key-condition-expression "Email = :email" \
    --expression-attribute-values  '{":email":{"S":"rafael555@email.com"}}'