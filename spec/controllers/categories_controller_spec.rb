# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

RSpec.describe CategoriesController, type: :controller do
  describe ' controller test cases ' do
    let(:user) { FactoryBot.create(:user) }
    let(:category1) { FactoryBot.create :category }

    before do
      sign_in user
      user.confirm
    end

    describe '#index' do
      it 'Render index, http status ok and check instance variable' do
        get :index
        expect(response).to render_template('index')
        expect(response).to have_http_status(:ok)
        expect(assigns(:categories)).to eq(Category.all)
      end
    end

    describe '#new ' do
      it 'respond to new, check status and check instance of object' do
        get 'new', params: { category: { name: 'gfhdgdigsa' } }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('new')
        expect(assigns[:category]).to be_instance_of(Category)
      end
    end

    describe '#create' do
      it 'will check category create, flash notice and redirects to @category' do
        post :create, params: { category: { name: 'abcdefgh' } }
        expect { category1.attributes }.to change(Category, :count).by(1)
        expect(flash[:notice]).to include('Category created successfully')
        expect(response).to have_http_status(:found)
        assert_redirected_to categories_path
      end

      it 'will fails authorization, flash alert' do
        user.admin = false
        user.save
        post :create, params: { category: { name: 'abcdefgh' } }
        expect(flash[:alert]).to include('You are not authorized.')
      end

      it 'when not create category because name can not be empty and render to new' do
        post 'create', params: { category: { name: '' } }
        expect(flash[:alert]).to include('Name can\'t be blank, Name is too short (minimum is 2 characters)')
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('new')
      end
    end

    describe '#edit' do
      it 'render :edit, check http status and instance of object' do
        get :edit, params: { id: category1.id }
        expect(response).to have_http_status(:ok)
        expect(assigns[:category]).to be_instance_of(Category)
      end

      it 'will fails authorization, flash alert' do
        user.admin = false
        user.save
        get :edit, params: { id: category1.id }
        expect(flash[:alert]).to include('You are not authorized.')
      end
    end

    describe '#update' do
      it 'updates the category, check http status and redirects categories_path' do
        patch :update, params: { category: { name: 'abcdef' }, id: category1.id }
        expect(flash[:notice]).to include('Category was updated successfully.')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to categories_path
      end

      it 'will fails authorization, flash alert' do
        user.admin = false
        user.save
        patch :update, params: { category: { name: 'abcdef' }, id: category1.id }
        expect(flash[:alert]).to include('You are not authorized.')
      end

      it 'when not updates the category because name can not be empty and render to edit page' do
        patch :update, params: { category: { name: '' }, id: category1.id }
        expect(flash[:alert]).to include('Name can\'t be blank, Name is too short (minimum is 2 characters)')
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('edit')
      end
    end

    describe 'DELETE #destroy' do
      it 'detete category, check http status, rediect to categories index and flash notice' do
        delete :destroy, params: { id: category1.id }
        expect(flash[:notice]).to eq('Category was deleted successfully.')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to categories_path
      end

      it 'will fails authorization, flash alert' do
        user.admin = false
        user.save
        delete :destroy, params: { id: category1.id }
        expect(flash[:alert]).to include('You are not authorized.')
      end

      it 'Fails destroy and check http status' do
        allow_any_instance_of(Category).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: category1.id }
        expect(response).to have_http_status(:found)
      end
    end
  end
end
