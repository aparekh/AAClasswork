def my_unique(array)
    uniqued_array = []

    array.each do |item|
        uniqued_array << item unless uniqued_array.include?(item)
    end

    uniqued_array
end

def two_sum(array)
    two_sum_pairs = []

    array.each_index do |idx1|
        idx2 = idx1 + 1
        while idx2 < array.length
            two_sum_pairs << [idx1, idx2] if array[idx1] + array[idx2] == 0
            idx2 += 1
        end
    end

    two_sum_pairs
end

def my_transpose(matrix)
    transposed_matrix = []
    
    idx2 = 0
    while idx2 < matrix.length
        transposed_row = []
        idx1 = 0
        while idx1 < matrix.length
            transposed_row << matrix[idx1][idx2]
            idx1 += 1
        end
        transposed_matrix << transposed_row
        idx2 += 1
    end

    transposed_matrix
end

def pick_stocks(prices)
    max_profit = 0
    price_idx1 = nil
    price_idx2 = nil

    prices.each_index do |idx1|
        idx2 = idx1 + 1
        
        while idx2 < prices.length
            profit = prices[idx2] - prices[idx1]
            
            if profit > max_profit
                max_profit = profit
                price_idx1 = idx1
                price_idx2 = idx2
            end
            
            idx2 += 1
        end
    end

    return nil if max_profit == 0
    [price_idx1, price_idx2]
end