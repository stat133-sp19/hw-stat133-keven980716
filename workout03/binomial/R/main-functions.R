library(ggplot2)
library(dplyr)

source("R/private-checker-functions.R")
source("R/private-auxiliary-functions.R")

### 1.3) Function bin_choose()

#' @title Function of Choosing k from n
#' @description compute the number of combinations in which k successes can occur in n trials
#' @param n total number of trials (integer)
#' @param k vector of number of successes (integer)
#' @return number of combinations in which k successes occur in n trials
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)

bin_choose <- function(n, k) {
  if (FALSE %in% (k %% 1 == 0)) {
    stop("k should be integer(s)")
  } else if (TRUE %in% (k < 0)) {
    stop("k cannot be negative")
  } else if (TRUE %in% (k > n)) {
    stop("k cannot be greater than n")
  } else {
    return(factorial(n)/(factorial(k) * factorial(n - k)))
  }
}


### 1.4) Function bin_probability()

#' @title Binomial Probability Function
#' @description compute the probability of making specified number of successes in several trials
#' with corressponding binomial probablity
#' @param success vector of number of successes (integer)total number of trials (integer)
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return probability of making successes in several trials
#' @export
#' @examples
#' # probability of getting 2 successes in 5 trials (assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#'
#' # probabilities of getting 2 or less successes in 5 trials (assuming prob of success = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#'
#' #55 heads in 100 tosses of a loaded coin with 45% chance of heads
#' bin_probability(success = 55, trials = 100, prob = 0.45)


bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)

  prob <- bin_choose(trials, success) * prob^(success) * (1 - prob)^(trials - success)
  return(prob)
}


### 1.5) Function bin_distribution()

#' @title Binomial Probability Distribution Function
#' @description compute the possibility distribution of making successes in several trials with
#' corressponding binomial probablity
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return a data frame of class "bindis" which contains the different numbers of successes and the corresponding probabilities
#' @export
#' @examples
#' # binomial probability distribution
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob) {
  df <- data.frame(success = 0:trials, probability = bin_probability(success = 0:trials, trials = trials, prob = prob))
  class(df) <- c("bindis", "data.frame")
  return(df)
}


#### (method) function plot.bindis()

#' @export
plot.bindis <- function(obj) {
  gg <- ggplot(data = obj) +
    geom_bar(aes(x = success, y = probability), stat = "identity") +
    xlab("successes") +
    ylab("probability") +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 10)) +
    ggtitle(label = "The probability histogram of a binomial distribution")
  gg

}


### 1.6) Function bin_cumulative()

#' @title Binomial Cumulative Distribution Function
#' @description compute the cumulative distribution of making successes in several trials with
#' corressponding binomial probablity
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return a data frame of class "bincum" which contains the different numbers of successes and the corresponding probabilities
#' and cumulative probabilities
#' @export
#' @examples
#' # binomial cumulative distribution
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob) {
  df <- data.frame(success = 0:trials, probability = bin_probability(success = 0:trials, trials = trials, prob = prob),
                   cumulative = cumsum(bin_probability(success = 0:trials, trials = trials, prob = prob)))
  class(df) <- c("bincum", "data.frame")
  return(df)
}


#### (method) function plot.bincum()

#' @export
plot.bincum <- function(obj) {
  gg <- ggplot(data = obj) +
    geom_point(aes(x = success, y = cumulative),shape = 1, size = 2) +
    geom_line(aes(x = success, y = cumulative)) +
    xlab("successes") +
    ylab("cumulative") +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 8)) +
    ggtitle(label = "The cumulative probability line plot of a binomial distribution")
  gg

}

### 1.7) Function bin_variable()

#' @title Binomial Random Variable Function
#' @description create a binomial random variable object wih specified number of trials and success probability
#' @param trials number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return a list of class "binvar" which contains the numbers of trials and the corresponding success probability
#' @export
#' @examples
#' bin_variable(trials = 10, p = 0.3)
bin_variable <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  ls <- list(trials = trials, prob = prob)
  class(ls) <- "binvar"
  return(ls)
}

#### Method print.binvar()

#' @export
print.binvar <- function(x) {
  cat('"Binomial variable"\n\n')
  cat('Paramaters\n')
  cat(paste('- number of trials:', x$trials),'\n')
  cat(paste('- prob of success :', x$prob))
  invisible(x)
}

#### Methods summary.binvar() and print.summary.binvar()

#' @export
summary.binvar <- function(x) {
  ls <- list(trials = x$trials, prob = x$prob, mean = aux_mean(trials = x$trials, prob = x$prob),
             variance = aux_variance(trials = x$trials, prob = x$prob), mode = aux_mode(trials = x$trials, prob = x$prob),
             skewness = aux_skewness(trials = x$trials, prob = x$prob), kurtosis = aux_kurtosis(trials = x$trials, prob = x$prob))
  class(ls) <- "summary.binvar"
  return(ls)
}

#' @export
print.summary.binvar <- function(x) {
  cat('"Summary Binomial"\n\n')
  cat('Paramaters\n')
  cat(paste('- number of trials:', x$trials),'\n')
  cat(paste('- prob of success :', x$prob),'\n\n')
  cat('Measures\n')
  cat(paste('- mean    :', x$mean),'\n')
  cat(paste('- variance:', x$variance),'\n')
  cat(paste('- mode    :', x$mode),'\n')
  cat(paste('- skewness:', x$skewness),'\n')
  cat(paste('- kurtosis:', x$kurtosis),'\n')
  invisible(x)
}



### 1.8) Functions of measures

#' @title Binomial Mean Function
#' @description compute the mean (expected value) of a binomial distribution with specified total number of
#' trials and success probability
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return the expected value of the specified binomial distribution
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  return(aux_mean(trials = trials, prob = prob))
}


#' @title Binomial Variance Function
#' @description compute the variance of a binomial distribution with specified total number of
#' trials and success probability
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return the variance of the specified binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  return(aux_variance(trials = trials, prob = prob))
}


#' @title Binomial Mode Function
#' @description compute the value of mode of a binomial distribution with specified total number of
#' trials and success probability
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return the value of mode of the specified binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  return(aux_mode(trials = trials, prob = prob))
}



#' @title Binomial Skewness Function
#' @description compute the value of skewness of a binomial distribution with specified total number of
#' trials and success probability
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return the value of skewness of the specified binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  return(aux_skewness(trials = trials, prob = prob))
}


#' @title Binomial Kurtosis Function
#' @description compute the value of kurtosis of a binomial distribution with specified total number of
#' trials and success probability
#' @param trials total number of trials (integer)
#' @param prob probability of making success in one trial (decimal)
#' @return the value of kurtosis of the specified binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)

  return(aux_kurtosis(trials = trials, prob = prob))
}


