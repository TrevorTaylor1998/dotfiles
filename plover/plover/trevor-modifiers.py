# Emily's Modifier Dictionary
import re

# define your ender here
uniqueEnders = ["LGTS"]


LONGEST_KEY = 1

# fingerspelling dictionary entries for relevant theories
lefthand = {
        "A"     : "a",
        "PW"    : "b",
        "KR"    : "c",
        "TK"    : "d",
#        "E"     : "e",
        "SK"    : "e",
        "TP"    : "f",
        "TKPW"  : "g",
        "H"     : "h",
#        "EU"    : "i",
#        "AOEU"  : "i", # magnum
        "SKW"   : "i",
        "SKWR"  : "j",
        "SKWRAEU" : "j", # magnum
        "K"     : "k",
        "HR"    : "l",
        "PH"    : "m",
        "TPH"   : "n",
        "O"     : "o",
        "P"     : "p",
        "KW"    : "q",
        "R"     : "r",
        "S"     : "s",
        "T"     : "t",
        "U"     : "u",
        "WR"    : "u",
        "SR"    : "v",
        "W"     : "w",
        "KP"    : "x",
        "KWR"   : "y",
        "KWH"   : "y",
        "STKPW" : "z",
        "STKPWHR" : "z", # magnum
        }

righthand = {
    "-RB":    "a",
    "-B":     "b",
    "-SZ":    "c",
    "-D":     "d",
    "E":      "e",
    "-F":     "f",
    "-G":     "g",
    "-FD":    "h",
    "EU":     "i",
    "-PBLG":  "j",
    "-BG":    "k",
    "-L":     "l",
    "-PL":    "m",
    "-PB":    "n",
    "-GS":    "o",
    "-P":     "p",
    "-LGTS":  "q",
    "-R":     "r",
    "-S":     "s",
    "-T":     "t",
    "U":      "u",
    "-FB":    "v",
    "-FRP":   "w",
    "-FRPB":  "x",
    "-FPL":   "y",
    "-Z":     "z",
}


def lookup(chord):

    # extract the chord for easy use
    stroke = chord[0]

    # quick tests to avoid regex if non-relevant stroke is sent
    if len(chord) != 1:
        raise KeyError
    assert len(chord) <= LONGEST_KEY

    match = re.fullmatch(r'([+]*)([\^\#STKPWHRAO]*)([*]*)([\-EUFRPBLGTSDZ]*)',stroke)

    
    if match is None:
        raise KeyError

    (starter, left, mid, right) = match.groups()

    if starter is not "+":
        raise KeyError

    pattern = left + right


    # if left not in lefthand:
    #     raise KeyError

    # if right not in righthand:
    #     raise KeyError

    ret = "{^}{#Control("+ lefthand[left] + ")}" + "{#Control("+ righthand[right] + ")}{^}"
    
    return ret
