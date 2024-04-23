import 'dart:developer';

import 'package:aquaria_mobile/models/bank_list_model.dart';
import 'package:aquaria_mobile/models/common_data_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/screens/auth/login_screen.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var size = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return CustomBackGroundContainer(
      backgroundColor: kTxtWhite,
      customDecoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.getPropotionateWidth(20)),
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.getPropotionateHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/logo2.jpeg',
                          width: size.getPropotionateWidth(70),
                          height: size.getPropotionateWidth(70),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: size.getTextSize(28),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(30),
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: size.getTextSize(16),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(7),
                  ),
                  CommonInputField(
                    hint: 'John Smith',
                    controller: auth.getNameController,
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(5),
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: size.getTextSize(16),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(7),
                  ),
                  CommonInputField(
                    hint: 'username@gmail.com',
                    controller: auth.getEmailController,
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(5),
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: size.getTextSize(16),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(7),
                  ),
                  CommonInputField(
                    hint: '000 000 000',
                    controller: auth.getPhoneController,
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(5),
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: size.getTextSize(16),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(7),
                  ),
                  CommonInputField(
                    hint: 'Password',
                    controller: auth.getPasswordController,
                    obscureText: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Customer'),
                          value: 'Customer',
                          groupValue: auth.getselectedRole,
                          onChanged: (value) {
                            auth.setselectedRole(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Vendor'),
                          value: 'Vendor',
                          groupValue: auth.getselectedRole,
                          onChanged: (value) {
                            auth.setselectedRole(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  if (auth.getselectedRole == 'Vendor')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vendor Code',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        CommonInputField(
                          hint: 'Vendor Code',
                          controller: auth.getVendorCodeController,
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'BR no',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        CommonInputField(
                          hint: 'BR no',
                          controller: auth.getBrNoController,
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        CommonInputField(
                          hint: 'Address',
                          controller: auth.getAddressController,
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Country',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Country',
                        //   controller: auth.getCountryController,
                        // ),

                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<Countries>(
                              filterFn: (item, filter) {
                                return item.name!.toLowerCase().contains(filter.toLowerCase());
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              items: auth.getloadedCommonData!.countries!,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              itemAsString: (item) {
                                return item.name!;
                              },
                              selectedItem: auth.getloadedCommonData!.countries!.first,
                              onChanged: (value) {
                                auth.setselectedCountry(value);
                                auth.loadBanksData(context);
                                log(value!.toJson().toString());
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Timezone',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Timezone',
                        //   controller: auth.getTimezoneController,
                        // ),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<Timezones>(
                              items: auth.getloadedCommonData!.timezones!,
                              filterFn: (item, filter) {
                                return "${item.name!} ${item.offset!}".toLowerCase().contains(filter.toLowerCase());
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              itemAsString: (item) {
                                return "${item.name!} ${item.offset!}";
                              },
                              onChanged: (value) {
                                auth.setselectedTimezone(value);

                                log(value!.toJson().toString());
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Currency',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Currency',
                        //   controller: auth.getCurrencyController,
                        // ),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<Currencies>(
                              items: auth.getloadedCommonData!.currencies!,
                              filterFn: (item, filter) {
                                return item.name!.toLowerCase().contains(filter.toLowerCase());
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              itemAsString: (item) {
                                return item.name!;
                              },
                              onChanged: (value) {
                                log(value!.toJson().toString());
                                auth.setselectedCurrency(value);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Account No',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        CommonInputField(
                          hint: 'Account No',
                          controller: auth.getAccountNoController,
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Bank',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Bank',
                        //   controller: auth.getBankController,
                        // ),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<SingleBankData>(
                              items: auth.getloadedBanksList == null ? [] : auth.getloadedBanksList!.data!,
                              filterFn: (item, filter) {
                                return item.name!.toLowerCase().contains(filter.toLowerCase());
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              itemAsString: (item) {
                                return item.name!;
                              },
                              selectedItem: auth.getselectedBank,
                              onChanged: (value) {
                                auth.setselectedBank(value);
                                auth.setselectedBranch(null);
                                log(value!.toJson().toString());
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Branch',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Branch',
                        //   controller: auth.getBranchController,
                        // ),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<BankBranches>(
                              items: (auth.getloadedBanksList == null || auth.getselectedBank == null) ? [] : auth.getselectedBank!.bankBranches!,
                              filterFn: (item, filter) {
                                return item.name!.toLowerCase().contains(filter.toLowerCase());
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              itemAsString: (item) {
                                return item.name!;
                              },
                              selectedItem: auth.getselectedBranch,
                              onChanged: (value) {
                                auth.setselectedBranch(value);
                                log(value!.toJson().toString());
                              },
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: size.getPropotionateHeight(7),
                        // ),
                        // Text(
                        //   'Offering Items',
                        //   style: TextStyle(
                        //     fontSize: size.getTextSize(16),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: size.getPropotionateHeight(7),
                        // ),
                        // CommonInputField(
                        //   hint: 'Offering Items',
                        //   controller: auth.getOfferingItemsController,
                        // ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Delivery Methods',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        // CommonInputField(
                        //   hint: 'Delivery Methods',
                        //   controller: auth.getDeliveryMethodsController,
                        // ),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return DropdownSearch<DeliveryMethods>.multiSelection(
                              // filterFn: (item, filter) {
                              //   return item.name!.toLowerCase().contains(filter.toLowerCase());
                              // },
                              // popupProps: const PopupPropsMultiSelection.menu(
                              //   showSearchBox: true,
                              // ),
                              items: auth.getloadedCommonData!.deliveryMethods!,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              itemAsString: (item) {
                                return item.name!;
                              },
                              onChanged: (value) {
                                auth.setselectedDeliveryMethods(value);
                                log(value.toList().toString());
                                // log(value!.toJson().toString());
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        Text(
                          'Specialized Areas',
                          style: TextStyle(
                            fontSize: size.getTextSize(16),
                          ),
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                        CommonInputField(
                          hint: 'Specialized Areas',
                          controller: auth.getSpecializedAreasController,
                        ),
                        SizedBox(
                          height: size.getPropotionateHeight(7),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have an account ?   ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "Log In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0199FE),
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(41),
                  ),
                  auth.getIsLogginIn
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(
                              color: Color(0xFF0E52A8),
                            ),
                          ],
                        )
                      : CommonButton(
                          size: size,
                          btnTxt: "Sign Up",
                          onTap: () {
                            auth.registerUser(context);
                          },
                        ),
                  SizedBox(
                    height: size.getPropotionateHeight(15),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
