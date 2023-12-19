import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/ui/face_detection/face_detection_view.dart';
import 'package:ml_kit_akademi_examples/ui/image_labeling/image_labeling_view.dart';
import 'package:ml_kit_akademi_examples/ui/text_recognition/text_recognition_view.dart';

class TabItemData {
  String title;
  Widget icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.ImageLabeling: TabItemData(title: "Image Labeling", icon: Icon(Icons.image)),
    TabItem.FaceDetection: TabItemData(title: "Face Detection", icon: Icon(Icons.face)),
    TabItem.TextRecognition: TabItemData(title: "Text Recognition", icon: Icon(Icons.text_fields)),
  };
}

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(icon: currentTab.icon, label: currentTab.title);
}

enum TabItem { ImageLabeling, FaceDetection, TextRecognition }

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const ImageLabelingView();
    case 1:
      return const FaceDetectionView();
    case 2:
      return const TextRecognitonView();
    default:
      return Container();
  }
}
