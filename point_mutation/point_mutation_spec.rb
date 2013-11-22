class DNA

  def self.point_mutation(string, other_string)
    string = string.split(//)
    other_string = other_string.split(//)
    hamming = 0
    string.each_with_index do |base, index|
      hamming += 1 if base != other_string[index]
    end
    hamming
  end

  # FASTER
  def self.point_mutation_2(string, other_string)
    hamming = 0

    i = 0
    while i < string.length
      hamming += 1 unless string[i] == other_string[i]
      i += 1
    end
    hamming
  end
end

describe DNA do
  it "counts the point mutation between two strings" do
    10000.times do
      hamming = DNA.point_mutation("GAGCCTACTAACGGGAT", "CATCGTAATGACGGCCT")
      expect(hamming).to eq 7
    end
  end

  it "#point_mutation_2 counts the point mutation between two strings" do
    10000.times do
      hamming = DNA.point_mutation_2("GAGCCTACTAACGGGAT", "CATCGTAATGACGGCCT")
      expect(hamming).to eq 7
    end
  end
end

f = File.read('rosalind_hamm.txt')
strings = f.split("\n")
p DNA.point_mutation(strings.first, strings.last)
