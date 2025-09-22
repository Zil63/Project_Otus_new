#!/bin/bash
set -e

SSL_DIR="./ssl"
DOMAIN="localhost"

mkdir -p "$SSL_DIR"

echo "🔹 Генерируем самоподписанный сертификат для $DOMAIN..."
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$SSL_DIR/nginx-selfsigned.key" \
  -out "$SSL_DIR/nginx-selfsigned.crt" \
  -subj "/CN=$DOMAIN"

echo "🔹 Сертификат создан:"
echo "  - $SSL_DIR/nginx-selfsigned.key"
echo "  - $SSL_DIR/nginx-selfsigned.crt"
