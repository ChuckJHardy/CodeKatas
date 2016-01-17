require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:post) { create(:post) }

  before do
    create(:post)
    post
  end

  describe 'GET /users/1/posts' do
    before do
      get user_posts_path(post.user, format: :json, per_page: 1, page: 2)
    end

    it 'response with expected status code' do
      expect(response.status).to eq(200)
    end

    it 'returns posts' do
      expect(response).to match_response_schema('posts')
    end

    it 'returns paginated results' do
      expect(JSON.parse(response.body)['posts'].first['id']).to eq(post.id)
    end
  end
end
