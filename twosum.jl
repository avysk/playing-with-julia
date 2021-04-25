function twosum(nums::Vector{Int64}, target::Int64)
    numdict = Dict()

    for (idx, num) in enumerate(nums)

        if num ∈ keys(numdict)
            # we already processed this number
            if num == target / 2
                # half of the target in different places
                return [idx, numdict[num]]
            end
            continue
        end

        pair = target - num
        if pair ∈ keys(numdict)
            return [idx, numdict[pair]]
        end

        numdict[num] = idx
    end

    @assert false "No solution"
end


# 5 + 5 = 10
res = twosum([1, 5, 2, 5, 10], 10)
println(res)
@assert res == [2, 4] || res == [4, 2]

# 2 + 8 = 10
res = twosum([1, 2, 3, 4, 8, 11, 22], 10)
println(res)
@assert res == [2, 5] || res == [5, 2]

# 3 + 7 = 10
res = twosum([1, 2, 3, 5, 7, 10, 20], 10)
println(res)
@assert res == [3, 5] || res == [5, 3]

# No solution
println("The following must fail")
twosum([1, 2, 3, 4, 5], 10)
