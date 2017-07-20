#!/usr/bin/ruby

require 'RMagick'

$image_rect = [60, 60]
$line_width = 25

directions   = ['top','right','bottom','left']
combinations = [] 

directions.each_with_index do |direction,index|
  directions.combination(index+1).to_a.each do |combination|
    combinations.push combination.join '-'
  end
end

#base canvas
def draw_canvas (color='#515159', &block)
  base_canvas = Magick::Image.new($image_rect[0], $image_rect[1]) {self.background_color = "transparent"}
  if color != nil 
    rect = Magick::Draw.new
    rect.fill color
    rect.rectangle 0, 0, $image_rect[0], $image_rect[1] 
    rect.draw base_canvas
  end
  write_path = base_canvas.instance_eval &block
  base_canvas.write write_path
  base_canvas
end

def draw_line (direction, color)
  l = Magick::Draw.new
  l.stroke color
  #One of "butt", "round", or "square".
  l.stroke_linecap 'butt'
  l.stroke_width $line_width
  if /top/.match direction
    l.line $image_rect[0] / 2, $image_rect[1] / 2, $image_rect[0] / 2, 0
  end
  
  if /right/.match direction
    l.line $image_rect[0] / 2, $image_rect[1] / 2, $image_rect[0], $image_rect[1] / 2
  end
  
  if /bottom/.match direction
    l.line $image_rect[0] / 2, $image_rect[1] / 2, $image_rect[0] / 2, $image_rect[1]
  end
  
  if /left/.match direction
    l.line $image_rect[0] / 2, $image_rect[1] / 2, 0, $image_rect[1] / 2
  end
  return l
end

$saved_path = []

def save_path (path)
  $saved_path << File.expand_path("../#{path}", __FILE__)
  $saved_path.last
end

# none line
draw_canvas do
  save_path 'direction-default.png'
end

combinations.each do |direction|
  
  #default line
  draw_canvas do
    (draw_line direction, '#6e6e7a').draw self
    save_path "direction-#{direction}.png"
  end
  
  #active line
  draw_canvas do    
    (draw_line direction, '#f1db4b').draw self
    save_path "direction-#{direction}-active.png"
  end
  
end

puts $saved_path