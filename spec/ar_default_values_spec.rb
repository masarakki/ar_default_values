require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class Book < ActiveRecord::Base
  default_values do
    lambda do
      {
        :price => 0,
        :edition => 1,
        :released_at => Time.now
      }
    end
  end
end

describe "ArDefaultValues" do
  subject { @sample }
  before do
    @now = Time.now
    Time.stub(:now).and_return(@now)
  end
  context :without_attributes do
    before do
      @sample = Book.new
    end
    its(:title) { should be_nil }
    its(:price) { should == 0 }
    its(:edition) { should == 1 }
    its(:released_at) { should == @now }
  end
  context :with_attributes do
    before do
      @sample = Book.new(:price => 100)
    end
    its(:title) { should be_nil }
    its(:price) { should == 100 }
    its(:edition) { should == 1 }
    its(:released_at) { should == @now }
  end
  context :with_block do
    before do
      @sample = Book.new(:edition => 3) do |t|
        t.title = 'foo'
      end
    end
    its(:title) { should == 'foo' }
    its(:price) { should == 0 }
    its(:edition) { should == 3 }
    its(:released_at) { should == @now }
  end
end
