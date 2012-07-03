require 'spec_helper'

describe "SearchesController" do
  describe "#create" do
    context "searching for tracks" do

      let(:tracks) { FactoryGirl.build_list(:track, 5) }

      before(:each) do
        Search.stub(:search_for_tracks).and_return(tracks)
        post search_url(format: :json)
      end

      it "returns some tracks" do
        response_json = JSON.parse(response.body)
        response_json.count.should == 5
      end

      it "returns a 200 response" do
        response.status.should == 200
      end
    end
  end

end