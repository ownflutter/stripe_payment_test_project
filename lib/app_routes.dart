import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:stripe_payment_test_project/Stripe%20Payment/stripe_payment_screen.dart';

class AppRoutes{
  static const String stripePaymentScreen = "/stripePayment_Screen";


  static List<GetPage> get routes =>[
    GetPage(name: stripePaymentScreen, page: () => StripePaymentScreen()),

  ];
}