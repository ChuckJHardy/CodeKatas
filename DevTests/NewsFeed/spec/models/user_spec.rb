require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:avatar).of_type(:string).with_options(null: false) }

  it do
    should have_db_column(:latitude).of_type(:decimal)
      .with_options(precision: 7, scale: 4, null: false)
  end

  it do
    should have_db_column(:longitude).of_type(:decimal)
      .with_options(precision: 7, scale: 4, null: false)
  end
end
