import 'package:flutter/material.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/presentation/forgot_password/forgot_password.dart';
import 'package:mvvm_demo/presentation/login/login.dart';
import 'package:mvvm_demo/presentation/main/main_view.dart';
import 'package:mvvm_demo/presentation/onboarding/onboarding.dart';
import 'package:mvvm_demo/presentation/register/register.dart';
import 'package:mvvm_demo/presentation/splash/splash.dart';
import 'package:mvvm_demo/presentation/store_detail/store_detail.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/loginroute";
  static const String registerRoute = "/registerroute";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
