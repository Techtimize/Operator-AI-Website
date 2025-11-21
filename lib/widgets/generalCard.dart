import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_reponsiveness/responsive.dart';

class GeneralCard extends StatefulWidget {
  final dynamic gradient;
  final dynamic gradientColors;
  final dynamic topIconPath;
  final dynamic question;
  final dynamic cardTitle;
  final dynamic answer;
  final dynamic buttonColor;
  final dynamic iconColor;
  final dynamic videoDescription;
  final dynamic featureTitles;
  final dynamic width;
  final dynamic height;
  final dynamic featureIcons;
  final dynamic buttonTitle;

  const GeneralCard({
    Key? key,
    this.gradient,
    this.gradientColors,
    required this.topIconPath,
    required this.cardTitle,
    required this.question,
    required this.answer,
    required this.iconColor,
    required this.buttonColor,
    required this.buttonTitle,
    required this.featureIcons,
    this.featureTitles,
    this.width,
    this.height,
    this.videoDescription,
  }) : super(key: key);

  @override
  State<GeneralCard> createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  bool _hover = false;
  bool _hoverPlay = false;
  bool _hoverButton = false;

  @override
  Widget build(BuildContext context) {
    final LinearGradient headerGradient = widget.gradient ??
        (widget.gradientColors != null && widget.gradientColors!.isNotEmpty
            ? LinearGradient(
                colors: widget.gradientColors!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF155DFC), Color(0xFF193CB8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ));

    final double translateY = _hover ? -6.0 : 0.0;
    final double cardScale = _hover ? 1.01 : 1.0;
    final double topIconScale = _hover ? 1.12 : 1.0;
    final List<BoxShadow> shadow = [
      BoxShadow(
        color: Colors.black.withOpacity(_hover ? 0.18 : 0.09),
        blurRadius: _hover ? 28 : 18,
        offset: Offset(0, _hover ? 14 : 8),
      ),
    ];

    // ✅ USING RESPONSIVE CLASS
    final double responsiveWidth = widget.width ?? Dimensions.cardWidth(context);
    final double topIconSize = Dimensions.iconLarge(context);
    final double headerVerticalPadding = Spacing.xl(context);
    final EdgeInsets contentPadding = Paddings.cardPadding(context);
    
    // Video container height for all devices
    final double videoContainerHeight = Responsive.getFontSize(context,
      mobile: 160,
      tablet: 200,
      desktop: 240,
      largeDesktop: 260,
      xlDesktop: 280,
    );
    
    final double playButtonSize = Dimensions.iconLarge(context);
    final double playIconSize = Dimensions.iconMedium(context);
    final double buttonHeight = Dimensions.buttonHeight(context);

    // Border radius for all devices
    final double cardBorderRadius = Responsive.getFontSize(context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
      largeDesktop: 22,
      xlDesktop: 24,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, translateY),
        width: responsiveWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardBorderRadius),
          boxShadow: shadow,
        ),
        child: AnimatedScale(
          scale: cardScale,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER
              Container(
                decoration: BoxDecoration(
                  gradient: headerGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cardBorderRadius),
                    topRight: Radius.circular(cardBorderRadius),
                  ),
                ),
                child: Padding(
                  padding: Paddings.symmetric(
                    context,
                    horizontal: contentPadding.horizontal,
                    vertical: headerVerticalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: topIconScale,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: Container(
                          padding: EdgeInsets.all(Spacing.md(context)),
                          decoration: BoxDecoration(
                            color: headerGradient.colors.length >= 2
                                ? headerGradient.colors[1].withOpacity(0.12)
                                : Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            widget.topIconPath,
                            width: topIconSize,
                            height: topIconSize,
                            color: Colors.white,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: Spacing.md(context)),
                      Text(
                        widget.cardTitle,
                        style: Responsive.heading3(context, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // CONTENT
              Padding(
                padding: contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question & Answer
                    Text(
                      '"${widget.question}"',
                      style: Responsive.bodyMedium(context, 
                        color: const Color(0xff4A5565).withOpacity(0.8),
                      ).copyWith(
                        fontStyle: FontStyle.italic, 
                        height: Responsive.isMobile(context) ? 1.4 : 1.5,
                      ),
                    ),
                    SizedBox(height: Spacing.md(context)),
                    Text(
                      widget.answer,
                      style: Responsive.bodyMedium(context, 
                        color: const Color(0xff1E2939).withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ).copyWith(
                        height: Responsive.isMobile(context) ? 1.3 : 1.4,
                      ),
                      textAlign: Responsive.isMobile(context) ? TextAlign.left : TextAlign.justify,
                    ),
                    SizedBox(height: Spacing.lg(context)),

                    // Divider
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                      height: 1,
                    ),
                    SizedBox(height: Spacing.lg(context)),

                    // Play Button Section
                    MouseRegion(
                      onEnter: (_) => setState(() => _hoverPlay = true),
                      onExit: (_) => setState(() => _hoverPlay = false),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            curve: Curves.easeOut,
                            height: videoContainerHeight,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Responsive.getFontSize(context,
                                  mobile: 10,
                                  tablet: 12,
                                  desktop: 12,
                                  largeDesktop: 14,
                                  xlDesktop: 16,
                                )
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(color: const Color(0xFF101419)),
                                  AnimatedOpacity(
                                    opacity: _hoverPlay ? 0.14 : 0.0,
                                    duration: const Duration(milliseconds: 160),
                                    curve: Curves.easeOut,
                                    child: Container(decoration: BoxDecoration(gradient: headerGradient)),
                                  ),
                                  // Play Icon - Centered
                                  Center(
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 160),
    transform: Matrix4.identity()..scale(_hoverPlay ? 1.06 : 1.0),
       width: playButtonSize * 1.2, // ✅ 20% bada
    height: playButtonSize * 1.2,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: headerGradient,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Icon(
      Icons.play_arrow_rounded, 
      color: Colors.white, 
      size: playIconSize * 0.9, // ✅ Icon size adjust karein
    ),
  ),
),
                                  // Video Description - Positioned at bottom
                                  Positioned(
                                    bottom: Spacing.xl(context),
                                    left: Spacing.md(context),
                                    right: Spacing.md(context),
                                    child: Text(
                                      widget.videoDescription!,
                                      style: Responsive.bodySmall(context, 
                                        color: const Color(0xff99A1AF).withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Spacing.lg(context)),

                    // Features list
                    Column(
                      children: List.generate(widget.featureIcons.length, (i) {
                        final String iconPath = widget.featureIcons[i];
                        final String? label = (widget.featureTitles != null && i < widget.featureTitles!.length)
                            ? widget.featureTitles![i]
                            : null;

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: Spacing.sm(context)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                iconPath,
                                width: Dimensions.iconSmall(context),
                                height: Dimensions.iconSmall(context),
                                color: widget.iconColor,
                              ),
                              SizedBox(width: Spacing.md(context)),
                              if (label != null)
                                Expanded(
                                  child: Text(
                                    label,
                                    style: Responsive.bodyMedium(context, 
                                      color: Colors.black87.withOpacity(0.9),
                                    ).copyWith(
                                      height: Responsive.isMobile(context) ? 1.3 : 1.4,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: Spacing.xl(context)),

                    // Button
                    MouseRegion(
                      onEnter: (_) => setState(() => _hoverButton = true),
                      onExit: (_) => setState(() => _hoverButton = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          gradient: headerGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.buttonTitle,
                                style: Responsive.bodyMedium(
                                  context, 
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(width: Spacing.sm(context)),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOutCubic,
                                transform: Matrix4.translationValues(
                                  _hoverButton ? 4.0 : 0.0, 
                                  0.0, 
                                  0.0
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: Dimensions.iconSmall(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}