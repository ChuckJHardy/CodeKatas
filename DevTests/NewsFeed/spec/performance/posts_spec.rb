require 'rails_helper'

RSpec.describe 'Posts', type: :request, performance: true do
  let(:posts) { 100_000_0 }
  let(:hits) { posts / 10 }

  let(:user) { create(:user) }

  it 'average response is acceptable during pagination' do
    ActiveRecord::Base.transaction { posts.times { create(:post, user: user) } }

    results = hits.times.inject([]) do |acc, page|
      acc << Benchmark.realtime do
        get posts_path(format: :json, per_page: 10, page: page)
      end
    end

    expect(results.sum / results.size.to_f).to be < 0.1
  end
end
