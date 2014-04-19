class Teacher < ActiveRecord::Base
  belongs_to :group

  	def self.import(file)
  		spreadsheet = open_spreadsheet(file)
		(2..spreadsheet.last_row).each do |i|
			
			# check if teacher is already in the database
			# group = Group.find_by_group_code(spreadsheet.row(i)[0])
			teacher = Teacher.find_by_name(spreadsheet.row(i)[2])


			if teacher == nil
				teacher = Teacher.create

				# set the attributes of Teacher
				teacher.name = spreadsheet.row(i)[2]
				teacher.group_id = Group.find_by_group_code(spreadsheet.row(i)[0]).id

				teacher.save
			end
		end
	end


		# Opens a file using the roo gem
	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::Csv.new(file.path)
		else raise "Unkown file type: #{file.original_filename}"
		end
	end
end
