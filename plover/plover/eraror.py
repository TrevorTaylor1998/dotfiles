import re

import re
import json
import os
cwd = os.getcwd()

numbers_to_letters = {
    "1": "S",
    "2": "T",
    "3": "P",
    "4": "H",
    "5": "A",
    "6": "F",
    "7": "P",
    "8": "L",
    "9": "T",
    "0": "O"
    }

def aericks_denumberizer(old_outline):

    old_strokes = old_outline.split("/")
    new_strokes = []

    for stroke in old_strokes:

        new_strokes.append(stroke)

        for match in numbers_to_letters.keys():

            if match in stroke:

                if new_strokes[-1][0] != "#":
                    new_strokes[-1] = "#" + new_strokes[-1]

                new_strokes[-1] = new_strokes[-1].replace(match, numbers_to_letters[match])

        if new_strokes == []:
            new_strokes = old_strokes

    return "/".join(new_strokes)


with (open("lapwing-base.json", "r", encoding="utf-8")) as temp_dictionary_name:
    temp_dictionary = json.load(temp_dictionary_name)
    for outline in temp_dictionary:
        translated_phrase = temp_dictionary[outline]

        outline = aericks_denumberizer(outline)
        unchecked_outlines_to_add = ['X' + str(outline) + 'X']
        checked_outlines_to_add = []
        while unchecked_outlines_to_add:
            working_outline =  unchecked_outlines_to_add.pop()

            match = re.fullmatch(r'(.*[/X]#?\+?\^?S?T?K?P?W?H?R?[AO\-\*EU]+F?R?P?B?L?G?T?S?D?Z?)\/\*ER([/X].*)',working_outline)


            if match:
                rstring = "(" + match[1] + "\/O\*R" + match[2] + ")"
                rstring2 = "(" + match[1] + "\/A\*R" + match[2] + ")"
                #print(working_outline)

                
                for outline2 in temp_dictionary:
                    translated_phrase2 = temp_dictionary[outline2]

                    outline2 = aericks_denumberizer(outline2)
                    unchecked_outlines_to_add2 = ['X' + str(outline2) + 'X']
                    checked_outlines_to_add2 = []
                    while unchecked_outlines_to_add2:
                        working_outline2 =  unchecked_outlines_to_add2.pop()
                        #print(working_outline2)
                        match = re.fullmatch(rstring, working_outline2)

                        if match:
                            print(match)
                            
                        match = re.fullmatch(rstring, working_outline2)

                        if match:
                            print(match)
                        


                        
                # for outline2 in temp_dictionary:
                #     outline2 = aericks_denumberizer(outline2)
                #     unchecked_outlines_to_add2 = ['X' + str(outline2) + 'X']
                #     checked_outlines_to_add2 = []
                #     while unchecked_outlines_to_add2:
                #         working_outline2 = unchecked_outlines_to_add2.pop
                
                #         if match:
                #             print("yes")
                #             print(working_outline2)
                #             print(" ")

        
