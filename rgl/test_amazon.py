# copyright 2005 by Maxim Khesin. 
# Released under Python license.
# Please preserve contributors' names in the headers!

import amazon
import bfs
from pygraphlib import pygraph
from pygraphlib import pydot

class amazon_similarity_adaptor:
    def out_edges(self, asin):
	similar = amazon.searchSimilar(asin)
	return zip([asin]*len(similar), [sim.Asin for sim in similar])
    def vertices(self):# we do not know the vertices up front -what to do?
	return []

# this will build a pygraphlib graph with the names of related products
# the bfs will terminate when max_depth is exceeded
class pygraphlib_builder_visitor(bfs.default_bfs_visitor):
    def __init__(self, graph, max_depth):
	bfs.default_bfs_visitor.__init__(self)
	self.graph = graph
	self.max_depth = max_depth
    def discover_edge(self, edge, graph):
	self.graph.add_edge(get_name_by_asin(edge[0]), get_name_by_asin(edge[1]))
    def discover_vertex(self, vertex, depth, graph):
	if depth > self.max_depth:
	    raise bfs.traversal_termination_exception(self.graph)
	

def get_nearest_asin(product_name):
    return amazon.searchByKeyword(product_name)[0].Asin

def get_name_by_asin(asin):
    return amazon.searchByASIN(asin)[0].ProductName


def build_amazon_graph(keyword, depth):
    return bfs.breadth_first_search(amazon_similarity_adaptor(), get_nearest_asin(keyword), pygraphlib_builder_visitor(pygraph.UGraph(), depth))
    
def main():
    import sys
    graph = build_amazon_graph(sys.argv[1], int(sys.argv[2]))
    dot = pydot.Dot(graph)
    dot.save_dot(sys.argv[3])

if('__main__'==__name__):
    main()
