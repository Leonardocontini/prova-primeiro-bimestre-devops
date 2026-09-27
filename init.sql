CREATE TABLE IF NOT EXISTS reservas (
    id SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    data_reserva TIMESTAMP NOT NULL,
    numero_pessoas INT,
    observacoes TEXT,
    status VARCHAR(20) DEFAULT 'confirmada',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
