import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';
import 'package:flutter_blog_firebase/core/app_routes.dart';
import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/core/navigator.dart';
import 'package:flutter_blog_firebase/core/value_objects/email_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/password_value_object.dart';
import 'package:flutter_blog_firebase/core/widgets/custom_pop_up.dart';
import 'package:flutter_blog_firebase/features/auth/domain/failures.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/manager/login_contract.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (BuildContext context) {
        return Injection.getIt.get<LoginBloc>();
      },
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget implements LoginContract {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*
    final LoginParams loginParams = LoginParams(
      emailAddress: EmailAddress('moohammed.gaber@gmail.com'),
      password: Password('12345675'),
    );
    context
        .read<LoginBloc>()
        .loginUseCase
        .authRepo
        .login(loginParams.emailAddress, loginParams.password)
        .then((value) => print(value));
*/
/*
    final LoginPresenter loginPresenter = LoginPresenter(
        LoginUseCase(AuthRepoImpl(AuthRemoteDataSource(FirebaseAuth.instance))),
        this);
*/

    return Scaffold(
      key: scaffoldKey,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(() {}, (a) {
            late final String message;
            a.fold((l) {
              if (l is InvalidEmailFailure) {
                message = 'البريد الإلكتروني غير صحيح';
              }
              if (l is WrongPasswordFailure) {
                message = 'كلمة المرور غير صحيحة';
              }
              if (l is UserNotFoundFailure) {
                message = 'البريد الإلكتروني غير مسجل';
              }
              if (l is UserDisabledFailure) {
                message = 'البريد الإلكتروني معطل';
              }
              if (l is TooManyRequestFailure) {
                message = 'تم تسجيل الدخول عدة مرات ';
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(CustomPopUp.errorSnackBar(message));
              print(l);
            }, (r) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
              // return null;
            });
          });
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 27.5.h, bottom: 24.h),
                  child: Text('تسجيل الدخول'),
                ),
                CustomTitledTextField(
                  name: 'البريد الالكتروني',
                  textField: TextFormField(
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(EmailChanged(email: EmailAddress(value)));
                    },
                    validator: (value) {
                      return context
                          .read<LoginBloc>()
                          .state
                          .email
                          .value
                          .fold((l) => 'بريد الكتروني غير صحيح', (r) => null);
                    },
                    // name: 'email',
                  ),
                ),
                SizedBox(
                  height: 18.4.h,
                ),
                PasswordTextField(
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(PasswordChanged(password: Password(value!)));
                    },
                    text: 'كلمة المرور',
                    validator: (value) {
                      return context
                          .read<LoginBloc>()
                          .state
                          .password
                          .value
                          .fold((l) => 'كلمة المرور غير صحيحة', (r) => null);
                    }),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text('نسيت كلمة المرور؟')),
                SizedBox(height: 38.h),
                TextButton(
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                    /*     final formCurrentState = formKey.currentState;
                        final isValid = formCurrentState!.saveAndValidate();
                        if (isValid) {
                          onLogin(LoginParams.fromJson(formCurrentState.value));
                        }*/
                  },
                  child: Text('تسجيل الدخول',
                      style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      minimumSize: Size(double.infinity, 40.h)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 23.53.h, bottom: 27.h),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text('أو'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),
                Text('إذا لم يكن لديك حساب قم بالتسجيل'),
                SizedBox(height: 18.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_add_alt, color: AppColors.orange),
                      SizedBox(
                        width: 4.79.w,
                      ),
                      Text('تسجيل حساب جديد',
                          style: TextStyle(color: AppColors.lightOrange)),
                    ],
                  ),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          side: BorderSide(color: AppColors.orange)),
                      backgroundColor: AppColors.white,
                      minimumSize: Size(double.infinity, 40.h)),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  @override
  onLogin(LoginParams loginParams) async {
    // loginPresenter.login(loginParams);
  }

  @override
  onLoginFailure(AuthFailure failure) {}

  @override
  onLoginSuccess(UserEntity loggedUser) {
    // Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false)
  }
}
