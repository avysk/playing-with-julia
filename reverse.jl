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

for (input, expected) in (
    (0, 0),
    (1, 1),
    (-2, -2),
    (12345, 54321),
    (-12345, -54321),
    (2^31-1, 0),
    (-2^31, 0),
    (-2147483641, -1463847412),
    (2147483641, 1463847412),
    (-2147483642, 0),
    (2147483642, 0))
    @assert reverse(convert(Int32, input)) == expected
    println("Got $expected for $input")
end
