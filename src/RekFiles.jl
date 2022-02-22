module RekFiles
export REKHeader, size, scales, rekread

struct REKHeader
    width::Int
    height::Int
    depth::Int
    nbits::Int
    comps::Int
    scalex::Float64
    scaley::Float64
    scalez::Float64
    header::Int
end

import Base.size
size(h::REKHeader) = (h.width, h.height, h.depth)
scales(h::REKHeader) = (h.scalex, h.scaley, h.scalez)

function readheader(io)


    width = Int(read(io, UInt16))
    height = Int(read(io, UInt16))
    nbits = Int(read(io, UInt16))

    if nbits == 8
        comps = 1
    else
        comps = 2
    end
    
    depth = Int(read(io, UInt16))
    headersize = Int(read(io, UInt16))
    major = Int(read(io, UInt16))
    minor = Int(read(io, UInt16))
    revision = Int(read(io, UInt16))

    seekstart(io)
    seek(io, 0x238)

    X = Int(read(io, UInt32))
    Y = Int(read(io, UInt32))
    Z = Int(read(io, UInt32))
    scaling = Float64(read(io, Float32))

    scalex = Float64(read(io, Float32))
    scalez = Float64(read(io, Float32))
    


    #return width, height, nbits, depth, headersize, major, minor, revision, X, Y, Z, scaling
    return REKHeader(width, height, depth, nbits, comps, scalex, scalex, scalez, headersize)
    
    
    
end

function readvolume(io, header)
    seekstart(io)
    seek(io, header.header)

    np = header.width * header.height * header.depth

    nbytes = np * header.comps

    data = zeros(UInt16, header.width, header.height, header.depth)

    read!(io, data)

    return data
    
end

function rekread(fname)

    io = open(fname, "r")
    header = readheader(io)
    data = readvolume(io, header)
    close(io)

    return header, data
    
end


end
