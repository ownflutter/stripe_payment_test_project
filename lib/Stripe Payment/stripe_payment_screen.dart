import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment_test_project/Stripe%20Payment/keys.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  double amount = 20;
  Map<String, dynamic>? internetPaymentData;

  //showPaymentSheet
  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val){
        internetPaymentData= null;
      }).onError((error,s){
        print(error);
      });
    }
    on StripeException catch (error){
      {
        print(error);
      }
      showDialog(
          context: context,
          builder: (c) => AboutDialog(
           children: [
             Text('Cancel')
           ],
          )
      );
    }
    catch (error) {
      print(error);
    }
  }

  // makeInternetForPayment Methode
  makeInternetForPayment(amountToBeCharge, currency) async {
    {
      try {
        Map<String, dynamic>? paymentInfo = {
          'amount': (int.parse(amountToBeCharge)*100).toString(),
          'currency': currency,
          'payment_method_types': 'card',
        };
        var responseFromStripe = await http.post(
          Uri.parse(" https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        );
        print('Response ===========>> ${responseFromStripe.body}');
        return jsonDecode(responseFromStripe.body);
      } catch (error) {
        print(error.toString());
      }
    }
  }

  // PaymentSheetInitialization Methode
  paymentSheetInitialization(amountToBeCharge, currency) async {
    {
      try {
        internetPaymentData = await makeInternetForPayment(amountToBeCharge, currency);
        await Stripe.instance.initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
                    allowsDelayedPaymentMethods: true,
                    paymentIntentClientSecret: internetPaymentData!["client_secret"],
                    style: ThemeMode.dark,
                    merchantDisplayName: "Mahafujer Rahman"))
            .then((val) {
          print(val);
        });
        showPaymentSheet();
      } catch (error, s) {
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    paymentSheetInitialization(
                      amount.round().toString(),
                      "USD",
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Pay Now \$${amount.toString()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          )),
    );
  }
}
