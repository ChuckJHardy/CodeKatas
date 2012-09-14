require 'rspec'
require_relative '../jobs'

describe 'Acceptance Tests' do
  subject { Jobs.new(given_structure) }

  context 'No Jobs' do
    let(:given_structure) { '' }
    let(:expected_response) { '' }

    it 'returns empty sequence' do
      subject.should eql(expected_response)
    end
  end

  context 'No Dependencies' do
    context 'Single Job' do
      let(:given_structure) { 'a' }
      let(:expected_response) { 'a' }

      it 'returns sequence consisting of a single job' do
        subject.should eql(expected_response)
      end
    end

    context 'Multiple Jobs' do
      let(:given_structure) { 'abc' }
      let(:expected_response) { 'abc' }

      it 'returns sequence consisting of all jobs' do
        subject.should eql(expected_response)
      end
    end
  end

  context 'Dependencies' do
    context 'Single' do
      let(:given_structure) { 'ab => cc' }
      let(:expected_response) { 'acb' }

      it 'returns sequence of jobs in expected order' do
        subject.should eql(expected_response)
      end
    end

    context 'Multiple' do
      let(:given_structure) { 'ab => cc => fd => ae => bf' }
      let(:expected_response) { 'adfcbef' }

      it 'returns sequence of jobs in expected order' do
        subject.should eql(expected_response)
      end
    end

    context 'On Self' do
      let(:given_structure) { 'abc => c' }
      let(:expected_response) { "Jobs can't depend on themselves." }

      it 'returns expected error' do
        subject.should eql(expected_response)
      end
    end

    context 'Circular' do
      let(:given_structure) { 'ab => cc => fd => aef => b' }
      let(:expected_response) { "jobs can't have circular dependencies." }

      it 'returns expected error' do
        subject.should eql(expected_response)
      end
    end
  end
end
