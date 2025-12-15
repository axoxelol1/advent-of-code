from __future__ import annotations
import rustworkx as rx

G: rx.PyGraph[None, None] = rx.PyGraph()


n = 0
name_to_id: dict[str, int] = {}

with open("input.txt") as file:
    for line in file:
        line = line.strip()
        fr, tos = line.split(": ")[:2]
        fr = fr.strip()
        if name_to_id.get(fr) is None:
            name_to_id[fr] = n
            n += 1
        for to in tos.split():
            to = to.strip()
            if name_to_id.get(to) is None:
                name_to_id[to] = n
                n += 1
            G.extend_from_edge_list([(name_to_id[fr], name_to_id[to])])

comp1 = rx.stoer_wagner_min_cut(G)[1]
print(len(comp1) * (G.num_nodes() - len(comp1)))
