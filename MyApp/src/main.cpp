#include <iostream>
#include <string>
#include <functional>

#include "ThirdPartyLib/third_party_lib.h"
#include "MyLib/printer.h"
#include "MyHeaderLib/utils.h"

int main() {
  SimpleFormatter formatter;
  Printer printer;
  printer.print(formatter.formatString("Hello"));

  auto max = GetMax<int>(2, 3);
  std::cout << "Max is " << max << std::endl;

  return 0;
}
