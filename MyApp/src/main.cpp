#include <iostream>
#include <string>
#include <functional>

#include "ThirdPartyLib/third_party_lib.h"

int main() {
  SimpleFormatter formatter;
  std::cout << formatter.formatString("Hello") << std::endl;

  return 0;
}