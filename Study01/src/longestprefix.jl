#=
        Problem 14: Longest common prefix

        Write a function to find the longest common prefix string amongst an
        array of strings.

        If there is no common prefix, return an empty string "".
=#

function longestprefix(input::Vector{String})
    # A lot of different optimizations is possible for this function.
    # None are done.

    if length(input) == 0
        return ""
    end

    sortedinput = sort(input, by = length)

    prefix = sortedinput[1]
    if prefix == ""
        # no reason to check anything
        return ""
    end

    for next ∈ sortedinput[2:end]
        for (idx, (pchar, nchar)) in enumerate(zip(prefix, next))
            if pchar != nchar
                if idx == 1
                    return ""
                end
                prefix = prefix[1:(idx - 1)]
                break
            end
        end
    end

    prefix
end
