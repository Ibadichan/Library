require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET #show' do
    let(:query) { 'my book' }

    it 'calls method find_book of class Search' do
      expect(Search).to receive(:find_book).with(query).and_call_original
      get :show, params: { query: query }
    end

    it 'renders template show' do
      get :show, params: { query: query }
      expect(response).to render_template 'show'
    end
  end
end
