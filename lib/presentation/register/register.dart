import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/images_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mvvm_demo/presentation/register/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey();
  final _picker = ImagePicker();
  _bind() {
    _viewModel.start();
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _phoneController
        .addListener(() => _viewModel.setPhoneNumber(_phoneController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isRegisterSuccessStreamController.stream.listen((isSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
              return snapshot.data?.getScreenWidget(context,
                      _getContentWidget(), () => _viewModel.register()) ??
                  _getContentWidget();
            }),
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
                Image.asset(ImageAssets.splashImage),
                const SizedBox(height: AppSize.s20),
                //username
                StreamBuilder<String?>(
                  stream: _viewModel.outputIsNameValid,
                  builder: ((context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: InputDecoration(
                          helperText: '',
                          hintText: AppStrings.name,
                          labelText: AppStrings.name,
                          errorMaxLines: 1,
                          errorText:
                              (snapshot.data == null) ? null : snapshot.data),
                    );
                  }),
                ),
                const SizedBox(height: AppSize.s12),
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
                const SizedBox(height: AppSize.s12),
                StreamBuilder(
                  stream: _viewModel.outputIsPhoneNumberValid,
                  builder: ((context, snapshot) {
                    return IntlPhoneField(
                      disableLengthCheck: true,
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        helperText: '',
                        hintText: AppStrings.mobilePhone,
                        labelText: AppStrings.mobilePhone,
                      ),
                      onChanged: (value) =>
                          _viewModel.setNumberCountryCode(value.countryCode),
                      initialCountryCode: 'VN',
                    );
                  }),
                ),
                const SizedBox(height: AppSize.s12),
                //password
                StreamBuilder<String?>(
                  stream: _viewModel.outputIsPasswordValid,
                  builder: ((context, snapshot) {
                    return TextFormField(
                      autofocus: false,
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
                const SizedBox(height: AppSize.s12),
                //picture
                StreamBuilder<String?>(
                  stream: _viewModel.outputIsProfilePictureValid,
                  builder: ((context, snapshot) {
                    return GestureDetector(
                      onTap: (() => _showPicker(context)),
                      child: TextFormField(
                        controller: TextEditingController(text: snapshot.data),
                        enabled: false,
                        keyboardType: TextInputType.text,
                        // obscureText: true,
                        decoration: InputDecoration(
                            isDense: true,
                            helperText: '',
                            hintText: AppStrings.profilePicture,
                            labelText: AppStrings.profilePicture,
                            suffixIcon: const Icon(Icons.image),
                            errorText: (snapshot.data != null)
                                ? null
                                : AppStrings.isPictureLink),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: AppSize.s20),
                StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s50,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () => _viewModel.register()
                                : null,
                            child: const Text(AppStrings.register)),
                      );
                    }),
                const SizedBox(height: AppSize.s20),
              ],
            ),
          ),
        ),
      ));
  _getImageGallery() async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      _viewModel.setProfilePicture(picture.name);
    }
  }

  _getImageCamera() async {
    var picture = await _picker.pickImage(source: ImageSource.camera);
    if (picture != null) {
      _viewModel.setProfilePicture(picture.name);
    }
  }

  _showPicker(BuildContext context) => showBottomSheet(
      context: context,
      builder: (context) => SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _getImageGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  _getImageCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          )));
}
