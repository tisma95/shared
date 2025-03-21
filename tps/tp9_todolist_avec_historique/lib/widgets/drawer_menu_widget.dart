import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  const DrawerMenuWidget({super.key, required this.pageType});

  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    // Build the menu
    return Drawer(
        semanticLabel: "Tâches à faire",
        backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Not necessary to show in semantic
            ExcludeSemantics(
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Icon(
                  Icons.widgets,
                  size: 38,
                ),
              ),
            ),
            _MenuItem(
              pageType: PageType.todo,
              isSelected: pageType == PageType.todo,
            ),
            _MenuItem(
              pageType: PageType.completed,
              isSelected: pageType == PageType.completed,
            )
          ],
        ));
  }
}

class _MenuItem extends StatelessWidget {
  @override
  const _MenuItem({required this.pageType, required this.isSelected});

  final PageType pageType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
        button: true,
        label: "Menu",
        child: ListTile(
          leading: getIconOfMenu(pageType),
          title: getTextOfMenu(pageType, context),
          titleTextStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          selected: isSelected,
          selectedTileColor: Theme.of(context).primaryColor,
          selectedColor: const Color.fromRGBO(249, 250, 251, 1),
          textColor: Colors.black,
          onTap: () => onTapMenu(pageType, context),
        ));
  }

  onTapMenu(PageType pageType, BuildContext context) {
    switch (pageType) {
      case PageType.todo:
        context.goNamed("todo");
        break;
      case PageType.completed:
        context.goNamed("complete");
        break;
    }
    // Close the drawer
    Navigator.pop(context);
  }

  Icon getIconOfMenu(PageType pageType) {
    const double iconSize = 30;
    IconData? icon;
    switch (pageType) {
      case PageType.todo:
        icon = Icons.list;
        break;
      case PageType.completed:
        icon = Icons.checklist;
        break;
    }
    return Icon(icon, size: iconSize);
  }

  Text getTextOfMenu(PageType pageType, BuildContext context) {
    String menuString;
    switch (pageType) {
      case PageType.todo:
        menuString = "À faire";
        break;
      case PageType.completed:
        menuString = "Terminée";
        break;
    }

    return Text(menuString);
  }
}
