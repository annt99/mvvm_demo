import 'package:flutter/material.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mvvm_demo/presentation/login/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _usernameController
        .addListener(() => _viewModel.setUserName(_usernameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  Widget _getContentWith() => SafeArea(
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
                  //username
                  StreamBuilder<String?>(
                    stream: _viewModel.outputIsUsernameValid,
                    builder: ((context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                        decoration: InputDecoration(
                            helperText: '',
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorMaxLines: 1,
                            errorText:
                                (snapshot.data == null) ? null : snapshot.data),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSize.s12),
                  //password
                  StreamBuilder<String?>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: ((context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        // obscureText: true,
                        decoration: InputDecoration(
                            helperText: '',
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
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
                                  ? () => _viewModel.login()
                                  : null,
                              child: const Text(AppStrings.login)),
                        );
                      }),
                  const SizedBox(height: AppSize.s14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: const Text(AppStrings.forgetPassword)),
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
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWith(),
                    () {
                  _viewModel.login();
                }) ??
                _getContentWith();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
