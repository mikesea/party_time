class LivingSocialDeal
  include Mongoid::Document

  field :ls_id
  field :published
  field :link
  field :title
  field :long_title
  field :deal_type
  field :merchandise_type
  field :market_id
  field :market_name
  field :market_location, type: Array
  field :featureType
  field :country_code
  field :subtitle
  field :offer_ends_at
  field :price
  field :value
  field :savings
  field :order_count
  field :merchant_type
  field :image_url
  field :categories
  field :sold_out
  field :national
  field :description
  field :details
  field :content
  field :merchant

  index(
    [[:division_latlon, Mongo::GEO2D]], background: true
  )

  def self.get_national_deal
    LivingSocialDeal.where(national: "true", sold_out: "false", country_code: "US").last
  end

end