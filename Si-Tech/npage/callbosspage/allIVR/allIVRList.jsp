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
        <td class="blue">IVR���̺�</td>
        <td class="blue">��������</td>
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
var arr;
function getWorkNos()
{
	arr=window.parent.opener.cCcommonTool.allIVRInfo();
	fillDataTable(arr,document.getElementById("dataTable"));
}
function fillDataTable(retData,tableid)
{
  for(var i=0;i<retData.length;i++){
    //������
    var tr=tableid.insertRow();
    tr.insertCell().innerHTML="<input type='radio' name='staff' value='"+retData[i][0]+"' onclick='setCallNo(this.value);' >";
    for(var j=0;j<2;j++){
      //���ӱ��
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




