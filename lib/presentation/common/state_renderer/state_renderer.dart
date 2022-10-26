// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_demo/core/utils/font_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/styles_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/data/network/failure.dart';

enum StateRendererType {
  //POPUP
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS_STATE,
  //Full Screen
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRender extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFuntion;

  const StateRender(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryActionFuntion})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      //POPUP LOADING
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupDialog(
            context, [_getAnimateImage(JsonAssets.loadingJson)]);
      //POPUP ERROR
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupDialog(context, [
          _getAnimateImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.POPUP_SUCCESS_STATE:
        return _getPopupDialog(context, [
          _getAnimateImage(JsonAssets.successJson),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      //FULL SCREEN LOADING
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getWidgetColumn([
          _getAnimateImage(JsonAssets.loadingJson),
          _getMessage(message),
        ]);
      //FULL SCREEN ERROR
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getWidgetColumn([
          _getAnimateImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      // CONTENT SCREEN
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      // EMPTY SCREEN
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getWidgetColumn(
            [_getAnimateImage(JsonAssets.emptyJson), _getMessage(message)]);

      default:
        return Container();
    }
  }

  Widget _getAnimateImage(String animationName) {
    return SizedBox(
      height: AppSize.s100 * 2,
      width: AppSize.s100 * 2,
      child: Lottie.asset(animationName, fit: BoxFit.contain),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: getMediumStyle(
              color: Colors.white, fontSize: FontSizeManager.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFuntion?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getWidgetColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
