import 'package:ml_kit_akademi_examples/ui/face_detection/face_detection_view.dart';
import 'package:ml_kit_akademi_examples/ui/image_labeling/image_labeling_view.dart';
import 'package:ml_kit_akademi_examples/ui/main/main_view.dart';
import 'package:ml_kit_akademi_examples/ui/palm_example/palm_example_view.dart';
import 'package:ml_kit_akademi_examples/ui/text_recognition/text_recognition_view.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/object_detection/objet_detection_view.dart';
import '../ui/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: MainView),
    MaterialRoute(page: ImageLabelingView),
    MaterialRoute(page: TextRecognitonView),
    MaterialRoute(page: FaceDetectionView),
    MaterialRoute(page: PampExampleView),
    MaterialRoute(page: ObjectDetectorView),
  ],
)
class App {}
