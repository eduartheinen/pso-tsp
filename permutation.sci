function [b] = permutation(a, w, transpositions)
  b = zeros(1, length(a))
  b(:) = a(:)
  [swaps, c] = size(transpositions)

  //reversion
  if(transpositions(1,1) < 0)    //case flag is -1 the array is reversed
    b = flipdim(b, 2)
  end

  disp(b, 'reversed?(b):')

  //slides
  j = transpositions(1, 2)
  b = slide(b, j)

  disp(b, 'slides(b):')

  //transpositions
  r = grand(1, "def")*w
  disp(ceil(swaps*r), 'r:')

  for t=2:ceil(swaps*r)+1
      j = transpositions(t,1)
      k = transpositions(t,2)

      tmp = b(j)
      b(j) = b(k)
      b(k) = tmp
  end

  disp(b, 'permutations(b):')

  //slides
  j = transpositions(1, 2)
  b = slide(b, length(b) - j)

  if(transpositions(1,1) < 0)    //case flag is -1 the array is reversed
    b = flipdim(b, 2)
  end

  disp(b, 'final b:')
endfunction


function [b] = slide(b, j)
  tmp(:) = b(1:j)
  b = [b(j+1:$), tmp]
endfunction
