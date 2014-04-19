class HeatSheetGeneratorController < ApplicationController
  require 'prawn'

  def index
  end

  def download

  	HeatSheetGenerator.generate
	send_file 'public/heatsheets.pdf'

	#athlete.order("score DESC").order("name DESC"))
  end

end
