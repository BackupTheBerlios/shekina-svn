# copyright 2005 by Maxim Khesin. 
# Released under Python license.
# Please preserve contributors' names in the headers!

"""unittest for bfs.py"""

import unittest
import bfs

class test_bfs_adaptor(bfs.default_bfs_visitor):
    def __init__(self, output):
	bfs.default_bfs_visitor.__init__(self)
	self.output = output
    def discover_vertex(self, vertex, depth, graph):
	self.output.append((vertex, depth))
	

class dict_list_adaptor(object):
    def __init__(self, dict_list):
	self.dict_list = dict_list
    def adjacent_vertices(self, node):
	return self.dict_list[node]
    def vertices(self):
	return self.dict_list.values()
    def out_edges(self, vertex):
	nbrs = self.dict_list[vertex]
	return zip((vertex,)*len(nbrs), nbrs)

class max_depth_bfs_visitor(test_bfs_adaptor):
    def __init__(self, out, maxdepth):
	test_bfs_adaptor.__init__(self, out)
	self.maxdepth = maxdepth
    def discover_vertex(self, vertex, depth, graph):
	if(depth > self.maxdepth):
	    raise bfs.traversal_termination_exception(vertex)
	test_bfs_adaptor.discover_vertex(self, vertex, depth, graph)


##############
#  A--B---
#  |     |
#  C-----|
#  |     |
#  D--E--F
##############
class test_bfs(unittest.TestCase):
    graph = {'A':['B', 'C'], 'B':['A', 'C', 'F'], 'C':['A', 'D', 'F'],
		 'D':['C', 'E'], 'E':['D', 'F'], 'F':['E', 'B', 'C']}
    def test_basic_bfs(self):
	"""test the basic bfs case"""
	out = []
	bfs.breadth_first_search(dict_list_adaptor(self.graph), 'A', test_bfs_adaptor(out))
	distance_map = dict(out)
	self.assertEqual(distance_map['A'], 0)
	self.assertEqual(distance_map['B'], 1)
	self.assertEqual(distance_map['C'], 1)
	self.assertEqual(distance_map['F'], 2)
	self.assertEqual(distance_map['D'], 2)
	self.assertEqual(distance_map['E'], 3)
    def test_capped_bfs(self):
	"""test bfs with a depth limitation"""
	out = []
	bfs.breadth_first_search(dict_list_adaptor(self.graph), 'A', max_depth_bfs_visitor(out, 2))
	distance_map = dict(out)
	self.assertEqual(distance_map['A'], 0)
	self.assertEquals(False, distance_map.has_key('E'))
    def test_terminating_return_value(self):
	out = []
	terminator = bfs.breadth_first_search(dict_list_adaptor(self.graph), 'A', max_depth_bfs_visitor(out, 2))
	self.assertEqual(terminator, 'E')
	

if("__main__"==__name__):
    unittest.main()


