require 'rspec'
require 'clipboard'

class DNA
  def self.transcribe(dna_string)
    dna_string.gsub(/T/, 'U')
  end
end
describe DNA do
  it "transcribes a DNA string to RNA" do
    rna = DNA.transcribe("GATGGAACTTGACTACGTAAATT")
    expect(rna).to eq "GAUGGAACUUGACUACGUAAAUU"
  end
end

dna_string = File.read('rosalind_rna.txt').strip
p DNA.transcribe(dna_string)
