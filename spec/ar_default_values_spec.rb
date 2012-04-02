require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Book < ActiveRecord::Base
  attr_protected :edition

  default_values price: 0, edition: 1, released_at: lambda { Time.now }
end

class Book2 < ActiveRecord::Base
  self.table_name = :books

  default_values price: 0 do
    t = Time.now
    {:released_at => t }
  end
end

describe "ArDefaultValues" do
  subject { @sample }
  before do
    @now = Time.at(Time.now.to_i)
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
      @sample = Book.new do |t|
        t.title = 'foo'
      end
    end
    its(:title) { should == 'foo' }
    its(:price) { should == 0 }
    its(:edition) { should == 1 }
    its(:released_at) { should == @now }
  end

  context :consider_attr_protected do
    before do
      @sample = Book2.new(:edition => 3)
    end
    its(:title) { should be_nil }
    its(:price) { should == 0 }
    its(:edition) { should == 3 }
    its(:released_at) { should == @now }
  end
end
