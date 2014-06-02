// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//
//= require justgage.1.0.1.min
//= require raphael.2.1.0.min

var possessive = ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'];

$(function() {
	$('#platform').children().tooltip();
	$('.ajax').each(function(i, el) {
		$.getJSON(sprintf('/metrics/metric/%s', $(el).attr('metric')), function(data) {
			var value = $(el).hasClass('smallnum') ? data.value.toFixed(2) : Math.floor(data.value);
			value = $(el).hasClass('percentile') ? Math.min(99, value) : value;
			if($(el).hasClass('text')) {
				$(el).text(value + ($(el).hasClass('percent') ? '%' : ''));
			}
			if($(el).hasClass('bar')) {
				$(el).find('div').width(data.value + '%');
				if(data.value > 15)
					$(el).find('div').text(value + '%');
				else
					$(el).append(value + '%');
			}
			if($(el).hasClass('stackbar')) {
				$(el).width(data.value + '%')
				$(el).append(value + '%')
			}
			if($(el).hasClass('percentile')) {
				var left = Math.min(98, Math.max(0, data.value - 1));
				var right = 98 - left;
				$(el).children().eq(0).width(left + '%');
				$(el).children().eq(1).width('2%');
				$(el).children().eq(2).width(right + '%');
				if (left > right) {
					$(el).children().eq(0).html(value + possessive[value % 10] + '&nbsp;').css('text-align', 'right');
				} else {
					$(el).children().eq(2).html('&nbsp;' + value + possessive[value % 10]).css('text-align', 'left');
				}
			}
		}).fail(function() {
			if($(el).hasClass('text'))
				$(el).text('Not Found');
			if($(el).hasClass('bar'))
				$(el).text('Not Found');
		});
	});
	
});