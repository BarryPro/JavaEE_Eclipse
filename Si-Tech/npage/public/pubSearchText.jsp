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
	/* 模糊搜索js函数入口
     searchId :		模糊搜索匹配的下拉框的name，建议id与name相同
     searchType :	模糊搜索的输入文本框的name，建议id与name相同
     splitFlag :  下拉框键值以什么分隔，默认为 -->
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
	/* 获取下拉框中的所有匹配结果，循环 */
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
	/* 设置搜索框样式 */
	var end = queryField.offsetWidth;
	var left  = calculateOffsetLeft(queryField);
	var top  = calculateOffsetTop(queryField) + queryField.offsetHeight;
	
	tableDiv.style.border = "red 1px solid";
	tableDiv.style.left = left + "px";
	tableDiv.style.top = top + "px";
	blurSearchResultTable.style.width = end + "px";
}

function populateResult(cell,serchId,splitFlag){
	/* 	设置搜索框文字为选中的选项文字
			设置下拉框选中的为选中的选项
	*/
	queryField.value = cell.firstChild.nodeValue;
	queryField = document.getElementById(serchId);
	queryField.value=cell.firstChild.nodeValue.split(splitFlag)[0];
	clearResults();
}

function clearResults(){
	/* 清空搜索结果 */
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