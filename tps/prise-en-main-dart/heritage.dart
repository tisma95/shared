class Personne {
  late String nom;
  late String prenom;
  // Garder le secret privé
  late String _secret;

  Personne({required this.nom, required this.prenom, required String secret}) {
    this._secret = secret;
    print("Personne $nom $prenom avec pour secret $secret créée !");
  }

  String get secret {
    return this._secret;
  }

  void description() {
    print("Je suis $nom $prenom mon secret est $_secret");
  }
}

// Définition d'une classe Elève qui hérite de la classe Personne
// La classe mère Personne sera accessible avec le mot clé super.
class Etudiant extends Personne {
  // Ajout des attributs supplémentaire à l'étudiant
  late String niveau;
  late int age;

  // Constructeur avec initialisation de l'élève comme étant une personne
  Etudiant(String nom, String prenom, String secret, String niveau, int age)
      : super(nom: nom, prenom: prenom, secret: secret) {
    this.niveau = niveau;
    this.age = age;
  }
  // Code de constructeur équivalent
  // Eleve(
  //     {required super.nom,
  //     required super.prenom,
  //     required super.secret,
  //     required String this.classe,
  //     required int this.age})
  //     : super();

  // Utilisation de @override pour changer une méthode existante du parent
  @override
  void description() {
    // Exécution de la fonction description parente
    super.description();
    // Affichage du niveau propre à la classe enfant
    print("Je étudiant avec un niveau d'études $niveau");
  }

  // Définition d'une fonction propre aux étudiants
  void afficherMonAge() {
    print("J'ai $age ans.");
  }
}

void main() {
  // Création d'une personne
  Personne personne = new Personne(nom: "John", prenom: "Doé", secret: "john");
  personne.description();
  // Création d'un étudiant
  Etudiant etudiant = Etudiant("Toto", "Test", "toto", "ingénieur", 18);
  etudiant.description();
  etudiant.afficherMonAge();
}
