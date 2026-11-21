// assets/js/app.js – ensure field names match the database schema
const SUPABASE_URL = "https://fovwfkujgjuooijwqcvm.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_U8UGxSX43Hj3BpXcrQxAag_8jQx_bx9";

import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const supabase = createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);

export async function fetchReviews(category) {
  const { data, error } = await supabase
    .from("reviews")
    .select("*")
    .eq("category", category)
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data || [];
}

export async function fetchreadings(category) {
  const { data, error } = await supabase
    .from(category)
    .select("*")
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data || [];
}

function normalizeReview(review) {
  const numericFields = [
    'ano', 'assistido_em', 'grafico_animacao', 'estetica',
    'som_efeito_sonoro', 'vozes', 'apresentacao', 'roteiro_historia',
    'personagens', 'ambiente'
  ];
  numericFields.forEach(field => {
    if (review[field] !== undefined) {
      const val = Number(review[field]);
      review[field] = isNaN(val) ? null : val;
    }
  });
  if (!('media' in review)) {
    const numericValues = numericFields.map(f => review[f] || 0);
    review.media = Math.round(numericValues.reduce((a, b) => a + b, 0) / numericValues.length * 100) / 100;
  }
  return review;
}

export async function addReview(review) {

// Existing addReview implementation

  const { data, error } = await supabase
    .from("reviews")
    .insert([review])
    .single();
  if (error) throw error;
  return data;
}



export async function fetchLastFive(category) {
  const { data, error } = await supabase
    .from(category)
    .select("*")
    .order("created_at", { ascending: false })
    .limit(5);
  if (error) throw error;
  return data || [];
}

export async function fetchGames() {
  const { data, error } = await supabase
    .from("games")
    .select("*")
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data || [];
}

export async function addReadingReview(review) {
  const { data, error } = await supabase
    .from("reading")
    .insert([review])
    .single();
  if (error) throw error;
  return data;
}
