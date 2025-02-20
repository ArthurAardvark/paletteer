context("test-continuous-ggplot2-scales")


df <- data.frame(
  x = 1:3,
  y = 1:3,
  color = c(1, 4, 9)
)

library(ggplot2)

test_that("scale_*_paletteer_c correctly assigns colors", {
  p1 <- ggplot(df, aes(x, y, color = color)) +
    geom_point() +
    scale_colour_paletteer_c("scico::berlin")

  p2 <- ggplot(df, aes(x, y, color = color)) +
    geom_point() +
    scale_color_paletteer_c("scico::berlin")

  p3 <- ggplot(df, aes(x, y, fill = color)) +
    geom_raster() +
    scale_fill_paletteer_c("scico::berlin")

  expect_equal(layer_data(p1)$colour, c("#9EB0FF", "#13313E", "#FFACAC"))
  expect_equal(layer_data(p2)$colour, c("#9EB0FF", "#13313E", "#FFACAC"))
  expect_equal(layer_data(p3)$fill, c("#9EB0FF", "#13313E", "#FFACAC"))
})

test_that("scale_*_paletteer_c correctly used direction", {
  p1 <- ggplot(df, aes(x, y, colour = color)) +
    geom_point() +
    scale_colour_paletteer_c("scico::berlin", direction = 1)

  p2 <- ggplot(df, aes(x, y, color = color)) +
    geom_point() +
    scale_color_paletteer_c("scico::berlin", direction = 1)

  p3 <- ggplot(df, aes(x, y, fill = color)) +
    geom_raster() +
    scale_fill_paletteer_c("scico::berlin", direction = 1)

  p4 <- ggplot(df, aes(x, y, colour = color)) +
    geom_point() +
    scale_colour_paletteer_c("scico::berlin", direction = -1)

  p5 <- ggplot(df, aes(x, y, color = color)) +
    geom_point() +
    scale_color_paletteer_c("scico::berlin", direction = -1)

  p6 <- ggplot(df, aes(x, y, fill = color)) +
    geom_raster() +
    scale_fill_paletteer_c("scico::berlin", direction = -1)

  expect_equal(layer_data(p1)$colour, c("#9EB0FF", "#13313E", "#FFACAC"))
  expect_equal(layer_data(p2)$colour, c("#9EB0FF", "#13313E", "#FFACAC"))
  expect_equal(layer_data(p3)$fill, c("#9EB0FF", "#13313E", "#FFACAC"))
  expect_equal(layer_data(p4)$colour, c("#FFACAC", "#3F1200", "#9EB0FF"))
  expect_equal(layer_data(p5)$colour, c("#FFACAC", "#3F1200", "#9EB0FF"))
  expect_equal(layer_data(p6)$fill, c("#FFACAC", "#3F1200", "#9EB0FF"))
})

test_that("scale_*_paletteer_c works with quoted palettes", {
  expect_equal(
    ggplot(df, aes(x, y, colour = color)) +
      geom_point() +
      scale_colour_paletteer_c(`"scico::berlin"`),
    ggplot(df, aes(x, y, colour = color)) +
      geom_point() +
      scale_colour_paletteer_c("scico::berlin")
  )

  expect_equal(
    ggplot(df, aes(x, y, color = color)) +
      geom_point() +
      scale_color_paletteer_c(`"scico::berlin"`),
    ggplot(df, aes(x, y, color = color)) +
      geom_point() +
      scale_color_paletteer_c("scico::berlin")
  )

  expect_equal(
    ggplot(df, aes(x, y, fill = color)) +
      geom_raster() +
      scale_fill_paletteer_c(`"scico::berlin"`),
    ggplot(df, aes(x, y, fill = color)) +
      geom_raster() +
      scale_fill_paletteer_c("scico::berlin")
  )
})

test_that("scale_*_paletteer_c works when called from another function", {
  colour_fun <- function(pal) {
    ggplot(df, aes(x, y, colour = color)) +
      geom_point() +
      scale_colour_paletteer_c(pal)
  }

  color_fun <- function(pal) {
    ggplot(df, aes(x, y, color = color)) +
      geom_point() +
      scale_color_paletteer_c(pal)
  }

  fill_fun <- function(pal) {
    ggplot(df, aes(x, y, fill = color)) +
      geom_raster() +
      scale_fill_paletteer_c(pal)
  }

  gg_colour_real <- ggplot(df, aes(x, y, colour = color)) +
    geom_point() +
    scale_colour_paletteer_c("scico::berlin")

  gg_color_real <- ggplot(df, aes(x, y, color = color)) +
    geom_point() +
    scale_color_paletteer_c("scico::berlin")

  gg_fill_real <- ggplot(df, aes(x, y, fill = color)) +
    geom_raster() +
    scale_fill_paletteer_c("scico::berlin")

  gg_colour_fun <- colour_fun("scico::berlin")
  gg_color_fun <- color_fun("scico::berlin")
  gg_fill_fun <- fill_fun("scico::berlin")

  expect_equal(
    layer_data(gg_colour_real)$colour,
    layer_data(gg_colour_fun)$colour
  )

  expect_equal(
    layer_data(gg_color_real)$colour,
    layer_data(gg_color_fun)$colour
  )

  expect_equal(
    layer_data(gg_fill_real)$fill,
    layer_data(gg_fill_fun)$fill
  )
})
