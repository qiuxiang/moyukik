import 'package:flutter/material.dart';

class Span extends LeafRenderObjectWidget {
  final String text;
  final TextStyle? style;

  const Span(this.text, {this.style});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SpanRender(text, style);
  }

  @override
  void updateRenderObject(BuildContext context, SpanRender render) {
    render.update(text, style);
  }
}

class SpanRender extends RenderBox {
  String text;
  TextStyle? style;
  TextPainter painter;
  Size? savedSize;

  SpanRender(this.text, this.style)
      : painter = TextPainter(
          text: TextSpan(style: style, text: text),
          textDirection: TextDirection.ltr,
        );

  void update(String text, TextStyle? style) {
    if (text == this.text && style == this.style) return;

    this.text = text;
    this.style = style;
    painter.text = TextSpan(text: text, style: style);
    painter.layout();
    if (painter.size != savedSize) {
      markNeedsLayout();
    }
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    painter.paint(context.canvas, offset);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    painter.layout();
    performResize();
  }

  @override
  void performResize() {
    savedSize = constraints.constrain(painter.size);
    size = savedSize!;
  }
}
