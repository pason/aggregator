CSV AGGREGATOR

Usage:

- create and add permisions to write to tmp/aggregator folder



	aggregator = Pason::Aggregator.new(	
						:from_file_path => 'csv/file1.csv',
						:to_file_path => 'csv/file2.csv',
						:from_file_id_column => 1,
						:to_file_id_column => 3,
						:from_value_column => 2, 
						:to_value_column => 4
					)
	aggregator.parse


OR

	aggregator = Pason::Aggregator.new
	aggregator.from_file_path = 'csv/file1.csv'
	aggregator.to_file_path = 'csv/file2.csv'
	aggregator.from_file_id_column = 1
	aggregator.to_file_id_column = 2
	aggregator.parse

