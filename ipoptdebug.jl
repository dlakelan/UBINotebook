using Distributions, ApproxFun, Optimization, OptimizationBase, 
    OptimizationMOI, Ipopt,
    Printf

const uspop = 336e6 # as of 2023

const nhous = 125736353.0
const currevenue = 3.8 # current revenue from income and payroll tax in trillions
incDist = MixtureModel([Uniform(0,28e3),Uniform(28e3,55e3),Uniform(55e3,89.7e3),Uniform(89.7e3,149e3), Truncated(Exponential(269356),115e3,2e6)])

incsamp = rand(incDist,10000)


revreqd = 4.116+1.12

function coefstofun(u,p)
    spc = Chebyshev(0.0..2_000_000.0)
    fsqt = Fun(spc,u)
#    df = fsqt*fsqt
    df = fsqt
    fI = Integral() * df
    ffI = fI - fI(0.0) + p.min
    return ffI,df
end

function fitness(u,p)
    fI,df = coefstofun(u,p)
    incomes = p.incs
    
    meaninc = mean(fI(i) for i in incomes)
    meanmarg = mean(df(i) for i in incomes)
    fitness = -(meaninc/p.gdppc + p.k * meanmarg)
end

function revconstr(constr, u,p) ## we need a certain revenue
    target = p.revneeded # in trillions
    fI,df = coefstofun(u,p)
    revactual = mean(i - fI(i) for i in p.incs ) * (nhous / 1e12) 
    constr[1] = revactual - target 
    return constr[1]
end

function revderivconstr(constr,u,p)
    target = p.revneeded
    incs = p.incs
    fI,df = coefstofun(u,p)
    revactual = mean(i-fI(i) for i in incs) * (nhous/1e12)
    constr[1] = revactual - target
    mind = minimum(df(i) for i in incs)
    constr[2] = mind
    return constr
end

let #u0 = [0.44678816662151877, -0.08788321820882686, 0.17815799706452318, -0.14584610993899744, 0.07437859490773412, -0.12028356099198997, -0.27147771772117185]
    u0 = rand(Normal(0.0,0.0001),7) .+ [.6; zeros(6)]

let min= 0.1, k= 0.25, maxtax = .7
    gdpc = mean(incsamp)
    parms = (k=k,min=min*gdpc,incs=incsamp,revneeded=currevenue,gdppc=gdpc)
    tax = (currevenue + min*gdpc*nhous/1e12) / (gdpc * nhous/1e12)
    u0 = [1.0- 1.03*tax,0.01,0.01,0.0,0.0,0.0,0.0]
    earn = collect(0.0:1000.0:1000000.0)
    #p = plot(earn,earn,xlim=(0.0,400e3),ylim=(0.0,400e3),label="y = x visual reference",xlab="Earned Income (Dollars)", ylab="Take Home Income (Dollars)")
    #p = plot!(earn,[min*gdpc + e*(1.0-tax) for e in earn],label="flat tax+UBI")
    opprob = OptimizationProblem(OptimizationFunction(fitness,Optimization.AutoForwardDiff(),cons=revderivconstr),
            u0,parms, 
            lcons=[0.0,1.0-maxtax],ucons=[0.0,10.0])
    sol = solve(opprob,Ipopt.Optimizer(); max_wall_time=135.0, print_level=5,output_file="optim.out")
    println(sol)
    revcon=[0.0, 0.0]
    revderivconstr(revcon,sol.u,parms)
    #u0 = sol.u .+ rand(Normal(0.0,.04),7)
    println("Revenue constraint: $(revcon[1])")
    println("Deriv constraint: $(revcon[2])")
    fI,df = coefstofun(sol.u,parms)
    #p = plot!(earn,[fI(e) for e in earn],label="Optimal Tax Curve")
    
end

end
