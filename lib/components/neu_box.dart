import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          // darker shadow on the bottom right
          BoxShadow(color: isDark ? Colors.black : Colors.grey.shade500, blurRadius: 15, offset: const Offset(4, 4)),
          // lighter shadow on the top left
          BoxShadow(color: isDark ? Colors.grey.shade800 : Colors.white, blurRadius: 15, offset: const Offset(-4, -4)),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(15),
      child: child,
    );
  }
}
