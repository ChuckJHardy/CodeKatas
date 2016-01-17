require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:post) { create(:post) }

  describe 'GET index' do
    before { get :index, params: { user_id: post.user.id } }

    it { should respond_with(200) }

    it 'returns posts' do
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end
end
