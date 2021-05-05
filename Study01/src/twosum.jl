#=
        Problem 01: Two Sum

        Given an array of integers nums and an integer target, return indices
        of the two numbers such that they add up to target.

        You may assume that each input would have exactly one solution, and you
        may not use the same element twice.

        You can return the answer in any order.
=#

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
