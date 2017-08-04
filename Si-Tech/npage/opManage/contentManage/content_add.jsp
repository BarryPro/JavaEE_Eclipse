<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="��������";
	String content_seq = request.getParameter("content_seq")!=null?(String)request.getParameter("content_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = orgCode.substring(0,2);
	String content_type = "";
	String content_id = "";
	String content_name = "";
	String content_detail = "";
	String is_effect = "";
	String content_cls = "";
	String opRoleId = "";
	if(!"".equals(content_seq)){
		String sql = "select to_char(seq),content_type,content_id,content_name,content_detail,is_effect,version,to_char(op_time,'yyyy-mm-dd hh24:mi:ss'),content_cls,op_roleid from dcontentmsg where seq=:content_seq  ";
		String param = "content_seq="+content_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="10" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="workspace" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			content_type  = workspace[0][1];  
			content_id  = workspace[0][2];  
			content_name   = workspace[0][3]; 
			content_detail  = workspace[0][4];
			is_effect = workspace[0][5];
			content_cls = workspace[0][8];
			opRoleId = workspace[0][9];
			
		}
	}
	if("".equals(content_cls)) content_cls = "��";
	System.out.println("--------------content_cls--------------------"+content_cls);
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������</title>
</head>
<body >
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">�������</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="10%">����ID</td>
							<td class="blue"  width="40%">
									
								<select id="content_id">
										<option value='c_busiguide'>ҵ����</option>
										<option value='c_privset'>ȫ������</option>
										<option value='c_callUserInfo'>�û���Ϣ</option>
										<option value='c_sysmenu'>ϵͳ�˵�</option>
										<option value='c_commfunc'>���ù���</option>
									</select>	
									<span id="checkMsg" style="color:orange"></span>
							</td>
							<td class="blue"  width="10%">��������</td>
							<td class="blue"  width="40%"><input type="text" maxlength="4" v_must=1 v_type="string" v_maxlength="64" id="content_name" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							 	<td class="blue">������ʽ</td>
							<td>
								<select id="conCls" name="conCls">	
									<option value="ico_fav">ico_fav</option>
									<option value="ico_buGu">ico_buGu</option>
									<option value="ico_user">ico_user</option>
									<option value="ico_tree">ico_tree</option>
								</select>		
							</td>
							<td class="blue">�Ƿ񷢲�</td>
							<td class="blue">
							    <select id="is_effect">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
								</select>
							</td>							
						</tr>
						<tr>
							
							<td class="blue">��ϸ��Ϣ&nbsp;</td>
							<td class="blue" ><input type="text" v_must=1 v_type="string" v_maxlength="512"  size="60" id="content_detail" value=""/><font class="orange">*</font></td>					
							
						<td class="blue">ѡ���ɫ</td>
								 
							<td>
								<input type="text" name="oproleidshow" value="<%=opRoleId%>" readOnly >
								<input type="hidden" name="oproleidhide" >
								<input type="button" class="b_text" onclick="queryPowerCode('frm')" value="ѡ���ɫ">
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
 		if(<%=content_seq!=""%>){
 			doUpate();
 		}else{
			doAdd();
		}
	}
});
</script>

<script type="text/javascript">
 
var ser;
var checkId = false;
var retVal = "";//���ظ�ҳ���ֵ
function queryPowerCode(str){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'','height=600,width=300,scrollbars=yes');
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	document.all.oproleidshow.value=retRoleId+"->"+retRoleName;
	document.all.oproleidhide.value=retRoleId;
}
$(document).ready(function(){
	if(<%=content_seq!=""%>){
		setShow();
		
		document.all.oproleidhide.value='<%=opRoleId%>';
		document.all.oproleidshow.value='<%=opRoleId%>';
		document.getElementById('content_id').value ='<%=content_id%>';
		document.getElementById('content_name').value ='<%=content_name%>';
		document.getElementById('content_detail').value ='<%=content_detail%>';
		document.getElementById('is_effect').value ='<%=is_effect%>';
		document.getElementById('conCls').value ='<%=content_cls%>';
		document.getElementById('update').style.display = "";
		document.all.content_id.disabled=true;
	}else{
		document.getElementById('add').style.display = "";
		setShow();
	}
	
})
 $(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
function setShow(){
		document.getElementById("conCls").options.length=0;
        document.getElementById("conCls").options.add(new Option("ȫ��������ʽ","ico_fav")); 
        document.getElementById("conCls").options.add(new Option("ȫ��������ʽ1","ico_fav_o")); 
        document.getElementById("conCls").options.add(new Option("ҵ������ʽ","ico_buGu")); 
        document.getElementById("conCls").options.add(new Option("ҵ������ʽ1","ico_buGu_o")); 
        document.getElementById("conCls").options.add(new Option("���ù�����ʽ","ico_user")); 
        document.getElementById("conCls").options.add(new Option("���ù�����ʽ1","ico_user_o")); 
        document.getElementById("conCls").options.add(new Option("ϵͳ�˵���ʽ","ico_tree")); 
        document.getElementById("conCls").options.add(new Option("ϵͳ�˵���ʽ1","ico_tree_o"));
        document.getElementById("conCls").options.add(new Option("�û���Ϣ��ʽ","ico_fav")); 
        document.getElementById("conCls").options.add(new Option("�û���Ϣ��ʽ1","ico_fav_o"));
        document.getElementById("content_id").options.length=0;
        document.getElementById("content_id").options.add(new Option("ҵ����","p_busiguide")); 
        document.getElementById("content_id").options.add(new Option("ȫ������","p_privset")); 
        document.getElementById("content_id").options.add(new Option("�û���Ϣ","p_callUserInfo")); 
        document.getElementById("content_id").options.add(new Option("ϵͳ�˵�","p_sysmenu")); 
        document.getElementById("content_id").options.add(new Option("���ù���","p_commfunc")); 
		
}
//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function doAdd()
{
		/*
		if(!check(frm)){
			return false;
		}
		*/
	    var content_id = document.getElementById('content_id').value;
		var content_name = document.getElementById('content_name').value.trim();
  		var is_effect = document.getElementById('is_effect').value;
		var content_detail = document.getElementById('content_detail').value;
		var oproleidshow = document.getElementById('oproleidshow').value;
		if(oproleidshow==""){
			rdShowMessageDialog("��ѡ���ɫ");
			return false;
		}
    	if(content_name==""){
			rdShowMessageDialog("����д��������");
			document.getElementById('content_name').value = "";
			document.getElementById('content_name').focus();
			return false;
		}
		if(content_detail==""){
			rdShowMessageDialog("����д��ϸ��Ϣ");
			document.getElementById('content_detail').value = "";
			document.getElementById('content_detail').focus();
			return false;
		}
    doCheck();
	//����wkCode�Ƿ��Ѿ����� ����workspace_op.jsp?opType=check----
	if(checkId){//�����ڷ���true����������
			document.getElementById('add').disabled = "disabled";
			//���� content_op.jsp?opType=add,������Ӳ���
			var addPacket = new AJAXPacket("content_op.jsp","����ִ��,���Ժ�...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("content_id", content_id.trim());
	  	addPacket.data.add("content_name", content_name.trim());
	  	addPacket.data.add("is_effect", is_effect.trim());
	  	addPacket.data.add("content_detail", content_detail.trim());
	  	addPacket.data.add("conCls", document.getElementById('conCls').value);
	  	addPacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
	  	
	 	core.ajax.sendPacket(addPacket,doFunction);
	  	addPacket = null;  
	}else{
		rdShowMessageDialog("����ID�Ѿ����ڣ����������룡",0);
		document.getElementById('content_id').value="c_busiguide";
		document.getElementById('content_id').focus();
		return false;
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
	    var content_id = document.getElementById('content_id').value;
		var content_name = document.getElementById('content_name').value.trim();
  		var is_effect = document.getElementById('is_effect').value;
		var content_detail = document.getElementById('content_detail').value;
		var oproleidshow = document.getElementById('oproleidshow').value;
		if(oproleidshow==""){
			rdShowMessageDialog("��ѡ���ɫ");
			return false;
		}
    	if(content_name==""){
			rdShowMessageDialog("����д��������");
			document.getElementById('content_name').value = "";
			document.getElementById('content_name').focus();
			return false;
		}
		if(content_detail==""){
			rdShowMessageDialog("����д��ϸ��Ϣ");
			document.getElementById('content_detail').value = "";
			document.getElementById('content_detail').focus();
			return false;
		}
		
    if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
    	document.getElementById('update').disabled = "disabled";
			//���� content_op.jsp?opType=update,�����޸Ĳ���
			var updatePacket = new AJAXPacket("content_op.jsp","����ִ��,���Ժ�...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("content_seq", '<%=content_seq%>');
	  	updatePacket.data.add("content_id", content_id.trim());
	  	updatePacket.data.add("content_name", content_name.trim());
	  	updatePacket.data.add("is_effect", is_effect.trim());
	  	updatePacket.data.add("content_detail", content_detail.trim());
	  	updatePacket.data.add("conCls", document.getElementById('conCls').value);
	  	updatePacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
	  	
	 		core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
    var content_id = document.getElementById('content_id').value;
    <%if(!"".equals(content_seq)){%>//�����޸�
   	if(content_id!="<%=content_id%>"){
  	<%}%>
    if(content_id.trim().length > 0){
      var chkPacket = new AJAXPacket("content_op.jsp","������֤,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("content_id", content_id.trim());
      chkPacket.data.add("oproleidhide",document.getElementById('oproleidhide').value);
      core.ajax.sendPacket(chkPacket,doFunction,false);
      chkPacket = null; 
    }
    <%if(!"".equals(content_seq)){%>//�����޸�
    	}
  	<%}%>
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
	              checkId = true;
	              $("#checkMsg").text("");
	          }else{
	          		checkId = false;
	          		//$("#checkMsg").text((document.getElementById('content_id').value).trim()+"�Ѿ����ڣ�");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸ĳɹ���",2);
				 		 		window.opener.queryContent();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("�޸�ʧ�ܣ�",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�����ɹ���",2);
				  			window.opener.queryContent();
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