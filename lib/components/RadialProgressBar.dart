import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgressBar extends StatefulWidget {

  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPosition;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final Widget child;

  RadialProgressBar({
    this.child,
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressColor = Colors.black,
    this.progressWidth = 5.0,
    this.thumbColor = Colors.black,
    this.thumbSize = 10.0,
    this.thumbPosition=0.0,
    this.progressPercent=0.0,
    this.innerPadding = const EdgeInsets.all(0.0),
    this.outerPadding = const EdgeInsets.all(0.0)
  });

  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: CustomPaint(
        child: Padding(
          padding: _insetForPainter() + widget.innerPadding,
          child: widget.child,
        ),
        foregroundPainter: RadialSeekPainter(
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
          progressWidth: widget.progressWidth,
          thumbColor: widget.thumbColor,
          thumbPosition: widget.thumbPosition,
          thumbSize: widget.thumbSize,
          trackColor: widget.trackColor,
          trackWidth: widget.trackWidth
        ),
      ),
    );
  }

  EdgeInsets _insetForPainter() {
    final outerThickness = max(
      widget.thumbSize,
      max(widget.progressWidth, widget.trackWidth)
    )/2;

    return EdgeInsets.all(outerThickness);
  }
}

class RadialSeekPainter extends CustomPainter {

  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final Paint thumbPaint;
  final double thumbPosition;

  RadialSeekPainter({
    @required this.trackWidth,
    @required trackColor,
    @required progressColor,
    @required this.progressWidth,
    @required this.thumbColor,
    @required this.thumbSize ,
    @required this.thumbPosition,
    @required this.progressPercent
  }): trackPaint = new Paint()
    ..color = trackColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = trackWidth,
    progressPaint = Paint()
    ..color = progressColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = progressWidth
    ..strokeCap = StrokeCap.round,
    thumbPaint = new Paint()
    ..style = PaintingStyle.fill
    ..color = thumbColor
  ;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(thumbSize, max(progressWidth, trackWidth));
    Size constrainedSize = Size(
      size.width - outerThickness,
      size.height - outerThickness
    );

    final center = Offset(size.width/2,size.height/2);
    final radius = min(constrainedSize.width, constrainedSize.height)/2;

    //draw track
    canvas.drawCircle(center, radius, trackPaint);
    
    //paint progress
    final progressAngle = 2 * pi * progressPercent;
    canvas.drawArc(
      Rect.fromCircle(radius: radius,center: center),
      -pi/2,
      progressAngle,
      false,
      progressPaint
    );

    //paint thumb
    final thumbAngle = 2 * pi * thumbPosition - (pi/2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX,thumbY) + center;
    canvas.drawCircle(thumbCenter, thumbSize/2, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

