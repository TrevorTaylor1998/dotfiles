# ordering of this dictionary
# since this uses nearly every right hand ender it kinda has to go
# above everything
# for example 51 [#LGTS] has a conflict with the emily modifer laping ender
# It also conflicts with The [#T]

import re
import mouse

LONGEST_KEY = 1

def lookup(chord):
    stroke = chord[0]

    if len(chord) != 1:
        raise KeyError
    assert len(chord) <= LONGEST_KEY

    #firstMatch = re.fullmatch(r'([#STKPWHR]*)([AO]*)([*-]*)([EU]*)([FRPB]*)([LGTSDZ]*)', stroke)
    
    #print(stroke)
    firstMatch = re.fullmatch(r'([#STKPWHR]*)([AO]*)([*-]*)([EUFRPBLGTSDZ]*)', stroke)


    if firstMatch is None:
        raise KeyError

    #print(firstMatch)
    
    # name the relevant extracted parts of the regex
    (starter, null, number, shape) = firstMatch.groups()

    #print(starter)
    #print(null)

    #print(number)
    #print(shape)
    # only caring about numbers here
    # other modifiers are blank but can be changed to add more
    # functions

    # null2 is either
    if starter == "#" and null == "" and (number == "-" or number == "") and shape != "":
        count = 0
        # typing 0 is kinda implicitly done since we match on d and z
        # pressing either of them is 0
        # if "Z" in shape:
        #     count += 0
        if "S" in shape:
            count += 1
        if "G" in shape:
            count += 2
        if "B" in shape:
            count += 4
        if "R" in shape:
            count += 8
        if "T" in shape:
            count += 16
        if "L" in shape:
            count += 32
        if "P" in shape:
            count += 64
        if "F" in shape:
            count += 128
        if "U" in shape:
            count += 256
        if "E" in shape:
            count += 512

        character = str(count)

        if character == "":
            raise KeyError

        # glueing version
        #ret = "{#" + character +"}"

        # nongluing version
        ret = "{^ ^}{&" + character +"}"

        return ret
        










        
