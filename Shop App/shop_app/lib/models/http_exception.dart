//here Exception is build in abastract class thats why implements
class HttpException implements Exception {
  final String? message;
  HttpException(this.message);

  @override
  String toString() {
    return message!;
    //return super.toString();//instance of HttpEception
  }
}
