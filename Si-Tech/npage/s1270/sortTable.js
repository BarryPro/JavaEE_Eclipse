function openDivWin(winURL, winTitle, winWidth, winHeight, backFunc){
				showWinCover();
				var winID = "divWin"+($(".window").length+1);
				var winNum = $(".window").length;
				if(backFunc){
					if(winURL.indexOf("?") != -1){
						winURL += "&backFunc=" + backFunc;
					}else{
						winURL += "?backFunc=" + backFunc;
					}
				}
				var divHtml = "<div class='window' id="+winID+" >";
				divHtml += "<div class='caption'>";
				divHtml += "<div class='title'>";
				divHtml += "<span class='shadow'>" + winTitle + "</span><span class='text'>" + winTitle + "</span>";
				divHtml += "</div>";
				divHtml += "<div class='close' id='divWinClose' onclick='removeDivWin(\""+winID+"\")'></div>";
				divHtml += "</div>";
				divHtml += "<div class='box'>";
				divHtml += "</div>";
				divHtml += "</div>";
				$("body:first").append(divHtml);
				$("#" + winID + " .box").height(winHeight);
				$("#" + winID).width(winWidth);
			
				var parentObj = $("#operation_table");
				if(parentObj.length == 0){
					parentObj = $("body");
				}
				h = parentObj.height();
				w = parentObj.width();
			
				var xleft = w/2 - $("#"+winID).width()/2;
				var xtop = h/2 - $("#"+winID).height()/4
			
				$("#"+winID).css("left",xleft);
				$("#"+winID).css("top",xtop);
				
				
				var iframe=document.createElement("<iframe src='' style='border-width:0;width:100%;height:100%' frameborder='0'></iframe>");
				$("#"+winID+" .box").append(iframe);
				setTimeout(function(){iframe.src=winURL},0)
			
				
			}
			
			
			function sortTable(tableID, sortColumn, nodeType)
			{
			//get table.
			var table = document.getElementById(tableID);
			
			//get tbody.
			var tableBody = table.tBodies[0];
			
			//table rows.
			var tableRows = tableBody.rows;
			
			var rowArray = new Array();
			
			//initial row array.
			for (var i=0; i<tableRows.length; i++)
			{
			rowArray[i] = tableRows[i];
			}
			
			if(table.sortColumn == sortColumn)
			{
			rowArray.reverse();
			}
			else
			{
			rowArray.sort(generateCompareTR(sortColumn, nodeType));
			}
			
			var tbodyFragment = document.createDocumentFragment();
			for(var i=0; i< rowArray.length; i++)
			{
			tbodyFragment.appendChild(rowArray[i]);
			}
			
			tableBody.appendChild(tbodyFragment);
			table.sortColumn = sortColumn;
			}
			
			function generateCompareTR(sortColumn, nodeType)
			{
			return function compareTR(trLeft, trRight){
			var leftValue = convert(trLeft.cells[sortColumn].firstChild.nodeValue, nodeType);
			var rightValue = convert(trRight.cells[sortColumn].firstChild.nodeValue, nodeType); 
			switch(nodeType)
			{
					case "zh": 
						//alert(leftValue.localeCompare(rightValue));
						return(leftValue.localeCompare(rightValue));
					default:
						if(leftValue<rightValue)
						{
						return -1;
						}
						else if(leftValue>rightValue)
						{
						return 1;
						}
						else
						{
						return 0
						}
				 
			}
			
			}
			
			
			}
			
			function convert(value, dataType)
			{
			switch(dataType)
			{
			case "int":
			return parseInt(value);
			case "float":
			return parseFloat(value);
			case "date":
			return new Date(Date.parse(value));
			case "yyyy-mm-dd":
			return getSortDate(value,"yyyy-mm-dd");
			case "zh":
			return value;
			default:
			return value.toString();
			}
			}
			
			function  getSortDate(val,format){
				var arr = new  Array();
				if(format.toLowerCase()=="yyyy-mm-dd"){
					arr = val.split("-");
					return  new  Date(arr[1]+"-"+arr[2]+"-"+arr[0]);
				}
				
				if(format.toLowerCase()=="yyyy/mm/dd"){
					arr = val.split("/");
					return  new  Date(arr[1]+"-"+arr[2]+"-"+arr[0]);
				}
				
				if(format.toLowerCase()=="yyyymmdd"){
					return  new  Date(val.substr(4,6)+"-"+val.substr(6,8)+"-"+val.substr(0,4));
				}
				
			}
