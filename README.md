# stripe_payment_test_project

A new Flutter project.

## Getting Started


Document :
## Stripe Payment
Referance vedio : https://www.youtube.com/watch?v=CR3CqMY5LnQ

1. Flutter Package Install.
Requirements Android :
 

2. android/app/build.gradle >>>>> minSdk = 24
3.android/settings.gradle  (Need update kotlin version)
4. android/settings.gradle 
add the latest version : com.android.application Version
. Go link :
https://developer.android.com/build/releases/gradle-plugin


5.android/app/src/main/res/values/styles.xml
Replace :   <style name="NormalTheme" parent="Theme.MaterialComponents">

6.android/app/src/main/res/values-night/styles.xml
Replace :   <style name="NormalTheme" parent="Theme.MaterialComponents">

 


7.Android/gradle/wrapper/gradle-wrapper.properties 
(Only below url replace)
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-bin.zip
 

8. android/app/src/main/kotlin/com/example/project_my_flutter/MainActivity

Replase last line 
import io.flutter.embedding.android.FlutterFragmentActivity
class MainActivity: FlutterFragmentActivity() {
}
9..Make new file in below path and keep this belowe code  :
android/app/proguard-rules.pro

===
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

 

No check everything going good ,Build one apk form app.

10. Replace the suugessed ndkVersion : 
android/app/build.gradle
11. Now - in concole (Flutter clean and Flutter pub get) one more

12.
https://docs.stripe.com/api/payment_intents..
13.
https://docs.page/flutter-stripe/flutter_stripe/sheet


Make fuction and Works good.
