dm = 'data_model.csv'

def save_data(file_path, data_array)
  Dir.mkdir("output") unless Dir.exist?("output")

  File.open("output/#{file_path}", 'w') do |file|
    data_array.each do |data|
      file.puts data
    end
  end
end

File.open(dm, 'r') do |file|
  regions = []
  documents = []
  countries = []

  file.each_line do |line|
    data = line.split(',')

    case data[1]
    when "Наименование по ОКАТО [List]"
      regions << "#{data[3][9..10]};#{data[4].gsub(/"|\s+/, "")};#{data[3][4..-1]}"
    when "Код документа удостоверяющего личность"
      documents << "#{data[4].gsub(/"/, "")};#{data[3]}"
    when "[Справочник стран]"
      File.open("oksm.csv", "r") do |f|
        f.each_line do |csv_line|
          csv_line.gsub!(/\n/, '')
          csv_data = csv_line.split(',')
          if csv_data[1] == data[4]
            countries << "#{data[4]};#{csv_data[2]};#{data[3]}"
            break
          end
        end
      end
    end
  end

  save_data('regions.csv', regions[1..-1])
  save_data('documents.csv', documents[1..-1])
  save_data('countries.csv', countries)
end