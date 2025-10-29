import 'package:flutter/material.dart';
import '../models/team_member.dart';

class TeamMemberCard extends StatefulWidget {
  final TeamMember teamMember;

  const TeamMemberCard({super.key, required this.teamMember});

  @override
  State<TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<TeamMemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Check if this is an Executive, Management, or Development team card
    final isExecutiveTeam = widget.teamMember.teamColor == TeamColor.executive;
    final isManagementTeam =
        widget.teamMember.teamColor == TeamColor.management;
    final isDevelopmentTeam =
        widget.teamMember.teamColor == TeamColor.development;
    final isHoverableTeam =
        isExecutiveTeam || isManagementTeam || isDevelopmentTeam;

    return MouseRegion(
      onEnter: (_) {
        if (isHoverableTeam) {
          setState(() {
            _isHovered = true;
          });
        }
      },
      onExit: (_) {
        if (isHoverableTeam) {
          setState(() {
            _isHovered = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isHovered && isHoverableTeam
            ? (Matrix4.identity()..translate(0.0, -8.0))
            : Matrix4.identity(),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isHovered && isHoverableTeam
                    ? (isExecutiveTeam
                          ? const Color(0xFFE0F2FE) // Lirght blue for Executive
                          : isManagementTeam
                          ? const Color(
                              0xFFECFDF5,
                            ) // Light green for Management
                          : const Color(
                              0xFFF3E8FF,
                            )) // Light purple for Development
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: _isHovered && isHoverableTeam
                    ? Border.all(
                        color: isExecutiveTeam
                            ? const Color(0xFF1E40AF) // Dark blue for Executive
                            : isManagementTeam
                            ? const Color(
                                0xFF059669,
                              ) // Dark green for Management
                            : const Color(
                                0xFF7C3AED,
                              ), // Dark purple for Development
                        width: 2,
                      )
                    : null,
                boxShadow: _isHovered && isHoverableTeam
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAvatar(),
                  const SizedBox(height: 16),
                  _buildName(),
                  const SizedBox(height: 8),
                  _buildTitle(),
                  const SizedBox(height: 12),
                  _buildDescription(),
                  const SizedBox(height: 8), // Add small bottom padding
                ],
              ),
            ),
            // Online status indicator at top-right corner of card
            if (widget.teamMember.isOnline)
              Positioned(
                top: 8,
                right: 8,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: _isHovered && isHoverableTeam ? 20 : 16,
                  height: _isHovered && isHoverableTeam ? 20 : 16,
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        widget.teamMember.teamColor.colorHex.replaceFirst(
                          '#',
                          '0xFF',
                        ),
                      ),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final isExecutiveTeam = widget.teamMember.teamColor == TeamColor.executive;
    final isManagementTeam =
        widget.teamMember.teamColor == TeamColor.management;
    final isDevelopmentTeam =
        widget.teamMember.teamColor == TeamColor.development;
    final isHoverableTeam =
        isExecutiveTeam || isManagementTeam || isDevelopmentTeam;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: _isHovered && isHoverableTeam ? 72 : 64,
      height: _isHovered && isHoverableTeam ? 72 : 64,
      decoration: BoxDecoration(
        color: Color(
          int.parse(
            widget.teamMember.teamColor.colorHex.replaceFirst('#', '0xFF'),
          ),
        ),
        shape: BoxShape.circle,
        boxShadow: _isHovered && isHoverableTeam
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          widget.teamMember.initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      widget.teamMember.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTitle() {
    final isExecutiveTeam = widget.teamMember.teamColor == TeamColor.executive;
    final isManagementTeam =
        widget.teamMember.teamColor == TeamColor.management;
    final isDevelopmentTeam =
        widget.teamMember.teamColor == TeamColor.development;
    final isHoverableTeam =
        isExecutiveTeam || isManagementTeam || isDevelopmentTeam;

    return Text(
      widget.teamMember.title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _isHovered && isHoverableTeam
            ? (isExecutiveTeam
                  ? const Color(0xFF3B82F6) // Light blue for Executive
                  : isManagementTeam
                  ? const Color(0xFF10B981) // Light green for Management
                  : const Color(0xFF8B5CF6)) // Light purple for Development
            : const Color(0xFF6B7280), // Default gray
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Expanded(
      child: Text(
        widget.teamMember.description,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF374151),
          height: 1.5,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
