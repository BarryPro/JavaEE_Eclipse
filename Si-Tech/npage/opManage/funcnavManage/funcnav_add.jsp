<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="����ҳ�浼����Ϣ";
	String funcnav_seq = request.getParameter("funcnav_seq")!=null?(String)request.getParameter("funcnav_seq"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String functionCode = "";
	String nav_path = "";
	String is_use = "";

	if(!"".equals(funcnav_seq)){
		String sql = "select to_char(nav_seq),function_code,nav_path,is_use,to_char(op_time,'yyyy-mm-ss hh24:mi:ss') from dfuncnavmsg  where nav_seq=:funcnav_seq";
		String param = "funcnav_seq="+funcnav_seq;
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="funcnavList" scope="end"/>
		<%		
				System.out.println(retCode);
		if("000000".equals(retCode)){ 
			if(funcnavList.length>0){
				functionCode  = funcnavList[0][1];  
				nav_path  = funcnavList[0][2];  
				is_use  = funcnavList[0][3];
			}
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ҳ�浼����Ϣ</title>
</head>
<body>
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">����ҳ�浼����Ϣ</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="10%">ҵ�����</td>
							<td class="blue" width="45%">
								<input type="text" v_must=1 v_type="string"   id="functionCode" name="functionCode" value="" onfocus="showNavInfo1()" size="100" /><font class="orange">*</font>
								<div class="orange" id="nav_path_info1" style="display:none">opcode֮��ʹ��Ӣ�ķֺţ�;���������磺 1104;1100;d603</div>
								<div class="orange" id="nav_path_info2" style="display:none">opcodeֻ����дһ���磺1100</div>
							</td>
						</tr>
						
						<tr>
							<td class="blue">����·��</td>
							<td class="blue" ><input type="text"  v_must=1 v_type="string" v_maxlength="512"  id="nav_path" name="nav_path" value="" onfocus="showNavInfo()"  size="100"   /><font class="orange">*</font>
								<div class="orange" id="nav_path_info" style="display:none">�ڵ�֮����Ӣ�ķֺţ�;���������磺 ϵͳ����;OP����;ҵ�񵼺�����</div>
								</td>					
							
						</tr>
								<tr>
							<td class="blue"  width="10%">�Ƿ�����</td>
							<td class="blue"  width="35%">
							    <select id="is_use">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
								</select>
							</td>							
						</tr>				
						<tr>
							<td colspan="2" class="blue" style="text-align:center">
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
 		if(<%=funcnav_seq!=""%>){
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
});
var ser;
var checkfunctionCode = false;
var retVal = "";//���ظ�ҳ���ֵ

$(document).ready(function(){
	if(<%=funcnav_seq!=""%>){
		document.getElementById('functionCode').value ='<%=functionCode%>';
		document.getElementById('nav_path').value ='<%=nav_path%>';
		document.getElementById('is_use').value ='<%=is_use%>';

		document.getElementById('update').style.display = "";

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
	var functionCode = document.getElementById('functionCode').value;
	var nav_path = document.getElementById('nav_path').value;
  	var is_use = document.getElementById('is_use').value;

    
	//����functionCode�Ƿ��Ѿ����� ����workspace_op.jsp?opType=check----
			document.getElementById('add').disabled = "disabled";
			//���� workspace_op.jsp?opType=add,������Ӳ���
			var addPacket = new AJAXPacket("funcnav_op.jsp","����ִ��,���Ժ�...");
	  	addPacket.data.add("opType", "add");
	  	addPacket.data.add("functionCode", functionCode.trim());
	  	addPacket.data.add("nav_path", nav_path.trim());
	  	addPacket.data.add("is_use", is_use.trim());
	 		core.ajax.sendPacket(addPacket,doFunction,true);
	  	addPacket = null;  
	 
	
}

    
//�����޸ĺ������
function doUpate()
{
	
	if(!check(frm)){
		return false;
	}
	
	var functionCode = document.getElementById('functionCode').value;
	var nav_path = document.getElementById('nav_path').value;
	var is_use =  document.getElementById('is_use').value;
	
    if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		//���� workspace_op.jsp?opType=update,�����޸Ĳ���
		var updatePacket = new AJAXPacket("funcnav_op.jsp","����ִ��,���Ժ�...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("function_seq", '<%=funcnav_seq%>');
	  	updatePacket.data.add("functionCode", functionCode.trim());
	  	updatePacket.data.add("nav_path", nav_path.trim());
	  	updatePacket.data.add("is_use", is_use.trim());
	 	  core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
      var functionCode = document.getElementById('functionCode').value;
      var chkPacket = new AJAXPacket("funcnav_op.jsp","������֤,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("functionCode", functionCode.trim());
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
	              checkfunctionCode = true; 
	              $("#checkMsg").text("");
	          }else{
	          		checkfunctionCode = false;
	          		$("#checkMsg").text($.trim($("#functionCode").val())+"�Ѿ����ڣ�");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸ĳɹ���",2);
				 		 		window.opener.queryNav();
				  			window.close();
	        }else{
	        		rdShowMessageDialog("�޸�ʧ�ܣ�",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�����ɹ���",2);
				  			window.opener.queryNav();
				  			window.close(); 
	        }else{
	        		rdShowMessageDialog("����ʧ�ܣ�",0);
	        		document.getElementById('add').disabled = "";
	        }
       }
   }

	function showNavInfo(){
		 $("#nav_path_info").show();
	}
	function showNavInfo1(){
		if(<%=funcnav_seq!=""%>){
		 $("#nav_path_info2").show();
		}else{
		  $("#nav_path_info1").show();
		}
	}
	
</script> 
</body>
</html>