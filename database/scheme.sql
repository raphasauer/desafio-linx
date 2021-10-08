CREATE TABLE IF NOT EXISTS public.shoes
(
    id integer NOT NULL,
    modelname character varying(25) COLLATE pg_catalog."default" NOT NULL,
    brand character varying(25) COLLATE pg_catalog."default" NOT NULL,
    stock integer NOT NULL,
    size integer NOT NULL,
    price numeric(6,2) NOT NULL,
    CONSTRAINT shoes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shoes
    OWNER to raphael;