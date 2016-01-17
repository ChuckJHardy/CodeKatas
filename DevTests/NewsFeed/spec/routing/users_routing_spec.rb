require 'rails_helper'

RSpec.describe 'UsersController', type: :routing do
  it { expect(get: 'users').not_to be_routable }
  it { expect(get: 'users/new').not_to be_routable }
  it { expect(get: 'users/1').not_to be_routable }
  it { expect(get: 'users/1/edit').not_to be_routable }
  it { expect(post: 'users').not_to be_routable }
  it { expect(put: 'users/1').not_to be_routable }
  it { expect(delete: 'users/1').not_to be_routable }
end
