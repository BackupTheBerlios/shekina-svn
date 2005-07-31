# copyright 2005 by Maxim Khesin. 
# Released under Python license.
# Please preserve contributors' names in the headers!

class default_bfs_visitor(object):
    def __init__(self, debug = False):
	self.debug = debug
    def initialize_vertex(self, vertex, graph):
	if self.debug:
	    print 'initializing vertex:', vertex
    def discover_vertex(self, vertex, depth, graph):
	if self.debug:
	    print 'new vertex:', vertex, 'depth:', depth
    def discover_edge(self, edge, graph):
	if self.debug:
	    print 'edge: ', edge
    def examine_vertex(self, vertex, graph):
	if self.debug:
	    print 'examining vertex: ', vertex
    def tree_edge(self, e, graph):
	if self.debug:
	    print 'tree edge: ', e
    def non_tree_edge(self, e, graph):
	if self.debug:
	    print 'non-tree edge: ', e
    def gray_target(self, e, graph):
	if self.debug:
	    print 'gray target: ', e
    def black_target(self, e, graph):
	if self.debug:
	    print 'black target: ', e
    
	    

class traversal_termination_exception:
    def __init__(self, val = None):
	self.val = val
    def get_val(self):
	return self.val

class Colors:
    White, Gray, Black = range(3)

def breadth_first_visit(graph, start, bfs_visitor):
    try:
	color_map = {start: Colors.Gray}
	queue = [(start, 0)] # keep track of the distance from start
	bfs_visitor.discover_vertex(start, 0, graph)
	while queue:
	    node, depth = queue.pop(0)
	    bfs_visitor.examine_vertex(node, graph)
	    for e in graph.out_edges(node):
		bfs_visitor.discover_edge(e, graph)
		v = e[1]
		if(not color_map.has_key(v)):
		    bfs_visitor.tree_edge(e, graph)
		    bfs_visitor.discover_vertex(v, depth+1, graph)
		    color_map[v] = Colors.Gray
		    queue.append((v, depth+1))
		else:
		    bfs_visitor.non_tree_edge(e, graph)
		    if color_map[v]==Colors.Gray:
			bfs_visitor.gray_target(e, graph)
		    else:
			bfs_visitor.black_target(e, graph)
	    color_map[node] = Colors.Black
    except traversal_termination_exception, e:
	return  e.get_val()  # this is a valid termination, no rethrow necessary
    return None

def breadth_first_search(graph, start, bfs_visitor = default_bfs_visitor()):
    for v in graph.vertices():
	bfs_visitor.initialize_vertex(v, graph)
    return breadth_first_visit(graph, start, bfs_visitor)
	
    
    
	
	
    
