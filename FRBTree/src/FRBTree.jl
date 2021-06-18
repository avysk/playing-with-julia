module FRBTree

include("Types.jl")

RBTree{T} = Union{Types.NonEmptyTree{T},Types.EmptyRootTree{T}}
EmptyRBTree = Types.EmptyRootTree
export push, EmptyRBTree

function Base.in(item::T, tree::Types.EmptyRootTree{T})::Bool where {T}
    false
end

function Base.in(item::T, tree::Types.NonEmptyTree{T})::Bool where {T}
    while !isnothing(tree)()
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

@inline function lbalance(
    color::Types.Color,
    left::Types.Tree{T},
    value::T,
    right::Types.Tree{T},
)::Types.NonEmptyTree{T} where {T}
    # this function is called when "left" is a result of ins operation, so non-empty
    # also "right" is untouched, so it's balanced
    if color === Types.red || left.color === Types.black
        return Types.NonEmptyTree{T}(color, left, value, right)
    end
    if !isnothing(left.left) && left.left.color === Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            left.left |> blackify,
            left.value,
            Types.NonEmptyTree{T}(Types.black, left.right, value, right),
        )
    elseif !isnothing(left.right) && left.right.color === Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left.left, left.value, left.right.left),
            left.right.value,
            Types.NonEmptyTree{T}(Types.black, left.right.right, value, right),
        )
    end
    return Types.NonEmptyTree{T}(color, left, value, right)
end

@inline function rbalance(
    color::Types.Color,
    left::Types.Tree{T},
    value::T,
    right::Types.Tree{T},
)::Types.NonEmptyTree{T} where {T}
    # this function is called when "right" is a result of ins operation, so non-empty
    # also "left" is untouched, so it's balanced
    if color === Types.red || right.color === Types.black
        return Types.NonEmptyTree{T}(color, left, value, right)
    end
    if !isnothing(right.left) && right.left.color === Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left, value, right.left.left),
            right.left.value,
            Types.NonEmptyTree{T}(Types.black, right.left.right, right.value, right.right),
        )
    elseif !isnothing(right.right) && right.right.color === Types.red
        return Types.NonEmptyTree{T}(
            Types.red,
            Types.NonEmptyTree{T}(Types.black, left, value, right.left),
            right.value,
            right.right |> blackify,
        )
    end
    return Types.NonEmptyTree{T}(color, left, value, right)
end


function ins(item::T, tree::Types.Tree{T})::Types.NonEmptyTree{T} where {T}
    if !isnothing(tree)
        if item < tree.value
            lbalance(tree.color, ins(item, tree.left), tree.value, tree.right)
        else
            rbalance(tree.color, tree.left, tree.value, ins(item, tree.right))
        end
    else
        Types.NonEmptyTree{T}(Types.red, nothing, item, nothing)
    end
end

@inline function blackify(tree::Types.NonEmptyTree{T})::Types.NonEmptyTree{T} where {T}
    Types.NonEmptyTree{T}(Types.black, tree.left, tree.value, tree.right)
end

function push(item::T, tree::Types.NonEmptyTree{T})::RBTree{T} where {T}
    ins(item, tree) |> blackify # the root is always black
end

function push(item::T, _tree::Types.EmptyRootTree{T})::RBTree{T} where {T}
    Types.NonEmptyTree{T}(Types.black, nothing, item, nothing)
end

function Base.isempty(tree::Types.NonEmptyTree{T})::Bool where {T}
    false
end

function Base.isempty(tree::Types.EmptyRootTree{T})::Bool where {T}
    true
end

end