-- migration: create movies table
-- DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  ano int,
  media numeric,
  obs text,
  created_at timestamptz DEFAULT now()
);

-- RLS: allow all users to read, only admins to write
ALTER TABLE movies ENABLE ROW LEVEL SECURITY;
CREATE POLICY admin_rw ON movies USING (auth.role() IN ('admin', 'auxiliar'));
CREATE POLICY public_select ON movies USING (TRUE);