Future<void> direHelloApresUneSeconde() async {
  // Attente de la fin de la Future qui est asynchrone
  await Future.delayed(Duration(seconds: 1));
  print("Hello");
}

void main() {
  direHelloApresUneSeconde();
  print("Je suis dans le main.");
}
