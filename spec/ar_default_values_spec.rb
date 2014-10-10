require 'rails_helper'

class Book1 < Book
  attr_protected :edition if Rails.version.to_i < 4

  default_values price: 0, edition: 1, released_at: -> { Time.now }
end

class Book2 < Book
  self.table_name = :books
  attr_protected :edition if Rails.version.to_i < 4
  default_values price: 0, edition: 1 do
    t = Time.now
    { released_at: t }
  end
end

class Book3 < Book
  self.table_name = :books
  attr_accessible :price if Rails.version.to_i < 4
  default_values price: 0, edition: 1, released_at: -> { Time.now }
end

describe DefaultValues do
  let!(:now) { Time.at(Time.now.to_i) }

  subject { @sample }
  describe 'fixed default_values' do
    before { allow(Time).to receive(:now).and_return(now) }
    context 'without attributes' do
      subject { Book1.new }
      its(:title) { is_expected.to be_nil }
      its(:price) { is_expected.to eq 0 }
      its(:edition) { is_expected.to eq 1 }
      its(:released_at) { is_expected.to eq now }
    end

    context 'with attributes' do
      subject { Book1.new(price: 100) }
      its(:title) { is_expected.to be_nil }
      its(:price) { is_expected.to eq 100 }
      its(:edition) { is_expected.to eq 1 }
      its(:released_at) { is_expected.to eq now }
    end
    context 'with block' do
      subject do
        Book1.new do |t|
          t.title = 'foo'
        end
      end
      its(:title) { is_expected.to eq 'foo' }
      its(:price) { is_expected.to eq 0 }
      its(:edition) { is_expected.to eq 1 }
      its(:released_at) { is_expected.to eq now }
    end

    if Rails.version.to_i < 4
      describe 'consider attr_protected' do
        subject { Book1.new(edition: 3) }
        its(:title) { is_expected.to be_nil }
        its(:price) { is_expected.to eq 0 }
        its(:edition) { is_expected.to eq 1 }
        its(:released_at) { is_expected.to eq now }
      end
    end
  end

  describe 'instance values with block' do
    subject { Book2.new }
    before do
      sleep 1
      @target = Book2.new
    end
    its(:released_at) { is_expected.not_to eq @target.released_at }
  end

  context 'both attr_accessible and attr_protected' do
    subject { Book3.new(price: 150) }
    its(:price) { is_expected.to eq 150 }
    its(:edition) { is_expected.to eq 1 }
  end
end
