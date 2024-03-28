# A notebook for investigating UBI + Flat tax

Universal Basic Income (UBI) is an income that everyone is guaranteed as a minimum just for being a citizen or resident. It's an incredibly good idea that is a combination alternative to Social Security, subsidized childcare, food stamps, disability insurance, minimum wage, and a massive host of "means-tested" welfare programs whose design ensures people remain poor and under the control of government bureaucrats.

UBI together with a flat fixed percentage tax forms a net "effective progressive tax system" which is **more progressive** than what we have now at **vastly vastly lower administrative overhead and complexity. It also ensures that both partners in marriages face the same marginal tax burden.

This notebook explains how we can view taxation through the lens of a function F(I) which gives the take-home income F as a function of the earned income I. The "tax" then is the quantity $I - F(I)$ which can be negative for some people with low income. The *marginal* tax rate is $1 - dF/dI$ which should never go too high because few people will chose to do useful work that actually makes them take home less income than if they earned a lower amount. 

This notebook explains how that works, and also lets you try to create your own "even more progressive" tax. Towards the end it lets you specify some parameters and will try to calculate an "optimal F(I) curve" based on those parameters. What you will find is that you either need to create very high marginal tax rates on not that high incomes (say the income level that a household with two doctors might earn, say $350-500k) or you wind up with something that isn't really substantially different from the linear flat tax plus UBI. 

