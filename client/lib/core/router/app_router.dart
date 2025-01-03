import 'package:auto_route/auto_route.dart';
import 'package:connectify/features/auth/screens/login_screen.dart';
import 'package:connectify/features/auth/screens/signup_screen.dart';
import 'package:connectify/features/auth/screens/role_selection_screen.dart';
import 'package:connectify/features/auth/screens/employee_info_screen.dart';
import 'package:connectify/features/auth/screens/employer_info_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
        AutoRoute(page: SignupRoute.page, path: '/signup'),
        AutoRoute(page: RoleSelectionRoute.page, path: '/role-selection'),
        AutoRoute(page: EmployeeInfoRoute.page, path: '/employee-info'),
        AutoRoute(page: EmployerInfoRoute.page, path: '/employer-info'),
      ];
}
