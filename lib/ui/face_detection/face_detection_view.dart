import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ml_kit_akademi_examples/common/face_detection_painter.dart';
import 'package:ml_kit_akademi_examples/ui/image_labeling/detector_view.dart';

class FaceDetectionView extends StatefulWidget {
  const FaceDetectionView({super.key});

  @override
  State<FaceDetectionView> createState() => _FaceDetectionViewState();
}

class _FaceDetectionViewState extends State<FaceDetectionView> {
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var cameraLensDirection = CameraLensDirection.front;
  final FaceDetector _faceDetector =
      FaceDetector(options: FaceDetectorOptions(enableContours: true, enableLandmarks: true));

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: DetectorView(
        title: "Face Detector",
        onImage: _processImage,
        customPaint: _customPaint,
        initialCameraLensDirection: cameraLensDirection,
        onCameraLensDirectionChanged: (mode) => cameraLensDirection = mode,
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces: faces,
        imageSize: inputImage.metadata!.size,
        rotation: inputImage.metadata!.rotation,
        cameraLensDirection: cameraLensDirection,
      );

      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = "Faces found: ${faces.length}\n\n";
      for (final face in faces) {
        text = "face: ${face.boundingBox}\n\n";
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
