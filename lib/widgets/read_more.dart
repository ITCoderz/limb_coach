import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/app_colors.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int trimLines;

  const ReadMoreText({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 4,
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? const TextStyle(fontSize: 13);

    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: widget.text, style: defaultStyle);

      final tp = TextPainter(
        text: span,
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.maxWidth);

      final isOverflow = tp.didExceedMaxLines;

      if (!isOverflow) {
        return Text(widget.text, style: defaultStyle);
      }

      return GestureDetector(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: RichText(
          text: TextSpan(
            style: defaultStyle,
            children: [
              TextSpan(
                text: isExpanded
                    ? widget.text
                    : _trimText(widget.text, tp, size.maxWidth),
              ),
              TextSpan(
                text: isExpanded ? " Read Less" : " Read More",
                style: defaultStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Trim text manually to fit into given width with ellipsis
  String _trimText(String text, TextPainter tp, double maxWidth) {
    final span = TextSpan(text: text, style: widget.style);
    final painter = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
      ellipsis: '...',
    )..layout(maxWidth: maxWidth);

    int endIndex =
        painter.getPositionForOffset(Offset(maxWidth, tp.height)).offset;
    if (endIndex < text.length) {
      return "${text.substring(0, endIndex)}...";
    }
    return text;
  }
}
