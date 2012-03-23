require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class Sample < ActiveRecord::Base

  define_attribute_methods ['foo', 'bar', 'buzz', 'other']
  attr_accessor :foo, :bar, :buzz, :other

  default_values do
    lambda do
      {
        :foo => 'foo',
        :bar => 'bar',
        :time => Time.now
      }
    end
  end
end

describe "ArDefaultValues" do
  subject { @sample }
  before do
    @t = Time.now
    Time.stub(:now).and_return(@t)
    @sample = Sample.new(:bar => 'test')
  end
  its(:foo) { should == 'foo' }
  its(:bar) { should == 'test' }
  its(:buzz) { should be_nil }
  its(:time) { should == @t }
end
