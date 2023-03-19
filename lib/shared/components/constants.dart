import 'package:Sallate/modules/login/shop_login_screen.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:Sallate/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      navigateReplacementTo(
        context,
        ShopLoginScreen(),
      );
    },
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;
