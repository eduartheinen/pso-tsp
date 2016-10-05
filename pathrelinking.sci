function [a] = pathrelinking(a, target, w)
  for i=1:length(a)
    fita = objectivefn(a)
    b = a
    j = find(a(i:$)==target(i))
    if(grand(1,"def") > w)
      tmp = b(j)
      b(j) = b(i)
      b(i) = tmp
      fitb = objectivefn(b)
      if(fitb < fita)
        a = b
      end
    end
  end

endfunction

function [a] = neighborhoodinversion(a, w)
  fita = objectivefn(a)
  for k=1:length(a)-1
    for i=1:length(a)
      if(grand(1,"def") > w)
        j = i + k
        tmp(:) = flipdim(a(i:j), 1)
        b(:) = [a(1:i-1), tmp(:), a(j+1:$)]
        fitb = objectivefn(b)
        if(fitb < fita)
          a = b
        end
      end
    end
  end
endfunction
