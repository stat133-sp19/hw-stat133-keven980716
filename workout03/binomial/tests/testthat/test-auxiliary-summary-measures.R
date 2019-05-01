#source("R/private-auxiliary-functions.R")

context("Check private auxiliary summary-mearsures functions")


test_that("aux_mean works with valid inputs", {

  expect_length(aux_mean(10, 0.3), 1)
  expect_equal(aux_mean(10, 0.3), 3)
  expect_type(aux_mean(10, 0.3), 'double')
  expect_equal(aux_mean(10,0.5), 5)
})




test_that("aux_variance works with valid inputs", {

  expect_length(aux_variance(10, 0.3), 1)
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_type(aux_variance(10, 0.3), 'double')
  expect_equal(aux_variance(10,0.5), 2.5)
})




test_that("aux_mode works with valid inputs", {

  expect_length(aux_mode(10, 0.3), 1)
  expect_equal(aux_mode(10, 0.3), 3)
  expect_type(aux_mode(10, 0.3), 'double')
  expect_equal(aux_mode(10,0.5), floor(0.5 * (10 + 1)))
})




test_that("aux_skewness works with valid inputs", {

  expect_length(aux_skewness(10, 0.3), 1)
  expect_equal(aux_skewness(10, 0.3), (1 - 2 * 0.3)/sqrt(10 * 0.3 * (1 - 0.3)))
  expect_type(aux_skewness(10, 0.3), 'double')
  expect_equal(aux_skewness(10,0.5), (1 - 2 * 0.5)/sqrt(10 * 0.5 * (1 - 0.5)))
})




test_that("aux_kurtosis works with valid inputs", {

  expect_length(aux_kurtosis(10, 0.3), 1)
  expect_equal(aux_kurtosis(10, 0.3), (1 - 6 * 0.3 * (1 - 0.3))/(10 * 0.3 * (1 - 0.3)))
  expect_type(aux_kurtosis(10, 0.3), 'double')
  expect_equal(aux_kurtosis(10,0.5), (1 - 6 * 0.5 * (1 - 0.5))/(10 * 0.5 * (1 - 0.5)))
})
