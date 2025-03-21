// Pour importer les librairies internes à Dart, il faut précéder de 'dart:' le nom de la librairie à importer.
import "dart:io";

// Pour importer des librairies externes installées, il faut précéder de 'package:' le nom du fichier de base du package(module).
import 'package:flutter/material.dart';

// Pour importer des fichiers de code, il faut préciser le chemin d'accès au fichier dans import.
import "package:tp1_premier_programme_dart/test.dart";

// Utiliser le mot clé 'as' pour définir un préfixe à spécifier lors de l'utilisation d'une librairie
import "dart:io"
    as dartIo; // Toutes les fonctions de dart:io devront être précédées de dartIo

// Utiliser le mot clé 'show' pour importer une partie des fonctions ou classes d'un module
import "dart:io"
    show
        File,
        Directory; // Seules les classes File et Directory de dart:io seront disponibles les autres non

// Utiliser le mot clé 'hide' pour importer tout sauf une partie des fonctions ou classes d'un module
import "dart:io"
    hide
        File,
        Directory; // Toutes les classes de "dart:io" seront disponibles sauf File et Directory