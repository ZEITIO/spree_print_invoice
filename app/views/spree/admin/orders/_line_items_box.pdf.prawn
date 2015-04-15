data = []

if @hide_prices
  @column_widths = { 0 => 265, 1 => 75, 2 => 75 }
  @align = { 0 => :left, 1 => :right, 2 => :right }
  data << [Spree.t(:item_description), Spree.t(:options), Spree.t(:qty)]
else
  @column_widths = { 0 => 280, 1 => 75, 2 => 50, 3 => 75, 4 => 60 }
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right}
  data << [Spree.t(:item_description), Spree.t(:options), Spree.t(:price), Spree.t(:qty), Spree.t(:total)]
end

@order.line_items.each do |item|
  row = [item.variant.product.name]
  row << item.variant.options_text
  row << item.single_display_amount.to_s unless @hide_prices
  row << item.quantity
  row << item.display_total.to_s unless @hide_prices
  data << row
end


move_down(250)

table(data, :width => @column_widths.values.compact.sum, :column_widths => @column_widths) do
  cells.border_width = 0.5

  row(0).borders = [:bottom]
  row(0).font_style = :bold

  last_column = data[0].length - 1
  row(0).columns(0..last_column).borders = [:top, :right, :bottom, :left]
  row(0).columns(0..last_column).border_widths = [0.5, 0, 0.5, 0.5]

  row(0).column(last_column).border_widths = [0.5, 0.5, 0.5, 0.5]
end



data = []
@column_widths = { 0 => 480, 1 => 75 }
@align = { 0 => :right, 1 => :right }
extra_row_count = 0

unless @hide_prices
  extra_row_count += 1
  data << [""] * 2
  data << [Spree.t(:subtotal), @order.display_item_total.to_s]

  @order.all_adjustments.eligible.each do |adjustment|
    extra_row_count += 1
    data << [adjustment.label, adjustment.display_amount.to_s]
  end

  @order.shipments.each do |shipment|
    extra_row_count += 1
    data << [shipment.shipping_method.name, shipment.display_cost.to_s]
  end

  data << [Spree.t(:total), @order.display_total.to_s]
end

table(data, :width => @column_widths.values.compact.sum, :column_widths => @column_widths) do
  cells.border_width = 0
  column(0).style :align => :right
  column(0).font_style = :bold

  # row(0).borders = [:bottom]
  # row(0).font_style = :bold
  #
  # last_column = data[0].length - 1
  # row(0).columns(0..last_column).borders = [:top, :right, :bottom, :left]
  # row(0).columns(0..last_column).border_widths = [0.5, 0, 0.5, 0.5]
  #
  # row(0).column(last_column).border_widths = [0.5, 0.5, 0.5, 0.5]
  #
  # if extra_row_count > 0
  #   extra_rows = row((-2-extra_row_count)..-2)
  #   extra_rows.columns(0..4).borders = []
  #   extra_rows.column(3).font_style = :bold
  #
  #   row(-1).columns(0..4).borders = []
  #   row(-1).column(3).font_style = :bold
  # end
end

