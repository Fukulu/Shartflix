import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 2,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(color: Colors.white70, fontSize: 14);
    const linkStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    if (_isExpanded) {
      // Açık hali
      return RichText(
        text: TextSpan(
          style: defaultStyle,
          children: [
            TextSpan(text: widget.text),
            const TextSpan(text: " "),
            TextSpan(
              text: "Show Less",
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => setState(() => _isExpanded = false),
            ),
          ],
        ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(text: widget.text, style: defaultStyle);
          final tp = TextPainter(
            text: span,
            maxLines: widget.trimLines,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          if (!tp.didExceedMaxLines) {
            return Text(widget.text, style: defaultStyle);
          }

          final cutText = widget.text.substring(
            0,
            tp.getPositionForOffset(Offset(constraints.maxWidth, tp.height))
                .offset,
          );

          return RichText(
            text: TextSpan(
              style: defaultStyle,
              children: [
                TextSpan(text: cutText.trimRight()),
                const TextSpan(text: "… "),
                TextSpan(
                  text: "Show More",
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() => _isExpanded = true),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
