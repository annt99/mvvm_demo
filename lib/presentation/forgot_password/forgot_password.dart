import 'package:flutter/material.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mvvm_demo/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:mvvm_demo/presentation/login/login_viewmodel.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.forgotPassword();
                }) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() => SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s40),
                Image.asset(ImageAssets.splashImage),
                const SizedBox(height: AppSize.s28),
                //email
                StreamBuilder<String?>(
                  stream: _viewModel.outputIsEmailValid,
                  builder: ((context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          helperText: '',
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                          errorMaxLines: 1,
                          errorText:
                              (snapshot.data == null) ? null : snapshot.data),
                    );
                  }),
                ),
                const SizedBox(height: AppSize.s40),
                StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s50,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () => _viewModel.forgotPassword()
                                : null,
                            child: const Text(AppStrings.resetPassword)),
                      );
                    }),
                const SizedBox(height: AppSize.s12),
                TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      _viewModel.forgotPassword();
                    },
                    child: const Text(AppStrings.resendTitle)),
                const SizedBox(height: AppSize.s14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: const Text(AppStrings.login)),
                    TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: const Text(
                          AppStrings.registerText,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ));
}
