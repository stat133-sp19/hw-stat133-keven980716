#source("R/main-functions.R")

context("Check main binomial functions")


test_that("bin_choose works with valid inputs", {

  expect_equal(bin_choose(5, 2), 10)
  expect_equal(bin_choose(5, 0), 1)
  expect_equal(bin_choose(5, 1:3), c(5, 10, 10))
})

test_that("bin_choose fails with invalid inputs", {

  expect_error(bin_choose(n = 5, k = 1.5))
  expect_error(bin_choose(5, -1))
  expect_error(bin_choose(5, 1:6))
})




test_that("bin_probability works with valid inputs", {

  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_equal(bin_probability(success = 0:2, trials = 5, prob = 0.5), c(0.03125, 0.15625, 0.31250))
})

test_that("bin_probability fails with invalid inputs", {

  expect_error(bin_probability(success = -2, trials = 5, prob = 0.5))
  expect_error(bin_probability(success = 3:6, trials = 5, prob = 0.5))
  expect_error(bin_probability(success = 2.5, trials = 5, prob = 0.5))
  expect_error(bin_probability(success = 2, trials = 5, prob = 1.2))
  expect_error(bin_probability(success = 2, trials = -1, prob = 0.5))
})




test_that("bin_distribution works with valid inputs", {

  expect_s3_class(bin_distribution(trials = 5, prob = 0.5), c("bindis", "data.frame"))
  expect_equal(bin_distribution(trials = 5, prob = 0.5)$success, 0:5)
  expect_equal(bin_distribution(trials = 5, prob = 0.5)$probability, c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
})

test_that("bin_probability fails with invalid inputs", {

  expect_error(bin_distribution(trials = -5, prob = 0.5))
  expect_error(bin_distribution(trials = 5, prob = -0.5))
  expect_error(bin_distribution(trials = 5.5, prob = 0.5))
  expect_error(bin_distribution(trials = 5, prob = 1.5))
})




test_that("bin_cumulative works with valid inputs", {

  expect_s3_class(bin_cumulative(trials = 5, prob = 0.5), c("bincum", "data.frame"))
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)$success, 0:5)
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)$probability, c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)$cumulative, c(0.03125, 0.18750, 0.50000, 0.81250, 0.96875, 1.00000))
})

test_that("bin_probability fails with invalid inputs", {

  expect_error(bin_cumulative(trials = -5, prob = 0.5))
  expect_error(bin_cumulative(trials = 5, prob = -0.5))
  expect_error(bin_cumulative(trials = 5.5, prob = 0.5))
  expect_error(bin_cumulative(trials = 5, prob = 1.5))
})
