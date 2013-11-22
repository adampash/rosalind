class DNA
  def self.rev_comp(dna_string)
    dna_array = dna_string.split(//)
    dna_array.map! do |base|
      case base
      when "A"
        "T"
      when "C"
        "G"
      when "T"
        "A"
      when "G"
        "C"
      end
    end
    dna_array.join.reverse
  end

  def self.rev_comp_2(dna_string)
    cypher = {A: "T", G: "C", T: "A", C: "G"}
    dna_array = dna_string.split(//)
    complement = ''
    dna_array.map! do |base|
      complement << cypher[base.to_sym]
    end
    complement.reverse
  end

  def self.rev_comp_3(dna_string)
    dna_string.gsub!(/\w/) do |base|
      case base
      when "A"
        "T"
      when "C"
        "G"
      when "T"
        "A"
      when "G"
        "C"
      end
    end
    dna_string.reverse
  end
end

describe DNA do
  it "returns the reverse compliment" do
    10000.times do
      dna_string = "AAAACCCGGT"
      rev_comp = DNA.rev_comp(dna_string)
      expect(rev_comp).to eq "ACCGGGTTTT"
    end
  end

  it "returns the reverse compliment with symbols" do
    10000.times do
      dna_string = "AAAACCCGGT"
      rev_comp = DNA.rev_comp_2(dna_string)
      expect(rev_comp).to eq "ACCGGGTTTT"
    end
  end

  it "returns the reverse compliment with gsub" do
    10000.times do
      dna_string = "AAAACCCGGT"
      rev_comp = DNA.rev_comp_3(dna_string)
      expect(rev_comp).to eq "ACCGGGTTTT"
    end
  end
end

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end
#
# dna_string = File.read('rosalind_revc.txt').strip
# p DNA.rev_comp(dna_string)
