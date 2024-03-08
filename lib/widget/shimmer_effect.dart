library shimmer_effect;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ShimmerEffectway { ltr, rtl, ttb, btt }

@immutable
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ShimmerEffectway way;
  final Gradient gradient;
  final int loop;
  final bool enabled;

  ShimmerEffect({
    Key? key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.duration = const Duration(milliseconds: 1500),
    this.way = ShimmerEffectway.ltr,
    this.loop = 0,
    this.enabled = true,
  })  : gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        baseColor,
        baseColor,
        highlightColor,
        baseColor,
        baseColor
      ],
      stops: const <double>[
        0.0,
        0.35,
        0.5,
        0.65,
        1.0
      ]),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.loop <= 0) {
          _controller.repeat();
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) => _ShimmerEffect(
        way: widget.way,
        gradient: widget.gradient,
        percent: _controller.value,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _ShimmerEffect extends SingleChildRenderObjectWidget {
  final double percent;
  final ShimmerEffectway way;
  final Gradient gradient;

  const _ShimmerEffect({
    Widget? child,
    required this.percent,
    required this.way,
    required this.gradient,
  }) : super(child: child);

  @override
  _ShimmerEffectFilter createRenderObject(BuildContext context) {
    return _ShimmerEffectFilter(percent, way, gradient);
  }

  @override
  // ignore: non_constant_identifier_names
  void updateRenderObject(
      // ignore: non_constant_identifier_names
      BuildContext context, _ShimmerEffectFilter ShimmerEffect) {
    ShimmerEffect.percent = percent;
    ShimmerEffect.gradient = gradient;
    ShimmerEffect.way = way;
  }
}

class _ShimmerEffectFilter extends RenderProxyBox {
  ShimmerEffectway _way;
  Gradient _gradient;
  double _percent;

  _ShimmerEffectFilter(this._percent, this._way, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  set way(ShimmerEffectway newway) {
    if (newway == _way) {
      return;
    }
    _way = newway;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final double width = child!.size.width;
      final double height = child!.size.height;
      Rect rect;
      double dx, dy;
      if (_way == ShimmerEffectway.rtl) {
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_way == ShimmerEffectway.ttb) {
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_way == ShimmerEffectway.btt) {
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else {
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      }
      layer ??= ShaderMaskLayer();
      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
