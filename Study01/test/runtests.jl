using Study01
using Test

@testset "twosum" begin
    # Write your tests here.

    # 5 + 5 = 10
    res = Study01.twosum([1, 5, 2, 5, 10], 10)
    @test res == [2, 4] || res == [4, 2]

    # 2 + 8 = 10
    res = Study01.twosum([1, 2, 3, 4, 8, 11, 22], 10)
    @test res == [2, 5] || res == [5, 2]

    # 3 + 7 = 10
    res = Study01.twosum([1, 2, 3, 5, 7, 10, 20], 10)
    @test res == [3, 5] || res == [5, 3]

    # No solution
    @test_throws AssertionError Study01.twosum([1, 2, 3, 4, 5], 10)

end

@testset "reverse" begin
    for (input, expected) in (
        (0, 0),
        (1, 1),
        (-2, -2),
        (12345, 54321),
        (-12345, -54321),
        (2^31 - 1, 0),
        (-2^31, 0),
        (-2147483641, -1463847412),
        (2147483641, 1463847412),
        (-2147483642, 0),
        (2147483642, 0),
    )
        @test Study01.reverse(convert(Int32, input)) == expected
    end
end
