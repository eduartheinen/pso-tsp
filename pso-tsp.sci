clear
clc

exec("objectivefn.sci")
exec("difference.sci")

data = fscanfMat("test16.tsp");

particles = 2
iterations = 10

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
c1 = 0.6
c2 = 0.8
w = 0.4

x = grand(particles, "prm", (1:r))    //random initial swarm
for p=1:particles
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

//for i=1:iterations
for p=1:particles
  gbestminx = difference(gbestx(1,:), x(p,:))
  pbestminx = difference(pbestx(p,:), x(p,:))
  randminx = difference(grand(1, "prm", (1:r)), x(p,:))

  disp(x(p,:), 'x(p):')
  disp(gbestx, 'gbestx:')
  disp(gbestminx, 'difference(gbest, x)')
  disp(pbestminx, 'difference(pbest, x)')
  disp(randminx, 'difference(rand, x)')

  //creating pos_g
  [transp, c] = size(gbestminx)
  pos_g(:) = x(p,:)

  if(transp > 1)
    //reversion
    if(gbestminx(1,1) < 0)    //case flag is -1 the array is reversed
      pos_g = flipdim(pos_g, 2)
    end

    //slides
    j = gbestminx(1, 2)
    tmp(:) = pos_g(1:j)
    pos_g = [pos_g(j+1:$), tmp]
    disp(pos_g, 'pos_g')

    //transpositions
    R = grand(1, transp, "def")
    for t=2:transp
      j = gbestminx(t,1)
      k = gbestminx(t,2)
      tmp = pos_g(j)
      pos_g(j) = pos_g(k)
      pos_g(k) = tmp
    end

    disp(pos_g, 'pos_g after transpositions')
  end

  //creating pos_p
  [transp, c] = size(pbestminx)
  pos_p(:) = x(p,:)

  if(transp > 1)
    //reversion
    if(pbestminx(1,1) < 0)    //case flag is -1 the array is reversed
      pos_p = flipdim(pos_p, 2)
    end

    //slides
    j = pbestminx(1, 2)
    tmp(:) = pos_p(1:j)
    pos_g = [pos_p(j+1:$), tmp]
    disp(pos_p, 'pos_p')

    //transpositions
    R = grand(1, transp, "def")
    for t=2:transp
      j = pbestminx(t,1)
      k = pbestminx(t,2)
      tmp = pos_p(j)
      pos_p(j) = pos_p(k)
      pos_p(k) = tmp
    end

    disp(pos_p, 'pos_p after transpositions')
  end
  disp('----i----')
end
//end
