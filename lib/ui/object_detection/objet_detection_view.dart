import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:ml_kit_akademi_examples/common/object_detector_painter.dart';
import 'package:ml_kit_akademi_examples/common/utils.dart';
import 'package:ml_kit_akademi_examples/ui/image_labeling/detector_view.dart';

class ObjectDetectorView extends StatefulWidget {
  const ObjectDetectorView({super.key});

  @override
  State<ObjectDetectorView> createState() => _ObjectDetectorViewState();
}

class _ObjectDetectorViewState extends State<ObjectDetectorView> {
  ObjectDetector? _objectDetector;
  DetectionMode _mode = DetectionMode.stream;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  int _option = 0;

  final _options = {
    'default': '',
    'object_custom': 'object_labeler.tflite',
    'fruits': 'object_labeler_fruits.tflite',
    'flowers': 'object_labeler_flowers.tflite',
    'birds': 'lite-model_aiy_vision_classifier_birds_V1_3.tflite',
    'food': 'lite-model_aiy_vision_classifier_food_V1_1.tflite',
    'plants': 'lite-model_aiy_vision_classifier_plants_V1_3.tflite',
    'mushrooms': 'lite-model_models_mushroom-identification_v1_1.tflite',
    'landmarks': 'lite-model_on_device_vision_classifier_landmarks_classifier_north_america_V1_1.tflite',
  };

  @override
  void dispose() {
    _canProcess = false;
    _objectDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DetectorView(
            title: "Object Detection",
            customPaint: _customPaint,
            text: _text,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraFeedReady: _initializeDetector,
            initialDetectionMode: DetectorViewMode.values[_mode.index],
            onDetectorViewModeChanged: _onScreenModeChanged,
            onImage: _processImage),
        Positioned(
            top: 30,
            left: 100,
            right: 100,
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: _buildDropdown(),
                )
              ],
            ))
      ]),
    );
  }

  Widget _buildDropdown() => DropdownButton<int>(
        value: _option,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (int? option) {
          if (option != null) {
            setState(() {
              _option = option;
              _initializeDetector();
            });
          }
        },
        items: List<int>.generate(_options.length, (i) => i).map<DropdownMenuItem<int>>((option) {
          return DropdownMenuItem<int>(
            value: option,
            child: Text(_options.keys.toList()[option]),
          );
        }).toList(),
      );

  void _onScreenModeChanged(DetectorViewMode mode) {
    switch (mode) {
      case DetectorViewMode.gallery:
        _mode = DetectionMode.single;
        _initializeDetector();
        return;

      case DetectorViewMode.liveFeed:
        _mode = DetectionMode.stream;
        _initializeDetector();
        return;
    }
  }

  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;

    if (_option == 0) {
      final options = ObjectDetectorOptions(
        mode: _mode,
        classifyObjects: true,
        multipleObjects: true,
      );
      _objectDetector = ObjectDetector(options: options);
    } else if (_option > 0 && _option <= _options.length) {
      final option = _options[_options.keys.toList()[_option]] ?? '';
      final modelPath = await getAssetPath('assets/ml/$option');
      final options = LocalObjectDetectorOptions(
        mode: _mode,
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: true,
      );
      _objectDetector = ObjectDetector(options: options);
    }

    _canProcess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final objects = await _objectDetector!.processImage(inputImage);
    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = ObjectDetectorPainter(
        objects,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Objects found: ${objects.length}\n\n';
      for (final object in objects) {
        text += 'Object:  trackingId: ${object.trackingId} - ${object.labels.map((e) => e.text)}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
