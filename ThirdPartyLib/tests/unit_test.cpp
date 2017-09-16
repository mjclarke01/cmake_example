#include "gtest/gtest.h"

namespace {
  constexpr int f() {return 1;}

  TEST(ThirdPartyTest, PretendTest) {
    EXPECT_EQ(1, f());
  }

}