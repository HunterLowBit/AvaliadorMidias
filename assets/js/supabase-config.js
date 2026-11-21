// Supabase configuration helper
export function configureSupabase(url, anonKey) {
  const supabase = createClient(url, anonKey);
  return supabase;
}
