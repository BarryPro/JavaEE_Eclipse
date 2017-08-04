<%
   /*
   * 功能:分页
　 * 版本: v1.0
　 * 日期: 2009-02-18
   * fengss
 　*/
%>

<script>
	var resultArray;
	var currentPage;
	var maxLine;
	function pagetitle(p1,pt){
		
		var allline=window.maxLine;

		var maxPage=parseInt(allline/pageline)+1;
		if(maxPage!=1 && (allline%pageline)==0){//如果正好n页，maxPage--;处理n*perline条数据时的page多一页的问题
			maxPage--;
		}
		var str="<a onclick='gotoPage(0)' style='cursor:hand;'>第一页</a>&nbsp;&nbsp;";
		var i;
		var p=parseInt(p1);
		if(p<4)
			i=0;
		else
			i=p-4;

		for(;i<(p+6)&&i<maxPage;i++){
			if(i==p){
				str=str+"<a onclick='gotoPage("+i+")' style='cursor:hand; color:red;'>"+(i+1)+"</a>&nbsp;&nbsp;";
			}else{
				str=str+"<a onclick='gotoPage("+i+")' style='cursor:hand;'>"+(i+1)+"</a>&nbsp;&nbsp;";
			}
		}
		str+="<a onclick='gotoPage("+(maxPage-1)+")' style='cursor:hand;'>最后一页</a>&nbsp;&nbsp;";
		str+="总共有"+maxPage+"页("+allline+"条记录)";
		str+="跳转到<input type='text' id='fss_p_1' size=3><input type='button' value='跳转' onclick='gotoPage(document.all.fss_p_1.value-1)' class='b_text'>"
		document.getElementById(pt).innerHTML=str;

	}

	function clearTable(tableId){
		var rows=document.getElementById(tableId).rows.length;
		for(var i=1;i<rows;i++){//删除原有的行
			document.getElementById(tableId).deleteRow(1);
		}
	}

	function drawTable(packet,tableId,pt,process){
		window.resultArray=packet.data.findValueByName("resultArray");
		window.currentPage=packet.data.findValueByName("currentPage");
		window.maxLine=packet.data.findValueByName("maxLine");
		pagetitle(window.currentPage,pt);
		self.status="";
		clearTable(tableId);
		if(process==null){
			for(var i=0;i<window.resultArray.length;i++){
				var info=document.getElementById(tableId).insertRow();
				for(var j=0;j<window.resultArray[i].length;j++){
					info.insertCell().innerHTML="<td>"+window.resultArray[i][j]+"</td>";

				}
			}
		}else{
			process(window.resultArray,tableId);
		}
	}




</script>