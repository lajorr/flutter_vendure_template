import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_text_field.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final bool _isDefault = false;
  final String _selectedCountry = 'NP';

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: CustomAppBar(title: "Add New Address"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1024),
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
                      ),
                      AppSpacing.vS,
                      CustomTextField(
                        label: "Street Line 1",
                        isRequired: true,
                        hint: "House number and street name",
                      ),
                      AppSpacing.vS,
                      CustomTextField(
                        label: "Street Line 2",
                        hint: "Apartment, suite, unit, etc.",
                      ),

                      AppSpacing.vS,

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(label: "City", hint: "City"),
                          ),
                          AppSpacing.hM,

                          Expanded(
                            child: CustomTextField(
                              label: "Province/State",
                              hint: "State",
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
                                  child: CountryCodePicker(
                                    onChanged: (country) {
                                      // Handle country change
                                    },
                                    initialSelection: _selectedCountry,
                                    showCountryOnly: true,
                                    searchDecoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    builder: (country) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              country?.code ?? _selectedCountry,
                                              style: AppTextStyles.bodyLarge,
                                            ),
                                            const Icon(
                                              Icons.expand_more,
                                              color: AppColors.textSecondary,
                                            ),
                                          ],
                                        ),
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
                            child: CountryCodePicker(
                              onChanged: (country) {
                                // Handle dial code change
                              },
                              initialSelection: _selectedCountry,
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
                            ),
                          ),
                          AppSpacing.hXS,

                          Expanded(child: CustomTextField(hint: "98XXXXXXXX")),
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
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _isDefault,
                                  onChanged: (value) {
                                    setState(() {
                                      // _isDefault = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primaryNavy,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.neutralGray,
                                    width: 2,
                                  ),
                                ),
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
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                shadowColor: AppColors.primaryNavy.withValues(alpha: 0.2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Address',
                style: AppTextStyles.h3.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
