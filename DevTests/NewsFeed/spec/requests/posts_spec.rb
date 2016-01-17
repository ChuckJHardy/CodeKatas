require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:post) { create(:post) }

  describe 'GET /users/1/posts' do
    it 'returns Posts' do
      get user_posts_path(post.user, format: :json)

      expect(response.status).to eq(200)
      expect(response).to match_response_schema('posts')
    end
  end
end
