// Supabase config – replace with your real keys
const SUPABASE_URL = "YOUR_SUPABASE_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";

import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

/**
 * Fetch reviews for a given category.
 * @param {string} category One of games, movies, series, anime, reading
 * @returns {Promise<Array<{id, title, rating, comment}>>}
 */
export async function fetchReviews(category) {
  // We assume reviews table has columns: id, title, rating, comment, category
  const { data, error } = await supabase
    .from("reviews")
    .select("id, title, rating, comment")
    .eq("category", category)
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data || [];
}

// Example of adding a comment – open a modal or form in the future.
export async function addComment(reviewId, commentText) {
  const { data, error } = await supabase
    .from("comments")
    .insert({ review_id: reviewId, comment: commentText })
    .single();
  if (error) throw error;
  return data;
}
