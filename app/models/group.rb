class Group < ActiveRecord::Base
	attr_accessible :group_code, :school_name
	has_many :teachers

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		(2..spreadsheet.last_row).each do |i|

			# check if group is already in the database
			group = Group.find_by_group_code(spreadsheet.row(i)[0])
			
			# if group does not exist
			if group == nil 
				group = Group.create

				# set the attributes of Group
				group.group_code = spreadsheet.row(i)[0]
				group.school_name = spreadsheet.row(i)[1]

				group.save
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
