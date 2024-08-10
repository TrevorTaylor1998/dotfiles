# from
# https://github.com/EPLHREU/steno-stuff/blob/main/prefix.py
 

import re, itertools, json;
print(sorted(set(map(lambda b: "".join(map((lambda p: p[1] if p[0] else ""), zip(b, "#STKPWHR"))), itertools.product((0, 1), repeat=7))).difference(re.match("#?S?T?K?P?W?H?R?", s).group(0) for ks in json.load(open("lapwing-base.json")).keys() for s in ks.split("/")), key=len))
