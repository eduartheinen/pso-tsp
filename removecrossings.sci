function o = orientation(p, q, r, data)
  orientation = ((data(p, 3) - data(q, 3)) * (data(r, 2) - data(q, 2)))
  orientation = orientation - ((data(p, 2) - data(q, 2)) * (data(r, 3) - data(q, 3)))

  if(orientation == 0)
    o = 0   //colinear
  elseif(orientation > 0)
    o = 1   //clockwise
  else
    o = 2   //anticlockwise
  end
endfunction

function ans = onsegment(p, q, r, data)
  ans = %f
  if(data(q, 2) <= max(data(p, 2), data(r, 2)) & data(q, 2) >= min(data(p, 2), data(r, 2)) & data(q, 3) <= max(data(p, 3), data(r, 3)) & data(q, 3) >= min(data(p, 3), data(r, 3)))
    ans = %t
  end
endfunction

function ans = dointersect(p1, q1, p2, q2)
  ans = %f

  o1 = orientation(p1, q1, p2)
  o2 = orientation(p1, q1, q2)
  o3 = orientation(p2, q2, p1)
  o4 = orientation(p2, q2, q1)

  if(o1 ~= o2 & o3 ~= o4)
    ans = %t

  // p1, q1 and p2 are colinear and p2 lies on segment p1q1
  elseif(o1 == 0 & onsegment(p1, p2, q1))
    ans = %t

  // p1, q1 and p2 are colinear and q2 lies on segment p1q1
  elseif(o2 == 0 & onsegment(p1, q2, q1))
    ans = %t

  // p2, q2 and p1 are colinear and p1 lies on segment p2q2
  elseif(o3 == 0 & onsegment(p2, p1, q2))
    ans = %t

  // p2, q2 and q1 are colinear and q1 lies on segment p2q2
  elseif(o4 == 0 & onsegment(p2, q1, q2))
    ans = %t
  end
endfunction

function a = removecrossings(a, w)
  for i=1:length(a)-3
    for j=i+2:length(a)-1
      if(dointersect(a(i), a(i+1), a(j), a(j+1)) & grand(1,"def") > w)
        for k=0:((j-i)/2)-1
          tmp = a(j-k)
          a(j-k) = a(i+k+1)
          a(i+k+1) = tmp
        end
      end
    end
  end
endfunction
