# Estágio de build
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN apk add --no-cache python3 make g++ \
    && npm install

COPY . .

# Estágio final
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app .

RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["node", "src/index.js"]