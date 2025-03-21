// Exercice: Ecrire un programme qui affiche la tranche d’âge en fonction de la catégorie Poussin (de 6 à 7 ans), Pupille (de 8 à 9 ans), Minime (de 10 à 11 ans) et Cadet (après 12 ans).

enum Category { poussin, pupille, minime, cadet }

final Category category = Category.cadet;

void main() {
  // Utilisation de switch pour l'évaluation
  switch (category) {
    case Category.poussin:
      print("Vous êtes poussin votre avez entre 6 et 7 ans.");
      break;
    case Category.pupille:
      print("Vous êtes pupille votre avez entre 8 et 9 ans.");
      break;
    case Category.minime:
      print("Vous êtes minime votre avez entre 10 et 11 ans.");
      break;
    case Category.cadet:
      print("Vous êtes cadet votre avez 12 ans et plus.");
      break;
    default:
      print("Catégorie inconnue !");
      break;
  }
}
