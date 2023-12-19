import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ml_kit_akademi_examples/common/text_recocnizer_painter.dart';
import 'package:ml_kit_akademi_examples/ui/image_labeling/detector_view.dart';

class TextRecognitonView extends StatefulWidget {
  const TextRecognitonView({super.key});

  @override
  State<TextRecognitonView> createState() => _TextRecognitonViewState();
}

class _TextRecognitonViewState extends State<TextRecognitonView> {
  var _script = TextRecognitionScript.latin;
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? text;
  var cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          DetectorView(
            title: "Text Detector",
            onImage: _processImage,
            customPaint: _customPaint,
            initialCameraLensDirection: cameraLensDirection,
            onCameraLensDirectionChanged: (mode) => cameraLensDirection = mode,
          ),
          Positioned(
              child: Row(
            children: [
              Spacer(),
              Container(
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDropdown(),
                ),
              ),
              Spacer(),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
        value: _script,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (TextRecognitionScript? script) {
          if (script != null) {
            setState(() {
              _script = script;
              _textRecognizer.close();
              _textRecognizer = TextRecognizer(script: _script);
            });
          }
        },
        items: TextRecognitionScript.values.map<DropdownMenuItem<TextRecognitionScript>>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
      );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      text = '';
    });

    final recognizedText = await _textRecognizer.processImage(inputImage);

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
          recognizedText, inputImage.metadata!.size, inputImage.metadata!.rotation, cameraLensDirection);
      _customPaint = CustomPaint(painter: painter);
    } else {
      text = 'Recognized Text:\n\n${recognizedText.text}';
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
