
s = """
type MyType{Int64}
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "unrelated to the type" ) )
s = """
type MyType{Int64} <: Float64
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "unrelated to the type" ) )
s = """
type MyType{T<:Int}
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "leaf type" ) )
s = """
type MyType{T<:Int, Int<:Real}
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "leaf type" ) )
@assert( contains( msgs[2].message, "parametric data type" ) )
s = """
type MyType{Int<:Real}
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "instead of a known type" ) )
s = """
type MyType{T<:Integer}
    t::T
    MyType( x ) = new( convert( T, x ) )
end
"""
msgs = lintstr(s)
@assert( isempty( msgs ) )
s = """
type MyType
    t::Int
    MyTypo() = new( 1 )
end
"""
msgs = lintstr(s)
@assert( contains( msgs[1].message, "Constructor-like function" ) )
s = """
type MyType
    t::Int
    NotATypo() = 1
end
"""
msgs = lintstr(s)
@assert( isempty( msgs ) )
