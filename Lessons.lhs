# Function composition and modification

We define a simple set of functions
f(x) = x^2
g(x) = (x + 10)^2

> g x = (x + 10)^2
> f x = x^2

We can compose them
f . g (x) = ((x+10)^2)^2
f . g /= g . f

g . f (x) = ((x^2)+10)^2

g . f (x) <=> g(f(x))

Why do we even compose things in haskell?
Why are you learning composition in math?

We want to treat functions as their own thing that is just as important as the
numbers that go into them

10 + 12 = 22
(+10) . (*12) = (+10).(*12)


What is composition?
Composition creates a function. By taking the return value from one function and
passing it to the other function.


(.) :: (b -> c) -> (a -> b) -> (a -> c)
(<=<) :: (b -> m c) -> (a -> m b) -> (a -> m c)
(<<<) :: m b c -> m a b -> m a c

($) :: (a -> b) -> a -> b
(=<<) :: (a -> m b) -> a -> m b
(<$>) :: (a -> b) -> m a -> m b
