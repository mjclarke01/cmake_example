#include <iostream>
#include <string>
#include "MyLib/printer.h"

Printer::Printer() {}

void Printer::print(const std::string &input) {
  std::cout << input << std::endl;
}