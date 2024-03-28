# A notebook for investigating UBI + Flat tax

Universal Basic Income (UBI) is an income that everyone is guaranteed as a minimum just for being a citizen or resident. It's an incredibly good idea that is a combination alternative to Social Security, subsidized childcare, food stamps, disability insurance, minimum wage, and a massive host of "means-tested" welfare programs whose design ensures people remain poor and under the control of government bureaucrats.

UBI together with a flat fixed percentage tax forms a net "effective progressive tax system" which is **more progressive** than what we have now at **vastly vastly lower administrative overhead and complexity. It also ensures that both partners in marriages face the same marginal tax burden.

This notebook explains how we can view taxation through the lens of a function $F(I)$ which gives the take-home income $F$ as a function of the earned income $I$. The "tax" then is the quantity $I - F(I)$ which can be negative for some people with low income (negative tax means you take home more than you earn). The *marginal* tax rate is $1 - dF/dI$ which should never go too high because few people will chose to do useful work that actually makes them take home less income than if they earned a lower amount. This would occur if the $F(I)$ curve actually "flattens" or "turns over" and begins to decline. If we require that it always increases at least a little bit, we find that the shape of feasible curves actually is quite limited. 

This notebook explains how that works, and also lets you try to create your own "even more progressive" tax. Towards the end it lets you specify some parameters and will try to calculate an "optimal $F(I)$ curve" based on those parameters. What you will find is that you either need to create very high marginal tax rates on not that high incomes (say the income level that a household with two doctors might earn, say $350-500k rather than say movie-star levels like \$10M or more) or you wind up with something that isn't really substantially different from the linear flat tax plus UBI. 

To use this stuff you'll want to do the following:

1) Get julia from https://julialang.org/downloads/ which on Windows can be done via the instructions there which will get you "juliaup" an updater that will allow you to install various Julia versions
2) clone this github repo
3) enter the directory and run `julia ./install.jl` which will download all the required packages and "instantiate the environment"
4) also from the directory run `julia ./runnotebook.jl` which will eventually after an initial install of a private Conda environment for Julia, instantiate the Jupyter notebook server and open a browser to let you browse the directory and select the notebook.
