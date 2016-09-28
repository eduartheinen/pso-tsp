function [best] = difference(a, b)
  best = zeros(length(b) + 1, 2)
  brev = zeros(1, length(b))
  brev(:) = flipdim(b(:), 1)

  if(~isequal(a,b))
    for sl=1:length(b)    //slides until back to original
      transpositions = zeros(length(b) + 1, 2)    //transpositions(i) = [2,7] swap indexes 2 and 7
      transpositions(1,:) = [1, sl-1]    //flag

      transpositionsreversed = zeros(length(b) + 1, 2)
      transpositionsreversed(1,:) = [-1, sl-1]    //flag

      tmpb(:) = b(:)
      tmpbrev(:) = brev(:)

      for i=1:length(a)

        j = find(tmpb(i:$)==a(i))
        if(j & j ~= 1)
          tmp = tmpb(i+j-1)
          tmpb(i+j-1) = tmpb(i)
          tmpb(i) = tmp
          transpositions(i+1,:) = [j+i-1, i]
        end

        k = find(tmpbrev(i:$)==a(i))
        if(k & k ~= 1)
          tmp = tmpbrev(i+k-1)
          tmpbrev(i+k-1) = tmpbrev(i)
          tmpbrev(i) = tmp
          transpositionsreversed(i+1,:) = [k+i-1, i]
        end
      end

      //remove rows [0,0]
      transpositions(transpositions(:,2)==0 & transpositions(:,1)==0,:) = []
      transpositionsreversed(transpositionsreversed(:,2)==0 & transpositionsreversed(:,1)==0,:) = []

      if(length(transpositions) < length(best) | sl == 1)
        best = transpositions
      end

      if(length(transpositionsreversed) < length(best))
        best = transpositionsreversed
      end

      tmp = b(1)
      b = [b(2:$), tmp]

      tmp = brev(1)
      brev = [brev(2:$), tmp]
    end
  end

  best(best(:,2)==0 & best(:,1)==0,:) = [] //remove rows [0,0] from best
endfunction
