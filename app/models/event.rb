class Event < ActiveRecord::Base
	attr_accessible :event_code, :event_name, :score_unit, :min_score, :max_score, :sort_seq
	has_many :heats, :dependent => :destroy
        # validations
        validates :event_code, format: { with: /\E[0-9][0-9][0-9]\z/, message: "Format: E followed by 3 digit code, e.g. E001"}
        validates :event_name, length:{in: 1..50}
	validates :score_unit, inclusion:{in: %w(T D N)}
	validates :min_score, numericality:{greater_than_or_equal_to: 0, message: "Should be a positive integer value"}
	validates :max_score, numericality:{greater_than_or_equal_to: :min_score, message: "Should be an integer greater than min score"}
	validates :sort_seq, numericality:{ only_integer: true, message: "Should be an integer value"}
      
	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = ["event_code","event_name","score_unit","min_score","max_score","sort_seq"]
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]

			event = find_by_event_code(row["event_code"]) || new
			event.attributes = row.to_hash.slice(*accessible_attributes)
			event.save!
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::Csv.new(file.path)
		else raise "Unkown file type: #{file.original_filename}"
		end
	end
end
