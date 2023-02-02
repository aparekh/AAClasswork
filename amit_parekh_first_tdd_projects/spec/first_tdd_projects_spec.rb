require 'first_tdd_projects'

describe "my_unique" do
    let(:array) { [1, 2, 1, 3, 3] }
    let(:uniqued_array) { my_unique(array.dup) }

    it "removes duplicates" do
        array.each do |item|
            expect(uniqued_array.count(item)).to eq(1)
        end
    end

    it "only contains items from original array" do
        uniqued_array.each do |item|
            expect(array).to include(item)
        end
    end

    it "does not modify original array" do
        expect { my_unique(array) }.to_not change{array}
    end
end

describe "two_sum" do
    let(:array) { [-1, 0, 2, -2, 1] }
    let(:one_zero) { [3, 0, 4] }
    let(:two_zeros) { [3, 0, 4, 0] }

    it "finds all zero-sum pairs" do 
        expect(two_sum(array)).to eq([[0, 4], [2, 3]])
    end

    it "is not confused by a single zero" do
        expect(two_sum(one_zero)).to eq([])
    end

    it "handles two zeros" do
        expect(two_sum(two_zeros)).to eq([[1, 3]])
    end
end

describe "my_transpose" do
    it "transposes a matrix" do
        matrix = [ [0, 1, 2], 
                   [3, 4, 5], 
                   [6, 7, 8] ] 

        expect(my_transpose(matrix)).to eq([ 
            [0, 3, 6], 
            [1, 4, 7], 
            [2, 5, 8] ])
    end
end

describe "pick_stocks" do
    it "finds a simple pair" do
        expect(pick_stocks([3, 1, 0, 4, 6, 9])).to eq([2, 5])
    end

    it "finds a better pair after an inferior pair" do
        expect(pick_stocks([3, 2, 5, 0, 6])).to eq([3, 4])
    end

    it "does not buy stocks in a crash" do
        expect(pick_stocks([5, 4, 3, 2 ,1])).to be_nil
    end
end