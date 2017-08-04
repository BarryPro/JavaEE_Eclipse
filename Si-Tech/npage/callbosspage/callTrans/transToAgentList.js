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
	String region=request.getParameter("org_id");
	String brand=request.getParameter("class_id");
	String staffstatus=request.getParameter("staffstatus");
	System.out.println("------------------------------------------------------");
	System.out.println("------------------------------------------------------");
	System.out.println("-----------   "+region+" "+brand+" "+staffstatus+"--------------");
	System.out.println("------------------------------------------------------");
	System.out.println("------------------------------------------------------");
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
        <td class="blue">工号</td>
        <td class="blue">地市</td>
        <td class="blue">BOSS工号</td>
        <td class="blue">状态</td>
        <td class="blue">姓名</td>
        <td class="blue">班组</td>
        <td class="blue">班长</td>
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
var worknos;
function doProcess(packet)
{
	//alert("Begin call doProcess()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	 worknos = packet.data.findValueByName("worknos");
	//alert(retType);
	//alert(retCode);
	//alert(retMsg);
	if(retType=="getworknos"){
		if(retCode=="000000"){
			//alert("成功获取坐席列表信息!");
			//alert(worknos);
			fillDataTable(worknos,document.getElementById("dataTable"));
		}else{
			//alert("无法获取坐席列表信息!");
			return false;
		}
	}
	//alert("End call doProcess()......");
}

/*发送mac地址，获得本机mac地址*/
function getWorkNos()
{
	//alert("Begin call getWorkNos()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/innerHelp/get_work_nos.jsp","正在获取本机配置信息,请稍后...");
    chkPacket.data.add("retType", "getworknos");
    chkPacket.data.add("org_id", "<%=request.getParameter("org_id")%>");
    chkPacket.data.add("class_id", "<%=request.getParameter("class_id")%>");
    chkPacket.data.add("staffstatus", "<%=request.getParameter("staffstatus")%>");
    chkPacket.data.add("endNum", "<%=request.getParameter("endNum")%>");
    core.ajax.sendPacket(chkPacket);
    //core.ajax.sendPacket(chkPacket,doProcessNew,true);
	//chkPacket =null;
	//alert("End call getWorkNos()....");
}


function fillDataTable(retData,tableid)
{
  for(var i=0;i<retData.length;i++){
    //增加行
    var tr=tableid.insertRow();
    tr.insertCell().innerHTML="<input type='radio' name='staff' value='"+retData[i][0]+"' onclick='setCallNo(this.value);' >";
    for(var j=0;j<7;j++){
      //增加表格
      tr.insertCell().innerHTML=retData[i][j];
    }
  }
}


function setCallNo(callNo)
{
parent.document.getElementById("called_no_agent").value = callNo;
parent.document.getElementById("transagent").value=worknos[0][2];
 var els=document.all("staff")
 for(var i=0;i<els.length;i++){
   if(els[i].checked){
   parent.document.getElementById("transagent").value=worknos[i][2];
   }
 }

}


</script>



