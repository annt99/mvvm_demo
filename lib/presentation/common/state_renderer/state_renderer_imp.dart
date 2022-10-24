import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading state (POPUP, FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (POPUP, FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Content state
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
      BuildContext context, Widget contentScreenWidget, Function retryFuntion) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRender(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFuntion: retryFuntion);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRender(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFuntion: retryFuntion);
          }
        }
      case EmptyState:
        {
          return StateRender(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFuntion: retryFuntion);
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRender(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFuntion: () {})));
  }
}
