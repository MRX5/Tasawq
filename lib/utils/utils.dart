import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class Utils{
  static final _formatterSettings=MoneyFormatterSettings(symbol: 'EGP');
  static String formatPrice(dynamic price,{bool withSymbol=true}){
    if(price!=null){
        var result= MoneyFormatter(
            amount: double.parse(price.toString()),
            settings:_formatterSettings).output;
        if(withSymbol) {
          if(result.symbolOnRight.contains('.00')) {
            return result.symbolOnRight.replaceAll('.00', '');
          }
          return result.symbolOnRight;
        } else {
          return result.withoutFractionDigits;
        }
    }
    return '0';
  }
}