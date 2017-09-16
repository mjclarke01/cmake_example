#include "ThirdPartyLib/third_party_lib.h"

SimpleFormatter::SimpleFormatter() {
}

std::string SimpleFormatter::formatString(const std::string& input) {
    return "Formatted: " + input;
}