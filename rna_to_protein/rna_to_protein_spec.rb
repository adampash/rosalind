require 'clipboard'

class DNA

  def initialize(method_1=true)
    raw_codon = File.read('codon_table.txt').strip
    if method_1
      @codon = parse(raw_codon)
    else
      @codon = parse_2(raw_codon)
    end
  end

  def parse(raw_codon)
    codon_array = raw_codon.split(/\s+/)
    codon_cypher = {}
    codon_array.each_slice(2) do |pair|
      codon_cypher[pair[0].to_sym] = pair[1]
    end
    codon_cypher
  end

  def to_protein(string)
    i = 0
    protein = ''
    while i < string.length
      letter = @codon[string[i...i+3].to_sym]
      unless letter == "Stop"
        protein << letter
      else
        break
      end
      i += 3
    end
    protein
  end

  def parse_2(raw_codon)
    codon_array = raw_codon.split(/\s+/)
    codon_cypher = {}
    codon_array.each_slice(2) do |pair|
      codon_cypher[pair[0]] = pair[1]
    end
    codon_cypher
  end

  def to_protein_2(string)
    i = 0
    protein = ''
    while i < string.length
      letter = @codon[string[i...i+3]]
      unless letter == "Stop"
        protein << letter
      else
        break
      end
      i += 3
    end
    protein
  end
end
describe DNA do
  it "#parse encodes RNA to protein strings" do
    dna = DNA.new
    100000.times do
      protien = dna.to_protein("AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA")
      expect(protien).to eq "MAMAPRTEINSTRING"
    end
  end

  it "#parse_2 encodes RNA to protein strings" do
    dna = DNA.new(false)
    100000.times do
      protien = dna.to_protein_2("AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA")
      expect(protien).to eq "MAMAPRTEINSTRING"
    end
  end
end

rna_string = File.read('rosalind_prot.txt').strip
dna = DNA.new

Clipboard.copy dna.to_protein(rna_string)
