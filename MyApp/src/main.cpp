#include <iostream>
#include <string>
#include <functional>

int main() {
  [out = std::ref(std::cout << "Hello, ")](){ out.get() << "World!" << std::endl; }();

  return 0;
}