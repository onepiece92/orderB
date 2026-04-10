import 'package:flutter/foundation.dart';
import '../../data/models/address.dart';
import '../../../catalogue/data/datasources/catalogue_local_datasource.dart';

/// Manages the currently selected delivery/pickup address.
class AddressProvider extends ChangeNotifier {
  int _selectedId = 1;

  int get selectedId => _selectedId;

  Address get selected => CatalogueLocalDatasource.savedAddresses.firstWhere(
        (a) => a.id == _selectedId,
        orElse: () => CatalogueLocalDatasource.savedAddresses.first,
      );

  void select(int id) {
    _selectedId = id;
    notifyListeners();
  }
}
