<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="headerfile.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
    <title>Create Header</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css"
        integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</head>
<body>
<%@include file="headerbody.jsp" %>
<%@include file="navbar.jsp" %>
<div class="container" id="bodycont" style="margin-top:50px">
        <form class="form" action="chartRequester" style="margin-left:10px;width:80%">
            <div class="row" style="align-items:center;display:flex">
                <div class="col-xs-4" style="margin-right:5px">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-calendar-alt"></i>
                            </span>
                        </div>
                        <select name="reqChoice" class="form-control">
							<c:forEach items="${reqOptions}" var="req">
						        <option value="${req.key}">
						            ${req.value}
						        </option>
						    </c:forEach>
						</select>
                    </div>
                </div>
                <div class="col-xs-4" style="margin-right:5px">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fas fa-calendar-alt"></i>
                            </span>
                        </div>
                        <select name="period" class="form-control">
                            <option value="30">Monthly</option>
                            <option value="90">Quarterly</option>
                            <option value="180">Six months</option>
                            <option value="365">Yearly</option>
                        </select>
                    </div>
                </div>
                <br>
                <div class="col-xs-4">
                    <div class="text-right" id="send_button">
                        <button type="submit" class="btn btn-info">
                            Click
                            <i class="far fa-hand-pointer"></i>
                        </button>
                    </div>
                </div>
                <br>
                <br>
            </div>
        </form>
    </div>

    <canvas id="myStatusChart" width="400px" height="300px" ></canvas>
    <br>
    <br>
    <canvas id="myPartChart" width="400px" height="300px" ></canvas>
        
        <script>
	console.log("HELLO");
		var data = [];
		<c:forEach items="${status}" var="request">
			var value = "${request}";
			data.push(value);
		</c:forEach>
		
		console.log(data);
		var period = "${period}";
		
		function getLabel(){
			if (period==90)
				return "Quarter";
			else if (period==180)
				return "6 Month Period"
			else if(period==365)
				return "Year";
			else
				return "Month"
			
		}
	
		var label = getLabel();
		
		var ctx = document.getElementById("myStatusChart").getContext('2d');
	    var myChart = new Chart(ctx, {
	        type: 'pie',
	        data: {
	            labels: ['Canceled', 'In Progress', 'Completed'],
	            datasets: [{
	                label: 'Training Request Status in ' + label,
	                data: data,
	                backgroundColor: [
	                    'rgba(25, 25, 112, 1)',
	                    'rgba(108, 117, 125, 1)',
	                    'rgba(23, 162, 184, 1)',
	                ],
	                borderWidth: 1
	            }]
	        },
	        options: {
	        	title: {
	                display: true,
	                text: 'Training Request Status in ' + label,
	                        fontSize: 24
	              },
	            responsive: false
	        }
	    });

		var partLabels = [];
		var partData = [];
		<c:forEach items="${participants}" var="entry">
			var key = "${entry.key}"; var value = "${entry.value}";
			partLabels.push(key);
			partData.push(value);
		</c:forEach>
		
		var partCtx = document.getElementById("myPartChart").getContext('2d');
	    var partMyChart = new Chart(partCtx, {
	        type: 'pie',
	        data: {
	            labels: partLabels,
	            datasets: [{
	                label: 'Training Participants in ' + label,
	                data: partData,
	                backgroundColor: [
	                    'rgba(25, 25, 112, 1)',
	                    'rgba(108, 117, 125, 1)',
	                    'rgba(23, 162, 184, 1)'
	                ],
	                borderWidth: 1
	            }]
	        },
	        options: {
	        	title: {
	                display: true,
	                text: 'Training Participants in ' + label,
	                        fontSize: 24
	              },
	            responsive: false
	        }
	    });
	    </script>
            
           <%@include file="footer.jsp" %>

</body>

</html>