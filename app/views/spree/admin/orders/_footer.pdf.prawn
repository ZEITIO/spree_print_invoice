bounding_box [bounds.left, bounds.bottom + 50], :width  => bounds.width do
  font "Helvetica"
  stroke_horizontal_rule
  move_down(10)
  text Spree.t(:invoice_footer), :size => 8
end
