module FRBTree

include("Types.jl")

using Match

function Base.in(item::T, tree::Types.Tree{T})::Bool where {T}
    while tree != Types.EmptyTree{T}()
        if tree.value < item
            tree = tree.right
        elseif tree.value > item
            tree = tree.left
        else
            return true
        end
    end
    false
end

function balance(
    body::Tuple{Types.Color,Types.Tree{T},T,Types.Tree{T}},
)::Types.NonEmptyTree{T} where {T}
    @match body begin
        (
            Types.black,
            Types.NonEmptyTree(Types.red, Types.NonEmptyTree(Types.red, a, x, b), y, c),
            z,
            d,
        ) => Types.NonEmptyTree(
            Types.red,
            Types.NonEmptyTree(Types.black, a, x, b),
            y,
            Types.NonEmptyTree(Types.black, c, z, d),
        )
        (
            Types.black,
            Types.NonEmptyTree(Types.red, a, x, Types.NonEmptyTree(Types.red, b, y, c)),
            z,
            d,
        ) => Types.NonEmptyTree(
            Types.red,
            Types.NonEmptyTree(Types.black, a, x, b),
            y,
            Types.NonEmptyTree(Types.black, c, z, d),
        )
        (
            Types.black,
            a,
            x,
            Types.NonEmptyTree(Types.red, Types.NonEmptyTree(Types.red, b, y, c), z, d),
        ) => Types.NonEmptyTree(
            Types.red,
            Types.NonEmptyTree(Types.black, a, x, b),
            y,
            Types.NonEmptyTree(Types.black, c, z, d),
        )
        (
            Types.black,
            a,
            x,
            Types.NonEmptyTree(Types.red, b, y, Types.NonEmptyTree(Types.red, c, z, d)),
        ) => Types.NonEmptyTree(
            Types.red,
            Types.NonEmptyTree(Types.black, a, x, b),
            y,
            Types.NonEmptyTree(Types.black, c, z, d),
        )
        (color, left, value, right) => Types.NonEmptyTree(color, left, value, right)
    end
end

function ins(item::T, tree::Types.Tree{T})::Types.NonEmptyTree{T} where {T}
    @match tree begin
        Types.EmptyTree{T}() => Types.NonEmptyTree{T}(
            Types.red,
            Types.EmptyTree{T}(),
            item,
            Types.EmptyTree{T}(),
        )
        Types.NonEmptyTree{T}(color, left, root, right) => if root > item
            balance((color, ins(item, left), root, right))
        else
            balance((color, left, root, ins(item, right)))
        end
    end
end

function push(item::T, tree::Types.Tree{T})::Types.NonEmptyTree{T} where {T}
    @match ins(item, tree) begin
        Types.NonEmptyTree(_, left, root, right) =>
            Types.NonEmptyTree(Types.black, left, root, right)
    end
end

end