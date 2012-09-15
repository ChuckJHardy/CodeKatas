require 'rspec'
require_relative '../jobs'

describe Error do
  context 'SelfDependentError' do
    let(:expected_response) { "Jobs can't depend on themselves." }

    subject { Error::SelfDependencyError.new }

    it 'raises with expected message' do
      subject.message.should eql(expected_response)
    end
  end

  context 'CircularDependencyError' do
    let(:expected_response) { "Jobs can't have circular dependencies." }

    subject { Error::CircularDependencyError.new }

    it 'raises with expected message' do
      subject.message.should eql(expected_response)
    end
  end
end

describe Jobs do
  let(:jobs) { Jobs.new(arg) }

  context '#new' do
    let(:arg) { 'a' }

    subject { jobs }

    it 'takes a String argument' do
      subject
    end
  end

  context '#collect' do
    context 'without dependencies' do
      let(:arg) { 'a' }
      let(:expected_response) { %w[a] }

      subject { jobs.collect }

      it 'returns array of jobs' do
        subject.should eql(expected_response)
      end
    end

    context 'with dependencies' do
      let(:arg) { 'a => b, c => d, e, c' }
      let(:expected_response) { %w[b a d c e] }

      subject { jobs.collect }

      it 'returns array of jobs' do
        subject.should eql(expected_response)
      end
    end
  end

  context '#sequence' do
    context 'Valid' do
      let(:arg) { 'a => b, c => d' }
      let(:expected_response) { 'badc' }

      subject { jobs.sequence }

      it 'returns string of sequenced jobs' do
        subject.should eql(expected_response)
      end
    end

    context 'Circular Dependency Error' do
      let(:arg) { 'a, b => c, c => f, d => a, e, f => b' }
      let(:error_msg) { "Jobs can't have circular dependencies." }

      subject { jobs.sequence }

      it 'returns string of sequenced jobs' do
        expect { subject }.to raise_error(Error::CircularDependencyError, error_msg)
      end
    end
  end
end

describe JobCollection do
  let(:job_collection) { JobCollection.new(arg) }

  context '#new' do
    let(:arg) { 'a' }

    subject { job_collection }

    it 'takes a string argument' do
      subject
    end
  end

  context '#jobs' do
    let(:arg) { 'a' }

    subject { job_collection.jobs }

    it 'return an array' do
      subject.should be_an_instance_of(Array)
    end

    it 'returns an array of Job Objects' do
      subject.first.should be_an_instance_of(Job)
    end
  end
end

describe Job do
  let(:job) { Job.new(arg) }

  subject { job }

  context '#job' do
    context 'without dependency' do
      let(:arg) { 'a' }

      it 'returns job object with a job' do
        subject.job.should eql(arg)
      end
    end

    context 'with dependency' do
      let(:given_job) { 'a' }
      let(:dependency) { 'b' }
      let(:arg) { "#{given_job} => #{dependency}" }

      it 'returns job object with a job' do
        subject.job.should eql(given_job)
      end
    end
  end

  context '#dependency' do
    context 'without dependency' do
      let(:arg) { 'a' }

      it 'returns job object with nil dependency' do
        subject.dependency.should be_nil
      end
    end

    context 'with dependency' do
      let(:given_job) { 'a' }
      let(:dependency) { 'b' }
      let(:arg) { "#{given_job} => #{dependency}" }

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
