// Exercice: Ecrire un programme qui affiche la liste des nombres pairs entre un nombre de départ et de fin. Le programme doit se terminer dès que lors du parcours il rencontre son nombre interdit qui est 100.

// Ce programme fait appel à la notion de break/continue dans une boucle
// Le programme peut être fait de manière beaucoup plus simple

final int MIN_VALUE = 0;
final int MAX_VALUE = 200;
final int NBRE_INTERDIT = 100;

void main() {
  print("Les nombres pairs entre $MIN_VALUE et $MAX_VALUE sont:");
  for (int nbre = MIN_VALUE; nbre <= MAX_VALUE; nbre++) {
    if (nbre == NBRE_INTERDIT) {
      print("J'ai rencontré mon nombre interdit $NBRE_INTERDIT !");
      break;
    } else if (nbre % 2 != 0) {
      continue;
    }
    print(nbre);
  }
}
