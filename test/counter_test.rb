require 'test_helper'

describe Von::Counter do
  Counter = Von::Counter

  before :each do
    Timecop.freeze(Time.local(2013, 01, 01, 01, 01))
    Von.config.init!
    @redis = Redis.new
    @redis.flushall
  end

  it "increments the total counter if given a single key" do
    counter = Counter.new('foo')

    counter.increment
    @redis.hget('von:counters:foo', 'total').must_equal '1'

    counter.increment
    @redis.hget('von:counters:foo', 'total').must_equal '2'
  end

  it "gets a total count for a counter" do
    counter = Counter.new('foo')
    counter.increment
    counter.increment
    counter.increment

    counter.count.must_equal 3
  end


end
