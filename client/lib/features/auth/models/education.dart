enum EducationType { tenth, twelfth, bachelors, masters, phd, other }

class Education {
  final String instituteName;
  final String duration;
  final EducationType type;
  final String? courseName;

  Education({
    required this.instituteName,
    required this.duration,
    required this.type,
    this.courseName,
  });
}
