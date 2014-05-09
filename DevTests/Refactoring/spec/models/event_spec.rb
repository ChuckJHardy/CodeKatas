require 'spec_helper'

describe Event do
  describe '.category' do
    subject { described_class.category(14) }

    it 'returns an ActiveRecord::Relation object' do
      expect(subject).to be_a_kind_of(ActiveRecord::Relation)
    end

    it 'using expected sql query' do
      expect(subject.to_sql).to include('"event_category_id" = 14')
    end
  end
end
