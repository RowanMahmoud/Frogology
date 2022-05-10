import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:local_auth/local_auth.dart';
final storage =FlutterSecureStorage();

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate(BuildContext context) async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    //
    // try {
    //   return await _auth.authenticateWithBiometrics(
    //     localizedReason: DemoLocalization.of(context)
    //         .translate("ScanFingerprinttoAuthenticate"),
    //     useErrorDialogs: true,
    //     stickyAuth: true,
    //   );
    // } on PlatformException catch (e) {
    //   return false;
    // }
    final authenticated =await _auth.authenticateWithBiometrics(
        localizedReason:DemoLocalization.of(context)
            .translate("ScanFingerprinttoAuthenticate"),
      useErrorDialogs: true,
         stickyAuth: true,);
    if(authenticated){
      storage.write(key:"email",value:null);
      storage.write(key:"password",value:null);
      storage.write(key:"UsingBiometric",value:'true');

    }

  }
}
