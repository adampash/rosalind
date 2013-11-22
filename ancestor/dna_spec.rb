class DNA
  def self.format(data_set)
    data_set.split(/>.+\n/).map do |s|
      s.strip.gsub("\n", '')
    end[1..-1]
  end

  def self.transpose(array)
    new_array = []
    until array.empty?
      if new_array.empty?
        new_array = array.shift.split(//)
      else
        new_array = new_array.zip(array.shift.split(//))
      end
    end
    new_array.map(&:join)
  end

  def self.profile(data)
    data.reduce([]) do |a, line|
      unless line.nil?
        a << line.count("A")
        a << line.count("C")
        a << line.count("G")
        a << line.count("T")
        a
      end
    end
  end

  def self.prettify(array)
    a = 'A:'
    g = 'G:'
    c = 'C:'
    t = 'T:'
    until array.empty?
      a << " " + array.shift.to_s
      c << " " + array.shift.to_s
      g << " " + array.shift.to_s
      t << " " + array.shift.to_s
    end
    a + "\n" + c + "\n" + g + "\n" + t
  end

  def self.consensus(array)
    key = ["A", "C", "G", "T"]
    string = ''
    array.each_slice(4) do |group|
      string << key[group.index(group.max)]
    end
    string
  end

  def self.prepare(data_set)
    transpose(format(data_set))
  end
end

describe DNA do

  it "returns a pretty profile and consensus" do
    data_set = File.read('sample.txt').strip
    prepared = DNA.prepare(data_set)
    results = DNA.profile(prepared)
    string = DNA.consensus(results)
    string << "\n" + DNA.prettify(results)
    correct_result = File.read('sample_result.txt').strip
    expect(string).to eq correct_result
  end

  it "counts frequency of ATCG strings at positions" do
    data_set = ">Rosalind_1\nATCCAGCT\n>Rosalind_2\nGGGCAACT\n>Rosalind_3\nATGGATCT\n>Rosalind_4\nAAGCAACC\n>Rosalind_5\nTTGGAACT\n>Rosalind_6\nATGCCATT\n>Rosalind_7\nATGGCACT"
    formatted_data = DNA.transpose(DNA.format(data_set))
    expect(DNA.profile([formatted_data[0]])).to eq [5, 0, 1, 1]
  end

  it "turns a rosalind string into an array of strings" do
    data_set = ">Rosalind_1\nATCCA\nGCT\n>Rosalind_2\nGGGCAACT\n>Rosalind_3\nATGGATCT\n>Rosalind_4\nAAGCAACC\n>Rosalind_5\nTTGGAACT\n>Rosalind_6\nATGCCATT\n>Rosalind_7\nATGGCACT"
    expect(DNA.format(data_set)).to eq(["ATCCAGCT", "GGGCAACT","ATGGATCT","AAGCAACC","TTGGAACT","ATGCCATT","ATGGCACT"])
  end

  it "transposes arrays of equal-length strings" do
    data = ["ATC", "GGG"]
    expect(DNA.transpose(data)).to eq(["AG", "TG", "CG"])
  end
end

require 'clipboard'
data_set = File.read('rosalind_cons.txt').strip
prepared = DNA.prepare(data_set)
results = DNA.profile(prepared)
string = DNA.consensus(results)
string << "\n" + DNA.prettify(results)
Clipboard.copy string
