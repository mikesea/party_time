require 'spec_helper'

describe "DealsController" do
  describe "#show" do
    context "retrieving a national deal" do

      let(:ls_deal) { FactoryGirl.build(:living_social_deal) }

      before(:each) do
        LivingSocialDeal.stub(:get_national_deal).and_return(ls_deal)
        get deal_url(format: :json)
      end

      it "returns a national deal" do
        response_json = JSON.parse(response.body)
        response_json['title'].should_not be nil
        response_json['url'].should_not be nil
        response_json['image_url'].should_not be nil
      end

      it "returns a 200 response" do
        response.status.should == 200
      end
    end
  end

end