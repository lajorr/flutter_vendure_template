import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/core/utils/validation_mixin.dart';
import 'package:vendure_flutter_app/features/auth/domain/entities/customer.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/set_order_customer_controller.dart';
import 'package:vendure_flutter_app/shared/models/create_customer_input.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_text_field.dart';

class SetGuestCustomerScreenArgs {
  final Customer? initialCustomer;

  SetGuestCustomerScreenArgs({this.initialCustomer});
}

class SetGuestCustomerScreen extends ConsumerStatefulWidget {
  const SetGuestCustomerScreen({super.key, this.args});

  final SetGuestCustomerScreenArgs? args;

  @override
  ConsumerState<SetGuestCustomerScreen> createState() =>
      _SetGuestCustomerScreenState();
}

class _SetGuestCustomerScreenState extends ConsumerState<SetGuestCustomerScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _selectedCountry = ValueNotifier<String>("NP");

  @override
  void initState() {
    super.initState();
    if (widget.args?.initialCustomer != null) {
      final customer = widget.args!.initialCustomer!;
      _firstNameController.text = customer.firstName;
      _lastNameController.text = customer.lastName;
      _emailController.text = customer.emailAddress;
      _phoneNumberController.text = customer.phoneNumber ?? '';
      _titleController.text = customer.title ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _selectedCountry.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setCustomerState = ref.watch(setOrderCustomerControllerProvider);
    final isLoading = setCustomerState.isLoading;

    ref.listen(setOrderCustomerControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else if (next is AsyncData && previous is AsyncLoading) {
        context.pop();
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(title: 'Customer Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.l),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.neutralGray),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.s),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: AppColors.primaryNavy,
                              ),
                            ),
                            AppSpacing.hM,
                            const Text(
                              'Contact Details',
                              style: AppTextStyles.h3,
                            ),
                          ],
                        ),
                        AppSpacing.vL,
                        CustomTextField(
                          label: 'Title',
                          hint: 'Enter Your Title',
                          controller: _titleController,
                        ),
                        AppSpacing.vM,
                        CustomTextField(
                          label: 'First Name',
                          hint: 'Jane',
                          controller: _firstNameController,
                          isRequired: true,
                          validator: (value) =>
                              validateRequired(value, 'First name'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        AppSpacing.vM,
                        CustomTextField(
                          label: 'Last Name',
                          hint: 'Doe',
                          controller: _lastNameController,
                          isRequired: true,
                          validator: (value) =>
                              validateRequired(value, 'Last name'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        AppSpacing.vM,
                        CustomTextField(
                          label: 'Email Address',
                          hint: 'Enter your email address',
                          controller: _emailController,
                          isRequired: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        AppSpacing.vM,
                        Text("Phone Number", style: AppTextStyles.label),
                        AppSpacing.vXS,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                border: Border.all(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ValueListenableBuilder(
                                valueListenable: _selectedCountry,
                                builder: (context, selectedCountry, child) {
                                  return CountryCodePicker(
                                    onChanged: (country) {
                                      _selectedCountry.value =
                                          country.code ?? selectedCountry;
                                    },
                                    initialSelection: selectedCountry,
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    showFlagMain: false,
                                    textStyle: AppTextStyles.label,
                                    padding: EdgeInsets.zero,
                                    searchDecoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            AppSpacing.hXS,
                            Expanded(
                              child: CustomTextField(
                                hint: "Enter phone number",
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                validator: (value) => validatePhoneNumber(
                                  value,
                                  _selectedCountry.value,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.neutralGray.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        final fullPhoneNumber = getInternationalPhoneNumber(
                          _phoneNumberController.text,
                          _selectedCountry.value,
                        );

                        final input = CreateCustomerInput(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          emailAddress: _emailController.text.trim(),
                          phoneNumber: fullPhoneNumber,
                        );
                        ref
                            .read(setOrderCustomerControllerProvider.notifier)
                            .setCustomer(input);
                      }
                    },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Save Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
