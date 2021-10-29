# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe ' controller test cases ' do
    let(:user) { FactoryBot.create(:user) }
    let(:order1) { FactoryBot.create :order }

    before do
      sign_in user
      user.confirm
      session[:cart] = [89, 87]
      session[:hash] = { '89' => 1, '87' => 1 }
    end

    Pundit.policy_scope!(:user, Category)

    it { is_expected.to set_session }

    describe '#index' do
      it 'render a template for index' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe '#new' do
      it 'render :new' do
        get 'new'
      end
    end

    describe '#create' do
      it 'when order created' do
        post 'create', params: { id: order1.id }
        assert_redirected_to root_path
      end

      it 'when order not created' do
        sign_out user
        post 'create', params: { id: order1.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe '#update_status' do
      it 'update order status' do
        post :update_status, params: { id: order1.id,
                                       status: 0 }, xhr: true
      end

      it do
        post :update_status, params: { id: order1.id,
                                       status: 0 }, xhr: true
        expect(flash[:notice]).to include('Order Updated successfully')
      end

      it 'Not update order status' do
        post :update_status, params: { id: order1.id }, xhr: true
        expect(flash[:alert]).to include('Order can not update successfully')
      end
    end
  end
end
