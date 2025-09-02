import 'package:flutter/material.dart';
import 'package:nodelabscase/Core/Theme/app_colors.dart';

class CustomCheckboxButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final double size;

  const CustomCheckboxButton({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    this.size = 24,
  });

  @override
  State<CustomCheckboxButton> createState() => _CustomCheckboxButtonState();
}

class _CustomCheckboxButtonState extends State<CustomCheckboxButton> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void toggle() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: isChecked
              ? AppColors.primary
              : Colors.black.withOpacity(0.2), // aktif/pasif arka plan
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isChecked
                ? AppColors.primary
                : Colors.white.withOpacity(0.5), // border aktif/pasif
            width: 2,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isChecked
              ? const Icon(
            Icons.check,
            key: ValueKey("checked"),
            color: Colors.white,
            size: 18,
          )
              : const SizedBox(
            key: ValueKey("unchecked"),
          ),
        ),
      ),
    );
  }
}
