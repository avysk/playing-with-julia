module Types

struct EmptyTree{T} end

@enum Color black red

struct NonEmptyTree{T}
    color::Color
    left::Union{NonEmptyTree{T},EmptyTree{T}}
    value::T
    right::Union{NonEmptyTree{T},EmptyTree{T}}
end

Tree{T} = Union{NonEmptyTree{T},EmptyTree{T}}

end