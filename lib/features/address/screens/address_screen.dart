import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/custom_text_field.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/payment_configurations.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFromKey = GlobalKey<FormState>();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  @override
  Widget build(BuildContext context) {
    // var address = context.watch<UserProvider>().user.address;
    var address = "101 Fake Street";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _addressFromKey,
              child: Column(
                children: [
                  if (address.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  CustomTextField(
                    controller: _flatBuildingController,
                    hintText: "Flat, House No, Building",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _areaController,
                    hintText: "Area, Street",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _pinCodeController,
                    hintText: "Pincode",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _cityController,
                    hintText: "Town & City",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // CustomButton(
                  //   text: 'Sign Up',
                  //   onTap: () {},
                  // )

                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: GooglePayButton(
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: _paymentItems,
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onGooglePayResult,
                      height: 200,
                      width: double.infinity,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
