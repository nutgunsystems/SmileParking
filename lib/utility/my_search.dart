class MySearch {
  String removeSpecChar(String value) {
    String strOutput1 = '';
    //String strOutput2 = '';
    String strOutput = '';

    if (value != null) {
      //strOutput1 = value.replaceAll(new RegExp(r'[^\w\s]+'), '');

      //strOutput2 = strOutput1.replaceAll(new RegExp('-'), '');
      strOutput1 = value.replaceAll('-', '');
      strOutput = strOutput1.replaceAll(' ', '');
    }

    return strOutput.trim();
  }

  MySearch();
}
