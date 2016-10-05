function a = plotroute(a, data)
  for i=1:length(a)
    coords(1, i) = data(a(i), 2)
    coords(2, i) = data(a(i), 3)
  end

  he = a
  ta = [a(2:$), a(1)]
  disp(he, 'he:')
  disp(ta, 'ta:')
  g=make_graph('foo', 1, length(a), ta, he);
  g.node_x=coords(1,:)*5;
  g.node_y=coords(2,:)*5;
  g.default_node_diam=10;

  show_graph(g, 'new', 10)
endfunction
