const String IS_DARK='isDark';
const String IS_FIRST_TIME='is_first_time';
const String TOKEN='token';
const USERNAME='username';

const HOME='Home';
const CART='Cart';
const FAVOURITES='Favourites';
const SETTINGS='Settings';

String? token;
String? username;

Map<int,String> categoriesImage={
  40:'assets/images/light-bulb.png',
  44:'assets/images/washer.png',
  43:'assets/images/medical-mask.png',
  42:'assets/images/football.png',
  46:'assets/images/tshirt.png',
};
String userAvatarImage='assets/images/user_avatar.png';

String? getCategoryImage(int? id){
  return categoriesImage[id];
}
