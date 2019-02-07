<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
<style>
.topright {
    margin-top: -4px;
    margin-right: 16px;
    margin-bottom: 16px;
    margin-left: -12px;
    padding: 16px;
    border: 1px solid black;
}

.sectiontext {
    font-size: 1.5em;
    font-weight: bold;
    font-family: Candara, Calibri, Cambria, serif;
    color: green;
    margin-top: -4px;
}
</style>
<title>Insert title here</title>
</head>
<body>

<form action="daotest3">

	<select name="spocChoice">
		<c:forEach items="${spocOptions}" var="spoc">
	        <option value="${spoc.key}">
	            ${spoc.value}
	        </option>
	    </c:forEach>
	</select>

	<select name="period">
		<option value ="30">Month</option>
		<option value="90">Quarter</option>
		<option value="180">Six Month</option>
		<option value="365">Year</option>
	</select>
	<input type="submit" value="Click"/>
</form>
<br>
<br>
<div class="topright">
    <h2 class="sectiontext">Price Compliance</h2>
    <div class="graph_container">
        <canvas id="priceComplianceBarChart" width="800" height="400"></canvas>
    </div>
</div>
<script>

	var numSets = 0;
	var backgroundColorChoice = ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)','rgba(255, 206, 86, 1)','rgba(75, 192, 192, 1)','rgba(153, 102, 255, 1)',
	    'rgba(255, 159, 64, 1)'];
	function getDataSet(label, data){
		var ret = {
			label : label,
			backgroundColor: backgroundColorChoice[numSets],
			data : data
		}
		
		numSets++;
		if(numSets==backgroundColorChoice.length)
			numSets= 0;
		
		return ret;
	}


	var labels = [];
	var datasets = new Map();
	var first = true;
	<c:forEach items="${requests}" var="location">
		var key = "${location.key}";
		console.log(key);
		labels.push(key);
		<c:forEach items="${location.value}" var="mode">
			var m = "${mode.key}";
			var data = "${mode.value}";
			if(first)
				datasets.set(m, [data]);
			else
				datasets.get(m).push(data);
		</c:forEach>
		first = false;
	</c:forEach>
	
	console.log(labels);
	console.log(datasets);
	var datasetObjs = [];
	
	var mapIter = datasets.keys();
	
	let resultKey = mapIter.next();
	while (!resultKey.done) {
		 console.log(resultKey.value);
		 datasetObjs.push(getDataSet(resultKey.value, datasets.get(resultKey.value)));
		 resultKey = mapIter.next();
	}
	
	console.log(datasetObjs);
	

	var ctxBarChart = document.getElementById("priceComplianceBarChart").getContext("2d");
	var priceBarChart = new Chart(ctxBarChart, {
	    type: 'bar',
	    data: {
	        labels: labels,
	        datasets: datasetObjs
	    },
	    options: {
	        tooltips: {
	            enabled: false
	        },
	        animation: {
	            duration: 0,
	            onComplete: function () {
	                if (this.data.datasets.length === 2) {
	                    // render the value of the chart above the bar
	                    var ctx = this.chart.ctx;
	                    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
	                    ctx.fillStyle = this.chart.config.options.defaultFontColor;
	                    ctx.textAlign = 'center';
	                    ctx.textBaseline = 'bottom';
	                    var firstDataSet = this.data.datasets[0];
	                    var secondDataSet = this.data.datasets[1];
	                    if (firstDataSet.length === secondDataSet.length) {
	                        for (var i = 0; i < firstDataSet.data.length; i++) {
	                            var firstModel = firstDataSet._meta[Object.keys(firstDataSet._meta)[0]].data[i]._model;
	                            var secondModel = secondDataSet._meta[Object.keys(secondDataSet._meta)[0]].data[i]._model;
	                            var total = firstDataSet.data[i] + secondDataSet.data[i];
	                            /*if (firstDataSet.data[i] >= secondDataSet.data[i]) {
	                                ctx.fillText((firstDataSet.data[i] * 100 / total).toFixed(2) + '%', firstModel.x, firstModel.y + 30);
	                            } else {
	                                ctx.fillText((secondDataSet.data[i] * 100 / total).toFixed(2) + '%', secondModel.x, secondModel.y + 30);
	                            }*/
	                        }
	                    }
	                }
	            }
	        },
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true
	                },
	                stacked: true
	            }],
	            xAxes: [{
	                stacked: true,
	            }]
	        },
	        responsive: false
	    }
	});
</script>
</body>
</html>