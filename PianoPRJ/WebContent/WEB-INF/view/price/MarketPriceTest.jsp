<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="chartdiv" style="width:100%;height:600px"></div>



<script src="//www.amcharts.com/lib/4/core.js"></script>
<script src="//www.amcharts.com/lib/4/charts.js"></script>
<script src="//www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="/resources/app-assets/js/core/libraries/jquery.min.js" type="text/javascript"></script>
<script>


var timedata = [{
	  "date": new Date(2018, 3, 20),
	  "value": 90,
	  "value2": 45
	}, {
	  "date": new Date(2018, 3, 21),
	  "value": 102,
	  "value2": 90
	}, {
	  "date": new Date(2018, 3, 22)
	}, {
	  "date": new Date(2018, 3, 23),
	  "value": 125
	}, {
	  "date": new Date(2018, 3, 24),
	  "value": 55,
	  "value2": 90
	}, {
	  "date": new Date(2018, 3, 25),
	  "value": 81,
	  "value2": 60
	}, {
	  "date": new Date(2018, 3, 26)
	}, {
	  "date": new Date(2018, 3, 27),
	  "value": 63,
	  "value2": 87
	}, {
	  "date": new Date(2018, 3, 28),
	  "value": 113,
	  "value2": 62
	}, {
	  "date": new Date(2018, 3, 29),
	  "value": 500,
	  "value2": 100
	}];

window.onload = function(){
	var obj;
	
	$.ajax({
		url:"/price/GetMarketPrice.do",
		type:"post",
		success:function(data){
			obj = data;
			for(var i=0; i<obj.length; i++){
				obj[i].deal_date = new Date(obj[i].deal_date);
			}
			

			// Create chart instance
			var chart = am4core.create("chartdiv", am4charts.XYChart);
			chart.paddingRight = 20;

			// Add data
			chart.data = obj;
			
			// Create axes
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.minGridDistance = 50;
			dateAxis.renderer.grid.template.location = 0.5;
			dateAxis.startLocation = 0.5;
			dateAxis.endLocation = 0.5;
			dateAxis.dateFormats.setKey("day", "MM/dd");
			dateAxis.dateFormatter = new am4core.DateFormatter();
			
			// Create value axis
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.numberFormatter = new am4core.NumberFormatter();
			valueAxis.numberFormatter.numberFormat = "#,###원"; 
			
			//Create series
			var tuningSeries = chart.series.push(new am4charts.LineSeries());
			tuningSeries.name = "조율";
			tuningSeries.dataFields.valueY = "tuning_avg";
			tuningSeries.dataFields.dateX = "deal_date";
			tuningSeries.strokeWidth = 3;
			tuningSeries.tensionX = 0.8;
			tuningSeries.tooltipText = "조율 : {tuning_avg.formatNumber('#,###원')}";
			tuningSeries.tooltip.pointerOrientation = "vertical";
			tuningSeries.stroke = am4core.color("#4272f5");
			tuningSeries.tooltip.getFillFromObject = false;
			tuningSeries.tooltip.background.fill = am4core.color("#4272f5");

			var regulSeries = chart.series.push(new am4charts.LineSeries());
			regulSeries.name = "조정";
			regulSeries.dataFields.valueY = "regul_avg";
			regulSeries.dataFields.dateX = "deal_date";
			regulSeries.strokeWidth = 3;
			regulSeries.tensionX = 0.8;
			regulSeries.stroke = am4core.color("#f55d42");
			regulSeries.tooltipText = "조정 : {regul_avg.formatNumber('#,###원')}";
			regulSeries.tooltip.getFillFromObject = false;
			regulSeries.tooltip.background.fill = am4core.color("#f55d42");

			var voicingSeries = chart.series.push(new am4charts.LineSeries());
			voicingSeries.name= "정음";
			voicingSeries.dataFields.valueY = "voicing_avg";
			voicingSeries.dataFields.dateX = "deal_date";
			voicingSeries.strokeWidth = 3;
			voicingSeries.tensionX = 0.8;
			voicingSeries.stroke = am4core.color("#26bd00");
			voicingSeries.tooltipText = "정음 : {voicing_avg.formatNumber('#,###원')}";
			voicingSeries.tooltip.getFillFromObject = false;
			voicingSeries.tooltip.background.fill = am4core.color("#26bd00");

			var transportSeries = chart.series.push(new am4charts.LineSeries());
			transportSeries.name = "운반"
			transportSeries.dataFields.valueY = "transport_avg";
			transportSeries.dataFields.dateX = "deal_date";
			transportSeries.strokeWidth = 3;
			transportSeries.tensionX = 0.8;
			transportSeries.stroke = am4core.color("#bd00a4");
			transportSeries.tooltipText = "운반 : {transport_avg.formatNumber('#,###원')}";
			transportSeries.tooltip.getFillFromObject = false;
			transportSeries.tooltip.background.fill = am4core.color("#bd00a4");
	
			chart.legend = new am4charts.Legend();
			chart.cursor = new am4charts.XYCursor();
			
		}
	});
}

</script>
</body>
</html>