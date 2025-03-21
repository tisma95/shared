// Exercice: Ecrire un programme qui analyse deux nombres et affiche le signe de leur produit négatif ou positif ou nul.
int nbre1 = -1;
int nbre2 = 2;

void main() {
  int produit = nbre1 * nbre2;
  if (produit > 0) {
    print("Le produit de $nbre1 et de $nbre2 est positif.");
  } else if (produit < 0) {
    print("Le produit de $nbre1 et de $nbre2 est négatif.");
  } else {
    print("Le produit de $nbre1 et de $nbre2 est nul.");
  }
}
