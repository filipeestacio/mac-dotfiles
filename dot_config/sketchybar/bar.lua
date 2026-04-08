local colors = require("colors")

sbar.bar({
  height = 40,
  color = colors.bar.bg,
  border_color = colors.bar.border,
  border_width = 0,
  blur_radius = 30,
  padding_right = 10,
  padding_left = 10,
  corner_radius = 0,
  y_offset = 0,
  margin = 0,
  sticky = true,
  topmost = "window",
  position = "top",
  shadow = false,
})
