require 'rails_helper'

RSpec.describe 'Posts', type: :request, performance: true do
  let(:posts) { 100_00 }
  let(:hits) { posts / 10 }

  let(:user) { create(:user) }

  it 'average response is acceptable during pagination' do
    ActiveRecord::Base.transaction { posts.times { create(:post, user: user) } }

    results = hits.times.inject([]) do |acc, page|
      print '.'
      acc << Benchmark.realtime do
        get posts_path(format: :json, per_page: 10, page: page)
      end
    end

    average = results.sum / results.size.to_f
    expect(average).to be < 0.1

    puts "\nResults for #{posts} posts over #{hits} requests (seconds):"
    puts "Min: #{results.min}"
    puts "Max: #{results.max}"
    puts "Average: #{average}"
  end
end
