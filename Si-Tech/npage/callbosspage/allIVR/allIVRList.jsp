<%
  /*
   * 功能: 坐席列表页面
　 * 版本: 1.0.0
　 * 日期: 2008/10/20
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K014";
	//String opName = "获得坐席列表";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>坐席列表</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
</head>
<body onload="getWorkNos();">
<form  name=formbar>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">选择</td>
        <td class="blue">IVR流程号</td>
        <td class="blue">名称描述</td>
      </tr>
      
      </table>
    </div>
    <br/>
    </td>
  </tr>
</table>

</form>
</body>
</html>

<script>
/*对返回值进行处理*/
var arr;
function getWorkNos()
{
	arr=window.parent.opener.cCcommonTool.allIVRInfo();
	fillDataTable(arr,document.getElementById("dataTable"));
}
function fillDataTable(retData,tableid)
{
  for(var i=0;i<retData.length;i++){
    //增加行
    var tr=tableid.insertRow();
    tr.insertCell().innerHTML="<input type='radio' name='staff' value='"+retData[i][0]+"' onclick='setCallNo(this.value);' >";
    for(var j=0;j<2;j++){
      //增加表格
      tr.insertCell().innerHTML=retData[i][j];
    }
  }
}


function setCallNo(callNo)
{
parent.document.getElementById("called_no_agent").value = callNo;
 var els=document.all("staff")
 for(var i=0;i<els.length;i++){
   if(els[i].checked){
   parent.document.getElementById("transagent").value=arr[i][2];
   }
 }

}


</script>




