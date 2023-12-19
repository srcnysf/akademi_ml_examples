import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/app/app.router.dart';
import 'package:ml_kit_akademi_examples/common/create_bottom_nav_item.dart';
import 'package:stacked/stacked.dart';

import 'package:ml_kit_akademi_examples/ui/main/main_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => MainViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              // bottomNavigationBar: BottomNavigationBar(
              //   elevation: 0,
              //   type: BottomNavigationBarType.fixed,
              //   items: [
              //     createNavItem(TabItem.ImageLabeling),
              //     createNavItem(TabItem.FaceDetection),
              //     createNavItem(TabItem.TextRecognition),
              //   ],
              //   onTap: (value) {
              //     model.setTabIndex(value);
              //   },
              //   currentIndex: model.currentTabIndex,
              // ),
              // body: getViewForIndex(model.currentTabIndex),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.imageLabelingView);
                      },
                      child: Text("Image Recognition"),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.textRecognitonView);
                      },
                      child: Text("Text Recognition"),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.faceDetectionView);
                      },
                      child: Text("Face Recognition"),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.pampExampleView);
                      },
                      child: Text("Palm Examples"),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.objectDetectorView);
                      },
                      child: Text("Object Detection Examples"),
                    ),
                  ],
                ),
              ),
            ));
  }
}
