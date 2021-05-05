#=
        Problem 07: Reverse

        Given a signed 32-bit integer x, return x with its digits reversed. If
        reversing x causes the value to go outside the signed 32-bit integer
        range [-231, 231 - 1], then return 0.

        Assume the environment does not allow you to store 64-bit integers
        (signed or unsigned).
=#

function reverse(val::Int32)::Int32
    max = 2^31 - 1

    if val == -2^31
        # cannot be reversed, 2147483648
        return 0
    end

    sign = val < 0
    if val < 0
        val = -val
    end

    res = 0
    while val > 0
        next = val % 10
        # This makes sure that res * 10 + next is within limits
        if div(max - next, 10) - res < 0
            res = 0
            break
        end
        res = res * 10 + next
        val = div(val, 10)
    end

    return sign ? -res : res
end
