class DNA
  def self.gc_content(gc)
    id = gc.match(/>(\w+_\d+)/)[1]
    dna_string = gc.split("\n")
    dna_string.shift
    dna_string = dna_string.join
    percent = ((dna_string.count("CG") * 1.0) / dna_string.length * 1.0) * 100
    gc_content = {id: id, gc_content: percent}
  end

  def self.find_hightest_gc(dataset)
    gc_sets = dataset.split(">").map {|s| ">#{s}" }
    gc_sets.shift

    gc_sets.map! do |gc|
      gc_content(gc)
    end

    gc_sets.max_by do |gc|
      gc[:gc_content]
    end
  end
end
describe DNA do
  let(:gc) { ">Rosalind_0808\nCCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT" }
  let(:dataset) { ">Rosalind_0808\nCCACCCT\nCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT\n>Rosalind_6404\nCCTGCG\nGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG\n>Rosalind_5959\nCCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCTATATCCATTTGTCAGCAGACACGC" }
  it "should analyze GC content" do
    result = DNA.gc_content(gc)
    expect(result[:id]).to eq "Rosalind_0808"
    expect("%0.06f" % result[:gc_content]).to eq "60.919540"
  end

  it "should return the sequence with the greatest GC content" do
    result = DNA.find_hightest_gc(dataset)
    expect(result[:id]).to eq "Rosalind_0808"
    expect("%0.06f" % result[:gc_content]).to eq "60.919540"
  end
end

dataset = File.read('rosalind_gc.txt')
result = DNA.find_hightest_gc(dataset)
puts "#{result[:id]}"
puts "%0.06f" % result[:gc_content]
