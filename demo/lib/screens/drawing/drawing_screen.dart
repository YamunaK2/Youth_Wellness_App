import 'package:flutter/material.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final List<DrawingPoint?> points = [];

  double brushSize = 5.0;

  Color selectedColor = const Color(0xff00897B);

  void clearCanvas() {
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FAF9),

      appBar: AppBar(
        backgroundColor: const Color(0xffF5FAF9),
        elevation: 0,

        title: const Text(
          "Creative Space",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: clearCanvas,
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // Drawing area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),

              clipBehavior: Clip.antiAlias,

              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    points.add(
                      DrawingPoint(
                        point: details.localPosition,
                        color: selectedColor,
                        size: brushSize,
                      ),
                    );
                  });
                },

                onPanEnd: (_) {
                  points.add(null);
                },

                child: CustomPaint(
                  painter: DrawingPainter(points),
                  size: Size.infinite,
                ),
              ),
            ),
          ),

          // Color selection
          SizedBox(
            height: 65,

            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              children: [
                _colorButton(
                  const Color(0xff00897B),
                ),

                _colorButton(
                  Colors.blue,
                ),

                _colorButton(
                  Colors.purple,
                ),

                _colorButton(
                  Colors.pink,
                ),

                _colorButton(
                  Colors.orange,
                ),

                _colorButton(
                  Colors.red,
                ),

                _colorButton(
                  Colors.black,
                ),
              ],
            ),
          ),

          // Brush size
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.brush,
                  color: Color(0xff00897B),
                ),

                Expanded(
                  child: Slider(
                    value: brushSize,
                    min: 2,
                    max: 20,

                    activeColor: const Color(0xff00897B),

                    onChanged: (value) {
                      setState(() {
                        brushSize = value;
                      });
                    },
                  ),
                ),

                Text(
                  brushSize.toInt().toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              20,
            ),

            child: SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Your drawing is ready to save 🎨",
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.save_outlined,
                ),

                label: const Text(
                  "Save Drawing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00897B),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    final bool isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },

      child: Container(
        width: 42,
        height: 42,

        margin: const EdgeInsets.only(
          right: 12,
          top: 10,
          bottom: 10,
        ),

        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,

          border: Border.all(
            color: isSelected
                ? Colors.black
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}

class DrawingPoint {
  final Offset point;
  final Color color;
  final double size;

  DrawingPoint({
    required this.point,
    required this.color,
    required this.size,
  });
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      if (current == null || next == null) {
        continue;
      }

      final paint = Paint()
        ..color = current.color
        ..strokeWidth = current.size
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawLine(
        current.point,
        next.point,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant DrawingPainter oldDelegate,
  ) {
    return true;
  }
}