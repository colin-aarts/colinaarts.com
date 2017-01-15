/*
** Collection of DOM functions
*/



/*
** Find and mark anchors wrapping (media) objects – CSS hook until we finally have `:has()`
*/

function mark-object-anchors parent
	const anchors = parent.query-selector-all 'a[href]'
	for anchor in anchors
		try if anchor.query-selector ':scope > img' then anchor.class-list.add 'wraps-object'


/*
** Syntax highlighting — Prism
*/

function init-code-highlighting
	require! 'prismjs'
	require! 'prismjs/components/prism-livescript'
	prismjs.highlight-all!


/*
** Service Worker
*/

function init-service-worker
	if 'serviceWorker' of navigator
		navigator.service-worker.register '/sw.js'


/*
** Update document title
** Pass in `false` to reset the title to its base (should be done automatically in the routing as a fallback for when a module doesn't set a proper title.)
*/

function set-title title
	const title-el = document.get-elements-by-tag-name 'title' .0
	const suffix   = title-el.dataset.suffix
	const base     = title-el.dataset.base
	if title is off
		document.title = base
	else
		document.title = "#title#suffix"



/*
** Exports
*/

module.exports = { mark-object-anchors, init-code-highlighting, init-service-worker, set-title }
