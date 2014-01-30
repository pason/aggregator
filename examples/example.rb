

require '../lib/pason.rb'

options = {:from_file_path => nil, 
					:to_file_path => nil, 
					:from_file_id_column => 1, 
					:to_file_id_column => 3,
					:from_value_column => 2, 
					:to_value_column => 4}

aggregator = Pason::Aggregator.new(options)
aggregator.from_file_path = 'csv/file1.csv'
aggregator.to_file_path = 'csv/file2.csv'
puts aggregator.parse
