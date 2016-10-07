clear
clc

exec("objectivefn.sci")
exec("pathrelinking.sci")
exec("removecrossings.sci")
exec("pso-tsp.sci")


//main
//data = fscanfMat("ch130.tsp"); //best possible solution 6110
data = fscanfMat("eil51.tsp"); //best possible solution 426

particles = 20
iterations = 50
x = zeros(1, 10)
for i=1:10
  x(i) = run(data, particles, iterations)
end

disp(stdev(x))
