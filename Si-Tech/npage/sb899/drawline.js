
function drawLine(total,numberX,decimals){
	var myChart = new JSChart('graph', 'line');
	var dataArr = new Array();
	for(var i = 0; i < total.length; i++){
		dataArr[i] = [i,total[i][1]];
	}
	myChart.setDataArray(dataArr);
	myChart.setTitle('');
	myChart.setTitleColor('#8E8E8E');
	myChart.setTitleFontSize(11);
	myChart.setAxisNameX('');
	myChart.setAxisNameY('');
	myChart.setAxisColor('#69f');
	myChart.setAxisValuesColor('#949494');
	myChart.setAxisPaddingLeft(100);
	myChart.setAxisPaddingRight(100);
	myChart.setAxisPaddingTop(30);
	myChart.setAxisPaddingBottom(40);
	myChart.setAxisValuesDecimals(decimals);
	myChart.setAxisValuesNumberX(numberX);
	myChart.setShowXValues(false);
	myChart.setGridColor('#C5A2DE');
	myChart.setLineColor('#69F');
	myChart.setLineWidth(2);
	myChart.setFlagColor('#69f');
	myChart.setFlagRadius(4);
	for(var i = 0;i < dataArr.length; i++){
		myChart.setTooltip(dataArr[i]);
	}
	for(var i = 0;i < total.length; i++){
		if(i==0){
			myChart.setLabelX([i,"(num)"+total[i][0]]);
		}
		else if(i == total.length-1){
			myChart.setLabelX([i,total[i][0]+"(time)"]);
		}else{
		    myChart.setLabelX([i,total[i][0]]);	
		}
	}
	myChart.setSize(616, 321);
	myChart.setBackgroundImage('chart_bg.jpg');
	myChart.draw();
	
	/*
	var myChart = new JSChart('graph', 'line');
	myChart.setDataArray(dataArr);
	myChart.setTitle('');
	myChart.setTitleColor('#8E8E8E');
	myChart.setTitleFontSize(11);
	myChart.setAxisNameX('');
	myChart.setAxisNameY('');
	myChart.setAxisColor('#69f');
	myChart.setAxisValuesColor('#949494');
	myChart.setAxisPaddingLeft(100);
	myChart.setAxisPaddingRight(100);
	myChart.setAxisPaddingTop(30);
	myChart.setAxisPaddingBottom(40);
	myChart.setAxisValuesDecimals(decimals);
	myChart.setAxisValuesNumberX(numberX);
	myChart.setShowXValues(false);
	myChart.setGridColor('#C5A2DE');
	myChart.setLineColor('#69F');
	myChart.setLineWidth(2);
	myChart.setFlagColor('#69f');
	myChart.setFlagRadius(4);
	for(var i = 0;i < dataArr.length; i++){
		myChart.setTooltip(dataArr[i]);
	}
	for(var i = 0;i < nameArr.length; i++){
		myChart.setLabelX(nameArr[i]);
	}
	
	myChart.setSize(616, 321);
	myChart.setBackgroundImage('chart_bg.jpg');
	myChart.draw();
	*/
}