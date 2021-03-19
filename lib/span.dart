import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Span extends LeafRenderObjectWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;

  const Span(this.text, {this.style, this.maxLines});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SpanRender(this);
  }

  @override
  void updateRenderObject(BuildContext context, SpanRender render) {
    render.update(this);
  }
}

class SpanRender extends RenderBox {
  Span widget;
  TextPainter painter;
  Size? savedSize;

  SpanRender(this.widget)
      : painter = TextPainter(
          text: TextSpan(style: widget.style, text: widget.text),
          textDirection: TextDirection.ltr,
        );

  void update(Span widget) {
    if (this.widget.text == widget.text && this.widget.style == widget.style) {
      return;
    }

    this.widget = widget;
    painter.text = TextSpan(
        text: widget.text, style: widget.style ?? Get.textTheme?.bodyText2);
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
    painter.maxLines = widget.maxLines;
    painter.layout(maxWidth: constraints.maxWidth);
    performResize();
  }

  @override
  void performResize() {
    savedSize = constraints.constrain(painter.size);
    size = savedSize!;
  }
}
