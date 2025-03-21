double division(int nbre1, int nbre2) {
  // On lève une exeption car la division par 0 est impossible
  if (nbre2 == 0) {
    throw UnsupportedError("nbre2 doit être non nul.");
  }
  return nbre1 / nbre2;
}

void main() {
  print(division(2, 3));
  print(division(2, 0));
}
