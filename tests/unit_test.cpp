#include "gtest/gtest.h"

namespace {
  constexpr int f() {return 1;}

  TEST(ConstExprFunctionReturnsOne, Zero) {
    EXPECT_EQ(1, f());
  }

}