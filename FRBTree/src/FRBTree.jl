module FRBTree

include("Types.jl")

RBTree = Types.Tree
EmptyRBTree = Types.EmptyTree
export push, EmptyRBTree

using Match

function Base.in(item::T, tree::RBTree{T})::Bool where {T}
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

function lbalance(
    color::Types.Color,
    left::Types.Tree{T},
    value::T,
    right::Types.Tree{T},
)::Types.NonEmptyTree{T} where {T}
    # this function is called when "left" is a result of ins operation, so non-empty
    # also "right" is untouched, so it's balanced
    if color == Types.red || left.color == Types.black
        return Types.NonEmptyTree{T}(color, left, value, right)
    end
    if !isempty(left.left) && left.left.color == Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(
                Types.black,
                left.left.left,
                left.left.value,
                left.left.right,
            ),
            left.value,
            Types.NonEmptyTree{T}(Types.black, left.right, value, right),
        )
    elseif !isempty(left.right) && left.right.color == Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left.left, left.value, left.right.left),
            left.right.value,
            Types.NonEmptyTree{T}(Types.black, left.right.right, value, right),
        )
    end
    return Types.NonEmptyTree{T}(color, left, value, right)
end

function rbalance(
    color::Types.Color,
    left::Types.Tree{T},
    value::T,
    right::Types.Tree{T},
)::Types.NonEmptyTree{T} where {T}
    # this function is called when "right" is a result of ins operation, so non-empty
    # also "left" is untouched, so it's balanced
    if color == Types.red || right.color == Types.black
        return Types.NonEmptyTree{T}(color, left, value, right)
    end
    if !isempty(right.left) && right.left.color == Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left, value, right.left.left),
            right.left.value,
            Types.NonEmptyTree{T}(Types.black, right.left.right, right.value, right.right),
        )
    elseif !isempty(right.right) && right.right.color == Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left, value, right.left),
            right.value,
            Types.NonEmptyTree{T}(
                Types.black,
                right.right.left,
                right.right.value,
                right.right.right,
            ),
        )
    end
    return Types.NonEmptyTree{T}(color, left, value, right)
end


function ins(item::T, tree::Types.Tree{T})::Types.NonEmptyTree{T} where {T}
    @match tree begin
        Types.NonEmptyTree{T}(color, left, root, right) => if root > item
            lbalance(color, ins(item, left), root, right)
        else
            rbalance(color, left, root, ins(item, right))
        end
        Types.EmptyTree{T}() => Types.NonEmptyTree{T}(
            Types.red,
            Types.EmptyTree{T}(),
            item,
            Types.EmptyTree{T}(),
        )
    end
end

function blackify(tree::Types.NonEmptyTree{T})::Types.NonEmptyTree{T} where {T}
    Types.NonEmptyTree{T}(Types.black, tree.left, tree.value, tree.right)
end

function push(item::T, tree::RBTree{T})::RBTree{T} where {T}
    ins(item, tree) |> blackify # the root is always black
end

function Base.isempty(tree::Types.NonEmptyTree{T})::Bool where {T}
    false
end

function Base.isempty(tree::Types.EmptyTree{T})::Bool where {T}
    true
end

end