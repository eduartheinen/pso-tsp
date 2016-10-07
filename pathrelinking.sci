function [a] = pathrelinking(a, target, w)
  j = find(a(:)==target(1))
  if(j > 1)
    a = slide(a, j-1)
  end

  b = a

  for i=2:length(a)
    fita = objectivefn(a)
    j = find(a==target(i))
    if(grand(1,"def") > w & j > 1 & j ~= [])
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
    i = 1
    while(i+k < length(a))
      if(grand(1,"def") > w)
        j = i + k
        tmp = flipdim(a(i:j), 2)
        b = [a(1:i-1), tmp]
        b = [b, a(j+1:$)]
        fitb = objectivefn(b)
        if(fitb < fita)
          a = b
        end
      end
      i = i + 1
    end
  end
endfunction

function [b] = slide(b, j)
  tmp(:) = b(1:j)
  b = [b(j+1:$), tmp]
endfunction
