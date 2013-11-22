require 'clipboard'

class Mendel
  def self.dominance_probability(homo_dom, hetero, homo_rec)
    total = homo_dom + hetero + homo_rec + 0.0
    total_dominant = homo_dom + hetero
    pro_rec_to_dom = (homo_dom/total * total_dominant/(total - 1))
    total_dominant/total + pro_rec_to_dom
  end
end
describe Mendel do
  it "calculates probability of dominant alleles" do
    dominance_probability = Mendel.dominance_probability(2, 2, 2)
    expect("%0.05f" % dominance_probability).to eq "0.78333"
  end
end

types = File.read('rosalind_iprb.txt').split(' ')
Clipboard.copy Mendel.dominance_probability(types[0].to_i, types[1].to_i, types[2].to_i)
