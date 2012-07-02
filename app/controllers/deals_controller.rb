class DealsController < ApplicationController

  def show
    @deal = LivingSocialDeal.get_national_deal
  end

end
