<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="����������ͨѶ";
	String commun_seq = request.getParameter("commun_seq")!=null?(String)request.getParameter("commun_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String wkCode = "";
	String wkName = "";
	String wkShow = "";
	String wkField = "";
	if(!"".equals(commun_seq)){
		String sql = "select to_char(seq),wkspace_code,wkspace_name,field,is_effect from dcommunicate where seq=:commun_seq";
		String param = "commun_seq="+commun_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			wkCode  = workspace[0][1];  
			wkName  = workspace[0][2];  
			wkField   = workspace[0][3]; 
			wkShow  = workspace[0][4];
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������ģ������</title>
</head>
<body  >
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">��ӹ�����ģ��</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">����������</td>
							<td class="blue">
								<!--input type="text" v_must=1 v_type="string" v_maxlength="16" maxlength="16" id="wkCode" value=""/><font class="orange">*</font-->
								<select id="wkCode" onchange="setNameAndFieId()">
									<option value="">--��ѡ��--</option>
									<option value="e487">e487</option>
									<option value="e484">e484</option>
									<option value="e485">e485</option>
								</select>
							</td>
							<td class="blue">����������</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="64" id="wkName" readOnly value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							<td class="blue">ͨѶ�ֶ�</td>
							<td class="blue">
								<!--input type="text" v_must=1 v_type="string" v_maxlength="1024" id="wkField" value=""/><font class="orange">*</font-->
								<select id="wkField" >
									<option value="">--��ѡ��--</option>
								</select>
								</td>					
							<td class="blue">�Ƿ�����</td>
							<td class="blue">
							    <select id="wkShow">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
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
 		if(<%=commun_seq!=""%>){
 			doUpate();
 		}else{
 			doAdd();
 		}
	}
});


</script>
<script type="text/javascript">
function setNameAndFieId(){
	$("#wkField").empty();//ÿ�ν������
	if(document.getElementById('wkCode').value=="e487"){
		$("#wkName").val("������ͨѶ����");
		var opt = $("<option>").text("����������").val("wkCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("����������").val("wkName");
		$("#wkField").append(opt);				
	}else if(document.getElementById('wkCode').value=="e484"){
		$("#wkName").val("���ֹ���");
		var opt = $("<option>").text("����ģ����").val("mCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("����ģ������").val("mName");
		$("#wkField").append(opt);
	}else if(document.getElementById('wkCode').value=="e485"){
		$("#wkName").val("�������");
		var opt = $("<option>").text("������").val("tCode");
		$("#wkField").append(opt);
				opt = $("<option>").text("��������").val("tName");
		$("#wkField").append(opt);
			  opt = $("<option>").text("����̨��ɫ").val("mrole");
		$("#wkField").append(opt);
	}else if(document.getElementById('wkCode').value==""){
		$("#wkName").val("");
		var opt = $("<option>").text("--��ѡ��--").val("");
		$("#wkField").append(opt);
	}
}	
	
	function CHECKKEY(){
 if (event.keyCode == 13 && event.ctrlKey)
 {
 	if(<%=commun_seq!=""%>){doUpate();}else{doAdd();}
 
 }
}
var ser;
var checkwkCode = false;
var retVal = "";//���ظ�ҳ���ֵ

$(document).ready(function(){
	$("select").width("150");
$("input[type='text']").width("150");
	if(<%=commun_seq!=""%>){
		
		document.getElementById('wkCode').value ='<%=wkCode%>';
		document.getElementById('wkName').value ='<%=wkName%>';
		document.getElementById('wkShow').value ='<%=wkShow%>';
		setNameAndFieId();
		document.getElementById('wkField').value ='<%=wkField%>';
		document.getElementById('update').style.display = "";
		document.getElementById('wkCode').disabled = true;
		document.getElementById('wkField').disabled = true;
		
	}else{
		document.getElementById('add').style.display = "";
	}
})

//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function doAdd()
{
	if(!check(frm)){
		return false;
	}
	
	var wkCode = document.getElementById('wkCode').value;
	var wkName = document.getElementById('wkName').value;
  	var wkShow = document.getElementById('wkShow').value;
  	var wkField = document.getElementById('wkField').value;
    if(wkCode==""){
    	rdShowMessageDialog("��ѡ����������");
    	return;
    }
	//����wkCode�Ƿ��Ѿ����� ����workspace_op.jsp?opType=check----
	doCheck();
	if(checkwkCode){//�����ڷ���true����������
			document.getElementById('add').disabled = "disabled";
			//���� workspace_op.jsp?opType=add,������Ӳ���
			var addPacket = new AJAXPacket("commun_op.jsp","����ִ��,���Ժ�...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("wkCode", wkCode.trim());
	  	addPacket.data.add("wkName", wkName.trim());
	  	addPacket.data.add("wkField", wkField.trim());
	  	addPacket.data.add("wkShow", wkShow.trim());
	 		core.ajax.sendPacket(addPacket,doFunction,true);
	  	addPacket = null;  
	}else{
		rdShowMessageDialog("�����������Ѿ����ڣ����������룡",0);
		document.getElementById('wkCode').value="";
		document.getElementById('wkCode').focus();
		setNameAndFieId();
		return false;
	}
	
}

    
//�����޸ĺ������
function doUpate()
{
	
	if(!check(frm)){
		return false;
	}
	
	var wkCode = document.getElementById('wkCode').value;
	var wkName = document.getElementById('wkName').value;
	var wkShow =  document.getElementById('wkShow').value;
	var wkField =  document.getElementById('wkField').value;
	
    if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		//���� workspace_op.jsp?opType=update,�����޸Ĳ���
		var updatePacket = new AJAXPacket("commun_op.jsp","����ִ��,���Ժ�...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("wkSeq", '<%=commun_seq%>');
	  	updatePacket.data.add("wkCode", wkCode.trim());
	  	updatePacket.data.add("wkName", wkName.trim());
	  	updatePacket.data.add("wkField", wkField.trim());
	  	updatePacket.data.add("wkShow", wkShow.trim());
	 	  core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
      var wkCode = document.getElementById('wkCode').value;
      var chkPacket = new AJAXPacket("commun_op.jsp","������֤,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("wkCode", wkCode.trim());
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
	              checkwkCode = true;
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸ĳɹ���",2);
				 		 		window.opener.queryTemplate();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("�޸�ʧ�ܣ�",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�����ɹ���",2);
				  			window.opener.queryTemplate();
				  			window.close(); 
	        }else{
	        		rdShowMessageDialog("����ʧ�ܣ�",0);
	        		document.getElementById('add').disabled = "";
	        }
       }
   }


</script> 
</body>
</html>