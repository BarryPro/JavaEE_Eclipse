<%
   /*
   * ����:��ҳ
�� * �汾: v1.0
�� * ����: 2009-02-18
   * fengss
 ��*/
%>

<script>
	var resultArray;
	var currentPage;
	var maxLine;
	function pagetitle(p1,pt){
		
		var allline=window.maxLine;

		var maxPage=parseInt(allline/pageline)+1;
		if(maxPage!=1 && (allline%pageline)==0){//�������nҳ��maxPage--;����n*perline������ʱ��page��һҳ������
			maxPage--;
		}
		var str="<a onclick='gotoPage(0)' style='cursor:hand;'>��һҳ</a>&nbsp;&nbsp;";
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
		str+="<a onclick='gotoPage("+(maxPage-1)+")' style='cursor:hand;'>���һҳ</a>&nbsp;&nbsp;";
		str+="�ܹ���"+maxPage+"ҳ("+allline+"����¼)";
		str+="��ת��<input type='text' id='fss_p_1' size=3><input type='button' value='��ת' onclick='gotoPage(document.all.fss_p_1.value-1)' class='b_text'>"
		document.getElementById(pt).innerHTML=str;

	}

	function clearTable(tableId){
		var rows=document.getElementById(tableId).rows.length;
		for(var i=1;i<rows;i++){//ɾ��ԭ�е���
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