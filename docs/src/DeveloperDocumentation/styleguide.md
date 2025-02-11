# Developer Style Guide

In general we aim to follow the [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
but there are some exceptions due to our specific needs and a different background.

The content of this page are merely *guidelines*. There may be good reasons to
deviate from them in some cases; in that case just do so.

## Naming conventions

The usual [Julia naming conventions](https://docs.julialang.org/en/v1/manual/style-guide/#Use-naming-conventions-consistent-with-Julia-base/)
apply to Oscar, too (that said, for various reasons our code still violates
quite some of them; but in general we strive to reduce these).
Here is a summary of the naming convention followed in Oscar:

- Use `CamelCase` for types and `snake_case` for *everything* else. (Internal functions do not have to follow these rules.)
- Noteworthy difference to Julia base is that we do not have exceptions `is*` or `has*`.
  It is `is_foo` instead of `isfoo` and `has_bar` instead of `hasbar`.
- For generic concepts choose generic names, based on general algebraic
  concepts, preferably not special names from your area of speciality.
- Use Julia conventions where applicable.
- In Julia we have multiple dispatch, so we do not need functions like
  `point_from_matrix` as the "from" part is clear by the type of the argument.
  It should be called `points(T::Matrix)` in some variation.
  Similarly for `matrix_to_points`. Of course it is fine to use them internally, where
  useful.
- Follow the mathematics. If your function needs a list of points, you should
  create a point-type (or use the one already ehre) and then use this.
  For user-facing functions, please do not use re-purposed lists, arrays,
  matrices...
- If already existing types in Oscar are almost what you need, consider
  improving them instead of writing your own. While it might be
  tempting to create a new polynomial ring type for the new application because
  some feature is missing, it causes a lot of work and compability issues: Will the new type support
  - normal functions (gcd, factor),
  - quotient fields,
  - modules and residue rings,
  - conversion to and from other already existing types?

## Code formatting

### Whitespace

- Do not use tabs.
- Do not put spaces "inside" parenthesis.
- Do put spaces after commas.

Good example:
```julia
f(x, y) = x + 1
print(f(1, 2))
```

Bad example:
```julia
f( x,y ) = x + 1
print( f ( 1,2 ) )
```

### Loops and other control structures

- `for` loops should use `in` not `=`
- don't put spaces around the `:` in a range

Good example:
```julia
for i in 1:3
  println(i)
end
```

Bad example:
```julia
for i = 1 : 3
  println(i)
end
```

## Code structure

- do not nest loops and `if` clauses too deeply; if you are using 5 or more
  levels, then in general that's a hint that you should refactor; e.g.
  - by moving parts of the code into a separate function
  - by replacing guard constructs like
    ```julia
    for i in A
      if flag
        ...
      end
    end
    ```
    by
    ```julia
    for i in A
      if !flag
        continue
      end
      ...
    end
    ```
    or
    ```julia
    for i in A
      flag ||continue
      ...
    end
    ```
  - by merging loops: you can replace
    ```julia
    for i in A
      for j in B
        ...
      end
    end
    ```
    by
    ```julia
    for i in A, j in B
      ...
    end
    ```

- Functions should not have too many arguments.
  If you need a bunch arguments, chances are that introducing a new type
  makes it more readable.

- Functions should not be too long; very long functions are in general harder
  to understand; it is also more difficult to see all the code at once. Consider
  splitting the function into multiple ones, if it is sensibly possible.

However, as always, rules sometimes should be broken.

## Documentation

In general we try to follow the list of recommendations in the
[Documentation section of the Julia manual](https://docs.julialang.org/en/v1/manual/documentation/).
