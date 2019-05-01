#source("R/private-checker-functions.R")

context("Check private checker functions")


test_that("check_prob with valid values",{

  expect_true(check_prob(0.5))
  expect_true(check_prob(0.7))
})

test_that("check_prob fails with invalid values or lengths",{

  expect_error(check_prob(c(0.2,0.4)))
  expect_error(check_prob(-0.2))
})




test_that("check_trials with valid values", {

  expect_true(check_trials(10))
  expect_true(check_trials(5))
})

test_that("check_trials fails with invalid values or lengths", {

  expect_error(check_trials(c(5,10)))
  expect_error(check_trials(-5))
  expect_error(check_trials(3.5))
})




test_that("check_success with valid values", {

  expect_true(check_success(5, 10))
  expect_true(check_success(c(5,6), 9))
})

test_that("check_success fails with invalid values", {

  expect_error(check_success(c(9,8), 7))
  expect_error(check_success(-1,5))
  expect_error(check_success(c(1,2,2.5), 5))
})
