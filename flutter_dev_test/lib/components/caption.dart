import 'package:flutter/material.dart';

class TransparentCaption extends StatefulWidget {
  final String text;

  TransparentCaption({required this.text});

  @override
  _TransparentCaptionState createState() => _TransparentCaptionState();
}

class _TransparentCaptionState extends State<TransparentCaption> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4C4243).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _showFullText
                ? widget.text
                : widget.text.length > 150
                    ? widget.text.substring(0, 150)
                    : widget.text,
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          widget.text.length > 150
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      _showFullText = !_showFullText;
                    });
                  },
                  child: Text(
                    _showFullText ? 'See less' : 'See more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
