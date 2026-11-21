// assets/js/fields.js
// Defines the required fields for each media category based on Regras1Assistidos.txt

export const mediaFields = {
  // Generic fields used across all categories
  common: [
    "nome", // nome escrito da obra
    "ano", // ano de lançamento
    "idioma_assistido", // idioma assistido
    "assistido_em", // ano em que foi assistido
    "grafico_animacao", // gráfico / animação
    "estetica", // avaliação de 0 a 10
    "som_efeito_sonoro", // avaliação de 0 a 10
    "vozes", // dublado ou original + avaliação 0 a 10
    "apresentacao", // avaliação de 0 a 10
    "roteiro_historia", // avaliação de 0 a 10
    "personagens", // avaliação de 0 a 10
    "ambiente", // avaliação de 0 a 10
    "media", // média dos valores acima (deve ser calculada no back-end)
    "obs", // observações livres (texto, bullets, justificado)
  ],

  // For Filmes, Series, and Animes/Desenhos – same fields as common
  filme: [],
  serie: [],
  anime: [],
};
