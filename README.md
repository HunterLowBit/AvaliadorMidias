# Avaliações de Conteúdos

## Visão geral
- **Frontend**: Páginas estáticas hospedadas no GitHub Pages.
- **Backend**: Supabase (PostgreSQL + API REST). As tabelas esperadas são `reviews` e `comments`.
- **RLS**: Configure regras de RLS nas tabelas conforme a descrição (admin‑only writes para `reviews`, público para `comments`).
- **Supabase SDK**: `supabase-js` via CDN. Configure os valores `SUPABASE_URL` e `SUPABASE_ANON_KEY` no arquivo `assets/js/app.js`.

## Estrutura de arquivos
```
/public
  index.html
  games.html
  movies.html
  series.html
  anime.html
  reading.html
/assets
  /css
    style.css
  /js
    app.js
```

## Como usar
1. Crie uma conta no Supabase e configure as tabelas `reviews` e `comments` com as colunas necessárias (`id`, `title`, `rating`, `comment`, `category`, `created_at`).
2. Defina as regras de RLS: apenas admins podem inserir/atualizar/apagar em `reviews`; todos podem inserir em `comments`.
3. Substitua `YOUR_SUPABASE_URL` e `YOUR_SUPABASE_ANON_KEY` no arquivo `assets/js/app.js`.
4. Faça commit e push para o seu repositório GitHub.
5. Ative o GitHub Pages (branch `main` ou `master`, pasta raiz).
6. Acesse as páginas: `index.html`, `games.html`, etc.

## Extensões futuras
- Formulário de envio de avaliação (somente admins, usando Supabase auth).
- Sistema de comentários interativos.
- Páginas de detalhes por review.

---

© 2026 Avaliações de Conteúdos. All rights reserved.
