import 'dart:math';

String randomPicture([int? seed]) {
  //Write algorithm to return a value 1 -1000 randomly
  if (seed != null) {
    final random = Random(seed);
    final randomNumber = random.nextInt(1000) + 1;
    return "https://loremflickr.com/200/200?random=$randomNumber";
  } else {
    final random = Random();
    final randomNumber = random.nextInt(1000) + 1;
    return "https://loremflickr.com/200/200?random=$randomNumber";
  }
}
