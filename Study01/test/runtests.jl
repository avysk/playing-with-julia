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
    for (input, expected) ∈ (
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

@testset "palindrome" begin
    for input ∈ (0, 1, 22, 343, 9876789)
        @test Study01.palindrome(input)
    end
end

@testset "!palindrome" begin
    for input ∈ (10, 233, 9876879)
        @test !Study01.palindrome(input)
    end
end

@testset "roman" begin
    for (input, expected) ∈ (
        ("I", 1),
        ("III", 3),
        ("IV", 4),
        ("V", 5),
        ("VII", 7),
        ("IX", 9),
        ("X", 10),
        ("XIV", 14),
        ("XVI", 16),
        ("XL", 40),
        ("XLIV", 44),
        ("L", 50),
        ("LIX", 59),
        ("XC", 90),
        ("CXC", 190),
        ("C", 100),
        ("CD", 400),
        ("CDXCIV", 494),
        ("D", 500),
        ("CM", 900),
        ("M", 1000),
    )
        @test Study01.roman2integer(input) == expected
        @test Study01.roman2integer("M" * input) == 1000 + expected
    end
end

@testset "prefix" begin
    for (input, expected) ∈ (
        (String[], ""),
        (["foobar"], "foobar"),
        (["foobar", "fooba", "foob", "foo", "fo", "fob", "foba", "fobaz"], "fo"),
        (["foo", "bar"], ""),
        (["foobar", "foobaz", "fooqux", ""], ""),
        (["fooone", "footwo", "foothree", "foofour", "foofive"], "foo"),
        (["foobar", "foobaz", "faabar"], "f")
    )
        @test Study01.longestprefix(input) == expected
    end
end
