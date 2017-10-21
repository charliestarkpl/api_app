module Api
  class LettersCountController < ApplicationController
    def index
      @service = LettersCountService.new(params)
      @service.call
      render json: json_format
    end

    private

    def json_format
     {
       response: {
         current_date: @service.current_date,
         letters_count: @service.letters_count,
         query: @service.query
       }
     }
    end
  end
end
