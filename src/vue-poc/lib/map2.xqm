xquery version "3.0";

(:~
 : Additional functions for XQuery 3.0 maps.
 :
 : @author Leo Woerteler &lt;leo@woerteler.de&gt;
 : @version 0.1
 : @version 0.2 Andy Bunce map:new -> map:merge
 : @license BSD 2-Clause License
 :)
module namespace map2='http://www.woerteler.de/xquery/modules/map-extras';

declare namespace map = 'http://www.w3.org/2005/xpath-functions/map';

(:~
 : Inserts with a combining function. <code>insert-with($f, $key, $value, $map)</code>
 : will insert <code>map:entry($key, $value)</code> into <code>$map</code> if
 : <code>$key</code> does not exist in the map. If the key does exist, the function
 : will insert <code>$f($new-value, $old-value)</code>.
 :
 : @param $f combining function
 : @param $key key to insert
 : @param $value value to insert
 : @param $map map to insert into
 : @return new map where the entry is inserted
 :)
declare function map2:insert-with(
  $f as function(item()*, item()*) as item()*,
  $key as item(),
  $value as item()*,
  $map as map(*)
) as map(*) {
  map:merge(
    (
      $map,
      map:entry(
        $key,
        if(map:contains($map, $key)) then $f($value, $map($key))
        else $value
      )
    )
  )
};

(:~
 : Inserts a key-value pair into a map. If an entry with the key <code>$key</code>
 : already exists in the map, it is replaced by the new one.
 :
 : @param $key key to insert
 : @param $value value to insert
 : @param $map map to insert into
 : @return map where the key-value pair was inserted
 :)
declare %public function map2:insert(
  $key as item(),
  $value as item()*,
  $map as map(*)
) as map(*) {
  map:merge(
    (
      $map,
      map:entry($key, $value)
    )
  )
};

(:~
 : Folds the keys and values in the map using the given combining function <code>$f</code>.
 : Let <code>{ $k1:$v1, ..., $kn:$vn }</code> be the key-value pairs in the
 : given map <code>$map</code>, then the result is calculated by:
 : <code>$f(... $f($f($start, $k1, $v1), $k2, $v2), ...), $kn, $vn)</code>
 :
 : @param $map map to be folded
 : @param $start start value
 : @param $f left-associative combining function
 : @return resulting value
 :)
declare %public function map2:fold(
  $map as map(*),
  $start as item()*,
  $f as function(item()*, item(), item()*) as item()*
) as item()* {
  fold-left(
    map:keys($map),
    $start,
    function($val, $key) { $f($val, $key, $map($key)) }
  )
};

(:~
 : Extracts all values from the map <code>$map</code>, returning
 : them in a sequence in arbitrary order.
 :
 : @param $map map to extract the values from
 : @return sequence of values
 :)
declare %public function map2:values(
  $map as map(*)
) as item()* {
  for-each(map:keys($map), $map)
};

(:~
 : Applies the function <code>$f</code> to all values in the map.
 : The keys are not touched.
 :
 : @param $f function to be applies to all values
 : @param $map input map
 : @return copy of <code>$map</code> where all values <code>$value</code>
 :         are replaced by <code>$f($value)</code>
 :)
declare %public function map2:map(
  $f as function(item()*) as item()*,
  $map as map(*)
) as map(*) {
  map:merge(
    for $key in map:keys($map)
    return map:entry($key, $f($map($key)))
  )
};

(:~
 : Maps a function over all entries of the map <code>$map</code>.
 : Each entry <code>($key, $value)</code> in the map is replaced by a new
 : entry <code>($key, $f($key, $value))</code>, the keys are not touched.
 :
 : @param $f function to be applies to all entries
 : @param $map input map
 : @return copy of <code>$map</code> where all values <code>$value</code>
 :         are replaced by <code>$f($key, $value)</code>
 :)
declare %public function map2:map-with-key(
  $f as function(item(), item()*) as item()*,
  $map as map(*)
) as map(*) {
  map:merge(
    for $key in map:keys($map)
    return map:entry($key, $f($key, $map($key)))
  )
};

(:~
 : Iterates over the entries of the given map and calls the given function
 : with their key and bound value.
 :
 : @param $map the map to iterate over
 : @param $f the two-argument function to call with the key and value
 : @return the results of all calls to <code>$f</code> concatenated
 :)
declare %public function map2:for-each-entry(
  $map as map(*),
  $f as function(item(), item()*) as item()*
) as item()* {
  for $k in map:keys($map)
  return $f($k, $map($k))
};
