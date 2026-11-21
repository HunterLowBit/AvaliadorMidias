-- migration: create games table and trigger for media calculation

-- Drop table if it already exists (for re-run)
DROP TABLE IF EXISTS games;

CREATE TABLE games (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  ano int,
  idioma text,
  jogabilidade int,
  apresentacao int,
  grafico int,
  som int,
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
CREATE OR REPLACE FUNCTION set_games_media()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  -- average of the numeric columns (ignore nulls by treating them as 0)
  NEW.media := (
    COALESCE(NEW.jogabilidade,0)+
    COALESCE(NEW.apresentacao,0)+
    COALESCE(NEW.grafico,0)+
    COALESCE(NEW.som,0)+
    COALESCE(NEW.ambiente,0)+
    COALESCE(NEW.designers,0)+
    COALESCE(NEW.roteiro,0)+
    COALESCE(NEW.historia,0)+
    COALESCE(NEW.personagens,0)+
    COALESCE(NEW.vozes,0)
  ) / 10.0;

  RETURN NEW;
END;
$$;

-- Trigger to run before insert or update
CREATE TRIGGER trg_games_media
BEFORE INSERT OR UPDATE ON games
FOR EACH ROW
EXECUTE FUNCTION set_games_media();

-- RLS for games – only admins can write, everyone can read
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
CREATE POLICY admin_rw ON games USING (auth.role() IN ('admin', 'auxiliar'));
CREATE POLICY public_select ON games USING (TRUE);

-- Optional: add index for faster queries
CREATE INDEX games_category_idx ON games (nome);