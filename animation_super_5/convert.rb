require 'json'
require 'RMagick'
include Magick

def imageToZprotocol(image_path)
  zprotocol = "Z"
  image = ImageList.new(image_path)
  27.times do |column|
    16.times do |row|
      color = image.pixel_color(column, row)
      zvalue = case color.red
        when 65535 then "F"
        when 52428 then "D"
        when 44975 then "B"
        when 39321 then "9"
        when 32896 then "7"
        when 26214 then "5"
        when 13107 then "3"
        when 7967 then "1"
        when 0 then "0"
        else "-1"
      end
      if zvalue == "-1"
        p color.red
      end
      #p "column: #{column} - row: #{row} - zvalue: #{zvalue}"
      zprotocol += zvalue
    end
  end

  return zprotocol
end

def zprotocolToJson(zprotocol)
  output = []
  column = 0
  row = 0
  zprotocol.gsub("Z", "").each_char do |char|
    fill = "##{char*3}"
    output << {
      :type => "rect", 
      :x => column, 
      :y => row, 
      :width => 1, 
      :height => 1, 
      'stroke-width' => 0,
      :fill => fill
    }
    row += 1
    if row == 16
      row = 0
      column += 1
    end
  end
  return output
end

def export_html(path, json, zprotocol)
  File.open(path, 'w') do |file|
    file.puts <<-eos
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="utf-8">
        <script src="./js/raphael.js"></script>
        <style media="screen">
          #canvas {
            height: 480px;
            margin: 0 auto;
            text-align: left;
            width: 640px;
          }
        </style>
        <script>
            window.onload = function () {
                var paper = Raphael("canvas", 640, 480);
                paper.add(#{json.to_json});
            };
        </script>
      </head>
      <body>
        <div id="canvas"></div>
        <p>#{zprotocol}</p>
      </body>
      </html>
    eos
  end
end

def export_zprotocol(zprotocol)
  File.open("zprotocol.txt", 'a') do |file|
    file.puts zprotocol
  end
end

Dir.glob("*.gif").each do |file|
  zprotocol = imageToZprotocol(file)
  json = zprotocolToJson(zprotocol)
  export_html("demo/#{file.gsub(".gif", "")}.html", json, zprotocol)
  export_zprotocol zprotocol
end
