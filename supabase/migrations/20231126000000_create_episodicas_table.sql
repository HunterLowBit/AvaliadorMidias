-- migration: create episodicas table and trigger for media calculation

DROP TABLE IF EXISTS episodicas;

CREATE TABLE episodicas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  ano int,
  idioma_assistido text,
  assistido_em int,
  terminado_em int,
  quantidade_ep int,
  ep_assistidos int,
  temporada int,
  apresentacao int,
  grafico_animacao int,
  som_efeitos int,
  ambiente int,
  designers int,
  roteiro int,
  historia int,
  personagens int,
  vozes int,
  media numeric,
  obs text,
  created_at timestamptz DEFAULT now()
);

-- Trigger function to compute media automatically
CREATE OR REPLACE FUNCTION set_episodicas_media()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.media := (
    COALESCE(NEW.apresentacao,0)+
    COALESCE(NEW.grafico_animacao,0)+
    COALESCE(NEW.som_efeitos,0)+
    COALESCE(NEW.ambiente,0)+
    COALESCE(NEW.designers,0)+
    COALESCE(NEW.roteiro,0)+
    COALESCE(NEW.historia,0)+
    COALESCE(NEW.personagens,0)+
    COALESCE(NEW.vozes,0)
  ) / 9.0;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_episodicas_media
BEFORE INSERT OR UPDATE ON episodicas
FOR EACH ROW
EXECUTE FUNCTION set_episodicas_media();

-- RLS for episodicas – admins can write, everyone can read
ALTER TABLE episodicas ENABLE ROW LEVEL SECURITY;
CREATE POLICY admin_rw ON episodicas USING (auth.role() IN ('admin', 'auxiliar'));
CREATE POLICY public_select ON episodicas USING (TRUE);
