import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deals/constants.dart';
import 'package:deals/core/widgets/custom_modal_sheet.dart';
import 'package:deals/core/widgets/custom_progress_hud.dart';
import 'package:deals/features/auth/presentation/manager/cubits/otp_verify_cubit/otp_verify_cubit.dart';
import 'package:deals/features/auth/presentation/manager/cubits/otp_verify_cubit/otp_verify_state.dart';
import 'package:deals/features/auth/presentation/views/widgets/otp_verfication_view_body.dart';
import 'package:deals/generated/l10n.dart';
import 'package:deals/core/utils/app_images.dart';
import 'package:deals/features/auth/presentation/views/reset_password_view.dart';
import 'package:go_router/go_router.dart';

class OTPVeficationBlocConsumer extends StatelessWidget {
  final String email;
  final String? image;
  final String path;
  final bool isRegister;
  // The legacy id is still passed but not used for OTP in reset flow.
  final String id;

  const OTPVeficationBlocConsumer({
    super.key,
    required this.email,
    this.image,
    required this.path,
    required this.id,
    required this.isRegister,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerifyCubit, OtpVerifyState>(
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          log('User typed OTP: ${state.otp}');
          CustomModalSheet.show(
            context,
            buttonText: S.of(context).Next,
            enableDrag: false,
            svgPicture: SvgPicture.asset(AppImages.assetsImagesSuccess),
            onTap: () {
              // If user is resetting password
              if (path == ResetPasswordView.routeName) {
                context.goNamed(
                  ResetPasswordView.routeName,
                  extra: {
                    kEmail: email,
                    kOtp: state.otp,
                  },
                );
              } else {
                // e.g. PersonalDataView.routeName or any other route
                context.goNamed(
                  path,
                  extra: state.userEntity!.uId,
                );
              }
            },
            message: S.of(context).EmailVerified,
          );
        }
      },
      child: BlocBuilder<OtpVerifyCubit, OtpVerifyState>(
        builder: (context, state) {
          String? errorMessage;
          bool isLoading = false;
          if (state is OtpVerifyLoading) {
            isLoading = true;
          } else if (state is OtpVerifyFailure) {
            errorMessage = S.of(context).InvalidCode;
          }

          return CustomProgressHud(
            isLoading: isLoading,
            child: OTPVerificationViewBody(
              isRegister: isRegister,
              id: id,
              image: image,
              email: email,
              routeName: path,
              errorMessage: errorMessage,
            ),
          );
        },
      ),
    );
  }
}
