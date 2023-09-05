import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:wow_shopping/features/main/nav_item.dart';

class NavbarManager extends ChangeNotifier {
  NavbarManager(this._selectedItem) {
    gotoSectionCommand = Command.createSyncNoResult((item) {
      _selectedItem = item;
      notifyListeners();
    },
    errorFilter: const ErrorHandlerLocalAndGlobal(),
    );
  }

  late final Command<NavItem, void> gotoSectionCommand;
 
  NavItem _selectedItem ;
  NavItem get selectedItem => _selectedItem;
}