import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/presentation/onboarding/onboarding_viewmodel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: ((context, snapshot) {
        return _getContentWidget(snapshot.data);
      }),
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: ((context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject);
          }),
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: const Text(
                      AppStrings.skip,
                    )),
              ),
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) => Expanded(
        child: Container(
          color: ColorManager.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: GestureDetector(
                  onTap: (() {
                    _pageController.animateToPage(_viewModel.goPrevious(),
                        duration:
                            const Duration(milliseconds: DurationConstant.d100),
                        curve: Curves.bounceInOut);
                  }),
                  child: sliderViewObject.currentIndex > 0
                      ? SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                          child: SvgPicture.asset(
                            ImageAssets.arrowLeftIC,
                            color: ColorManager.white,
                          ),
                        )
                      : const SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                        ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: _getProperCircle(i, sliderViewObject.currentIndex),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: GestureDetector(
                  onTap: (() {
                    _pageController.animateToPage(_viewModel.goNext(),
                        duration:
                            const Duration(milliseconds: DurationConstant.d100),
                        curve: Curves.bounceInOut);
                  }),
                  child: sliderViewObject.currentIndex !=
                          sliderViewObject.numOfSlides - 1
                      ? SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                          child: SvgPicture.asset(
                            ImageAssets.arrowRightIC,
                            color: ColorManager.white,
                          ),
                        )
                      : const SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                        ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.dotNoFillIC);
    } else {
      return SvgPicture.asset(ImageAssets.dotIC);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);
  final SliderObject _sliderObject;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
