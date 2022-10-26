import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_demo/app/app_prefs.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    _appPreferences.isLogged().then((isLoggin) => {
          if (isLoggin)
            {Navigator.of(context).pushReplacementNamed(Routes.mainRoute)}
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(
        image: AssetImage(ImageAssets.splashImage),
      )),
    );
  }
}
