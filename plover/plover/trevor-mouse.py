import re
import mouse

LONGEST_KEY = 2
true = True
false = False
duration = .01

# def pargs(arg, defaults):  # process arguments, use default argument and format correctly
#     args = arg.split(",")
#     args = (args + len(defaults) * [''])[:len(defaults)]  # pad args to same length as defaults
#     ret = []
#     for x in range(len(defaults)):
#         if args[x] == '':
#             ret.append(defaults[x])
#         else:
#             ret.append(args[x])
#     return tuple(ret)

# def mouse_move(steno, args):
#     (x,y) = pargs(args, (0,0))
#     move(x,y,absolute=false,duration=duration)

def lookup(chord):
    
    stroke = chord[0]

    if len(chord) != 1:
        raise KeyError
    assert len(chord) <= LONGEST_KEY

    firstMatch = re.fullmatch(r'([#STKPWHR]*)([AO]*)([*\-EU]*)([FRPBLGTSDZ]*)', stroke)

    if firstMatch is None:
        raise KeyError

    (starter, null, speed, move) = firstMatch.groups()

    if starter != "#TWH":
        raise KeyError

    # these seem to need root acess
    if move == "F":
        mouse.click("left")
    if move == "P":
        mouse.click("middle")
    if move == "T":
        mouse.click("right")
    
    dx = 0
    x1 = 0
    x2 = 0
    
    if speed == "E":
        dx = 30
    if speed == "U":
        dx = 80
    if speed == "EU":
        dx = 120

    if "R" in move:
        x1 = -dx
    if "B" in move:
        x2 = -dx
    if "G" in move:
        x2 = dx
    if "S" in move:
        x1 = dx

    mouse.move(x1,x2,absolute=false,duration=duration)

    return "{#}"
 
