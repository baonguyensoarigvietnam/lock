import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A 3×3 pattern lock grid widget.
/// Calls [onPatternComplete] when the user lifts their finger.
/// Calls [onPatternStart] when the user starts drawing.
class PatternLockGrid extends StatefulWidget {
  const PatternLockGrid({
    super.key,
    required this.onPatternComplete,
    this.onPatternStart,
    this.selectedDots = const [],
    this.isError = false,
    this.isReadOnly = false,
  });

  /// Called with the ordered list of selected dot indices (0–8) when drawing ends.
  final ValueChanged<List<int>> onPatternComplete;

  /// Called when the user starts a new drawing gesture.
  final VoidCallback? onPatternStart;

  /// Pre-selected dots to render (e.g. while in read-only / display mode).
  final List<int> selectedDots;

  /// Whether to show the error (red) colour on selected dots.
  final bool isError;

  /// If true, the widget only displays the pattern and ignores touch.
  final bool isReadOnly;

  @override
  State<PatternLockGrid> createState() => _PatternLockGridState();
}

class _PatternLockGridState extends State<PatternLockGrid> {
  final List<int> _selected = [];
  Offset? _currentPointer; // in LOCAL coordinates of the widget
  bool _isDrawing = false;

  /// Returns the center of the dot at [index] in the widget's local coordinate space.
  /// Index 0–8, mapped to row = index ~/ 3, col = index % 3.
  Offset _dotCenterLocal(int index, Size size) {
    final cellW = size.width / 3;
    final cellH = size.height / 3;
    final row = index ~/ 3;
    final col = index % 3;
    return Offset(col * cellW + cellW / 2, row * cellH + cellH / 2);
  }

  /// Hit-test in local coordinates.
  int? _hitTest(Offset localPos, Size size) {
    const double hitRadius = 36.0;
    for (int i = 0; i < 9; i++) {
      if (_selected.contains(i)) continue;
      final center = _dotCenterLocal(i, size);
      if ((center - localPos).distance <= hitRadius) return i;
    }
    return null;
  }

  Size? _currentSize;

  void _onPanStart(DragStartDetails details) {
    if (widget.isReadOnly || _currentSize == null) return;
    final localPos = _globalToLocal(details.globalPosition);
    setState(() {
      _selected.clear();
      _currentPointer = localPos;
      _isDrawing = true;
    });
    widget.onPatternStart?.call();

    final hit = _hitTest(localPos, _currentSize!);
    if (hit != null) {
      HapticFeedback.selectionClick();
      setState(() => _selected.add(hit));
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (widget.isReadOnly || !_isDrawing || _currentSize == null) return;
    final localPos = _globalToLocal(details.globalPosition);
    setState(() => _currentPointer = localPos);

    final hit = _hitTest(localPos, _currentSize!);
    if (hit != null) {
      HapticFeedback.selectionClick();
      setState(() => _selected.add(hit));
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (widget.isReadOnly || !_isDrawing) return;
    setState(() {
      _isDrawing = false;
      _currentPointer = null;
    });
    if (_selected.isNotEmpty) {
      widget.onPatternComplete(List.unmodifiable(_selected));
    }
  }

  /// Converts a global position to the local coordinate space of this widget.
  Offset _globalToLocal(Offset globalPosition) {
    final renderBox = context.findRenderObject() as RenderBox;
    return renderBox.globalToLocal(globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    final dotsToShow =
        widget.selectedDots.isNotEmpty && !_isDrawing
            ? widget.selectedDots
            : _selected;
    final isError = widget.isError;

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            _currentSize = size;

            return CustomPaint(
              size: size,
              painter: _PatternLinePainter(
                selected: dotsToShow,
                gridSize: size,
                currentPointer: _isDrawing ? _currentPointer : null,
                isError: isError,
              ),
              child: _buildDots(dotsToShow, isError, size),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDots(List<int> dotsToShow, bool isError, Size size) {
    final cellW = size.width / 3;
    final cellH = size.height / 3;

    return Stack(
      children: List.generate(9, (index) {
        final row = index ~/ 3;
        final col = index % 3;
        final isSelected = dotsToShow.contains(index);

        return Positioned(
          left: col * cellW + cellW / 2 - 24,
          top: row * cellH + cellH / 2 - 24,
          child: _PatternDot(
            isSelected: isSelected,
            isError: isError,
          ),
        );
      }),
    );
  }
}

// ─── Dot Widget ─────────────────────────────────────────────────────────────

class _PatternDot extends StatelessWidget {
  const _PatternDot({
    required this.isSelected,
    required this.isError,
  });

  final bool isSelected;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final Color activeColor =
        isError ? const Color(0xFFEF4444) : const Color(0xFF000000);
    const Color inactiveColor = Color(0xFFD1D5DB);

    if (isSelected) {
      return SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: activeColor, width: 2.2),
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 48,
      height: 48,
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: inactiveColor,
          ),
        ),
      ),
    );
  }
}

// ─── Line Painter ────────────────────────────────────────────────────────────

class _PatternLinePainter extends CustomPainter {
  _PatternLinePainter({
    required this.selected,
    required this.gridSize,
    required this.currentPointer,
    required this.isError,
  });

  final List<int> selected;
  final Size gridSize;
  final Offset? currentPointer;
  final bool isError;

  Offset _dotCenter(int index) {
    final cellW = gridSize.width / 3;
    final cellH = gridSize.height / 3;
    final row = index ~/ 3;
    final col = index % 3;
    return Offset(col * cellW + cellW / 2, row * cellH + cellH / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (selected.isEmpty) return;

    final Color lineColor =
        isError ? const Color(0xFFEF4444) : const Color(0xFFB0B3B8);

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw lines between consecutively selected dots
    for (int i = 0; i < selected.length - 1; i++) {
      final from = _dotCenter(selected[i]);
      final to = _dotCenter(selected[i + 1]);
      canvas.drawLine(from, to, paint);
    }

    // Draw line from last dot to current pointer position
    if (currentPointer != null && selected.isNotEmpty) {
      final last = _dotCenter(selected.last);
      canvas.drawLine(last, currentPointer!, paint);
    }
  }

  @override
  bool shouldRepaint(_PatternLinePainter old) =>
      old.selected != selected ||
      old.currentPointer != currentPointer ||
      old.isError != isError;
}
