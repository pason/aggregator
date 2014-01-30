require 'csv'
require 'securerandom'

module Pason
	class Aggregator

		attr_accessor :from_file_path, :to_file_path, :from_value_column, :to_value_column, :from_file_id_column, :to_file_id_column
		OUTPUT_FOLDER = 'tmp/aggregator/'


		def initialize(options = {})

			raise Exception.new('Argument not a Hash...') unless options.is_a? Hash

			#Default values
			@from_value_column = 2
			@to_value_column = 4

			#pass parameters
			options.each do |name, value|
				raise Exception.new("Invalid argument #{name}") unless  respond_to? "#{name}="
				self.send("#{name}=", value) 
			end

		end


		def parse
			validate

			output_file_name = SecureRandom.hex(4) + '.csv'

			to_file_data = CSV.readlines(@to_file_path)	

			CSV.foreach(@from_file_path) do |from_row|
				index = $.-1
				to_row = to_file_data[index]
				if to_row[@to_file_id_column-1] == from_row[@from_file_id_column-1]
					to_row[@to_value_column-1] = from_row[@from_value_column-1]
				end
			
				CSV.open(OUTPUT_FOLDER + output_file_name, "a+") {|csv| csv << to_row}

			end

			return OUTPUT_FOLDER + output_file_name 			
		end


		private 

		def validate
			raise Exception.new("Parameter from_file_path can't be empty") if @from_file_path.nil? 
			raise Exception.new("Parameter to_file_path can't be empty") if @to_file_path.nil? 
			raise Exception.new("Parameter from_file_id_column invalid number") unless @from_file_id_column.is_a? Integer 
			raise Exception.new("Parameter to_file_id_column invalid number") unless @to_file_id_column.is_a? Integer 
			raise Exception.new("Parameter from_value_column invalid number") unless @from_value_column.is_a? Integer 
			raise Exception.new("Parameter to_value_column invalid number") unless @to_value_column.is_a? Integer 
		end


	end
end




