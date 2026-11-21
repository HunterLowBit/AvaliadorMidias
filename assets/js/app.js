// assets/js/app.js
// Supabase config – replace with your real keys
const SUPABASE_URL = "YOUR_SUPABASE_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";

import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

/**
 * Fetch reviews for a given category.
 * @param {string} category One of games, movies, series, anime, reading
 * @returns {Promise<Array<{id, nome, ano, idioma_assistido, assistido_em, grafico_animacao, estetica, som_efeito_sonoro, voces, apresentacao, roteiro_historia, personagens, ambiente, media, obs}>>
 */
export async function fetchReviews(category) {
  const { data, error } = await supabase
    .from("reviews")
    .select(
      "id, nome, ano, idioma_assistido, assistido_em, grafico_animacao, estetica, som_efeito_sonoro, voces, apresentacao, roteiro_historia, personagens, ambiente, media, obs"
    )
    .eq("category", category)
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data || [];
}

export async function addComment(reviewId, commentText) {
  const { data, error } = await supabase
    .from("comments")
    .insert({ review_id: reviewId, comment: commentText })
    .single();
  if (error) throw error;
  return data;
}
