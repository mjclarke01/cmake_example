#include "gtest/gtest.h"
#include "ThirdPartyLib/third_party_lib.h"

namespace {
  constexpr int f() {return 1;}

  TEST(ThirdPartyTest, PretendTest) {
    EXPECT_EQ(1, f());
  }

}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}