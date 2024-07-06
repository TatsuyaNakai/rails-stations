class SheetsController < ApplicationController
  # GET /sheets
  def index
    @sheets = Sheet.all
  end
end
