<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="��������ģ��";
	String theme_css = request.getParameter("theme_css")!=null?(String)request.getParameter("theme_css"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tCode = "";
	String tName = "";
	String tShow = "";
	if(!"".equals(theme_css)){
		String sql = "select theme_css,theme_name,is_effect from dthememsg where theme_css=:theme_css";
		String param = "theme_css="+theme_css;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="theme" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			tCode  = theme[0][0];  
			tName  = theme[0][1];  
			tShow  = theme[0][2]; 
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ģ������</title>
</head>
<body>
<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">�������</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">������</td>
							<td class="blue">
								 
								<select id="tCode">
										<option value='default'>������</option>
										<option value='orange'>���ó�</option>
									</select>
							</td>
							<td class="blue">��������</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="32" id="tName" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
												
							<td class="blue">�Ƿ񷢲�</td>
							<td class="blue">
							    <select id="tShow">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
								</select>
							</td>
							<td class="blue">&nbsp;</td>
							<td class="blue">&nbsp;</td>
						</tr>
												
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="addbut" style="display:none" type=button value="����" onclick="doAdd()">
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
	$("#addbut").bind("mousemove", function(){
		$("#ts").show();
		var dd=document.all.ts;
		dd.style.top=event.clientY;
		dd.style.left=event.clientX;
	}) ;
	$("#addbut").bind("mouseout", function(){
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
		if(<%=theme_css!=""%>){
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
var checktCode = "";
var retVal = "";//���ظ�ҳ���ֵ

$(document).ready(function(){
	if(<%=theme_css!=""%>){
		document.getElementById('tCode').value ='<%=tCode%>';
		document.getElementById('tName').value ='<%=tName%>';
		document.getElementById('tShow').value ='<%=tShow%>';
		document.getElementById('update').style.display = "";
		document.all.tCode.disabled=true;
	}else{
		document.getElementById('add').style.display = "";
	}
})

//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function doAdd()
{
	var tCode = document.getElementById('tCode').value;
	var tName = document.getElementById('tName').value.trim();
    var tShow = document.getElementById('tShow').value;
	
	if(tName==""){
		rdShowMessageDialog("����д��������");
		document.getElementById('tName').value = "";
		document.getElementById('tName').focus();
		return;
	}
    if(rdShowConfirmDialog("���������������޸ģ�ȷ��Ҫ������")==1)
    {
		//����tCode�Ƿ��Ѿ����� ����theme_op.jsp?opType=check----
		doCheck();
		if(checktCode=="1"){//�����ڷ���true����������
	  		//���� theme_op.jsp?opType=add,������Ӳ���
			var chkPacket = new AJAXPacket("theme_op.jsp","����ִ��,���Ժ�...");
		  	chkPacket.data.add("opType", "add");
		  	chkPacket.data.add("tCode", tCode.trim());
		  	chkPacket.data.add("tName", tName.trim());
		  	chkPacket.data.add("tShow", tShow.trim());
		 	core.ajax.sendPacket(chkPacket,doFunction,true);
		  	chkPacket = null;  
		}else if(checktCode=="0"){
			rdShowMessageDialog("�����Ѿ����ڣ����������룡",0);
			document.getElementById('tCode').value="default";
			document.getElementById('tCode').focus();
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
	var tCode = document.getElementById('tCode').value;
	var tName = document.getElementById('tName').value.trim();
  var tShow = document.getElementById('tShow').value;
	
	if(tName==""){
		rdShowMessageDialog("����д��������");
		document.getElementById('tName').value = "";
		document.getElementById('tName').focus();
		return false;
	}
    
    if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
		//���� theme_op.jsp?opType=update,�����޸Ĳ���
		var chkPacket = new AJAXPacket("theme_op.jsp","����ִ��,���Ժ�...");
	  	chkPacket.data.add("opType", "update");
	  	chkPacket.data.add("tCode", tCode.trim());
	  	chkPacket.data.add("tName", tName.trim());
	  	chkPacket.data.add("tShow", tShow.trim());
	 	core.ajax.sendPacket(chkPacket,doFunction,true);
	  	chkPacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
      var tCode = document.getElementById('tCode').value;
      var chkPacket = new AJAXPacket("theme_op.jsp","������֤,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("tCode", tCode.trim());
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
	                checktCode = "1";
	          	}else if(isAdd=="1"){//����1ʱ���������Ѿ�����
	          		checktCode = "0";
	          	}else{//δ֪����
	          		checktCode = "2";
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸�����ɹ���",2);
				  window.opener.queryTemplate();
				  window.close();
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("��������ɹ���",2);
				  window.opener.queryTemplate();
				  window.close(); 
	        }
       }
   }


</script> 
</body>
</html>