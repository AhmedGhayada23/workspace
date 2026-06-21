import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

/// خط فاصل منقّط بين صفوف تفاصيل الحجز.
class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: DottedDecoration(
        shape: Shape.line,
        linePosition: LinePosition.bottom,
        color: const Color(0xFFBDBDBD),
        dash: const [4, 4],
      ),
    );
  }
}
