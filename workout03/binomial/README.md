## Overview

`"binomial"` is a R package which can help you build binomial objects, plot the probability distribution and cumulative probability distribution, and calculate some summary statistics of a binomial distribution, such as mean, variance, mode, skewness and kurtosis. The list of some handful functions is as following:

* `bin_choose()` compute the number of combinations in which k successes can occur in n trials
* `bin_probability()` compute the probability of making specified number of successes in several trials with corressponding binomial probablity
* `bin_distribution()` compute the possibility distribution of making successes in several trials with corressponding binomial probablity
* `bin_cumulative()` compute the cumulative distribution of making successes in several trials with corressponding binomial probablity
* `bin_variable()` create a binomial random variable object wih specified number of trials and success probability
* `bin_mean()` compute the mean (expected value) of a binomial distribution with specified total number of trials and success probability  
* `bin_variance()` compute the variance of a binomial distribution with specified total number of trials and success probability 
* `bin_mode()` compute the value of mode of a binomial distribution with specified total number of trials and success probability  
* `bin_skewness()` compute the value of skewness of a binomial distribution with specified total number of trials and success probability     
* `bin_kurtosis()` compute the value of kurtosis of a binomial distribution with specified total number of trials and success probability 
* `plot()` generic function to plot a probability histogram (for `bindis` object) and cumulative probability line plot (for `bincum` object) of a binomial distribution
* `summary()` generic function to display some summary statistics of our `binvar` object




## Installation

You can easily install this version of package from GitHub by using `"devtools"`:

```{r}
# make sure you have this package
#install.packages("devtools") 


# install "bnomial" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-keven980716/workout03/binomial", build_vignettes = TRUE)
```


## Usage


```{r}
# create a binvar object and display the summary
bin1 <- bin_variable(trials = 10, prob = 0.3)
bin1

binsum1 <- summary(bin1)
binsum1

# useful functions to calculate some statistics
bin_mean(10, 0.3)
## [1] 3
bin_variance(10, 0.3)
## [1] 2.1
bin_mode(10, 0.3)
## [1] 3
bin_skewness(10, 0.3)
## [1] 0.2760262
bin_kurtosis(10, 0.3)
## [1] -0.1238095

# choose 5 from 10
bin_choose(10, 5)

# probabilities of getting 3 or less successes in 5 trials
bin_probability(success = 0:3, trials = 5, prob = 0.5)

# binomial probability distribution
dis1 <- bin_distribution(trials = 5, prob = 0.5)
dis1
# plot probability distribution 
plot(dis1)

# binomial cumulative distribution
dis2 <- bin_cumulative(trials = 5, prob = 0.5)
dis2
# plot cumulative probability distribution 
plot(dis2)
```