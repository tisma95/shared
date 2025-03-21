import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:provider/provider.dart';

class ProviderStore {
  final List<dynamic> _providers = [
    ChangeNotifierProvider(create: (context) => TaskProvider())
  ];

  get provider {
    return _providers;
  }

  void resetAllState(BuildContext context) {
    context.read<TaskProvider>().resetTaskProvider();
  }
}
