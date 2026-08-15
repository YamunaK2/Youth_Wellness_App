import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(42),
            border: Border.all(
              color: Colors.black,
              width: 10,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 30,
                color: Colors.black38,
              )
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(child: child),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 140,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}