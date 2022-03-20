import 'package:flutter/material.dart';
import 'package:flutter_search_bar_sample/sample_data.dart';

class SearchBarController extends ChangeNotifier {
  final globalKey = GlobalKey<ScaffoldState>();

  /// state
  bool isLoading = true;
  bool isSearching = false;
  String _searchedText = '';

  var allItemList = <String>[];
  var searchedItemList = <String>[];

  String get searchedText => _searchedText;

  final scrollController = ScrollController();

  void init() {
    fetch();
  }

  Future<void> fetch() async {
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      // fetch data
      // allItemList = await hogehogeRepo.fetch();
      allItemList = exampleList;

      isLoading = false;
      notifyListeners();
    });
  }

  void searchStart() {
    isSearching = true;
    notifyListeners();
  }

  void searchEnd() {
    isSearching = false;
    _searchedText = '';
    searchedItemList.clear();
    notifyListeners();
  }

  void searchOperation(String searchText) {
    _searchedText = searchText;

    searchedItemList.clear();

    searchedItemList.addAll(
      allItemList.where(
        (element) => element.toLowerCase().contains(
              searchText.toLowerCase(),
            ),
      ),
    );
    notifyListeners();
  }
}
