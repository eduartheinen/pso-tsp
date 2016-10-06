function x = run(data, particles, iterations)

  ploty = zeros(iterations)
  [r, c] = size(data)
  distances = zeros(r, r)

  for i=1:r
    for j=1:r
      distx = (data(i,2) - data(j,2))^2
      disty = (data(i,3) - data(j,3))^2
      distances(i,j) = sqrt(distx + disty)
    end
  end

  f = zeros(particles)    //objective function
  v = zeros(particles, r)   //particle's velocity
  x = zeros(particles, r)   //solutions, particles

  //weights
  c1 = 0.9
  c2 = 0.05
  c3 = 0.05

  x = grand(particles, "prm", (1:r))    //random initial swarm
  for p=1:particles
    x(p,:) = removecrossings(x(p,:), data)
    f(p) = objectivefn(x(p, :), distances)
  end

  pbestx = zeros(particles, r)     //best route found by the particle
  gbestx = zeros(1, r)     //best route found by the swarm
  pbestf = zeros(particles, 1)     //best fitness reached by the particle

  pbestx = x       //first route is the best so far
  pbestf = f       //first fitness is the best so far

  [i, j] = min(pbestf)   //index of smallest fitness (smaller is better)
  gbestx = pbestx(j, :)   //best route found by all particles
  gbestf = pbestf(j)    //best fitness found by all particles

  for i=1:iterations
    for p=1:particles

      //  x = busca local na particula (hill climbing/delete crossings/2-opt)
      x(p,:) = neighborhoodinversion(x(p,:), c1)    //neighborhoodinversion - local search

      //  pathrelinking entre pbest e x
      x(p,:) = pathrelinking(x(p,:), pbestx(p,:), c2)

      //  pathrelinking entre gbest e x
      x(p,:) = pathrelinking(x(p,:), gbestx(1,:), c3)

      //  atualiza o f(p)
      f(p) = objectivefn(x(p, :), distances)

      if(f(p) < pbestf(p))
        pbestx(p,:) = x(p,:)
        pbestf(p) = f(p)
      end

      if(f(p) < gbestf)
        gbestx = x(p,:)
        gbestf = f(p)
      end
    end
    ploty(i) = gbestf
    disp("i:" + string(i) + "--gbest:" + string(gbestf))

    c1 = c1*0.95
    c2 = c2*1.01
    c3 = 1-(c1+c2)
  end

  plotx = [1:iterations]
  plot2d(plotx, ploty)
endfunction
