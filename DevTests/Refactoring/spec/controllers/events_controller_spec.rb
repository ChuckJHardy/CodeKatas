require 'spec_helper'

describe EventsController do
  subject { get :index, params.merge(unwanted) }

  let(:current_user) { User.create!(name: 'John Doe') }
  let(:event_category) { EventCategory.new(name: 'TestCategory') }
  let(:event) { Event.new(name: 'AEvent', event_category: event_category) }

  let(:unwanted) { { 'unwanted' => 'Active Model mass assignments' } }
  let(:params) {
    {
      'filter' => { 'event_category_id' => '14', 'type' => 'valid' },
      'sort' => 'event_categories.name',
      'query' => 'Test String'
    }
  }

  before do
    current_user.events << event

    allow(EventFilter).to receive(:call).
      with(current_user.events, params) { [event] }
  end

  it { should be_success }

  it 'renders index template' do
    expect(subject).to render_template(:index)
  end

  it 'assigns event categories with id and name only' do
    subject
    assigns(:event_categories).first.tap do |record|
      expect(record.as_json).to eq({'id' => 1, 'name' => 'TestCategory'})
    end
  end

  it 'assigns events' do
    subject
    expect(assigns(:events)).to eq([event])
  end
end
