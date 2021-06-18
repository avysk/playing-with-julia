using FRBTree
using Test
using DataStructures

function filltree(n::Int64)::FRBTree.RBTree{Int64}
    tree = EmptyRBTree{Int64}()
    for idx = 1:n
        tree = push(2 * idx, tree)
    end
    for idx = 1:n
        tree = push(2 * idx + 1, tree)
    end
    return tree
end

function filltreeds(n::Int64)::RBTree{Int64}
    tree = RBTree{Int64}()
    for idx = 1:n
        push!(tree, 2 * idx)
    end
    for idx = 1:n
        push!(tree, 2 * idx + 1)
    end
    return tree
end


function checkinvariants(
    tree::Union{FRBTree.RBTree{Int64},Nothing},
    depth::Int64,
    canbered::Bool,
)
    if isnothing(tree)
        @test depth == 0
        return
    end
    isblack = (tree.color == FRBTree.Types.black)
    @test canbered || isblack
    newdepth = if isblack
        depth - 1
    else
        depth
    end
    checkinvariants(tree.left, newdepth, isblack)
    checkinvariants(tree.right, newdepth, isblack)
end

@testset "invariants" begin
    tree = filltree(1000)

    count = 0

    cur = tree
    while !isnothing(cur)
        if cur.color == FRBTree.Types.black
            count += 1
        end
        cur = cur.left
    end

    checkinvariants(tree, count, false)

end

@testset "time" begin
    @time filltree(10000)
    @time filltreeds(10000)
end