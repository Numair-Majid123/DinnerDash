# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'
require_relative '../support/devise'

RSpec.describe CategoriesController, type: :controller do
  describe ' controller test cases ' do
    let(:user) { FactoryBot.create(:user) }
    let(:category1) { FactoryBot.create :category }

    before do
      sign_in user
      user.confirm
    end

    Pundit.policy_scope!(:user, Category)

    describe '#index' do
      it 'render a template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe '#new ' do
      it 'render :new' do
        get 'new', params: {
          category: {
            name: 'gfhdgdigsa'
          }
        }
      end
    end

    describe '#create' do
      it 'redirects to @category' do
        post 'create', params: { category: { name: 'gfhdgdigsa' } }
        assert_redirected_to categories_path
      end

      it do
        post 'create', params: { category: { name: 'gfhdgdigsa' } }
        expect(flash[:notice]).to include('Category created successfully')
      end

      it 'when not create category' do
        post 'create', params: { category: { name: '' } }
        expect(response).to render_template('new')
      end

      it do
        post 'create', params: { category: { name: '' } }
        expect(flash[:alert]).to include('Name can\'t be blank, Name is too short (minimum is 2 characters)')
      end
    end

    describe '#edit' do
      it 'render :edit' do
        get :edit, params: { id: category1.id }
      end
    end

    describe '#update' do
      it 'updates the category and redirects categories_path' do
        patch :update, params: { category: { name: 'abcdef' }, id: category1.id }
        expect(response).to redirect_to categories_path
      end

      it do
        patch :update, params: { category: { name: 'abcdef' }, id: category1.id }
        expect(flash[:notice]).to include('Category was updated successfully.')
      end

      it 'when not updates the category and render to edit page' do
        patch :update, params: { category: { name: '' }, id: category1.id }
        expect(response).to render_template('edit')
      end

      it do
        patch :update, params: { category: { name: '' }, id: category1.id }
        expect(flash[:alert]).to include('Name can\'t be blank, Name is too short (minimum is 2 characters)')
      end
    end

    describe 'DELETE #destroy' do
      it do
        delete :destroy, params: { id: category1.id }
        expect(response).to redirect_to categories_path
      end

      it do
        delete :destroy, params: { id: category1.id }
        expect(flash[:notice]).to eq('Category was deleted successfully.')
      end

      it do
        delete :destroy, params: { id: category1.id + 1000 }
        expect(response).to have_http_status(:found)
      end
    end
  end
end
