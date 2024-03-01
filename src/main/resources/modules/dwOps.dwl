%dw 2.0

fun flattenObject(field, path) =
    field match {
        case is Array -> 
            field map (value,index) -> flattenObject(value, path)
        case is Object -> field mapObject (value,key) -> 
            flattenObject (value, if (sizeOf(path)>0) path ++ "." ++ key else key)
        else -> (path) : field
    }