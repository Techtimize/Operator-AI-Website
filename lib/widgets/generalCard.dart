import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import 'package:new_public_website/utils/app_reponsiveness/app_spaces.dart';

class GeneralCard extends StatefulWidget {
  final LinearGradient? gradient;
  final List<Color>? gradientColors;
  final String topIconPath;
  final String cardTitle;
  final String question;
  final String answer;
  final Color iconColor;
  final Color buttonColor;
  final String buttonTitle;
  final List<String> featureIcons;
  final List<String>? featureTitles;
  final double? width;
  final double? height;
  final String? videoDescription; // Video description parameter

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
    this.videoDescription, // Added parameter
  }) : super(key: key);

  @override
  State<GeneralCard> createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  bool _hover = false;
  bool _hoverPlay = false;

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

    final double translateY = _hover ? -8.0 : 0.0;
    final double cardScale = _hover ? 1.02 : 1.0;
    final double topIconScale = _hover ? 1.12 : 1.0;
    final List<BoxShadow> shadow = [
      BoxShadow(
        color: Colors.black.withOpacity(_hover ? 0.18 : 0.09),
        blurRadius: _hover ? 28 : 18,
        offset: Offset(0, _hover ? 14 : 8),
      ),
    ];

    // Responsive width and height
    final double responsiveWidth = widget.width ?? 
        (ResponsiveUtils.isMobile(context) 
            ? MediaQuery.of(context).size.width * 0.9
            : ResponsiveUtils.isTablet(context)
                ? 350.0
                : 384.22);

    final double? responsiveHeight = widget.height;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, translateY),
        width: responsiveWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: ResponsiveUtils.isMobile(context) ? 32 : 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: topIconScale,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: headerGradient.colors.length >= 2
                                ? headerGradient.colors[1].withOpacity(0.12)
                                : Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            widget.topIconPath,
                            width: 60,
                            height: 60,
                            color: Colors.white,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.cardTitle,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // CONTENT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question & Answer
                    Text(
                      '"${widget.question}"',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xff4A5565).withOpacity(0.8),
                            fontStyle: FontStyle.italic,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                            height: 1.5,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.answer,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xff1E2939).withOpacity(0.9),
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                            height: 1.6,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                      height: 1,
                    ),
                    const SizedBox(height: 24),

                    // Play Button Section - FIXED: Description below play icon
                    Column(
                      children: [
                        // Play Button Container
                        MouseRegion(
                          onEnter: (_) => setState(() => _hoverPlay = true),
                          onExit: (_) => setState(() => _hoverPlay = false),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                curve: Curves.easeOut,
                                height: ResponsiveUtils.isMobile(context) ? 200 : 240,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
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
                                      Center(
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 160),
                                          transform: Matrix4.identity()..scale(_hoverPlay ? 1.06 : 1.0),
                                          padding: const EdgeInsets.all(20),
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
                                            Icons.play_arrow, 
                                            color: Colors.white, 
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Video Description - NOW BELOW PLAY ICON (Inside same container)
                              const SizedBox(height: 16),
                              Text(
                                widget.videoDescription ?? "AI Sales Demo: Lead qualification in action",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xff4A5565).withOpacity(0.7),
                                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Features list
                    Column(
                      children: List.generate(widget.featureIcons.length, (i) {
                        final String iconPath = widget.featureIcons[i];
                        final String? label = (widget.featureTitles != null && i < widget.featureTitles!.length)
                            ? widget.featureTitles![i]
                            : null;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                iconPath,
                                width: 20,
                                height: 20,
                                color: widget.iconColor,
                              ),
                              const SizedBox(width: 16),
                              if (label != null)
                                Expanded(
                                  child: Text(
                                    label,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.black87.withOpacity(0.9),
                                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
                                          height: 1.4,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 32),

                    // Button
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {},
                        child: Text(
                          widget.buttonTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
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