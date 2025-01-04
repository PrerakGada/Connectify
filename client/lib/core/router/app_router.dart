import 'package:auto_route/auto_route.dart';
import 'package:connectify/features/auth/screens/login_screen.dart';
import 'package:connectify/features/auth/screens/role_selection_screen.dart';
import 'package:connectify/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectify/features/auth/screens/employer_info_screen.dart';
import 'package:connectify/features/auth/screens/employee_info_screen.dart';
import 'package:connectify/features/home/screens/home_screen.dart';
import 'package:connectify/features/jobs/screens/create_job_screen.dart';
import 'package:connectify/features/jobs/screens/employee_job_details_screen.dart';
import 'package:connectify/features/jobs/screens/employer_job_details_screen.dart';
import 'package:connectify/features/schedule/screens/calendar_screen.dart';
import 'package:connectify/features/jobs/models/job.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
        AutoRoute(page: SignupRoute.page, path: '/signup'),
        AutoRoute(page: RoleSelectionRoute.page, path: '/role-selection'),
        AutoRoute(page: EmployerInfoRoute.page, path: '/employer-info'),
        AutoRoute(page: EmployeeInfoRoute.page, path: '/employee-info'),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: CreateJobRoute.page, path: '/create-job'),
        AutoRoute(
            page: EmployeeJobDetailsRoute.page, path: '/employee-job-details'),
        AutoRoute(
            page: EmployerJobDetailsRoute.page, path: '/employer-job-details'),
        AutoRoute(page: CalendarRoute.page, path: '/calendar'),
      ];
}
