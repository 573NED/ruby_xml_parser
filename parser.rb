dm = 'data_model.csv'
regions_file = 'regions.csv'
documents_file = 'documents.csv'
countries_file = 'countries.csv'

def save_data(file_path, data_array)
  data_array = data_array[1..-1]

  File.open(file_path, 'w') do |file|
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
      regions << "#{data[3][9..10]};#{data[4]};#{data[3][4..-1]}"
    when "Код документа удостоверяющего личность"
      documents << "#{data[4]};#{data[3]}"
    when "[Справочник стран]"
      countries << "#{data[4]};#{data[3][13..-1].split('Member').first};#{data[3]}"
    end
  end

  save_data(regions_file, regions)
  save_data(documents_file, documents)
  save_data(countries_file, countries)
end