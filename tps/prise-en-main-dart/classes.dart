class Personne {
  late String nom;
  late String prenom;
  // Garder le secret privé
  late String _secret;

  // Une méthode plus rapide est d'utiliser le code ci-dessous
  // Personne({required this.nom, required this.prenom, required this.secret})
  Personne(String nom, String prenom, String secret) {
    this.nom = nom;
    this.prenom = prenom;
    this._secret = secret;
  }

  String get secret {
    return this._secret;
  }

  void description() {
    print("Je suis $nom $prenom mon secret est $_secret");
  }
}

void main() {
  // Création d'une personne
  Personne personne1 = new Personne("John", "Doé", "john");
  print(personne1.nom);
  print(personne1.prenom);
  personne1.description();
  // Création d'une autre personne
  Personne personne2 = new Personne("Toto", "Oro", "toto");
  personne2.description();
}
