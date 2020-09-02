
# Installs

## $aceExtras   ace customisations
```
{ rhymeCompleter, 
  basexCompleter, 
  snippets
}
```

## $auth 
```
 { user: "guest",
    role: null,
    session: null,
    created: null,
}
```

## $fullscreen
```
isInFullScreen()
toggle()
```

## $MimeTypes
```
$mimetype.contentType['image/svg+xml'] returns object {mode:'ace mode',..}
$mimetype.mode['acemode'] return object { format:fn, icon:;icon'}
$mimetype.list['acemode'] returns icon
icon(mode)
```

## $notification
```
add()
```
# Filters
* fromNow
* readablizeBytes
* round
* pretty