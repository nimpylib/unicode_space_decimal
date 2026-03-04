

from std/unicode import `<%`

import ./[rune_decl, decimal, space]
import ../../Utils/castChar

const AsciiDigits = "0123456789"
proc transformDecimalAndSpaceToASCII*(unicodeStr: openArray[Rune]): string =
  result = (when declared(newStringUninit): newStringUninit else: newString)(unicodeStr.len)
  for i, rune in unicodeStr:
    template st(val) = result[i] = val
    if rune <% Rune(127): st castChar(rune)
    elif rune.isspace(): st ' '
    else:
      decimalItOr(rune):
        st AsciiDigits[it]
      do:
        st '?'

