import 'package:flutter/material.dart';
import '../models/team_member.dart';
import 'team_section.dart';
import '../utils/app_reponsiveness/responsive_utils.dart';

class CompanySection extends StatelessWidget {
  const CompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSectionHeader(context),
              const SizedBox(height: 48),
              _buildTeamSections(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              Color(0xff155DFC),
              Color(0xff1447E6),
              Color(0xff193CB8),
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Text(
          'Leadership & Team',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 36),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      
      // Responsive spacing
      SizedBox(height: ResponsiveUtils.isMobile(context) ? 8 : 12),
      
      // Responsive subtitle
      Text(
        ResponsiveUtils.isMobile(context) 
            ? 'Experienced leaders and dedicated professionals driving innovation at Opperator AI'
            : 'Experienced leaders and dedicated professionals driving innovation at\n Opperator AI',
        style: TextStyle(
          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
          color: Color(0xFF4A5565),
          height: ResponsiveUtils.isMobile(context) ? 1.4 : 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

  Widget _buildTeamSections() {
    return Column(
      children: [
        // Executive Team
        TeamSection(title: 'Executive Team', teamMembers: _getExecutiveTeam()),
        const SizedBox(height: 48),

        // Management Team
        TeamSection(
          title: 'Management Team',
          teamMembers: _getManagementTeam(),
        ),
        const SizedBox(height: 48),

        // Development Team
        TeamSection(
          title: 'Development Team',
          teamMembers: _getDevelopmentTeam(),
        ),
      ],
    );
  }

  List<TeamMember> _getExecutiveTeam() {
    return [
      const TeamMember(
        name: 'Ignacio Kindelan',
        title: 'Chief Executive Officer',
        description:
            'Visionary leader driving AI innovation and strategic growth across global markets. With 15+ years of experience, Ignacio shapes the company\'s future direction.',
        initials: 'IK',
        teamColor: TeamColor.executive,
      ),
      const TeamMember(
        name: 'Alfonso Suarez',
        title: 'Chief Technology Officer',
        description:
            'Technology pioneer architecting cutting-edge AI solutions. Alfonso leads our engineering excellence and oversees all technical innovations and infrastructure.',
        initials: 'AS',
        teamColor: TeamColor.executive,
      ),
      const TeamMember(
        name: 'Dominik Oggenfüss',
        title: 'Chief Financial Officer',
        description:
            'Financial strategist ensuring sustainable growth and operational excellence. Dominik manages fiscal planning and drives data-driven business decisions.',
        initials: 'DO',
        teamColor: TeamColor.executive,
      ),
    ];
  }

  List<TeamMember> _getManagementTeam() {
    return [
      const TeamMember(
        name: 'Azul Debonis',
        title: 'Customer Service Manager',
        description:
            'Customer experience champion ensuring world-class service delivery and client satisfaction across all touchpoints.',
        initials: 'AD',
        teamColor: TeamColor.management,
      ),
      const TeamMember(
        name: 'Fco Javier Peña',
        title: 'Marketing Manager',
        description:
            'Brand architect crafting compelling narratives and driving market presence through innovative marketing strategies.',
        initials: 'FJP',
        teamColor: TeamColor.management,
      ),
      const TeamMember(
        name: 'Abdo Abouelrous',
        title: 'Machine Learning Manager',
        description:
            'AI research leader pushing boundaries in machine learning, developing intelligent algorithms that power our solutions.',
        initials: 'AA',
        teamColor: TeamColor.management,
      ),
      const TeamMember(
        name: 'AMR SHAWKI',
        title: 'Art Director',
        description:
            'Creative visionary shaping stunning visual experiences and maintaining brand excellence across all creative deliverables.',
        initials: 'AS',
        teamColor: TeamColor.management,
      ),
      const TeamMember(
        name: 'Jeremy Presner',
        title: 'AI Film Director',
        description:
            'Pioneering AI-driven storytelling, creating immersive visual content that bridges technology and cinematic artistry.',
        initials: 'JP',
        teamColor: TeamColor.management,
      ),
    ];
  }

  List<TeamMember> _getDevelopmentTeam() {
    return [
      const TeamMember(
        name: 'Sultan Sheikh',
        title: 'BackEnd Developer',
        description:
            'Server-side expert building robust and scalable backend systems that power our AI infrastructure.',
        initials: 'SS',
        teamColor: TeamColor.development,
      ),
      const TeamMember(
        name: 'Muhammad Sayyam',
        title: 'FullStack Developer',
        description:
            'Versatile engineer creating seamless end-to-end solutions from database to user interface.',
        initials: 'MS',
        teamColor: TeamColor.development,
      ),
      const TeamMember(
        name: 'Iman Ali',
        title: 'FullStack Developer',
        description:
            'Full-stack specialist delivering comprehensive solutions with expertise across the entire technology stack.',
        initials: 'IA',
        teamColor: TeamColor.development,
      ),
      const TeamMember(
        name: 'Muhammad Haseeb',
        title: 'FrontEnd Developer',
        description:
            'UI/UX craftsman building intuitive and responsive interfaces that delight users.',
        initials: 'MH',
        teamColor: TeamColor.development,
      ),
      const TeamMember(
        name: 'Usman Ghani',
        title: 'BackEnd Developer',
        description:
            'Backend architect ensuring system reliability, performance optimization, and data integrity.',
        initials: 'UG',
        teamColor: TeamColor.development,
      ),
    ];
  }
}
