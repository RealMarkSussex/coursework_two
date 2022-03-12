import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class InteractiveImage extends StatefulWidget {
  final Image image;
  const InteractiveImage({Key? key, required this.image}) : super(key: key);

  @override
  State<InteractiveImage> createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  double scale = 1.0;
  double? previousScale;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) => previousScale = scale,
      onScaleUpdate: (details) => setState(() {
        if (previousScale != null) {
          setState(() {
            scale = previousScale! * details.scale;
          });
        }
      }),
      onScaleEnd: (details) => previousScale = null,
      child: Transform(
        transform: Matrix4.diagonal3(Vector3(scale, scale, scale)),
        alignment: FractionalOffset.center,
        child: widget.image,
      ),
    );
  }
}
