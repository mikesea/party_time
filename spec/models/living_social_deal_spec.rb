require 'spec_helper'

describe "LivingSocialDeal" do
  context "national deals" do

    let(:ls_deal) { FactoryGirl.build(:living_social_deal) }

    before(:each) do
      Mongoid::Criteria.any_instance.stub(:where).and_return([ls_deal])
    end

    it "returns a national deal for the US" do
      deal = LivingSocialDeal.get_national_deal
      deal.class.should be LivingSocialDeal
      deal.national.should == "true"
      deal.country_code.should == "US"
    end
  end

end