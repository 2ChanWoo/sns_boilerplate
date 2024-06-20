import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sns_for_portfolio/data/provider/network/api_response.dart';
import 'package:sns_for_portfolio/domain/repository/auth_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/auth_stream_usecase.dart';
import 'package:sns_for_portfolio/domain/usecase/signin_usecase.dart';
import 'package:sns_for_portfolio/presentation/bloc/auth/auth_bloc.dart';

import '../../../../app/router/router.dart';
import '../../component/exception_indicator.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    required this.authRepository,
    Key? key,
  }) : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) {
        final useCase = SignInUseCase(authRepository);
        final streamUseCase = AuthStreamUseCase(authRepository);
        return AuthBloc(useCase, streamUseCase);
      },
      child: SignInView(),
    );
  }
}

@visibleForTesting
class SignInView extends StatelessWidget {
  const SignInView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            "Sign In",
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: _SignInForm(),
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _emailTextController = TextEditingController(text: "dlcksdn95@gmail.com");
  final _emailFocusNode = FocusNode();
  final _passwordTextController = TextEditingController(text: "qwer12#\$");
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //TODO: Add SignIn Textform validation
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _emailFocusNode.dispose();
    _passwordTextController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSigned && state.response.status == ApiStatus.COMPLETED) {
          FeedRouteData().go(context);
        }
      },
      builder: (context, state) {
        final bloc = context.read<AuthBloc>();
        bool submitting = (state is AuthStateSigned && state.response.status == ApiStatus.LOADING);
        return Column(
          children: <Widget>[
            TextField(
              controller: _emailTextController,
              focusNode: _emailFocusNode,
              // TODO onChanged: bloc.onEmailChanged,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.alternate_email,
                ),
                // TODO enabled: !isSubmissionInProgress,
                labelText: "E-mail",
                // errorText:
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordTextController,
              focusNode: _passwordFocusNode,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.password,
                ),
                labelText: "Password",
                // errorText:
              ),
            ),
            TextButton(
              child: Text(
                "Forgot my password",
              ),
              onPressed: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            submitting
                ? ExpandedElevatedButton.inProgress(label: "Sign In")
                : ExpandedElevatedButton(
                    onTap: () {
                      bloc.add(AuthEventSignIn(
                        _emailTextController.text,
                        _passwordTextController.text,
                      ));
                    },
                    label: "Sign In",
                    icon: const Icon(
                      Icons.login,
                    ),
                  ),
            const SizedBox(
              height: 48,
            ),
            Text(
              "Don't have account?",
            ),
            TextButton(
              child: Text(
                "Sign Up",
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
