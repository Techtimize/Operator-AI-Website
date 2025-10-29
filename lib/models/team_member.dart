class TeamMember {
  final String name;
  final String title;
  final String description;
  final String initials;
  final TeamColor teamColor;
  final bool isOnline;

  const TeamMember({
    required this.name,
    required this.title,
    required this.description,
    required this.initials,
    required this.teamColor,
    this.isOnline = true,
  });
}

enum TeamColor {
  executive, // Blue
  management, // Green
  development, // Purple
}

extension TeamColorExtension on TeamColor {
  String get colorHex {
    switch (this) {
      case TeamColor.executive:
        return '#2563EB'; // Blue
      case TeamColor.management:
        return '#10B981'; // Green
      case TeamColor.development:
        return '#8B5CF6'; // Purple
    }
  }
}
