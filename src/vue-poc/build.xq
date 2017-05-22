let $head:="<head/>"
let $app:="<v-app/>"
return ``[
<!DOCTYPE html>
<html>
 `{$head}`
<body>
 `{$app}`
 <script src="/vue-poc/ui/app.js"></script>
</body>
</html>
]``