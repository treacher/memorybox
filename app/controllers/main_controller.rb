class MainController < ApplicationController

	layout 'angular'

	before_filter :authenticate_user!

	def index
	end
end