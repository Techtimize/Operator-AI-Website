import 'package:flutter/material.dart';
import 'responsive_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? child;

  const ResponsiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < ResponsiveBreakpoints.md) {
          return mobile ?? child ?? const SizedBox.shrink();
        } else if (constraints.maxWidth < ResponsiveBreakpoints.lg) {
          return tablet ?? mobile ?? child ?? const SizedBox.shrink();
        } else {
          return desktop ??
              tablet ??
              mobile ??
              child ??
              const SizedBox.shrink();
        }
      },
    );
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    DeviceType deviceType,
    ScreenSize screenSize,
  )
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveUtils.getDeviceType(constraints.maxWidth);
        final screenSize = ResponsiveUtils.getScreenSize(constraints.maxWidth);
        return builder(context, deviceType, screenSize);
      },
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding =
        padding ??
        EdgeInsets.all(ResponsiveUtils.getResponsivePadding(context));
    final containerMaxWidth =
        maxWidth ?? ResponsiveUtils.getResponsiveWidth(context);

    Widget content = Container(
      constraints: BoxConstraints(maxWidth: containerMaxWidth),
      padding: responsivePadding,
      child: child,
    );

    if (centerContent) {
      content = Center(child: content);
    }

    return content;
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final int? forceColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.forceColumns,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns =
            forceColumns ?? ResponsiveUtils.getResponsiveColumns(context);
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          alignment: alignment,
          crossAxisAlignment: crossAxisAlignment,
          children:
              children.map((child) {
                return SizedBox(width: itemWidth, child: child);
              }).toList(),
        );
      },
    );
  }
}

class ResponsiveRow extends StatelessWidget {
  final List<ResponsiveColumn> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveUtils.getDeviceType(constraints.maxWidth);

        // On mobile, stack columns vertically
        if (deviceType == DeviceType.mobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                children.map((col) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: col.child,
                  );
                }).toList(),
          );
        }

        // On tablet and desktop, use Row
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children:
              children.asMap().entries.map((entry) {
                final index = entry.key;
                final col = entry.value;

                return Expanded(
                  flex: col.flex,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index < children.length - 1 ? spacing : 0,
                    ),
                    child: col.child,
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}

class ResponsiveColumn {
  final Widget child;
  final int flex;

  const ResponsiveColumn({required this.child, this.flex = 1});
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double baseFontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.baseFontSize = 16.0,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = ResponsiveUtils.getResponsiveFontSize(
      context,
      baseFontSize,
    );

    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: responsiveFontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
