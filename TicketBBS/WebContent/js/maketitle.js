/**
 * 
 */

var my_ticket_date = "";
var my_ticket_block = "";
var my_ticket_row = "";

var other_ticket_block = "";
var other_ticket_row = "";
	
function make_title_my(doc, flag) {
	if (flag == 1) {
		var my_ticket = $("div[name=title_my_ticket]"); // 제목 박스
		var dropdown_my_date = $("button[name=dropdown_my_date]"); // 날짜 선택 버튼
		my_ticket_date = doc.innerText;
		dropdown_my_date["0"].innerText = my_ticket_date;
		my_ticket[0].innerText = my_ticket_date;
	}
	else {
		if (flag == 2) {
			my_ticket_block = " " + $("input[name=my-ticket-block]").val() + "구역";
		}
		else {
			my_ticket_row = " " + $("input[name=my-ticket-row]").val() + "열";
		}

		var my_seat = $("div[name=title_my_seat]"); // 제목 박스
		my_seat[0].innerText = my_ticket_block + my_ticket_row;
	}
}

function make_title_other(flag) {
	if (flag == 1) {
		other_ticket_block = " " + $("input[name=other-ticket-block]").val() + "구역";
	}
	else {
		other_ticket_row = " " + $("input[name=other-ticket-row]").val() + "열";
	}
	
	var other_seat = $("div[name=title_other_seat]"); // 제목 박스
	other_seat[0].innerText = other_ticket_block + other_ticket_row;
}

$(document).ready(function() {
    $("ul.dropdown-menu input[name=other-ticket-date-cb]").each(function() {
        $(this).change(function() {
            var line = "";
            $("ul.dropdown-menu input[name=other-ticket-date-cb]").each(function() {
                if ($(this).is(":checked")) {
                    line += $("+ label", this).text() +";";
                    var dateArr = line.split(';');
                    $("div[name=title_other_tickets]").empty()
                    for (var i = 0; i < dateArr.length - 1; i++) {
                    	$("div[name=title_other_tickets]").append("<div class='btn btn-info'>" + dateArr[i] + "</div>");                    	
                    }
                }
            });
            $("input[type=text][name=other-ticket-date\n]").val(line);
            
            if ($('input[name=other-ticket-date-cb]:checked').length == 0) {
            	$("[name=title_other_tickets] div")[0].innerText = "상대 티켓";
            }
        });
    });
});