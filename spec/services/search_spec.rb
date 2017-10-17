require 'rails_helper'

RSpec.describe Search do
  describe '.find_book' do
    it 'makes an api request to Google' do
      stub_request(:get, 'https://www.googleapis.com/books/v1/volumes?q=Lenin')
        .to_return(status: 200)
      RestClient.get 'https://www.googleapis.com/books/v1/volumes?q=Lenin'
    end
  end
end
