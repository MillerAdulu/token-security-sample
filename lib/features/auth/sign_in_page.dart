import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresher/features/auth/cubit/sign_in_cubit.dart';
import 'package:refresher/l10n/l10n.dart';
import 'package:refresher/utils/custom_text_theme.dart';
import 'package:refresher/utils/router.dart';
import 'package:refresher/widgets/input_form_field.dart';
import 'package:refresher/widgets/primary_button.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController(
    text: kDebugMode ? 'member.mills@parkroadfellowship.org' : '',
  );
  final _passwordController =
      TextEditingController(text: kDebugMode ? 'password' : '');
  final _hidePasswordNotifier = ValueNotifier<bool>(true);

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Center(child: FlutterLogo(size: 200)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.signIn,
                    style: CustomTextTheme.customTextTheme().displayLarge,
                  ),
                ),
                const SizedBox(height: 20),
                InputFormField(
                  hintText: l10n.studentEmail,
                  controller: _emailController,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                  valueListenable: _hidePasswordNotifier,
                  builder: (context, hidePassword, child) {
                    return InputFormField(
                      hintText: l10n.enterPassword,
                      controller: _passwordController,
                      showSuffix: true,
                      hidePassword: hidePassword,
                      toggleHidePassword: () {
                        _hidePasswordNotifier.value = !hidePassword;
                      },
                      enabled: !_isLoading,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocConsumer<SigninCubit, SignInState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loading: () => setState(() {
                        _isLoading = !_isLoading;
                      }),
                      loaded: () => context.router.pushNamed(
                        RefresherRouter.landingRoute,
                      ),
                      error: (message) {
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => PrimaryButton(
                        onPressed: () {
                          context.read<SigninCubit>().signIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                        },
                        title: _isLoading ? l10n.signingIn : l10n.signIn,
                        disabled: _isLoading,
                        isLoading: _isLoading ? true : null,
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
