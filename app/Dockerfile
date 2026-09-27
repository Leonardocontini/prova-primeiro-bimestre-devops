# ─── Estágio 1: builder ───────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

# ─── Estágio 2: produção ──────────────────────────────────────────────────────
FROM node:20-alpine AS production

WORKDIR /app

# Cria usuário não-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copia apenas as dependências instaladas e o código fonte
COPY --from=builder /app/node_modules ./node_modules
COPY . .

# Garante que o usuário não-root é dono dos arquivos
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

CMD ["node", "src/server.js"]
