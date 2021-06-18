module Types

struct EmptyRootTree{T} end

@enum Color black red

struct NonEmptyTree{T}
    color::Color
    left::Union{NonEmptyTree{T},Nothing}
    value::T
    right::Union{NonEmptyTree{T},Nothing}
end

Tree{T} = Union{NonEmptyTree{T},Nothing}

end