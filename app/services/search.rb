class Search
  def self.find_book(query)
    encoded_url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{query}")
    response = RestClient.get encoded_url
    JSON.parse(response.body) unless response.body.blank?
  end
end
