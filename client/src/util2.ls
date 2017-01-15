/*
** str-struncate
*/

function str-truncate str, start = 0, end = 0, delimiter = ''

	return str if not start? and not end?

	if str.length > (start + end)
		return (str.substr 0, start) + delimiter + (str.substr -end, end)
	else
		return str



/*
** Exports
*/

module.exports = { str-truncate }
