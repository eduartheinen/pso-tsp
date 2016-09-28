function f = objectivefn(x, distances)
  f = 0
  for i=2:length(x)
    f = f + distances(x(i-1), x(i))
  end
  f = f + distances(x($), x(1))
endfunction
