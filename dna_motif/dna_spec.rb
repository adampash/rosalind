class DNA
  def self.motif(initial_string, test_string, acc=[])
    match = initial_string.index(test_string)
    if match.nil?
      return acc
    else
      initial_string.slice!(0..match)
      new_index =  match + 1
      new_index += acc.last unless acc.last.nil?
      acc << new_index
      motif(initial_string, test_string, acc)
    end
  end
end
describe DNA do
  it "returns indexes of substrings" do
    initial_string = "GATATATGCATATACTT"
    test_string = "ATAT"
    expect(DNA.motif(initial_string, test_string)).to eq([2, 4, 10])
  end
end

require 'clipboard'
f = File.read('rosalind_subs.txt').strip
initial_string, test_string = f.split("\n")
Clipboard.copy DNA.motif(initial_string, test_string)
