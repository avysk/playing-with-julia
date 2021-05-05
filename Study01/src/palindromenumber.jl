#=
        Problem 09: Palindrome number

        Given an integer x, return true if x is palindrome integer.

        An integer is a palindrome when it reads the same backward as forward.
        For example, 121 is palindrome while 123 is not.
=#

function palindrome(number::Int64)
    palindrome_rec(string(number))
end

function palindrome_rec(string::String)
    if length(string) < 2
        # empty string and string of length 1 are palindromes
        return true
    end

    if string[1] != string[end]
        return false
    end

    # no tail call optimization in Julia 😢
    # but our numbers are not long, so no problem
    palindrome_rec(string[2:end-1])
end
