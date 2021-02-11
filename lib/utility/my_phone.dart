class MyPhone {
  String newNumber = '';

  String replacePhoneNo(String number) {
    newNumber = number;

    for (int i = 4; i < number.length - 2; i++) {
      newNumber = replaceCharAt(newNumber, i, "*");
    }

    //print("PHONE_NUMBER_LOOP:$newNumber");
    return newNumber;
  }

  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  MyPhone();
}
