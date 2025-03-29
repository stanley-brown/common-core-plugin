import java!org::mule::utils::Crosswalk

fun loadCSV(filename, skipHeader = true, multi = false) = 
	Crosswalk::loadCSV(filename, skipHeader, multi) as Object

fun loadObj(alias, obj) = if (contains(alias)) obj else set(alias, obj)

fun contains(alias) = Crosswalk::contains(alias)

fun set(alias, obj) = Crosswalk::set(alias, obj)
	
fun set(alias, key, value) =
	Crosswalk::set(alias, key, value)