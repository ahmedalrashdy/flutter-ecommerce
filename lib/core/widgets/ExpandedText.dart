import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  String text;
  int maxLines;
  TextStyle? style;
  ExpandedText({super.key, required this.text, this.maxLines = 3, this.style});

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  @override
  Widget build(BuildContext context) {
    return _buildExpandableText();
  }

  bool addHideAction = false;
  bool _isExpanded = false;
  Widget _buildExpandableText() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text);
        final tp = TextPainter(
          text: span,
          maxLines: _isExpanded ? null : widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (!tp.didExceedMaxLines) {
          if (addHideAction) {
            return InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = false;
                });
              },
              child: Text(
                widget.text,
                style: widget.style,
              ),
            );
          } else {
            return Text(widget.text, style: widget.style);
          }
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                style: widget.style,
                maxLines: _isExpanded ? null : widget.maxLines,
                overflow:
                    _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    addHideAction = true;
                  });
                },
                child: Text(
                  _isExpanded ? "عرض أقل" : "عرض المزيد",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
