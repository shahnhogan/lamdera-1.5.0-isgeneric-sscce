module Main exposing (view)


type alias Box a =
    { value : a }


type alias Outer a b =
    { other : b
    , box : Box (Maybe a)
    }


take : { r | box : Box (Maybe a) } -> ()
take _ =
    ()


view : Outer {} b -> ()
view x =
    take x
