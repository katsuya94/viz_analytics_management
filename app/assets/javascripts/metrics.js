// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//

var suffixes = ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'];
function suffix(n) {
	if (~~(n / 10) === 1)
		return 'th';
	return suffixes[n % 10];
}

$(function() {
	$('.tooltipme').tooltip();
	$('.ajax').each(function(i, el) {
		$.getJSON(sprintf('/metrics/metric/%s', $(el).attr('metric')), function(data) {
			var value = $(el).hasClass('smallnum') ? data.value.toFixed(2) : Math.floor(data.value);
			value = $(el).hasClass('percentile') ? Math.min(99, value) : value;
			if($(el).hasClass('text')) {
				$(el).text(value + ($(el).hasClass('percent') ? '%' : ''));
			}
			if($(el).hasClass('relation')) {
				var color;
				if($(el).hasClass('minimize')) {
					color = value < 0 ? '#5CB8B8' : '#B85CB8';
				} else {
					color = value > 0 ? '#5CB8B8' : '#B85CB8';
				}
				$(el).text(Math.abs(value) + ($(el).hasClass('percent') ? '%' : '') + (value < 0 ? ' lower' : ' higher')).css('color', color);
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
					$(el).children().eq(0).html(value + suffix(value) + ($(el).hasClass('verbose') ? ' percentile' : '') + '&nbsp;').css('text-align', 'right');
				} else {
					$(el).children().eq(2).html('&nbsp;' + value + suffix(value) + ($(el).hasClass('verbose') ? ' percentile' : '')).css('text-align', 'left');
				}
			}
		}).fail(function() {
			if($(el).hasClass('text') || $(el).hasClass('relation'))
				$(el).text('Not Found');
			if($(el).hasClass('bar') || $(el).hasClass('percentile'))
				$(el).text('Not Found');
			if($(el).hasClass('stackbar'))
				$(el).parent().text('Not Found')
		});
	});
	
});