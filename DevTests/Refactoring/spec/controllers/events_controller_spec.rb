require 'spec_helper'

describe EventsController do
  def current_user
    @current_user ||= User.create! name: 'John Doe'
  end

  before do
    current_user
  end

  it 'returns 200 OK' do
    get :index
    expect(response).to be_ok
  end
end
