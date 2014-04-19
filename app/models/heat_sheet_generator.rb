class HeatSheetGenerator < ActiveRecord::Base
	require 'prawn'

	def self.header(pdf,heat,page_number)
			event = Event.find(heat.event_id).event_name

				# get gender info
				gender = ""
				if heat.gender == "F"
					gender = "For Women" 
				elsif heat.gender == "M"
					gender = "For Men"
				else
					gender = "For Both"
				end

				#print header information
				pdf.text "#{event}                      \tGroup #{heat.min_age} to #{heat.max_age}             \tTime #{heat.time}                      Page #{page_number}\n#{gender}\n---------------------------------------------------------------------------------------------------------------------------------------"
	end

	def self.generate
		# get all the events
		events = Event.all

		# start page_number at 1
		page_number = 1

		# making new Prawn pdf document
		pdf = Prawn::Document.new
		events.each do |event|
			heats = event.heats
			heats.each do |heat|
				if heat.athletes.length != 0
					athletes = heat.athletes
					if Event.find((heat).event_id).score_unit == "N"
						athletes = athletes.order("last_name ASC")
					else
						athletes = athletes.order("score ASC, last_name ASC")
					end
					num_per_heat = heat.athletes.length / heat.num_heats
					division = 1


					# FITTING ATHLETES INTO TABLE
					# --------------------------------------------------------------------------
					rank = 1
					# setting the length of the table
					table_length = 30
					# incrementers used for cutting table
					start_index = 0
					end_index = (table_length-1)
					# partial array of athletes that will fit into a table
					athletes_partial = athletes[start_index..end_index]

					# cut the pages
					i = 1
					while i*(table_length) < athletes.length
						header(pdf,heat,page_number)
						athlete_to_table(pdf,heat,athletes_partial,rank)
						rank += table_length-1
						pdf.start_new_page

						start_index = (i*table_length)
						end_index += (table_length)
						athletes_partial = athletes[start_index..end_index]

						i+=1
						page_number += 1
					end
					header(pdf,heat,page_number)
					athlete_to_table(pdf,heat,athletes_partial,rank)
					rank += table_length
					pdf.start_new_page

					page_number+=1
					division += 1
					# ------------------------------------------------------------------------------
				end
			end
		end
		pdf.render_file "public/heatsheets.pdf"
	end

	def self.athlete_to_table(pdf,heat,athletes,rank)

		score_unit = Event.find(heat.event_id).score_unit

		# Give the array an initial value
		athlete_info = [[]]
		# Generate double array of athlete information
		athletes.each do |athlete|
			# Get right display of score based on 
			if Event.find((heat).event_id).score_unit == "T"
				minutes = athlete.score/100
				seconds = athlete.score%100
				if seconds < 10
					score = "#{minutes}:0#{seconds}"
				else
					score = "#{minutes}:#{seconds}"
				end
			elsif Event.find((heat).event_id).score_unit == "D"
				feet = athlete.score/100
				inches = athlete.score%100
				score = "#{feet}ft. #{inches}in."
			else
				score = ""
			end

			athlete_info += [[
				"#{athlete.last_name}, #{athlete.first_name}",
				athlete.age,
				athlete.gender,
				rank,
				score,
				"",
				"#{Group.find(Teacher.find(athlete.teacher_id).group_id).group_code} #{Group.find(Teacher.find(athlete.teacher_id).group_id).school_name}",
				Teacher.find(athlete.teacher_id).name
			]]
			rank+=1
		end
		# Get rid of initial array value
		athlete_info.delete([])
		# Add header to athlete_info
		athlete_info_w_header = [["Name","Age","Sx","Rank","Time","Div.","Group","Supervisor"]] + athlete_info

		# Print the athlete table
		if athlete_info_w_header != [] && athlete_info_w_header != nil
			pdf.move_down(10)

			pdf.table athlete_info_w_header,
			:header => true,
			:cell_style => { size: 8, :border_width => 0 } 
		end
		# return the pdf
		#return pdf
	end

end


