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
      if ($(this).attr('id') == 'trip_initial_date') {
        $('#trip_final_date').datepicker("option", "minDate", selectDate)
      } else {
        $('#trip_initial_date').datepicker("option", "maxDate", selectDate)
      }
    }
  }); 
	var total_voos = 0;
	var total_hotel = 0;
	var total_calc = 0;
		jQuery(".passage").bind("click",function(){                        
			total_voos = parseFloat(jQuery(this).attr("data-value").replace(",","").replace(".",""));
			jQuery(".passagem span").html(total_voos);
			jQuery(".total span").html(total_voos+total_calc);
		});
		
		jQuery(".hosped").bind("click",function(){
			total_hotel = parseFloat(jQuery(this).attr("data-value").replace(",","").replace(".",""));
			alert(total_hotel);
			jQuery(".hospedagem span").html(total_hotel);
			jQuery(".total span").html(parseFloat(total_voos)+parseFloat(total_calc)+parseFloat(total_hotel));
		});

})