import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mega_app/helper.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  const DrawerMenuWidget({super.key, required this.pageType});
  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Menu de l'application",
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ExcludeSemantics(
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary),
              child: Icon(
                Icons.widgets,
                size: 38,
                color: Colors.white,
              ),
            ),
          ),
          _MenuItem(
            pageType: PageType.funcat,
            isSelected: pageType == PageType.funcat,
          ),
          _MenuItem(
            pageType: PageType.password,
            isSelected: pageType == PageType.password,
          ),
          _MenuItem(
            pageType: PageType.todolist,
            isSelected: pageType == PageType.todolist,
          )
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  @override
  const _MenuItem({required this.pageType, required this.isSelected});

  final PageType pageType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: getIconOfMenu(pageType),
      title: getTextOfMenu(pageType),
      titleTextStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      selected: isSelected,
      selectedTileColor: Theme.of(context).primaryColor,
      selectedColor: const Color.fromARGB(255, 0, 255, 221),
      textColor: Colors.black,
      onTap: () => onTapMenu(pageType, context),
    );
  }

  void onTapMenu(PageType pageType, BuildContext context) {
    switch (pageType) {
      case PageType.funcat:
        context.goNamed("funcat");
        break;
      case PageType.password:
        context.goNamed("password");
        break;
      case PageType.todolist:
        context.goNamed("todo");
        break;
    }
  }

  Icon getIconOfMenu(PageType pageType) {
    const double iconSize = 30;
    switch (pageType) {
      case PageType.funcat:
        return Icon(
          Icons.pets,
          size: iconSize,
        );
      case PageType.password:
        return Icon(
          Icons.password,
          size: iconSize,
        );
      case PageType.todolist:
        return Icon(
          Icons.task,
          size: iconSize,
        );
    }
  }

  Text getTextOfMenu(PageType pageType) {
    String menuString;
    switch (pageType) {
      case PageType.funcat:
        menuString = "Fun Cat";
        break;
      case PageType.password:
        menuString = "Password Generator";
        break;
      case PageType.todolist:
        menuString = "Todo list";
        break;
    }
    return Text(menuString);
  }
}
