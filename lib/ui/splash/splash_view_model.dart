import 'package:ml_kit_akademi_examples/app/app.router.dart';
import 'package:ml_kit_akademi_examples/ui/main/main_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends MainViewModel {
  init() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        NavigationService().pushNamedAndRemoveUntil(Routes.mainView);
      },
    );
  }
}
