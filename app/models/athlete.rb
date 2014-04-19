class Athlete < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :age, :gender, :score
  belongs_to :teacher
  has_and_belongs_to_many :heats

  # Takes file and parses it
  def self.import(file)
		spreadsheet = open_spreadsheet(file)
		(2..spreadsheet.last_row).each do |i|

			# FIND THE HEAT FOR ATHLETE REFERENCE
			#-----------------------------------------------------------------------------------------------------

			# generate list of possible heats by event code
			event = Event.find_by_event_code(spreadsheet.row(i)[7])
			list_of_possible_heat = Heat.where(:event_id => event.id)

			# filter through possible heats by gender
			heat_gender_filtered = []
			index = 0
			list_of_possible_heat.each { |temp_heat|
				if temp_heat[:gender] == spreadsheet.row(i)[6]
					heat_gender_filtered[index] = temp_heat
					index = index + 1
				elsif temp_heat[:gender] == "B"
					heat_gender_filtered[index] = temp_heat
					index = index + 1
				end
			}

			# filter through possible heats by age range
			heat = nil
			heat_gender_filtered.each { |temp_heat|
				if (spreadsheet.row(i)[5]).to_i >= temp_heat[:min_age] && (spreadsheet.row(i)[5]).to_i <= temp_heat[:max_age]
					heat = temp_heat
					break
				end
			}
			#-----------------------------------------------------------------------------------------------------

			# check if athlete already exists
			athlete = Athlete.where(
							:first_name => spreadsheet.row(i)[3],
							:last_name => spreadsheet.row(i)[4],
							:age => spreadsheet.row(i)[5],
							:gender => spreadsheet.row(i)[6])

			# if the athlete does not exist
			if athlete == []
				athlete = Athlete.create

				# find teacher associated with athlete
				teacher = Teacher.find_by_name(spreadsheet.row(i)[2])

				# set all other attributes of Athlete
				athlete.teacher_id = teacher.id
				athlete.first_name = spreadsheet.row(i)[3]
				athlete.last_name = spreadsheet.row(i)[4]
				athlete.age = spreadsheet.row(i)[5]
				athlete.gender = spreadsheet.row(i)[6]
				athlete.score = spreadsheet.row(i)[9]

				athlete.save

				# add the heat to the athletes heats
				if heat != nil
					athlete.heats.concat(heat)
				end
			else
				# add the heat to the athletes heats
				if heat != nil
					athlete[0].heats.concat(heat)
				end
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
