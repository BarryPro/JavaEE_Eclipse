<%
  /*
   * ����: ��ϯ�б�ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/10/20
�� * ����: mixh
�� * ��Ȩ: sitech
   *update:
��*/
%>
<%
	//String opCode = "K014";
	//String opName = "�����ϯ�б�";
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
<title>��ϯ�б�</title>
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
        <td class="blue">ѡ��</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <td class="blue">BOSS����</td>
        <td class="blue">״̬</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <td class="blue">�೤</td>
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
/*�Է���ֵ���д���*/
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
			//alert("�ɹ���ȡ��ϯ�б���Ϣ!");
			//alert(worknos);
			fillDataTable(worknos,document.getElementById("dataTable"));
		}else{
			//alert("�޷���ȡ��ϯ�б���Ϣ!");
			return false;
		}
	}
	//alert("End call doProcess()......");
}

/*����mac��ַ����ñ���mac��ַ*/
function getWorkNos()
{
	//alert("Begin call getWorkNos()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/innerHelp/get_work_nos.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
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
    //������
    var tr=tableid.insertRow();
    tr.insertCell().innerHTML="<input type='radio' name='staff' value='"+retData[i][0]+"' onclick='setCallNo(this.value);' >";
    for(var j=0;j<7;j++){
      //���ӱ��
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



