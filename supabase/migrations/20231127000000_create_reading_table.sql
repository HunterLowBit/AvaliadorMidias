
-- Migration: create reading table
DROP TABLE IF EXISTS reading;

CREATE TABLE reading (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  autor text,
  editora text,
  ano_leitura int,
  historia int,
  personagens int,
  ritmo int,
  enredo int,
  obs text,
  created_at timestamptz DEFAULT now()
);

-- RLS: allow all users to read, only admins to write
ALTER TABLE reading ENABLE ROW LEVEL SECURITY;
CREATE POLICY admin_rw ON reading USING (auth.role() IN ('admin', 'auxiliar'));
CREATE POLICY public_select ON reading USING (TRUE);