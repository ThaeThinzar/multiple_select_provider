import 'package:flutter/foundation.dart';
import 'package:multi_select_lib/provider/search_model.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider();

  final List<SearchModel> _searchTypes = [];

  List<SearchModel> get searchTypes => _searchTypes;

  void setSearchTypes(List<SearchModel> searchTypeList) {
    _searchTypes.clear();
    _searchTypes.addAll(searchTypeList);
    notifyListeners();
  }

  void updateSearchTypesToList(SearchModel search, int index) {
    _searchTypes.removeAt(index);
    _searchTypes.insert(index, search);
    notifyListeners();
  }
}
