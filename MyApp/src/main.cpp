#include <iostream>
#include <string>
#include <functional>

#include "ThirdPartyLib/third_party_lib.h"
#include "MyLib/printer.h"

int main() {
  SimpleFormatter formatter;
  Printer printer;

  printer.print(formatter.formatString("Hello"));

  return 0;
}