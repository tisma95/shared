// Exercice: Ecrire un programme qui affiche la tranche d’âge en fonction de la catégorie Poussin (de 6 à 7 ans), Pupille (de 8 à 9 ans), Minime (de 10 à 11 ans) et Cadet (après 12 ans).

final String category = "cadets";

final Map<String, String> ageByCategory = {
  "poussin": "entre 6 et 7 ans",
  "pupille": "entre 8 et 9 ans",
  "minime": "entre 10 et 11 ans",
  "cadet": "12 ans et plus"
};

void main() {
  final String categoryKey = category.toLowerCase();

  // Utilisation de switch pour l'évaluation
  switch (categoryKey) {
    case 'poussin':
    case 'pupille':
    case 'minime':
    case 'cadet':
      print("Vous êtes $categoryKey votre avez ${ageByCategory[categoryKey]}.");
      break;
    default:
      print("Catégorie inconnue !");
      break;
  }
}
