class FibRabbit

  def self.multiply_2(months, fertility)
    @pairs = [1, 1]
    @fertility = fertility
    @i = 2
    until @i == months
      @pairs << @pairs[-2] * @fertility + @pairs.last
      @i += 1
    end
    @pairs.last
  end

  def self.multiply(months, fertility)
    @pairs = [1, 1]
    @fertility = fertility
    @i = 2
    until @i == months
      last_month = @pairs[1]
      this_month = @pairs[0] * @fertility + last_month
      @pairs[0] = last_month
      @pairs[1] = this_month
      @i += 1
    end
    @pairs.last
  end

end

describe FibRabbit do
  it "should multiply as expected" do
    100000.times do
      rabbits = FibRabbit.multiply(5, 3)
      expect(rabbits).to eq 19
    end
  end

  it "should multiply_2 as expected" do
    100000.times do
      rabbits = FibRabbit.multiply_2(5, 3)
      expect(rabbits).to eq 19
    end
  end

end

p FibRabbit.multiply_2(33, 5)
