clear
clc

exec("objectivefn.sci")
exec("pathrelinking.sci")
exec("removecrossings.sci")
exec("pso-tsp.sci")


//main
data = fscanfMat("eil51.tsp");

particles = 20
iterations = 100

for i=1:10
  x(i) = run(data, particles, iterations)
end

disp(stdev(x))
