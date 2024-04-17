dm = 'data_model.csv'
regions_file = 'regions.csv'
documents_file = 'documents.csv'

File.open(dm, 'r') do |file|
  File.open(regions_file, 'w') do |region|
    File.open(documents_file, 'w') do |document|

      file.each_line do |line|
        data = line.split(',')

        case data[1]
        when "Наименование по ОКАТО [List]"
          region.puts "#{data[3][9..10]};#{data[4]};#{data[3][4..-1]}"
        when "Код документа удостоверяющего личность"
          document.puts "#{data[4]};#{data[3]}"
        end
      end
    end
  end
end