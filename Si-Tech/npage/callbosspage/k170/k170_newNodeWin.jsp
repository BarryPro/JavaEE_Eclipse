<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����(ҵ���߼�)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:  yinzx 2009/07/17  �ͷ����ܵ���  1.�޸Ļ�ȡ���еķ����� ʹ��sPubSelect 2 �޸��˻�ȥ���е���� ȥ�������� valid_flag = 'Y' 3.ȥ����е��¼�  onchange="region.value=this.options[this.selectedIndex].tex" �����Ϊ��Ҫ�����
   * modify by 20091009  �޸�regioncode�� 
*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>����ԭ����Ϣά��</title>

<script language=javascript>

// �������¼
function cleanValue(){
document.getElementById("groupName").value="";
document.getElementById("region_code").value="";	
document.getElementById("note").value="";	
var obj = document.getElementsByName("flag")[0];
if(obj.checked==true)
 {	
  obj.checked=false;
 } 	
}

function closeWin(){
	window.close();
}
function getFlag()
{
  var obj = document.getElementsByName("flag")[0]; 
     var check;
      if(obj.checked == true){///ѡ�� 
           check="1";
      } 
      if(obj.checked == false){///ȡ�� 
            check="0";
      } 
    return check;
}
function addNewNode(){
	var nodeName = document.getElementById("groupName").value;
	var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
	var parNode=document.getElementById("parNode").value;
	var cityid=document.getElementById("region_code").value;
	var flag=getFlag();
	var note=document.getElementById("note").value;
	
	if(nodeName == ""){
		rdShowMessageDialog("����������ԭ�����ƣ�",1);
		return;
	}if(cityid == ""){
		rdShowMessageDialog("�������������У�",1);
		return;
	}
	window.opener.insertNewNode(parNode,nodeName,strValue,note,cityid,flag);
	window.close();
}
function showObjectCheckTree(){
  openWinMid('k280_objectIdTree.jsp','ѡ�񱻼�������',300, 250);
}

function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ��;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/1.1; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/1.4; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>

<body >
	<%
	     /*midify by yinzx 20091113 ������ѯ�����滻*/
 
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
	%>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
						<tr>
  				<td class="blue">�ڵ����</td>
  				<td width="70%">
<select name="nodeType" size="1" id="nodeType"  
    onChange="changeType();">
 <option value="0" selected>ͬ��ڵ�</option>
 <option value="1">ͬ���ӽڵ�</option>
</select>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">�ϲ�ڵ���</td>
  				<td width="70%">
      <input id="parNode" name ="parNode" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">�ϲ�ڵ�����</td>
  				<td width="70%">
       <input id="nodeName" name ="nodeName" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">�����ڵ�����</td>
  				<td  width="70%">
  					<input id="groupName" name ="groupName" size="20" type="text" value="">
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">��������</td>
  				<td  width="70%">
  				<select id="region_code" name="1_=_region_code" size="1" onchange="">
  				<option value="" selected>--ѡ�����--</option>
				   <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag='Y' order by region_code</wtc:sql>
				   </wtc:qoption>	
        </select>
	    			<font color="orange">*</font>
	    			<input id="flag" type="checkbox" name="flag" checked onclick="getFlag()">�Ƿ���ʾ
	  			</td>	
			</tr>
			
			<tr>
  				<td class="blue">����</td>
  				<td  width="60%">
  					<textarea name="note" cols="30" rows="4"></textarea>

	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="addNewNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<SCRIPT type=text/javascript> 
//�ڵ�ѡ���¼�
initValue();	
function initValue(){	
	var selectItemId =window.opener.tree.getSelectedItemId();
	var level=window.opener.tree.getLevel(selectItemId);
	if(level=='1'){
		  
		  document.getElementById("nodeName").value=window.opener.tree.getSelectedItemText();
	    document.getElementById("parNode").value=window.opener.tree.getSelectedItemId();
	    document.getElementById("nodeType").value="1";
	    document.getElementById("nodeType").disabled = true;
		}else{
	    var parnertId    =window.opener.tree.getParentId(selectItemId);	
      var parnertName  =window.opener.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;
			}


}

function changeType(){
     var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
     var selectItemId =window.opener.tree.getSelectedItemId();
		if(strValue=="0"){
			var parnertId    =window.opener.tree.getParentId(selectItemId);	
      var parnertName  =window.opener.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;

		}else{
			document.getElementById("nodeName").value=window.opener.tree.getSelectedItemText();
	    document.getElementById("parNode").value=selectItemId;
		}	
	}

</SCRIPT>
