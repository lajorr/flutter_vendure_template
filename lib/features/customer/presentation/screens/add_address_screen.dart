import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/set_order_address_controller.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_text_field.dart';

class AddAddressScreenArgs {
  final bool isGuest;
  final ActiveOrderAddress? initialAddress;

  AddAddressScreenArgs({required this.isGuest, this.initialAddress});
}

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key, required this.args});

  final AddAddressScreenArgs args;

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _streetLine1Controller = TextEditingController();
  final _streetLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final ValueNotifier<bool> _isDefault = ValueNotifier<bool>(false);
  final ValueNotifier<String> _selectedCountry = ValueNotifier<String>("NP");

  // texts
  late String appBarTitleText;
  late String buttonText;

  @override
  void initState() {
    super.initState();
    appBarTitleText = widget.args.isGuest
        ? "Set Shipping Address"
        : "Add New Address";
    buttonText = widget.args.isGuest ? "Set Address" : "Save Address";

    if (widget.args.initialAddress != null) {
      final addr = widget.args.initialAddress!;
      _fullNameController.text = addr.fullName ?? '';
      _streetLine1Controller.text = addr.streetLine1 ?? '';
      _streetLine2Controller.text = addr.streetLine2 ?? '';
      _cityController.text = addr.city ?? '';
      _provinceController.text = addr.province ?? '';
      _postalCodeController.text = addr.postalCode ?? '';
      _phoneNumberController.text = addr.phoneNumber ?? '';
      _selectedCountry.value = addr.countryCode ?? 'NP';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _streetLine1Controller.dispose();
    _streetLine2Controller.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Widget buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: AppTextStyles.label,
          children: isRequired
              ? const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error),
                  ),
                ]
              : const [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final setAddressState = ref.watch(setOrderAddressControllerProvider);
    final isLoading = setAddressState.isLoading;

    ref.listen(setOrderAddressControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else if (next is AsyncData && previous is AsyncLoading) {
        // Success
        context.pop();
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: appBarTitleText),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1024),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.neutralGray),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: AppColors.black,
                              ),
                            ),
                            AppSpacing.hM,

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Delivery Details',
                                    style: AppTextStyles.h3,
                                  ),
                                  Text(
                                    'Tell us where to send your order.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vXL,
                        CustomTextField(
                          label: "Full Name",
                          hint: "Enter your full name",
                          controller: _fullNameController,
                        ),
                        AppSpacing.vS,
                        CustomTextField(
                          label: "Street Line 1",
                          isRequired: true,
                          hint: "House number and street name",
                          controller: _streetLine1Controller,
                          validator: (value) => (value == null || value.isEmpty)
                              ? "Street Line 1 is required"
                              : null,
                        ),
                        AppSpacing.vS,
                        CustomTextField(
                          label: "Street Line 2",
                          hint: "Apartment, suite, unit, etc.",
                          controller: _streetLine2Controller,
                        ),

                        AppSpacing.vS,

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: "City",
                                hint: "City",
                                controller: _cityController,
                              ),
                            ),
                            AppSpacing.hM,

                            Expanded(
                              child: CustomTextField(
                                label: "Province/State",
                                hint: "State",
                                controller: _provinceController,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vS,

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: "Postal Code",
                                hint: "Zip Code",
                                controller: _postalCodeController,
                              ),
                            ),
                            AppSpacing.hM,

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildLabel('Country Code', isRequired: true),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ValueListenableBuilder(
                                      valueListenable: _selectedCountry,
                                      builder:
                                          (
                                            BuildContext context,
                                            selectedCountry,
                                            Widget? child,
                                          ) {
                                            return CountryCodePicker(
                                              onChanged: (country) {
                                                _selectedCountry.value =
                                                    country.code ??
                                                    selectedCountry;
                                              },
                                              initialSelection: selectedCountry,
                                              showCountryOnly: true,
                                              searchDecoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              builder: (country) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 12,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        country?.code ??
                                                            selectedCountry,
                                                        style: AppTextStyles
                                                            .bodyLarge,
                                                      ),
                                                      const Icon(
                                                        Icons.expand_more,
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vS,

                        buildLabel('Phone Number'),
                        Row(
                          children: [
                            Container(
                              height: 48,
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
                                hint: "98XXXXXXXX",
                                controller: _phoneNumberController,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.vL,

                        InkWell(
                          onTap: () {
                            setState(() {
                              // _isDefault = !_isDefault;
                            });
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: _isDefault,
                                  builder: (context, isDefault, child) {
                                    return SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: isDefault,
                                        onChanged: (value) {
                                          _isDefault.value = value ?? isDefault;
                                        },
                                        activeColor: AppColors.primaryNavy,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        side: const BorderSide(
                                          color: AppColors.neutralGray,
                                          width: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                AppSpacing.hS,
                                Expanded(
                                  child: Text(
                                    'Set as default shipping address',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          border: Border(
            top: BorderSide(color: AppColors.grey.withValues(alpha: 0.5)),
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.m),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        final address = CreateAddressInput(
                          fullName: _fullNameController.text,
                          streetLine1: _streetLine1Controller.text,
                          streetLine2: _streetLine2Controller.text,
                          city: _cityController.text,
                          province: _provinceController.text,
                          postalCode: _postalCodeController.text,
                          countryCode: _selectedCountry.value,
                          phoneNumber: _phoneNumberController.text,
                          defaultShippingAddress: _isDefault.value,
                          defaultBillingAddress: _isDefault.value,
                        );

                        if (widget.args.isGuest) {
                          await ref
                              .read(setOrderAddressControllerProvider.notifier)
                              .setAddress(address);
                        } else {
                          // TODO: Implement save address for logged in customer
                        }
                      }
                    },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                shadowColor: AppColors.primaryNavy.withValues(alpha: 0.2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      buttonText,
                      style: AppTextStyles.h3.copyWith(color: AppColors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
