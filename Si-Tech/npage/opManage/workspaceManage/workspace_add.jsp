<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="����������ģ��";
	String workspace_id = request.getParameter("workspace_id")!=null?(String)request.getParameter("workspace_id"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String wCode = "";
	String wName = "";
	String wShow = "";
	String wSrc = "";
	if(!"".equals(workspace_id)){
		String sql = "select wkspace_id,wkspace_name,wkspace_src,is_effect from dwkspacemsg where wkspace_id=:wkspace_id";
		String param = "wkspace_id="+workspace_id;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			wCode  = workspace[0][0];  
			wName  = workspace[0][1];  
			wSrc   = workspace[0][2]; 
			wShow  = workspace[0][3];
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������ģ������</title>
</head>
<body>
<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">��ӹ�����ģ��</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">ģ��ID</td>
							<td class="blue">
								<select id="wCode">
										<option value='div1'>div1</option>
										<option value='div3'>div3</option>
										<option value='div4'>div4</option>
										<option value='div5'>div5</option>
										<option value='div6'>div6</option>
										<option value='div7'>div7</option>
										<option value='div8'>div8</option>
										<option value='div9'>div9</option>
										<option value='div10'>div10</option>
										<option value='div11'>div11</option>
									</select>
							</td>
							<td class="blue">ģ������</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="64" id="wName" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							<td class="blue">ģ��·��</td>
							<td class="blue">
								<select id="wSrc">
										<option value='getHotKey.jsp'>getHotKey.jsp</option>
										<option value='getNotice2.jsp'>getNotice2.jsp </option>
										<option value='getFavFunc.jsp'>getFavFunc.jsp</option>
										<option value='getNotice.jsp'>getNotice.jsp</option>
										<option value='getSysnotice.jsp'>getSysnotice.jsp</option>
										<option value='getMessage.jsp'>getMessage.jsp</option>
										<option value='taskInfo.jsp'>taskInfo.jsp</option>
										<option value='custordersTip.jsp'>custordersTip.jsp</option>
										<option value='getProduceMessage.jsp'>getProduceMessage.jsp</option>
										<option value='getReportName.jsp'>getReportName.jsp</option>
									</select>
									
								</td>					
							<td class="blue">�Ƿ�����</td>
							<td class="blue">
							    <select id="wShow">
										<option value="0">��</option>	
										<option value="1" selected >��</option>
								</select>
							</td>							
						</tr>
												
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add" style="display:none" type=button value="����" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="update" id="update" style="display:none" type=button value="�޸�" onclick="doUpate()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="ȡ��" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<div id="ts" style=" position:absolute;border:1px green solid; z-index:5; height:20px; font-size:12px; width:180px; display:none;">&nbsp;&nbsp;&nbsp;ͬʱ����ctrl+enterҲ���ύ</div>
<script>
$(document).ready(function(){
	$("#add").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#add").bind("mouseout", function(){
		$("#ts").hide();
	}) ;
	$("#update").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#update").bind("mouseout", function(){
		$("#ts").hide();
	}) ;
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
 		if(<%=workspace_id!=""%>){
 			doUpate();
 		}else{
 			doAdd();
 		}
	}
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
var ser;
var checkwCode = "";
var retVal = "";//���ظ�ҳ���ֵ

$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
	if(<%=workspace_id!=""%>){
		document.getElementById('wCode').value ='<%=wCode%>';
		document.getElementById('wName').value ='<%=wName%>';
		document.getElementById('wShow').value ='<%=wShow%>';
		document.getElementById('wSrc').value ='<%=wSrc%>';
		document.getElementById('update').style.display = "";
		document.all.wCode.disabled=true;

	}else{
		document.getElementById('add').style.display = "";
	}
})

//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function doAdd()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	var wCode = document.getElementById('wCode').value;
	var wName = document.getElementById('wName').value.trim();
  	var wShow = document.getElementById('wShow').value;
  	var wSrc = document.getElementById('wSrc').value;
	
	if(wName==""){
		rdShowMessageDialog("����д��������");
		document.getElementById('wName').value = "";
		document.getElementById('wName').focus();
		return;
	}
	
    if(rdShowConfirmDialog("����ģ��IDΪ"+wCode+"��ȷ��Ҫ������")==1)
    {
		//����wCode�Ƿ��Ѿ����� ����workspace_op.jsp?opType=check----
		doCheck();
		if(checkwCode=="1"){//�����ڷ���true����������
				document.getElementById('add').disabled = "disabled";
				//���� workspace_op.jsp?opType=add,������Ӳ���
				var chkPacket = new AJAXPacket("workspace_op.jsp","����ִ��,���Ժ�...");
		  	chkPacket.data.add("opType", "add");
		  	chkPacket.data.add("wCode", wCode.trim());
		  	chkPacket.data.add("wName", wName.trim());
		  	chkPacket.data.add("wSrc", wSrc.trim());
		  	chkPacket.data.add("wShow", wShow.trim());
		 		core.ajax.sendPacket(chkPacket,doFunction,true);
		  	chkPacket = null;  
		}else if(checkwCode=="0"){
			rdShowMessageDialog("ģ���Ѿ����ڣ����������룡",0);
			document.getElementById('wCode').value="div1";
			document.getElementById('wCode').focus();
			return false;
		}else{
			rdShowMessageDialog("ϵͳ��������ϵϵͳ����Ա��",0);
			return false;
		}
	}
}

    
//�����޸ĺ������
function doUpate()
{
	
	/*
	if(!check(frm)){
		return false;
	}
	*/
	var wCode = document.getElementById('wCode').value;
	var wName = document.getElementById('wName').value.trim();
  	var wShow = document.getElementById('wShow').value;
  	var wSrc = document.getElementById('wSrc').value;
	
	if(wName==""){
		rdShowMessageDialog("����д��������");
		document.getElementById('wName').value = "";
		document.getElementById('wName').focus();
		return;
	}
	
		document.getElementById('update').disabled = "disabled";
		//���� workspace_op.jsp?opType=update,�����޸Ĳ���
		var chkPacket = new AJAXPacket("workspace_op.jsp","����ִ��,���Ժ�...");
  	chkPacket.data.add("opType", "update");
  	chkPacket.data.add("wCode", wCode.trim());
  	chkPacket.data.add("wName", wName.trim());
  	chkPacket.data.add("wSrc", wSrc.trim());
  	chkPacket.data.add("wShow", wShow.trim());
  	chkPacket.data.add("wOldCode", "<%=wCode%>");
 		core.ajax.sendPacket(chkPacket,doFunction,true);
  	chkPacket = null; 
	
}


function doCheck()//У��ģ���Ƿ����
{     
      var wCode = document.getElementById('wCode').value;
      var chkPacket = new AJAXPacket("workspace_op.jsp","������֤,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("wCode", wCode.trim());
      core.ajax.sendPacket(chkPacket,doFunction,false);
      chkPacket = null; 
}


 function doFunction(packet)      
 {
       var opType = packet.data.findValueByName("opType"); 
       var retCode = packet.data.findValueByName("retCode"); 
       var retMsg = packet.data.findValueByName("retMsg"); 
       if(opType.trim()=="check"){      	
	        if(retCode=="000000"){   
	        	var isAdd = packet.data.findValueByName("isAdd");  
	        	if(isAdd=="0"){  //����0ʱ�����ڣ����Լ������         
	                checkwCode = "1";
	          	}else if(isAdd=="1"){//����1ʱ���������Ѿ�����
	          		checkwCode = "0";
	          	}else{//δ֪����
	          		checkwCode = "2";
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸�ģ��ɹ���",2);
							  window.opener.queryTemplate();
							  window.close();
	        }else{
	        			rdShowMessageDialog("�޸�ģ��ʧ�ܣ�",0);
	        			document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("����ģ��ɹ���",2);
							  window.opener.queryTemplate()
							  window.close(); 
	        }else{
	        			rdShowMessageDialog("����ģ��ʧ�ܣ�",0);
	        			document.getElementById('add').disabled = "";
	        }
       }
   }


</script> 
</body>
</html>