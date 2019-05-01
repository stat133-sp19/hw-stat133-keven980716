
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

### 1.1) Private Checker Functions
#### Function check_prob()

# private checker function to check if the input probability is valid
check_prob <- function(prob) {
  if (length(prob) != 1) {
    stop("'prob' has to be length of 1")
  } else if (prob < 0 | prob > 1) {
    stop("'prob' has to be a number betwen 0 and 1")
  }

  TRUE
}


#### Function check_trials()

# private checker function to check if the input trials is valid
check_trials <- function(trials) {
  if (length(trials) != 1) {
    stop("'trials' has to be length of 1")
  } else if (trials %% 1 != 0) {
    stop("'trials' should be a integer")
  } else if (trials < 0) {
    stop("'trials' should be non-negative")
  }

  TRUE
}


#### Function check_success()

# private checker function to check if the input success is valid
check_success <- function(success, trials) {
  if (FALSE %in% (success %% 1 == 0)) {
    stop("'success' should be a vector of integer(s)")
  } else if (TRUE %in% (success < 0)) {
    stop("'success' should be non-negative")
  } else if (TRUE %in% (success > trials)) {
    stop("'success' cannot be greater than trials")
  }
  TRUE
}


