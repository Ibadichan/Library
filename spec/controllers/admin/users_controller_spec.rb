require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { create(:user, admin: true) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new user to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders templates new' do
      expect(response).to render_template 'new'
    end
  end

  describe 'POST #create' do
    let(:avatar) { Rack::Test::UploadedFile.new(File.open("#{Rails.root}/.rspec")) }

    context 'with valid attributes' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: attributes_for(:user, avatar: avatar) }
        end.to change(User, :count).by(1)
      end

      it 'redirects to admin panel' do
        post :create, params: { user: attributes_for(:user, avatar: avatar) }
        expect(response).to redirect_to admin_users_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create user' do
        expect do
          post :create, params: { user: attributes_for(:invalid_user) }
        end.to_not change(User, :count)
      end

      it 'renders new template' do
        post :create, params: { user: attributes_for(:invalid_user) }
        expect(response).to render_template 'new'
      end
    end
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'PATCH #block' do
    let(:not_admin) { create(:user, blocked: false) }
    before { patch :block, params: { id: not_admin.id, format: :json } }

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq not_admin
    end

    it "sets true to the field 'blocked' of user" do
      not_admin.reload
      expect(not_admin.blocked).to eq true
    end

    it 'responds with json of user' do
      not_admin.reload
      expect(response.body).to be_json_eql(not_admin.to_json)
    end
  end

  describe 'PATCH #unblock' do
    let(:not_admin) { create(:user, blocked: true) }
    before { patch :unblock, params: { id: not_admin.id, format: :json } }

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq not_admin
    end

    it "sets false to the field 'blocked' of user" do
      not_admin.reload
      expect(not_admin.blocked).to eq false
    end

    it 'responds with json of user' do
      not_admin.reload
      expect(response.body).to be_json_eql(not_admin.to_json)
    end
  end
end
