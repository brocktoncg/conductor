#-- page parts --#

window.remove_fields = (link) ->
	$(link).prev(":input").val(true)
	$(link).parent(".fields").slideUp()

window.remove_new = (link) ->
	fields = $(link).parent(".fields")
	fields.slideUp 400, ()->
		fields.remove()

window.add_fields = (link, association, content) ->
	new_id = new Date().getTime()
	regexp = new RegExp("new_" + association, "g")
	$(link).after(content.replace(regexp, new_id))
	initTinyMCE()
	$(link).next(".fields").hide().slideDown()

#-- tree DnD --#

$('#reorder').click (e) ->
	e.preventDefault()
	$('.sortable').nestedSortable(
		forcePlaceholderSize: true,
	    handle: 'div'
	    items: 'li'
	    toleranceElement: '> div'
	    expandOnHover: 700
	    startCollapsed: true,
	    placeholder: 'placeholder',
	)
	$('#new-page').hide()
	$('#reorder').hide()
	$('#cancel').show()
	$('#save').show()

$('#save').click () ->
	c = {
		set: JSON.stringify($('.sortable').nestedSortable('toHierarchy', {startDepthCount: 0}))
	}
	d = {
		set: $('.sortable').nestedSortable('toHierarchy', {startDepthCount: 0})
	}
	$.ajax
		type: 'post'
		dataType: 'json'
		url: '/pages/savesort'
		data: d
		success: (data) ->
			window.location = "/pages"

$('.disclose').on 'click', () ->
	$(this).closest('li').toggleClass('mjs-nestedSortable-collapsed').toggleClass('mjs-nestedSortable-expanded')
