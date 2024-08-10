from collections import defaultdict
import sys, functools, json

def join(a, b):
    for k, v in b.items():
        a[k].append(v)
    return a

ds = list(map(lambda f: {k: (v, f) for k, v in json.load(open(f)).items()}, sys.argv[1:]))
first = defaultdict(list)
first.update({k: [v] for k, v in ds[0].items()})
merged = functools.reduce(join, ds[1:], first)
for k, v in merged.items():
    if len(v) > 1:
        print(f"Conflict on key '{k}':")
        for c in v:
            print(f"  |-> '{c[0]}' in '{c[1]}'")
