#include "gtest/gtest.h"
#include "ThirdPartyLib/third_party_lib.h"

namespace {
  constexpr int f() {return 1;}

  TEST(ConstExprFunctionReturnsOne, SomeTest) {
    EXPECT_EQ(1, f());
  }

  TEST(ThirdPartyLib, SomeOtherTest) {
	  // Use the ThirdPartyLibrary for the hell of it
	  SimpleFormatter formatter;

	  EXPECT_EQ("Formatted: Hello", formatter.formatString("Hello"));
  }

}