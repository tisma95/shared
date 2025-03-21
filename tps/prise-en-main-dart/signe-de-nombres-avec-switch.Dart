// Programme qui détermine si un nombre est positif ou négatif ou nul avec switch
final int nbre = 12;

void main() {
  switch(nbre) {
    case > 0:
      print("Le nombre $nbre est positif.");
      break;
    case < 0:
      print("Le nombre $nbre est négatif.");
      break;
    default:
      print("Le nombre $nbre est nul.");
      break;
  }
}