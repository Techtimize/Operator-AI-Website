import 'package:flutter/material.dart';
import '../models/team_member.dart';
import 'team_member_card.dart';

class TeamSection extends StatelessWidget {
  final String title;
  final List<TeamMember> teamMembers;

  const TeamSection({
    super.key,
    required this.title,
    required this.teamMembers,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: 24),
        _buildTeamGrid(isMobile, isTablet),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF374151),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTeamGrid(bool isMobile, bool isTablet) {
    int crossAxisCount;
    double childAspectRatio;

    if (isMobile) {
      crossAxisCount = 1;
      childAspectRatio = 1.23;
    } else if (isTablet) {
      crossAxisCount = 2;
      childAspectRatio = 1.1;
    } else {
      // Desktop: Show all cards in a single row with proper aspect ratio for content
      crossAxisCount = teamMembers.length;

      // Adjust aspect ratio based on team size to fix Executive Team excess space
      if (teamMembers.length == 3) {
        // Executive Team - further reduce aspect ratio to eliminate excess space
        childAspectRatio = 1.5;
      } else {
        // Management and Development Teams - keep original ratio
        childAspectRatio = 0.8;
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: teamMembers.length,
      itemBuilder: (context, index) {
        return TeamMemberCard(teamMember: teamMembers[index]);
      },
    );
  }
}
