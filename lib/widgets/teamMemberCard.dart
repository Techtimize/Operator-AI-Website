import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_public_website/utils/app_reponsiveness/responsive_utils.dart';
import '../responsiveness/responsive.dart';
// ✅ FlipCard Widget (Separate file mein ya same file mein)
class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final Duration duration;
  final bool flipOnTap;

  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.duration = const Duration(milliseconds: 300),
    this.flipOnTap = true,
  }) : super(key: key);

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.flipOnTap ? _flip : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(_animation.value * 3.14159), // 180 degrees in radians
            alignment: Alignment.center,
            child: _animation.value < 0.5
                ? widget.front
                : Transform(
                    transform: Matrix4.identity()..rotateY(3.14159), // Flip back side
                    child: widget.back,
                  ),
          );
        },
      ),
    );
  }
}


class TeamMemberFlipCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String title;
  final String description;

  const TeamMemberFlipCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.title,
    required this.description,
  });

  @override
  State<TeamMemberFlipCard> createState() => _TeamMemberFlipCardState();
}

class _TeamMemberFlipCardState extends State<TeamMemberFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovering) {
    if (mounted) {
      setState(() {
        _isHovered = isHovering;
      });
      
      if (_isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(-angle),
            alignment: Alignment.center,
            child: _buildCardContent(context),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    if (_animation.value < 0.5) {
      return _buildFront(context);
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(3.14159),
        child: _buildBack(context),
      );
    }
  }

  Widget _buildFront(BuildContext context) {
    final double cardWidth = ResponsiveUtils.isMobile(context) 
        ? 240   // ✅ Mobile: 240
        : ResponsiveUtils.isTablet(context)
            ? 260  // ✅ Tablet: 260
            : 280;
    
    final double cardHeight = ResponsiveUtils.isMobile(context)
        ? 280   // ✅ Mobile: 280
        : ResponsiveUtils.isTablet(context)
            ? 300  // ✅ Tablet: 300
            : 320;

    final double imageSize = ResponsiveUtils.isMobile(context)
        ? 100
        : ResponsiveUtils.isTablet(context)
            ? 120
            : 140;

    final double titleFontSize = ResponsiveUtils.isMobile(context)
        ? 22
        : ResponsiveUtils.isTablet(context)
            ? 24
            : 28;

    final double subtitleFontSize = ResponsiveUtils.isMobile(context)
        ? 14
        : ResponsiveUtils.isTablet(context)
            ? 16
            : 18;

    final double circleSize = ResponsiveUtils.isMobile(context)
        ? 12
        : ResponsiveUtils.isTablet(context)
            ? 12
            : 12;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF8EC5FF),
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ✅ Top Left Circle - STROKE REMOVED & WHITE 50%
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff8EC5FF), // ✅ FFFFFF 50%
                // ✅ BORDER/STROKE REMOVED
              ),
            ),
          ),
          
          // ✅ Bottom Right Circle - STROKE REMOVED & WHITE 50%
          Positioned(
            bottom: 20,  
            right: 20,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff8EC5FF), // ✅ FFFFFF 50%
                // ✅ BORDER/STROKE REMOVED
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveUtils.isMobile(context) ? 20 : 30),
                // Circular image with border
                Container(
                  width: imageSize*0.7,
                  height: imageSize*0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF155DFC),
                      width: 4.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.person, 
                            size: imageSize * 0.4, 
                            color: Colors.grey
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.person, 
                            size: imageSize * 0.4, 
                            color: Colors.grey
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.isMobile(context) ? 20 : 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.isMobile(context) ? 16 : 8,
                  ),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.isMobile(context) ? 8 : 12),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.isMobile(context) ? 16 : 8,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
  final double cardWidth = ResponsiveUtils.isMobile(context) 
        ? 240   // ✅ Mobile: 240
        : ResponsiveUtils.isTablet(context)
            ? 260  // ✅ Tablet: 260
            : 280; 
  
  final double cardHeight = ResponsiveUtils.isMobile(context)
        ? 280   // ✅ Mobile: 280
        : ResponsiveUtils.isTablet(context)
            ? 300  // ✅ Tablet: 300
            : 320; 

  final double titleFontSize = ResponsiveUtils.isMobile(context)
      ? 20
      : ResponsiveUtils.isTablet(context)
          ? 22
          : 24;

  final double subtitleFontSize = ResponsiveUtils.isMobile(context)
      ? 14
      : ResponsiveUtils.isTablet(context)
          ? 15
          : 16;

  final double descriptionFontSize = ResponsiveUtils.isMobile(context)
      ? 14
      : ResponsiveUtils.isTablet(context)
          ? 15
          : 16;

  final double circleSize = ResponsiveUtils.isMobile(context)
      ? 12
      : ResponsiveUtils.isTablet(context)
          ? 12
          : 12;

  return Container(
    width: cardWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      // ✅ GRADIENT SET KAR DIYA
      gradient: const LinearGradient(
        colors: [
          Color(0xFF155DFC), // 0% stop
          Color(0xFF193CB8), // 100% stop
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFF2B7FFF),
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Stack(
      children: [
        // ✅ Top Right Circle - STROKE REMOVED & WHITE 50%
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5), // ✅ FFFFFF 50%
              // ✅ BORDER/STROKE REMOVED
            ),
          ),
        ),
        
        // ✅ Bottom Left Circle - STROKE REMOVED & WHITE 50%
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5), // ✅ FFFFFF 50%
              // ✅ BORDER/STROKE REMOVED
            ),
          ),
        ),

        // Main Content
        Padding(
          padding: EdgeInsets.all(
            ResponsiveUtils.isMobile(context) ? 20 : 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name on back side
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: ResponsiveUtils.isMobile(context) ? 6 : 8),
              // Title on back side
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Divider(color: Colors.white70, height: ResponsiveUtils.isMobile(context) ? 20 : 30),
              SizedBox(height: ResponsiveUtils.isMobile(context) ? 20 : 30),
              // Description with proper formatting
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.isMobile(context) ? 5 : 10,
                    ),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: descriptionFontSize,
                        color: Colors.white,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}