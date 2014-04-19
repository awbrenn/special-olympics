class Heat < ActiveRecord::Base
  attr_accessible :event_id, :gender, :min_age, :max_age, :time, :num_heats
  belongs_to :event
  has_and_belongs_to_many :athletes
  # Validations
  validates_associated :event
  validates :gender, inclusion:{in: %w(M F B)}
  validates :min_age, numericality:{only_integer: true, greater_than: 0}
  validates :max_age, numericality:{only_integer: true, greater_than_or_equal_to: :min_age}
  validates :time, format:{with: /\A[0-2]?[0-9]:[0-5][0-9]:00+\z/, message: "Format: hours:minutes:seconds, where 0<=hours<=24, 0<=minutes<=59, seconds=00, e.g. 11:30:00"}
  validates :num_heats, numericality:{only_integer: true, greater_than: 0}

  # Takes file and parses it
  def self.import(file)
		spreadsheet = open_spreadsheet(file)

		(2..spreadsheet.last_row).each do |i|

			# create new heat
			heat = Heat.create
			# find event associated with heat
			event = Event.find_by_event_code(spreadsheet.row(i)[0])

			# set attributes of heat
			heat.event_id = event.id
			heat.gender = spreadsheet.row(i)[2]
			heat.min_age = spreadsheet.row(i)[3]
			heat.max_age = spreadsheet.row(i)[4]
			heat.time = spreadsheet.row(i)[5]
			heat.num_heats = spreadsheet.row(i)[6]

			# save heat
			heat.save
			# sets up belongs_to association with event
			event.heats.concat(heat)
			# save event
			event.save
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
