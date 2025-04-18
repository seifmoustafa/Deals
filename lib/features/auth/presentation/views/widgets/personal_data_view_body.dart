import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:deals/core/utils/app_colors.dart';
import 'package:deals/core/widgets/country_selector_field.dart';
import 'package:deals/core/widgets/custom_button.dart';
import 'package:deals/core/widgets/custom_text_form_field.dart';
import 'package:deals/core/widgets/date_picker_field.dart';
import 'package:deals/core/widgets/gender_selector.dart';
import 'package:deals/features/auth/presentation/manager/cubits/user_update_cubit/user_update_cubit.dart';
import 'package:deals/generated/l10n.dart';

class PersonalDataViewBody extends StatefulWidget {
  final String id;
  // fullName and phone are not needed for the update now.
  const PersonalDataViewBody({
    super.key,
    required this.id,
  });

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // These fields will be set via the form.
  Country? selectedCountry;
  String? city;
  DateTime? birthday;
  String? selectedGender; // Now store as a string

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          spacing: 20,
          children: [
            CountrySelectorField(
              validator: (value) {
                if (value == null) {
                  return S.of(context).CountryValidator;
                }
                return null;
              },
              label: S.of(context).Country,
              onCountrySelected: (Country country) {
                setState(() {
                  selectedCountry = country;
                });
              },
            ),
            CustomTextFormField(
              onSaved: (value) {
                city = value;
              },
              hintText: S.of(context).City,
              textInputType: TextInputType.text,
              label: S.of(context).City,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).CityValidator;
                }
                return null;
              },
            ),
            CustomDatePicker(
              validator: (value) {
                if (value == null) {
                  return S.of(context).BirthdayValidator;
                }
                return null;
              },
              onDateSelected: (value) {
                birthday = value;
              },
            ),
            GenderSelector(
              onGenderSelected: (value) {
                setState(() {
                  selectedGender =
                      value; // value is "male", "female", or "other"
                });
              },
              label: S.of(context).Gender,
              // Example validator function that returns a message if gender is not selected:
              validator: (gender) {
                if (gender == null) {
                  return S.of(context).PleaseSelectGender;
                }
                return null;
              },
            ),
            CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  final formattedBirthday = birthday != null
                      ? DateFormat('yyyy-MM-dd').format(birthday!)
                      : null;
                  context.read<UserUpdateCubit>().updateUser(
                        id: widget.id,
                        country: selectedCountry?.name,
                        city: city,
                        dateOfBirth: formattedBirthday,
                        gender: selectedGender, // pass directly
                      );
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
              width: double.infinity,
              text: S.of(context).Save,
            ),
            CustomButton(
              onPressed: () {
                context.read<UserUpdateCubit>().updateUser(
                      id: widget.id,
                      city: city,
                      country: selectedGender,
                      dateOfBirth: birthday?.toIso8601String() ?? "",
                      gender: selectedGender,
                    );
              },
              width: double.infinity,
              text: S.of(context).Later,
              textColor: AppColors.text,
              buttonColor: AppColors.lightGray,
            ),
          ],
        ),
      ),
    );
  }
}
