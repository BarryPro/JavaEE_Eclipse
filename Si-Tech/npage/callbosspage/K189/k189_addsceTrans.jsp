<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �˹�ת�Զ�-תҵ����ѯά���������
�� * �汾: 1.0.0
�� * ����: 2009/08/07
�� * ����: yinzx
�� * ��Ȩ: sitech
   * modify  by yinzx 20091009 region_code
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String boss_login_no =  request.getParameter("boss_login_no");
		String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
%>
<html>
<head>
<title>����ҵ����ѯ�������</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  * 
  */
function addsceTrans(){
	
	 //add  by yinzx 20091120 ��ע������� ����
			var	obj_note_value= document.all.messegecontent.value ;
	 		var note_length=obj_note_value.replace(/[^\x00-\xff]/g,"**").length;
	 		if(note_length>1350)
	 		{
	 			rdShowMessageDialog("����Ķ������ݳ��ȹ��������������룡");
	 			return false;
			}	
			 
	if(!check(sitechform))
	{
		return false;
	}
	
	var xinval="";
	var yinval="";
  
	for(var i=0;i<6;i++)
	{
			 xinval+=$("input")[i].value+",";
  }
  
  for(var i=0;i<1;i++)
	{
			 yinval+=$("select")[i].value+",";
  }
   
	var packet = new AJAXPacket("k189_sceTrans_rpc.jsp","...");
	packet.data.add("retType","addsceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("addvalyin" ,yinval);
	packet.data.add("addvalzhi" ,document.getElementById("messegecontent").value);


	
	core.ajax.sendPacket(packet,doProcessaddsceTrans,true);
	packet=null;
}

/**
  *���ش�����
  */
function doProcessaddsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	if (retCode == "000000") {
		rdShowMessageDialog("����ҵ����ѯ������ݳɹ���");		
    closeWin();
	} else {
		rdShowMessageDialog("����ҵ����ѯ�������ʧ�ܣ�");

	}
}

// �������¼
function genid(){
		var ACCESSCODE = document.getElementById("ACCESSCODE").value;
  	var city_code = document.getElementById("city_code").value;
  	var user_class = document.getElementById("user_class").value;
  	var DIGITCODE = document.getElementById("DIGITCODE").value;
  	
  		document.sitechform.ID.value = ACCESSCODE + city_code+user_class+DIGITCODE;
  		document.sitechform.SUPERID.value = document.sitechform.ID.value.substr( 0,document.sitechform.ID.value.length -1);

}

// �������¼
function cleanValue(){
			var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			}   
}

function closeWin(){
	window.close();
}

function initValue(){

}

</script>
</head>

<body >
<form id="sitechform" name="sitechform">
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">����ҵ����ѯ�������</div></div>
		<table>
	   <tr>
  				<td class="blue">������ </td>
  				<td width="70%">
  					<input id="ACCESSCODE" name="ACCESSCODE" size="20" type="text"   v_must="1"  value="10086"  readonly >
	  			</td>
			</tr>
			<tr>
  				<td class="blue">���д��� </td>
  				<td width="70%">
  					<select id="city_code" name="city_code"  v_must="1"   >
		        <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
            		select  city_code,region_name from scallregioncode where valid_flag='Y'  order by region_code  
            </wtc:sql>
				    </wtc:qoption>	
        </select>
	  			</td>
			</tr>
		 
  				<td class="blue">�ض����̱�־ </td>
  				<td width="70%">
            <input id="TYPEID" name="TYPEID" size="20" type="text"    value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">���̵������� </td>
  				<td width="70%">
  					<input id="SERVICENAME" name="SERVICENAME" size="20" type="text"  v_must="1"  value="">
	  			</td>
			</tr>
			    
		  </tr>
		  <tr>
  				<td class="blue">����·�� </td>
  				<td width="70%">
  					<input id="DIGITCODE" name="DIGITCODE" size="20" type="text"  v_must="1"  value=""  >
	  			</td>
			</tr>
			 
			<tr>
  				<td class="blue">������ </td>
  				<td width="70%">
  					<input id="TTANSFERCODE" name="TTANSFERCODE" size="20" type="text"    value="6090" readonly>
	  			</td>
			</tr>
		
			<tr>
  				<td class="blue">�������� </td>
  				<td width="70%">
  					<textarea id="messegecontent" name="messegecontent" cols="40" rows="8"  value="" ></textarea>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">�Ƿ���ʾ </td>
  				<td width="70%">
  					<input id="VISIABLE" name="VISIABLE" size="20" type="text"    value="1">
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="���" onClick="addsceTrans()">
   				<!--	<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">  -->
   					<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
</script>