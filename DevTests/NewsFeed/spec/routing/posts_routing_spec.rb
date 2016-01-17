require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  let(:user_id) { '22' }

  it do
    expect(get: "users/#{user_id}/posts")
      .to route_to('posts#index', user_id: user_id)
  end

  it do
    expect(post: "users/#{user_id}/posts")
      .to route_to('posts#create', user_id: user_id)
  end

  it do
    expect(delete: "users/#{user_id}/posts/1")
      .to route_to('posts#destroy', id: '1', user_id: user_id)
  end

  it { expect(get: "users/#{user_id}/posts/1").not_to be_routable }
  it { expect(get: "users/#{user_id}/posts/new").not_to be_routable }
  it { expect(put: "users/#{user_id}/posts/1/edit").not_to be_routable }
  it { expect(put: "users/#{user_id}/posts/1").not_to be_routable }
end
