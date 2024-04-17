dm = 'data_model.csv'
output_file = 'regions.csv'

File.open(dm, 'r') do |file|
  File.open(output_file, 'w') do |output|
    file.each_line do |line|
      data = line.split(',')

      if data[1] == "Наименование по ОКАТО [List]"
        output.puts "#{data[3][9..10]};#{data[4]};#{data[3][4..-1]}"
      end
    end
  end
end
