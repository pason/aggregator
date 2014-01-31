require 'spec_helper'
require 'pason.rb'

fixture_path = 'spec/fixtures/'


describe "Aggregator" do

 
  it 'accept only arguments hash' do
  	expect {Pason::Aggregator.new('')}.to raise_error "Argument not a Hash"
  	expect {Pason::Aggregator.new([1,2,3])}.to raise_error "Argument not a Hash"  	
  end

  it 'not accept invalid arguments' do
  	expect {Pason::Aggregator.new({:from_file_path => nil, :file => nil})}.to raise_error "Invalid argument file"
  end


  it 'not accept empty from_file_path' do
  	aggregator = Pason::Aggregator.new(
					  				:from_file_path => nil, 
										:to_file_path => 'file2.csv', 
										:from_file_id_column => 1, 
										:to_file_id_column => 3,
										:from_value_column => 2, 
										:to_value_column => 4) 
  	
  	expect { aggregator.parse }.to raise_error "Parameter from_file_path can't be empty"
  end

  it 'not accept empty to_file_path' do
  	aggregator = Pason::Aggregator.new(
					  				:from_file_path => 'file1.csv', 
										:to_file_path => nil, 
										:from_file_id_column => 1, 
										:to_file_id_column => 3,
										:from_value_column => 2, 
										:to_value_column => 4) 
  	
  	expect { aggregator.parse }.to raise_error "Parameter to_file_path can't be empty"
  end

   it 'accept only number for column parameters' do
  	aggregator = Pason::Aggregator.new(
					  				:from_file_path => 'file1.csv', 
										:to_file_path => 'file2.csv', 
										:from_file_id_column => nil, 
										:to_file_id_column => 3,
										:from_value_column => 2, 
										:to_value_column => 4) 
  	
  	expect { aggregator.parse }.to raise_error "Parameter from_file_id_column invalid number"

  	aggregator.from_file_id_column = 1
  	aggregator.to_file_id_column = nil
  	expect { aggregator.parse }.to raise_error "Parameter to_file_id_column invalid number"

  	aggregator.to_file_id_column = 3
  	aggregator.from_value_column = nil
  	expect { aggregator.parse }.to raise_error "Parameter from_value_column invalid number"

  	aggregator.from_value_column = 2
  	aggregator.to_value_column = ''
  	expect { aggregator.parse }.to raise_error "Parameter to_value_column invalid number"

  end


  it 'parse basic csv file' do 
  	aggregator = Pason::Aggregator.new(
					  				:from_file_path => "#{fixture_path}basic1.csv", 
										:to_file_path => "#{fixture_path}basic2.csv", 
										:from_file_id_column => 1, 
										:to_file_id_column => 3,
										:output_folder => 'spec/tmp/aggregator/')
  	
  	output_file_path = aggregator.parse 
  	output_data = CSV.readlines(output_file_path)	
  	
  	expect(output_data[0][3]).to eq "value1"

  end


  it 'parse pets csv file' do 
  	aggregator = Pason::Aggregator.new(
					  				:from_file_path => "#{fixture_path}pets1.csv", 
										:to_file_path => "#{fixture_path}pets2.csv", 
										:from_file_id_column => 1, 
										:to_file_id_column => 1,
										:from_value_column => 3, 
										:to_value_column => 3,
										:output_folder => 'spec/tmp/aggregator/')
  	
  	output_file_path = aggregator.parse 
  	output_data = CSV.readlines(output_file_path)	
  	
  	expect(output_data[0][2]).to eq "2"
  	expect(output_data[1][2]).to eq "5"
  	expect(output_data[2][2]).to eq "3"
  	expect(output_data[3][2]).to eq "0"

  end


end