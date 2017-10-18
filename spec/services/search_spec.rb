require 'rails_helper'

RSpec.describe Search do
  describe '.find_book' do
    let(:query)  { 'abc' }
    let(:object) { create(:user).to_json }

    it 'makes an api request to Google' do
      stub_request(:get, "https://www.googleapis.com/books/v1/volumes?q=#{query}")
        .to_return(status: 200)
      Search.find_book(query)
    end

    it 'returns json' do
      stub_request(:get, "https://www.googleapis.com/books/v1/volumes?q=#{query}")
        .to_return(status: 200, body: object)
      expect(Search.find_book(query)).to eq JSON.parse(object)
    end
  end
end
