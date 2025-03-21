double division(int nbre1, int nbre2) {
  // On lève une exeption car la division par 0 est impossible
  if (nbre2 == 0) {
    // On aurait pu utiliser throw "nbre2 doit être non nul.";
    throw UnsupportedError("nbre2 doit être non nul.");
  }
  return nbre1 / nbre2;
}

void main() {
  try {
    int nbre1 = 2;
    int nbre2 = 0;
    double resultat = division(nbre1, nbre2);
    print("La division de $nbre1 par $nbre2 est: $resultat");
  } on UnsupportedError {
    print("La division par zéro est impossible.");
  } catch (err) {
    print("Une erreur a été rencontrée $err");
  }
}
