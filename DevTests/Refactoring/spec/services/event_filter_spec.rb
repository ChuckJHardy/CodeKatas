require 'spec_helper'

describe EventFilter do
  let!(:time) { Time.parse('2014-05-08 20:01:51.429819') }
  let(:params) { {} }

  let(:select) {
    %Q{SELECT events.id, events.user_id, events.name, created_by, starts_at, ends_at, event_category_id, active FROM "events"}
  }

  let(:join) {
    %Q{INNER JOIN "event_categories" ON "event_categories"."id" = "events"."event_category_id"}
  }

  let(:valid) { %Q{WHERE (starts_at > '2014-05-08 19:01:51.429819')} }
  let(:order) { %Q{ORDER BY events.id, events.name ASC} }

  before do
    allow(Time).to receive(:current) { time }
  end

  describe '.call' do
    subject { described_class.call(Event, params) }

    it 'returns ActiveRecord::Relation Object' do
      expect(subject).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'when no params passed' do
      it 'queries with expected sql' do
        expect(subject.to_sql).to eq("#{select} #{join}  #{order}")
      end
    end

    context 'when sort' do
      let(:params) { { sort: 'event_categories.name' } }
      let(:order) { %Q{ORDER BY event_categories.name, events.name ASC} }

      it 'queries with expected sql' do
        expect(subject.to_sql).to eq("#{select} #{join}  #{order}")
      end
    end

    context 'when type' do
      context 'with a valid method' do
        let(:params) { { filters: { type: :valid } } }

        it 'queries with expected sql' do
          expect(subject.to_sql).to eq(%Q{#{select} #{join} #{valid}  #{order}})
        end
      end

      context 'with an invalid method' do
        let(:params) { { filters: { type: :test } } }

        it 'queries with expected sql' do
          expect(subject.to_sql).to eq(%Q{#{select} #{join} #{valid}  #{order}})
        end
      end
    end

    context 'when category id' do
      let(:params) { { filters: { event_category_id: 14 } } }

      it 'queries with expected sql' do
        expect(subject.to_sql).to eq(
          %Q{#{select} #{join} #{valid} AND "events"."event_category_id" = 14  #{order}}
        )
      end
    end

    context 'when text search' do
      let(:params) { { query: 'Test String' } }

      it 'queries with expected sql' do
        expect(subject.to_sql).to eq(
          %Q{#{select} #{join} WHERE (name LIKE %'Test String'%)  #{order}}
        )
      end
    end
  end
end
