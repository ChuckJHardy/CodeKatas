require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  it { expect(get: 'posts').to route_to('posts#index') }
  it { expect(post: 'posts').to route_to('posts#create') }
  it { expect(delete: '/posts/1').to route_to('posts#destroy', id: '1') }
  it { expect(get: 'posts/1').not_to be_routable }
  it { expect(get: 'posts/new').not_to be_routable }
  it { expect(put: 'posts/1/edit').not_to be_routable }
  it { expect(put: 'posts/1').not_to be_routable }
end
