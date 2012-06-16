// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-pt-BR
//= require_tree .
$(function(){
	$('.date').datepicker({
		defaultDate: "+1w",
		showButtonPanel: true,
		onSelect: function(selectDate) {
			if ($(this).attr('id') == 'search_partida') {
				$('#search_retorno').datepicker("option", "minDate", selectDate)
			} else {
				$('#search_partida').datepicker("option", "maxDate", selectDate)
			}
		}
	});
	$('form').submit(function(){
		if ($('#search_origin').val() == $('#search_destination').val()){
			alert('Você precisa selecionar um destino diferente!');
			$('#search_destination').focus();
			return false;
		}
	});
})