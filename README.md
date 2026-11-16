# Lamdera 1.5.0 `Type.Solve.isGeneric` crash

Lamdera 1.5.0 and 1.5.1 crash while type-checking `src/Main.elm`. Lamdera 1.4.0 compiles it.

```
lamdera make src/Main.elm --output=/dev/null
```

| Compiler | Result |
|---|---|
| Lamdera 1.4.0 (Elm 0.19.1) | `Success! Compiled 1 module.` |
| Lamdera 1.5.0 (Elm 0.19.3) | Crash |
| Lamdera 1.5.1 (Elm 0.19.3, built from source at `3e26a1c`) | Crash |

```
Crash {_module = Module "Type.Solve", _name = Name "Type.Solve.isGeneric", _line = Line 224, _message = "You ran into a compiler bug. Here are some details for the developers:\n\n    b [rank = 1]\n\n..."} (in module Main)
```

## What it needs

Changing any one of these makes 1.5.0 compile it:

- `view` is annotated with the `Outer` alias. Writing its record type out compiles.
- `b` stays a type variable in that annotation. A concrete type compiles.
- `Outer`'s first argument is a record. `{}` crashes; `()` and `Int` compile.
- `a` is wrapped in `Maybe` inside `Outer`.
- The `Box` alias appears in both `Outer` and the argument type of `take`. Writing `{ value : Maybe a }` out in either place compiles.

Splitting the definitions across modules crashes the same way.
