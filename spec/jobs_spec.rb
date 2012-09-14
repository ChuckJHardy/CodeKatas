require 'rspec'
require 'jobs'

describe Job do
  let(:job) { Job.new(arg) }

  context '#new' do
    subject { job }

    context 'without dependency' do
      let(:arg) { 'a' }

      it 'returns job object with a job' do
        subject.job.should eql(arg)
      end

      it 'returns job object with nil dependency' do
        subject.dependency.should be_nil
      end
    end

    context 'with dependency' do
      let(:given_job) { 'a' }
      let(:dependency) { 'b' }
      let(:arg) { "#{given_job} => #{dependency}" }

      it 'returns job object with a job' do
        subject.job.should eql(given_job)
      end

      it 'returns job object with a dependency' do
        subject.dependency.should eql(dependency)
      end
    end
  end

  context '#dependency?' do
    subject { job.dependency? }

    context 'without job dependency' do
      let(:arg) { 'a' }

      it 'returns false' do
        subject.should be_false
      end
    end

    context 'with job dependency' do
      let(:dependency) { 'b' }
      let(:arg) { "a => #{dependency}" }

      it 'returns true' do
        subject.should be_true
      end
    end
  end
end
