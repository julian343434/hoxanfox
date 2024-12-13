-- Tabla: public.turno
CREATE TABLE public.turno (
    id_turno UUID PRIMARY KEY,
    fecha_creacion TIMESTAMP NOT NULL,
    observaciones CHARACTER VARYING(50),
    numero_cola INT NOT NULL,
    factura_cliente BYTEA,
    copia_negocio BYTEA
);

-- Tabla: public.productos_enturnados
CREATE TABLE public.productos_enturnados (
    id_productos_vendidos UUID PRIMARY KEY,
    id_producto UUID NOT NULL REFERENCES public.producto(id_producto),
    id_turno UUID NOT NULL REFERENCES public.turno(id_turno),
    estado BOOLEAN NOT NULL
);

-- Tabla: public.producto
CREATE TABLE public.producto (
    id_producto UUID PRIMARY KEY,
    nombre CHARACTER VARYING(50) NOT NULL,
    unidades INT NOT NULL,
    precio FLOAT4 NOT NULL
);

-- Tabla: public.cierre_diario
CREATE TABLE public.cierre_diario (
    id_cierre_diario UUID PRIMARY KEY,
    fecha_cierre TIMESTAMP NOT NULL,
    total_ventas FLOAT4 NOT NULL,
    fecha_apertura TIMESTAMP NOT NULL,
    hash_blockchaine TEXT NOT NULL REFERENCES public.historial_blockchain(hash_blockchaine),
    estado BOOLEAN NOT NULL,
    numero_transacciones INT NOT NULL,
    id_usuario UUID NOT NULL REFERENCES public.usuarios(id_usuario),
    identificacion INT NOT NULL REFERENCES public.usuarios(identificacion),
    id_operacion UUID NOT NULL REFERENCES public.operacion(id_operacion)
);

-- Tabla: public.historial_blockchain
CREATE TABLE public.historial_blockchain (
    hash_blockchaine TEXT PRIMARY KEY,
    fecha_generacion TIMESTAMP NOT NULL,
    id_operacion UUID NOT NULL REFERENCES public.operacion(id_operacion),
    id_usuario UUID NOT NULL REFERENCES public.usuarios(id_usuario),
    identificacion INT NOT NULL REFERENCES public.usuarios(identificacion),
    data JSON NOT NULL
);

-- Tabla: public.movimientoInventario
CREATE TABLE public.movimientoInventario (
    id_movimientoInventario UUID PRIMARY KEY,
    id_producto UUID NOT NULL REFERENCES public.producto(id_producto),
    id_operacion UUID NOT NULL REFERENCES public.operacion(id_operacion),
    fecha_movimiento TIMESTAMP NOT NULL,
    cantidad INT NOT NULL,
    descripcion CHARACTER VARYING(50),
    hash_blockchaine TEXT NOT NULL REFERENCES public.historial_blockchain(hash_blockchaine)
);

-- Tabla: public.operacion
CREATE TABLE public.operacion (
    id_operacion UUID PRIMARY KEY,
    nombre CHARACTER VARYING(50) NOT NULL
);

-- Tabla: public.usuarios
CREATE TABLE public.usuarios (
    id_usuario UUID PRIMARY KEY,
    identificacion INT NOT NULL UNIQUE,
    nombre CHARACTER VARYING(50) NOT NULL,
    correo CHARACTER VARYING(50) NOT NULL,
    id_rol UUID NOT NULL REFERENCES public.rol(id_rol)
);

-- Tabla: public.rol
CREATE TABLE public.rol (
    id_rol UUID PRIMARY KEY,
    nombre CHARACTER VARYING(50) NOT NULL
);
