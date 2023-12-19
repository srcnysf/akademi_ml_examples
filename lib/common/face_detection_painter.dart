import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ml_kit_akademi_examples/common/coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  List<Face> faces;
  Size imageSize;
  InputImageRotation rotation;
  CameraLensDirection cameraLensDirection;

  FaceDetectorPainter({
    required this.faces,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color.red;

    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color.green;

    for (final Face face in faces) {
      final left = translateX(
        face.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        face.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        face.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        face.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint1);
      void paintContour(FaceContourType type) {
        final contour = face.contours[type];

        if (contour?.points != null) {
          for (final Point point in contour!.points) {
            if (contour.type == FaceContourType.leftEye) {
              paint1.color = Colors.yellow;
              paint1.strokeWidth = 3.0;
            } else if (contour.type == FaceContourType.rightEye) {
              paint1.color = Colors.red;
              paint1.strokeWidth = 3.0;
            } else if (contour.type == FaceContourType.lowerLipBottom) {
              paint1.color = Colors.blue;
              paint1.strokeWidth = 3.0;
            } else if (contour.type == FaceContourType.lowerLipTop) {
              paint1.color = Colors.blue;
              paint1.strokeWidth = 3.0;
            } else {
              paint1.color = Colors.black;
              paint1.strokeWidth = 1.0;
            }

            canvas.drawCircle(
                Offset(
                  translateX(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    point.y.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                ),
                1,
                paint1);
          }
        }
      }

      void paintLandmark(FaceLandmarkType type) {
        final landmark = face.landmarks[type];
        if (landmark?.position != null) {
          canvas.drawCircle(
              Offset(
                translateX(
                  landmark!.position.x.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  landmark.position.y.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              2,
              paint2);
        }
      }

      for (final type in FaceContourType.values) {
        paintContour(type);
      }

      for (final type in FaceLandmarkType.values) {
        paintLandmark(type);
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}
