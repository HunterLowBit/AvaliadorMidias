-- migration: create tables and RLS

-- Drop tables if they already exist (for re-run)
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS reviews;

-- reviews table
CREATE TABLE reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  ano int,
  idioma_assistido text,
  assistido_em int,
  grafico_animacao text,
  estetica int,
  som_efeito_sonoro int,
  vozes text,
  apresentacao int,
  roteiro_historia int,
  personagens int,
  ambiente int,
  media numeric,
  obs text,
  category text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- comments table
CREATE TABLE comments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  review_id uuid REFERENCES reviews(id) ON DELETE CASCADE,
  comment text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- RLS for reviews – only admins
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
CREATE POLICY admin_rw ON reviews USING (auth.role() IN ('admin', 'auxiliar'));
CREATE POLICY public_select ON reviews USING (TRUE);

-- RLS for comments – all can read/write
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY public_rw ON comments USING (TRUE);

-- Optional: add indexes for faster queries
CREATE INDEX reviews_category_idx ON reviews (category);
