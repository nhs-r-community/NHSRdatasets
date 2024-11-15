# Generate hexagonal logo for the package

# Setup ------------------------------------------------------------------------
p_family <- "Aller_Rg"

main_colour <- NHSRtheme::get_nhs_colours()["DarkBlue"]

# Creating subplot -------------------------------------------------------------
nrow <- 3
ncol <- 4
cell_size <- 0.85
border_size <- 0.15

data <- data.frame(x = c(1, rep(1:ncol, nrow)),
                   y = c(nrow + 1, rep(1:nrow, each = ncol))) |>
  dplyr::mutate(xend = ifelse(y == nrow + 1,
                              ncol + cell_size,
                              x + cell_size))

subplot <- data |>
  ggplot2::ggplot() +
  funkyheatmap::geom_rounded_rect(
    ggplot2::aes(
      xmin = min(x) - border_size,
      xmax = max(xend) + border_size,
      ymin = min(y) - border_size,
      ymax = max(y) + cell_size + border_size,
      radius = 0.05
    ),
    fill = "#768692"
  ) +
  funkyheatmap::geom_rounded_rect(ggplot2::aes(
    xmin = x,
    xmax = xend,
    ymin = y,
    ymax = y + cell_size,
    fill = y,
    radius = 0.1
  )) +
  NHSRtheme::scale_fill_nhs(palette = 'blues',
                            discrete = FALSE,
                            reverse = TRUE) +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "none") +
  hexSticker::theme_transparent()

# Creating hex logo ------------------------------------------------------------
hexSticker::sticker(
  subplot = subplot,
  package = "NHSRdatasets",
  h_color = main_colour,
  h_fill = "#ffffff",
  s_x = 1.0,
  s_y = 0.85,
  s_height = 0.9,
  s_width = 1.3,
  url = "",
  u_angle = 30,
  u_x = 1.02,
  u_y = 0.08,
  u_size = 4.85,
  dpi = 500,
  p_x = 1.0,
  p_y = 1.42,
  p_size = 30,
  p_color = main_colour,
  p_family = p_family,
  u_color = main_colour,
  u_family = p_family,
  filename = "inst/images/nhsrdatasetslogo.png"
)
