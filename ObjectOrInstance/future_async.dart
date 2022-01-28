import 'dart:async';
//(i)
/*main() {
  print("About to fetch data");
  get("http://kdjfkldjf.com").then((result) {
    print(result);
  });
}*/

//this is as same as (i)
// And async inidcate that this function will take some time to fetch dat
 main() async {
  print("About to fetch data");
  // this await indicate it is for fututre
  var reslut = await get("http://dlkfjdf");
  print(reslut);
}

Future<String> get(String url) {
  return new Future.delayed(new Duration(seconds: 2), () {
    return "Got the data";
  });
}
