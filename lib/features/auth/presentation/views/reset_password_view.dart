import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:deals/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;
  final String otp;

  const ResetPasswordView({
    super.key,
    required this.email,
    required this.otp,
  });

  static const routeName = '/reset-password';

  @override
  Widget build(BuildContext context) {
    log("The otp in reset: $otp");
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: ResetPasswordViewBody(
          email: email,
          otp: otp,
        ),
      ),
    );
  }
}
