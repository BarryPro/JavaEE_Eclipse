<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<%
String opName  = "参照页面";
String opCode = "";
String dataConsult = request.getParameter("dataConsult");
String[] dataV = dataConsult.split("~");
String productspec_number = "";
for(int i=0;i<dataV.length;i++){
    String[] dataRows = dataV[i].split("\\$");
    String[] dataNodes = dataRows[0].split("\\^");
   
    productspec_number += "'"+dataNodes[3]+"'";
    if(i==(dataV.length-1))
      break;
    productspec_number += ",";
}
String sql = "SELECT productspec_name,productspec_number FROM dproductspecInfo WHERE productspec_number IN ("+productspec_number+")";

  // out.print("["+sql+"]");
%>

<wtc:pubselect name="sPubSelect" routerKey="region"  retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<head>
<title>参照页面</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	var curPage = 0;
  
	
	function inita(){
		var dataConsult = '<%=dataConsult%>';
	  //alert(dataConsult);
    var dataV = dataConsult.split('~');
    var testDis = '';
    for(var i=0;i<dataV.length-1;i++){
    var dataR = dataV[i].split('$');
      for(var j=0;j<dataR.length;j++){
      	var dataC = dataR[j].split('^');
      	for(var k=0;k<dataC.length;k++){
      		testDis+=dataC[k];
      		testDis+='|';
      	}	  	
      	testDis+='<br>';
      }
     testDis+='<hr>';
    }
   document.getElementById('dis').innerHTML = testDis; 
	}
	
function initb(){
	  
	  
	  
	  
	  var rows = document.getElementById("tabBody").rows;
	  for(var i=0;i<rows.length;i++){  
      rows[i].removeNode(true);
      i--;
    }


	  //document.getElementById("newbody").deleteRow();
	  //alert(document.getElementById("tabBody").innerHTML);
	  var dataConsult = '<%=dataConsult%>';
    var dataV = dataConsult.split('~');
		var dataR = dataV[curPage/1].split('$');
		for(var j=0;j<dataR.length;j++){
		    var row=document.createElement("tr"); 
  	    var dataC = dataR[j].split('^');
  	    for(var k=0;k<3;k++){
  	    	var cell=document.createElement("td"); 	  	   	
  	 	    cell.appendChild(document.createTextNode(dataC[k])); 	  	  	
  	    	row.appendChild(cell);
  	    }	  	  	  
  	    var cell=document.createElement("td"); 	  	   	
        cell.appendChild(document.createTextNode(dataC[4])); 
        row.appendChild(cell);	  
        document.getElementById("tabBody").appendChild(row);
    }	
    
    var maxPageNum = dataV.length-2;
    if(curPage/1>=maxPageNum){
    	document.getElementById("down").disabled='disabled';
    }else{
    	document.getElementById("down").disabled='';
    }
    if(curPage/1<=0){
    	document.getElementById("up").disabled='disabled';
    }else{
    	document.getElementById("up").disabled='';
    }
    
    
    for(var i = 0;i<maxPageNum+1;i++){
    	var butTab = document.getElementById('tab'+i);
    	butTab.disabled='';
    }
    document.getElementById('tab'+curPage).disabled='disabled';
}
	
	
</script>

</head>

	
<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="initb(0);" >
<%@ include file="/npage/include/header_pop.jsp" %> 
<form name="form1" method="post" action="">	
<div id=dis ></div>
<div style="height: 360px;width: 99%;overflow: auto">

<%for(int i=0;i<result.length;i++){%>
	<input class='b_text' style='height:25px' type=button value='<%=result[i][0]%>' onClick="curPage=<%=i%>;initb();" id='tab<%=i%>' >&nbsp;
<%}%>
<br>
<table>
	
	<tr align="center">
		<th>产品属性代码</th>
		<th>属性名</th>
		<th>属性值</th>
		<th>属性值归属组</th>
	</tr>
	<TBODY id=tabBody>
  </TBODY>
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
            	<!-- <input class='b_foot' type=button value='TEST' onClick='inita();' id='TEST'  />&nbsp;-->
            	<input class='b_foot' type=button value='上一页' onClick='curPage-=1;initb();' id='up'  />&nbsp;
	            <input class='b_foot' type=button value='下一页' onClick='curPage+=1;initb();' id='down' />&nbsp;
              <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>
	</div>

</form>                                 
<%@ include file="/npage/include/footer.jsp" %>     

</body>
</html>
