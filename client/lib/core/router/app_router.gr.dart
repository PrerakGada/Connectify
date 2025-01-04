// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CalendarScreen]
class CalendarRoute extends PageRouteInfo<CalendarRouteArgs> {
  CalendarRoute({
    Key? key,
    required bool isEmployee,
    String? jobId,
    String? applicantId,
    List<PageRouteInfo>? children,
  }) : super(
         CalendarRoute.name,
         args: CalendarRouteArgs(
           key: key,
           isEmployee: isEmployee,
           jobId: jobId,
           applicantId: applicantId,
         ),
         initialChildren: children,
       );

  static const String name = 'CalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CalendarRouteArgs>();
      return CalendarScreen(
        key: args.key,
        isEmployee: args.isEmployee,
        jobId: args.jobId,
        applicantId: args.applicantId,
      );
    },
  );
}

class CalendarRouteArgs {
  const CalendarRouteArgs({
    this.key,
    required this.isEmployee,
    this.jobId,
    this.applicantId,
  });

  final Key? key;

  final bool isEmployee;

  final String? jobId;

  final String? applicantId;

  @override
  String toString() {
    return 'CalendarRouteArgs{key: $key, isEmployee: $isEmployee, jobId: $jobId, applicantId: $applicantId}';
  }
}

/// generated route for
/// [CreateJobScreen]
class CreateJobRoute extends PageRouteInfo<void> {
  const CreateJobRoute({List<PageRouteInfo>? children})
    : super(CreateJobRoute.name, initialChildren: children);

  static const String name = 'CreateJobRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateJobScreen();
    },
  );
}

/// generated route for
/// [EmployeeInfoScreen]
class EmployeeInfoRoute extends PageRouteInfo<void> {
  const EmployeeInfoRoute({List<PageRouteInfo>? children})
    : super(EmployeeInfoRoute.name, initialChildren: children);

  static const String name = 'EmployeeInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmployeeInfoScreen();
    },
  );
}

/// generated route for
/// [EmployeeJobDetailsScreen]
class EmployeeJobDetailsRoute
    extends PageRouteInfo<EmployeeJobDetailsRouteArgs> {
  EmployeeJobDetailsRoute({
    Key? key,
    required Job job,
    List<PageRouteInfo>? children,
  }) : super(
         EmployeeJobDetailsRoute.name,
         args: EmployeeJobDetailsRouteArgs(key: key, job: job),
         initialChildren: children,
       );

  static const String name = 'EmployeeJobDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployeeJobDetailsRouteArgs>();
      return EmployeeJobDetailsScreen(key: args.key, job: args.job);
    },
  );
}

class EmployeeJobDetailsRouteArgs {
  const EmployeeJobDetailsRouteArgs({this.key, required this.job});

  final Key? key;

  final Job job;

  @override
  String toString() {
    return 'EmployeeJobDetailsRouteArgs{key: $key, job: $job}';
  }
}

/// generated route for
/// [EmployerInfoScreen]
class EmployerInfoRoute extends PageRouteInfo<void> {
  const EmployerInfoRoute({List<PageRouteInfo>? children})
    : super(EmployerInfoRoute.name, initialChildren: children);

  static const String name = 'EmployerInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmployerInfoScreen();
    },
  );
}

/// generated route for
/// [EmployerJobDetailsScreen]
class EmployerJobDetailsRoute
    extends PageRouteInfo<EmployerJobDetailsRouteArgs> {
  EmployerJobDetailsRoute({
    Key? key,
    required Job job,
    List<PageRouteInfo>? children,
  }) : super(
         EmployerJobDetailsRoute.name,
         args: EmployerJobDetailsRouteArgs(key: key, job: job),
         initialChildren: children,
       );

  static const String name = 'EmployerJobDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployerJobDetailsRouteArgs>();
      return EmployerJobDetailsScreen(key: args.key, job: args.job);
    },
  );
}

class EmployerJobDetailsRouteArgs {
  const EmployerJobDetailsRouteArgs({this.key, required this.job});

  final Key? key;

  final Job job;

  @override
  String toString() {
    return 'EmployerJobDetailsRouteArgs{key: $key, job: $job}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({Key? key, required bool isEmployee, List<PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(key: key, isEmployee: isEmployee),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return HomeScreen(key: args.key, isEmployee: args.isEmployee);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.isEmployee});

  final Key? key;

  final bool isEmployee;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, isEmployee: $isEmployee}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [RoleSelectionScreen]
class RoleSelectionRoute extends PageRouteInfo<void> {
  const RoleSelectionRoute({List<PageRouteInfo>? children})
    : super(RoleSelectionRoute.name, initialChildren: children);

  static const String name = 'RoleSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RoleSelectionScreen();
    },
  );
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupScreen();
    },
  );
}
