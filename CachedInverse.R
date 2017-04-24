makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}


cacheSolve <- function(X) {
## X - object returned by makeCacheMatrix()
    M <- X$get_inverse()
    if(!is.null(M)) {
        message("Inverse matrix fom cache")
    }
    else {
        message("Inverse matrix fom solve()")
        M <- solve(X$get())
        X$set_inverse(M)
    }
    M
}

makeCacheMatrix <- function(M = matrix()) {
    M_INV <- NULL
    set <- function(x) {
        M <<- x
        M_INV <<- NULL
    }
    get <- function() M
    set_inverse <- function(m_inv) M_INV <<- m_inv
    get_inverse <- function() M_INV
    list(set = set, get = get,
         set_inverse = set_inverse,
         get_inverse = get_inverse)
}