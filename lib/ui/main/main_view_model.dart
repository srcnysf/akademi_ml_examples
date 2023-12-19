import 'package:ml_kit_akademi_examples/core/di.dart';
import 'package:ml_kit_akademi_examples/core/repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends BaseViewModel {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  NavigationService navigationService = NavigationService();
  Repository repository = getIt<Repository>();

  init() {}

  void setTabIndex(int value) {
    _currentTabIndex = value;
    notifyListeners();
  }
}
