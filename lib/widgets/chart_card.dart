import 'package:flutter/material.dart';
import 'dart:math';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget? chart; // Optional custom chart widget to render inside the card
  final double height;

  const ChartCard({
    super.key,
    required this.title,
    this.chart,
    this.height = 302,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: chart ?? _PerformanceTrendsChart(title: title)),
        ],
      ),
    );
  }
}

class _PerformanceTrendsChart extends StatefulWidget {
  final String title;

  const _PerformanceTrendsChart({required this.title});

  @override
  State<_PerformanceTrendsChart> createState() =>
      _PerformanceTrendsChartState();
}

class _PerformanceTrendsChartState extends State<_PerformanceTrendsChart> {
  Offset? _hoverPosition;
  int? _hoveredIndex;
  PieSlice? _hoveredSlice;

  // Sample data for Performance Trends
  late final List<double> blueLineData;
  late final List<double> greenLineData;
  late final List<String> weeks;

  // Pie chart data
  late final List<PieSlice> pieSlices;

  @override
  void initState() {
    super.initState();
    blueLineData = [1200, 1350, 1650, 1800];
    greenLineData = [375, 450, 480, 500];
    weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

    // Pie chart data with labels
    pieSlices = [
      PieSlice(
        percentage: 40,
        color: const Color(0xFF8B5CF6),
        label: 'Cold Calls',
        value: 40,
      ),
      PieSlice(
        percentage: 35,
        color: const Color(0xFF10B981),
        label: 'Warm Leads',
        value: 35,
      ),
      PieSlice(
        percentage: 25,
        color: const Color(0xFFF59E0B),
        label: 'Hot Prospects',
        value: 25,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Return pie chart for Distribution Analytics
    if (widget.title == 'Distribution Analytics') {
      return LayoutBuilder(
        builder: (context, constraints) {
          return MouseRegion(
            onHover: (event) {
              setState(() {
                _hoverPosition = event.localPosition;
                _hoveredSlice = _getHoveredSlice(
                  event.localPosition,
                  constraints.maxWidth,
                  constraints.maxHeight,
                );
              });
            },
            onExit: (event) {
              setState(() {
                _hoverPosition = null;
                _hoveredSlice = null;
              });
            },
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _PieChartPainter(slices: pieSlices),
                ),
                if (_hoveredSlice != null && _hoverPosition != null)
                  Positioned(
                    left: _hoverPosition!.dx,
                    top: _hoverPosition!.dy - 50,
                    child: _buildPieTooltip(_hoveredSlice!),
                  ),
              ],
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) {
            setState(() {
              _hoverPosition = event.localPosition;
              _hoveredIndex = _getHoveredIndex(
                event.localPosition,
                constraints.maxWidth,
                constraints.maxHeight,
              );
            });
          },
          onExit: (event) {
            setState(() {
              _hoverPosition = null;
              _hoveredIndex = null;
            });
          },
          child: Stack(
            children: [
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _LineChartPainter(
                  blueLineData: blueLineData,
                  greenLineData: greenLineData,
                  weeks: weeks,
                ),
              ),
              if (_hoveredIndex != null && _hoverPosition != null)
                Positioned(
                  left: _hoverPosition!.dx,
                  top: _hoverPosition!.dy - 60,
                  child: _buildTooltip(_hoveredIndex!),
                ),
            ],
          ),
        );
      },
    );
  }

  int? _getHoveredIndex(Offset position, double width, double height) {
    const double leftPadding = 50;
    const double rightPadding = 20;
    const double topPadding = 10;
    const double bottomPadding = 40;

    final double chartWidth = width - leftPadding - rightPadding;

    if (position.dx < leftPadding ||
        position.dx > width - rightPadding ||
        position.dy < topPadding ||
        position.dy > height - bottomPadding) {
      return null;
    }

    final x = position.dx - leftPadding;
    final closestIndex = ((x / chartWidth) * (weeks.length - 1)).round();
    return closestIndex.clamp(0, weeks.length - 1);
  }

  Widget _buildTooltip(int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weeks[index],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'calls : ${blueLineData[index].toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF3B82F6)),
          ),
          Text(
            'successful : ${greenLineData[index].toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF10B981)),
          ),
        ],
      ),
    );
  }

  PieSlice? _getHoveredSlice(Offset position, double width, double height) {
    const double padding = 15;
    final center = Offset(width / 2, height / 2);
    final availableWidth = width - (padding * 2);
    final availableHeight = height - (padding * 2);
    final radius = min(availableWidth, availableHeight) * 0.5;

    // Check if position is within pie chart circle
    final distance = (position - center).distance;
    if (distance > radius) return null;

    // Calculate angle from center
    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    double angle = atan2(dy, dx);

    // Convert to 0-2π range and adjust for -90° start
    angle = (angle + 3.14159 / 2) % (2 * 3.14159);
    if (angle < 0) angle += 2 * 3.14159;

    // Find which slice contains this angle
    double currentAngle = 0;
    for (final slice in pieSlices) {
      final sliceAngle = (slice.percentage / 100) * 2 * 3.14159;
      if (angle >= currentAngle && angle <= currentAngle + sliceAngle) {
        return slice;
      }
      currentAngle += sliceAngle;
    }
    return null;
  }

  Widget _buildPieTooltip(PieSlice slice) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '${slice.label} : ${slice.value}',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> blueLineData;
  final List<double> greenLineData;
  final List<String> weeks;

  _LineChartPainter({
    required this.blueLineData,
    required this.greenLineData,
    required this.weeks,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFE5E7EB);

    final textStyle = TextStyle(fontSize: 12, color: const Color(0xFF6B7280));

    // Define chart area
    const double leftPadding = 50;
    const double rightPadding = 20;
    const double topPadding = 10;
    const double bottomPadding = 40;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    // Y-axis range
    final double minY = 0;
    final double maxY = 1800;

    // Draw horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final yValue = i * 450;
      final normalizedY = (yValue - minY) / (maxY - minY);
      final y = topPadding + chartHeight - (normalizedY * chartHeight);

      // Draw dotted line
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint..strokeWidth = 1,
      );

      // Draw Y-axis labels
      final yTextPainter = TextPainter(
        text: TextSpan(text: yValue.toString(), style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      yTextPainter.paint(
        canvas,
        Offset(
          leftPadding - yTextPainter.width - 10,
          y - yTextPainter.height / 2,
        ),
      );
    }

    // Draw vertical grid lines and X-axis labels
    for (int i = 0; i < weeks.length; i++) {
      final x = leftPadding + (i / (weeks.length - 1)) * chartWidth;

      // Draw dotted line
      canvas.drawLine(
        Offset(x, topPadding),
        Offset(x, size.height - bottomPadding),
        gridPaint..strokeWidth = 1,
      );

      // Draw X-axis labels
      final xTextPainter = TextPainter(
        text: TextSpan(text: weeks[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      xTextPainter.paint(
        canvas,
        Offset(x - xTextPainter.width / 2, size.height - bottomPadding + 5),
      );
    }

    // Draw blue line
    _drawLine(
      canvas,
      blueLineData,
      const Color(0xFF3B82F6),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
      minY,
      maxY,
    );

    // Draw green line
    _drawLine(
      canvas,
      greenLineData,
      const Color(0xFF10B981),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
      minY,
      maxY,
    );
  }

  void _drawLine(
    Canvas canvas,
    List<double> data,
    Color color,
    double leftPadding,
    double topPadding,
    double chartWidth,
    double chartHeight,
    double minY,
    double maxY,
  ) {
    final path = Path();
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;

    final pointPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    for (int i = 0; i < data.length; i++) {
      final x = leftPadding + (i / (data.length - 1)) * chartWidth;
      final normalizedY = (data[i] - minY) / (maxY - minY);
      final y = topPadding + chartHeight - (normalizedY * chartHeight);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw circle marker
      canvas.drawCircle(Offset(x, y), 6, strokePaint);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PieChartPainter extends CustomPainter {
  final List<PieSlice> slices;

  _PieChartPainter({required this.slices});

  @override
  void paint(Canvas canvas, Size size) {
    // Add padding to ensure labels fit within bounds
    const double padding = 15;
    final availableWidth = size.width - (padding * 2);
    final availableHeight = size.height - (padding * 2);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(availableWidth, availableHeight) * 0.5;

    double startAngle = -90 * (3.14159 / 180); // Start from top (-90 degrees)

    for (int i = 0; i < slices.length; i++) {
      final slice = slices[i];
      final sweepAngle = (slice.percentage / 100) * 2 * 3.14159;

      // Draw pie slice
      final paint = Paint()
        ..color = slice.color
        ..style = PaintingStyle.fill;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      // Calculate label position with better spacing
      final labelAngle = startAngle + (sweepAngle / 2);
      // Increase distance for 35% slice (green, bottom)
      final labelRadius = slice.percentage == 35 ? radius + 35 : radius + 20;
      final labelX = center.dx + labelRadius * cos(labelAngle);
      final labelY = center.dy + labelRadius * sin(labelAngle);

      // Draw label
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${slice.percentage}%',
          style: TextStyle(
            fontSize: 12, // Reduced from 14 to 12
            fontWeight: FontWeight.bold,
            color: slice.color,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Position label with bounds checking
      final labelOffset = Offset(
        (labelX - textPainter.width / 2).clamp(
          padding,
          size.width - padding - textPainter.width,
        ),
        (labelY - textPainter.height / 2).clamp(
          padding,
          size.height - padding - textPainter.height,
        ),
      );

      textPainter.paint(canvas, labelOffset);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PieSlice {
  final int percentage;
  final Color color;
  final String label;
  final int value;

  PieSlice({
    required this.percentage,
    required this.color,
    required this.label,
    required this.value,
  });
}
