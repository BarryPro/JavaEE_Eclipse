<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="����ҵ����ģ��";
	String template_id = request.getParameter("template_id")!=null?(String)request.getParameter("template_id"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String temp_id = "";
	String temp_name = "";
	String op_code="";//����ҵ��
	String[] stepArr = new String[0];
	if(!"".equals(template_id)){
		String sql = " select to_char(a.seq),a.template_id,a.template_name,to_char(a.step_seq),a.step_name from  dbusiguidetemp a where a.template_id=:temp_id order by a.step_seq";
		String param = "temp_id="+template_id;
		System.out.println(sql);
		System.out.println(param);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="6" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="tempList" scope="end"/>
		<%		
			System.out.println(retCode);
			if("000000".equals(retCode)){ 
				temp_id = tempList[0][1];  
				System.out.println("-------------================>>>>><<<<<"+temp_id);
				temp_name  = tempList[0][2];  
				op_code = tempList[0][5];
				stepArr = new String[tempList.length];
				for(int i=0;i<tempList.length;i++){
					String step_seq   = tempList[i][3]; 
					String step_name  = tempList[i][4];
					stepArr[i] = step_seq+"~"+step_name;
				}
			}
		}
	%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ҵ����</title>
</head>
<body  ONKEYDOWN="CHECKKEY()">
<form method="post" name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>

				<div class="title">
					<div id="title_zi">����ҵ����ģ��</div>
				</div>
				
					<table cellspacing="0">
						<tr>
							<td class="blue">��ģ��ID</td>
							<td class="blue">
								<input type="text" v_must="1" v_type="string" v_maxlength="16" id="temp_id" name="temp_id" onchange="doCheck()" value="<%=temp_id%>"/><font class="orange">*</font>
								<span id="checkMsg" style="color:orange"></span>
							</td>
							<td class="blue">��ģ������</td>
							<td class="blue"><input type="text"  v_must="1" v_type="string" v_maxlength="64" id="temp_name" name="temp_name" value="<%=temp_name%>"/><font class="orange">*</font></td>
						</tr>										
						
					</table>
				</div>
				<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								��������
							</div>
						</div>
						<table id="sTable" cellspacing="0">
							<tr>
								<th>
									�������
								</th>
								<th>
									��������
								</th>
								<th>
									<input class="b_text" name="addStep"  id="addStep"  type=button value="��������" onclick="doAddStep()"
								</th>
							<tr>
								<%
							
									for(int i=0;i<stepArr.length;i++){
											
										String[] stepArr_tmp = stepArr[i].split("~");
										String step_seq   = stepArr_tmp[0]; 
										String step_name  = stepArr_tmp[1];
										%>
										<tr id='step_tr_<%=i+1%>'>
											<td id='step_td_<%=i+1%>'><%=step_seq%></td>
											<td>
												<input id="step_input_<%=i+1%>" type="text"  v_must="1" v_type="string" v_maxlength="64" value="<%=step_name%>">
											</td>
											<td>
												<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick='delStep(<%=step_seq%>)'/>
											</td>
										</tr>
										<%
									}
							%>
					</table>	
			</div>
			<div id="Operation_Table">
						<table cellspacing="0">
							<tr>
							<td class="blue" style="text-align:center">
								   <input class="b_foot" name="add"  id="add" style="display:none" type=button value="����" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="update" id="update" style="display:none" type=button value="�޸�" onclick="doUpate()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="ȡ��" onclick="javascript:window.close();">
							</td>
						</tr>
						</table>	
			</div>
			
	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script type="text/javascript">
	
	
	 	function CHECKKEY(){
 if (event.keyCode == 13 && event.ctrlKey)
 {
 	if(<%=template_id!=""%>){
 		doUpate();
 		}else{
 			doAdd();
 		}
 }
}


$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
	
var ser;
var checktemp_id = false;
var retVal = "";//���ظ�ҳ���ֵ

$(document).ready(function(){
	if(<%=template_id!=""%>){
		document.getElementById('update').style.display = "";
	}else{
		document.getElementById('add').style.display = "";
	}
})


	var step_i = <%=stepArr.length%>+1;//����ʱstepArrΪ0���޸�ʱ���ݲ�ѯ����ֵ��1
	//��������
	function doAddStep(){
			$("#sTable").append("<tr id='step_tr_"+step_i+"'><td id='step_td_"+step_i+"'>"+step_i+"</td><td><input id='step_input_"+step_i+"'   v_must=1 v_type=string v_maxlength=64  type='text'></td><td><img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick='delStep("+step_i+")'/></td></tr>");
			step_i = step_i + 1;
	}
	
	//����ɾ��
	function delStep(step){
		if(step+1<step_i){//�����м�ɾ����ֱ��ɾ�����һ�����仯������ֵ
			$("#step_input_"+step).val("");
			for(var j=0;j<step_i-(step+1);j++){//������ֵ����ǰһ��
				$("#step_input_"+(step+j)).val($("#step_input_"+(step+1+j)).val());
			}
			
			$("#step_tr_"+(step_i-1)).remove();
			if(step_i>1){
				step_i = step_i-1;
			}
		}else{
			$("#step_tr_"+step).remove();
			if(step_i>1){
				step_i = step_i-1;
			}
		}	
	}
	

//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function doAdd()
{
		if(!check(frm)){
			return false;
		}
		if(step_i==1){
			rdShowMessageDialog("�����Ӳ��裡",1);
			return false;
		}
		var temp_id = document.getElementById('temp_id').value;
		var temp_name = document.getElementById('temp_name').value;
    
    var stepArr = new Array();
		for(var i=0;i<step_i-1;i++){
		  		stepArr[i] = $.trim($("#step_input_"+(i+1)).val());
	  }
		if(checktemp_id){//�����ڷ���true����������
				document.getElementById('add').disabled = "disabled";
				//���� template_op.jsp?opType=add,������Ӳ���
				var addPacket = new AJAXPacket("template_op.jsp","����ִ��,���Ժ�...");
		  	addPacket.data.add("opType", "add");
		  	addPacket.data.add("temp_id", temp_id.trim());
		  	addPacket.data.add("temp_name", temp_name.trim());
	    	addPacket.data.add("stepArr", stepArr);
		 		core.ajax.sendPacket(addPacket,doFunction,true);
		  	addPacket = null;  
		}else{
			rdShowMessageDialog("ģ��ID�Ѿ����ڣ����������룡",0);
			document.getElementById('temp_id').value="";
			document.getElementById('temp_id').focus();
			return false;
		}
	
}

    
//�����޸ĺ������
function doUpate()
{
		if(!check(frm)){
			return false;
		}
		if(step_i==1){
			rdShowMessageDialog("�����Ӳ��裡",1);
			return false;
		}
		var temp_id = document.getElementById('temp_id').value;
		var temp_name = document.getElementById('temp_name').value;
    
    //��֯�������ݴ��ݺ�̨
    var stepArr = new Array();
		for(var i=0;i<step_i-1;i++){
		  		stepArr[i] = $.trim($("#step_input_"+(i+1)).val());
	  }
    
    if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
    	document.getElementById('update').disabled = "disabled";
		  //���� workspace_op.jsp?opType=update,�����޸Ĳ���
		  var updatePacket = new AJAXPacket("template_op.jsp","����ִ��,���Ժ�...");
	  	updatePacket.data.add("opType", "update");
	  	updatePacket.data.add("template_id", '<%=template_id%>');
	  	updatePacket.data.add("temp_id", temp_id.trim());
	  	updatePacket.data.add("temp_name", temp_name.trim());
	  	updatePacket.data.add("stepArr", stepArr);
	 	  core.ajax.sendPacket(updatePacket,doFunction,true);
	  	updatePacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
      var temp_id = document.getElementById('temp_id').value;
      <%if(!"".equals(template_id)){%>//�����޸�
	   	if(temp_id!="<%=template_id%>"){
	  	<%}%>
	    if(temp_id.trim().length > 0){
	      var chkPacket = new AJAXPacket("template_op.jsp","������֤,���Ժ�...");
	      chkPacket.data.add("opType", "check");
	      chkPacket.data.add("template_id", temp_id.trim());
	      core.ajax.sendPacket(chkPacket,doFunction,false);
	      chkPacket = null; 
      }
      <%if(!"".equals(template_id)){%>//�����޸�
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
	        	//alert("isAdd="+isAdd);
	        	if(isAdd=="0"){  //����0ʱ�����ڣ����Լ������         
	              checktemp_id = true;
	              $("#checkMsg").text("");
	          }else{
	          		checktemp_id = false;
	          		$("#checkMsg").text((document.getElementById('temp_id').value).trim()+"�Ѿ����ڣ�");
	          }
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸ĳɹ���",2);
				 		 		window.returnValue=true;
				  			window.close();
	        }else{
	        		rdShowMessageDialog("�޸�ʧ�ܣ�",0);
	        		document.getElementById('update').disabled = "";
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�����ɹ���",2);
				  			window.returnValue=true;
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