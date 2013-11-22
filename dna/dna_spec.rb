class DNACounter
  attr_reader :pairs

  # extend Forwardable
  # def_delegator :@counter, :A, :C, :G, :T

  def initialize(dna_string)
    @dna_array = dna_string.split(//)
    @pairs = {A: 0, C: 0, G: 0, T: 0}
    count
  end

  def count
    @dna_array.each do |base|
      @pairs[base.to_sym] += 1
    end
  end
end

describe DNACounter do
  let(:dna) { "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"}
  it "should count number of A" do
    counter = DNACounter.new(dna)
    expect(counter.pairs[:A]).to eq 20
  end

  it "should count number of C" do
    counter = DNACounter.new(dna)
    expect(counter.pairs[:C]).to eq 12
  end
  it "should count number of G" do
    counter = DNACounter.new(dna)
    expect(counter.pairs[:G]).to eq 17
  end
  it "should count number of T" do
    counter = DNACounter.new(dna)
    expect(counter.pairs[:T]).to eq 21
  end
end


dna_string = File.read('rosalind_dna.txt').strip
counter = DNACounter.new(dna_string)
p "#{counter.pairs[:A]} #{counter.pairs[:C]} #{counter.pairs[:G]} #{counter.pairs[:T]}"
