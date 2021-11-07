import 'package:flutter/material.dart';

class CheckableBox extends CustomPainter {
  CheckableBox({required this.isChecked});
  final bool isChecked;

  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double r = 15; //<-- corner radius

    // ボーダー部分
    Paint borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // 内側は白く塗る
    Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 右上の三角でチェックが入ってる部分を塗る
    Paint topRightArcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path topRightArc = Path()
      // 右上が開始なので、まず左に移動
      ..moveTo(w - 6 * r, 0)
      // arc始まりの部分まで線を引く
      ..relativeLineTo(5 * r, 0)
      // 右上のarcの部分を描くというかなぞる
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
      // arcの終わりから下に線を引く
      ..relativeLineTo(0, 3 * r)
      // 最後は斜辺を描く
      ..relativeLineTo(-6 * r, -4 * r);

    canvas.drawRRect(fullRect, innerPaint);
    canvas.drawRRect(fullRect, borderPaint);

    if (isChecked) {
      canvas.drawPath(topRightArc, topRightArcPaint);

      final icon = Icons.check;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
      textPainter.text = TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
              fontSize: 30.0,
              fontFamily: icon.fontFamily,
              color: Colors.white));
      textPainter.layout();
      textPainter.paint(canvas, Offset(w - 2.5 * r, 0));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
