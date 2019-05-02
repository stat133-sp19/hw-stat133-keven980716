### 1.2) Private Auxiliary Functions
#### aux_mean()

# private auxillary function to compute the mean of a binomial distribution with corresponding trials and probability
aux_mean <- function(trials, prob) {
  return(trials * prob)
}



#### aux_variance()

# private auxillary function to compute the variance of a binomial distribution with corresponding trials and probability
aux_variance <- function(trials, prob) {
  return(trials * prob * (1 - prob))
}


#### aux_mode()

# private auxillary function to compute the most likely number of success in several independent trials (trials) with corresponding probability (prob)
aux_mode <- function(trials, prob) {
  m <- floor(prob * (trials + 1))
  if ((prob * (trials + 1)) %% 1 == 0) {
    return(as.integer(c(m, m-1)))
  } else {
    return(as.integer(m))
  }
}


#### aux_skewness()

# private auxillary function to compute the the skewness of a binomial random variable with corresponding trials and probability
aux_skewness <- function(trials, prob) {
  skewness <- (1 - 2 * prob)/sqrt(trials * prob * (1 - prob))
  if (prob == 1 | prob == 0) {
    return(paste("undefined skewness:", skewness))
  } else {
    return(skewness)
  }
}


#### aux_kurtosis()

# private auxillary function to compute the the kurtosis of a binomial random variable with corresponding trials and probability
aux_kurtosis <- function(trials, prob) {
  kurtosis <- (1 - 6 * prob * (1 - prob))/(trials * prob * (1 - prob))
  if (prob == 1 | prob == 0) {
    return(paste("undefined kurtosis:", kurtosis))
  } else {
    return(kurtosis)
  }
}


