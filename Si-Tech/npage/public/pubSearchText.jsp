<div style="position:absolute;z-index:100;" id="blurSearchTableDiv">
	<table id="blurSearchResultTable" bgcolor="#FFFAFA" border="0" cellspacing="0" 
		 cellpadding="0" style="font-size:12px;color:black"/>     
		<tbody id="blurSearchResultTableBody"></tbody>
	</table>
</div>

<script language="javascript">
	var queryField ;
	var blurSearchResultTableBody = document.getElementById("blurSearchResultTableBody");
	var tableDiv = document.getElementById("blurSearchTableDiv");

function blurSearchFunc(serchId,searchType,splitFlag){	
	/* ģ������js�������
     searchId :		ģ������ƥ����������name������id��name��ͬ
     searchType :	ģ�������������ı����name������id��name��ͬ
     splitFlag :  �������ֵ��ʲô�ָ���Ĭ��Ϊ -->
	*/
	if(typeof(splitFlag) == "undefined"){
		splitFlag = "-->";
	}
	var array1 = document.getElementById(searchType).value.split(' ');
	queryField = document.getElementById(searchType);
	blurSearchResultTableBody = document.getElementById("blurSearchResultTableBody");
	tableDiv = document.getElementById("blurSearchTableDiv");
	clearResults();
	setOffsets();
	var row, cell, txtNode;
	/* ��ȡ�������е�����ƥ������ѭ�� */
	$("select[name="+serchId+"] option:contains('"+array1+"')").each(function(i,n){	
		var nextNode =$(n).text();
		row = document.createElement("tr");
		cell = document.createElement("td");            
		cell.onmouseout = function() {this.className='mouseOver';};
		cell.onmouseover = function() {this.className='mouseOut';};
		cell.setAttribute("bgcolor", "#FFFAFA");
		cell.setAttribute("border", "0");
		cell.setAttribute("align", "left");
		$(cell).css("cursor", "hand");
		cell.onclick = function() { populateResult(this,serchId,splitFlag);blurSearchFunc(serchId,searchType,splitFlag); clearResults();} ;
		txtNode = document.createTextNode(nextNode);
		cell.appendChild(txtNode);
		row.appendChild(cell);
		blurSearchResultTableBody.appendChild(row);
	});
}


function setOffsets() {
	/* ������������ʽ */
	var end = queryField.offsetWidth;
	var left  = calculateOffsetLeft(queryField);
	var top  = calculateOffsetTop(queryField) + queryField.offsetHeight;
	
	tableDiv.style.border = "red 1px solid";
	tableDiv.style.left = left + "px";
	tableDiv.style.top = top + "px";
	blurSearchResultTable.style.width = end + "px";
}

function populateResult(cell,serchId,splitFlag){
	/* 	��������������Ϊѡ�е�ѡ������
			����������ѡ�е�Ϊѡ�е�ѡ��
	*/
	queryField.value = cell.firstChild.nodeValue;
	queryField = document.getElementById(serchId);
	queryField.value=cell.firstChild.nodeValue.split(splitFlag)[0];
	clearResults();
}

function clearResults(){
	/* ���������� */
	$("#blurSearchResultTableBody").html("");
	tableDiv.style.border = "none";
}

function calculateOffsetLeft(field){
	return calculateOffset(field, "offsetLeft");
}

function calculateOffsetTop(field) {
	return calculateOffset(field, "offsetTop");
}

function calculateOffset(field, attr) {
	var offset = 0;
	while(field) {
		offset += field[attr]; 
		field = field.offsetParent;
	}
	return offset;
}
</script>