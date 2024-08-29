import 'dart:math';

String randomPicture() {
  //Write algorithm to return a value 1 -1000 randomly
  final random = Random();
  final randomNumber = random.nextInt(1000) + 1;
  return "https://loremflickr.com/200/200?random=$randomNumber";
}
