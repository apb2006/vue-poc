/**
 * some vue filters, requires date-fns
 *  formatDate
 *  fromNow
 *  readablizeBytes
 *  round 
 */

//Define the date time format filter
Vue.filter("formatDate", function(date) {
	var d=(date instanceof Date)?date:parseISO(date)
    return  format(d, "MMM d, yyyy")
});

Vue.filter("fromNow", function(date) {
  var d=(date instanceof Date)?date:parseISO(date)
  return formatDistanceToNow(d)
});

Vue.filter('readablizeBytes', function (bytes,decimals) {
  if(bytes == 0) return '0 Bytes';
  var k = 1000,
      dm = decimals || 2,
      sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
      i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
});

Vue.filter("any", function(any) {
  return "ANY"
});

/**
 * Vue filter to round the decimal to the given place.
 * http://jsfiddle.net/bryan_k/3ova17y9/
 *
 * @param {String} value    The value string.
 * @param {Number} decimals The number of decimal places.
 */
Vue.filter('round', function(value, decimals) {
  if(!value) {
    value = 0;
  }

  if(!decimals) {
    decimals = 0;
  }

  value = Math.round(value * Math.pow(10, decimals)) / Math.pow(10, decimals);
  return value;
});

Vue.filter('pretty',function(value) {
  return JSON.stringify(value, null, 2);
});
