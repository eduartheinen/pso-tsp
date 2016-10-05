clear
clc

exec("objectivefn.sci")
exec("difference.sci")
exec("permutation.sci")
exec("pathrelinking.sci")
exec("removecrossings.sci")

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
c1 = 0.8
c2 = 0.8
w = 0.8

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
  //  x = busca local na particula (hill climbing/delete crossings/2-opt)
  //  pathrelinking entre pbest e x = posx
  //  pathrelinking entre gbest e posx = posg
  //  pathrelinking entre randtour e posg = posr

  x(p,:) = neighborhoodinversion(x(p,:), c1)
  //x(p,:) = removecrossings(x(p,:), data) //delete crossings - local search

  gbestminx = difference(gbestx(1,:), x(p,:))
  pbestminx = difference(pbestx(p,:), x(p,:))
  randtour = grand(1, "prm", (1:r))
  randminx = difference(randtour, x(p,:))

  disp(x(p,:), 'x(p):')
  disp(gbestx, 'gbestx:')
  disp(randtour, 'randtour:')
  disp(gbestminx, 'difference(gbest, x)')

  //creating pos_g
  if(gbestminx)
    pos_g = permutation(x(p,:), c1, gbestminx)
  else
    pos_g = x(p,:)
  end
  disp(pos_g, "pos_g:")


  disp(pbestminx, 'difference(pbest, x)')
  //creating pos_g
  if(pbestminx)
    pos_p = permutation(x(p,:), c2, pbestminx)
  else
    pos_p = x(p,:)
  end
  disp(pos_p, "pos_p:")

  disp(randminx, 'difference(rand, x)')
  //creating pos_r
  if(randminx)
    pos_r = permutation(randtour, c2, randminx)
  else
    pos_r = randtour
  end
  disp(pos_r, "pos_r:")
  disp('----i----')
end
//end
