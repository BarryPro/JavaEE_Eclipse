<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="��������ģ��";
	String layout_css = request.getParameter("layout_css")!=null?(String)request.getParameter("layout_css"):"";
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String mCode = "";
	String mName = "";
	String mShow = "";
	if(!"".equals(layout_css)){
		String sql = "select layout_css,layout_name,is_effect from dlayoutmsg where layout_css=:layout_css";
		String param = "layout_css="+layout_css;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="layout" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			mCode  = layout[0][0];  
			mName  = layout[0][1];  
			mShow   = layout[0][2];   

		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ģ������</title>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">��Ӳ���ģ��</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">����ģ����</td>
							<td class="blue">
								<select id="mCode">
										<option value='0'>0</option>
										<option value='1'>1</option>
										<option value='2'>2</option>
										<option value='3'>3</option>
									</select>
							</td>
							<td class="blue">����ģ������</td>
							<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="32" id="mName" value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							
							<td class="blue">�Ƿ񷢲�</td>
							<td class="blue">
							    <select id="mShow">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
								</select>
							</td>
							<td class="blue">&nbsp;</td>
							<td class="blue">&nbsp;</td>
							
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
<script type="text/javascript">
var ser;
var checkMCode = "";
var retVal = "";//���ظ�ҳ���ֵ
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
$(document).ready(function(){
	if(<%=layout_css!=""%>){
		document.getElementById('mCode').value ='<%=mCode%>';
		document.getElementById('mName').value ='<%=mName%>';
		document.getElementById('mShow').value ='<%=mShow%>';
		document.getElementById('update').style.display = "";
		document.all.mCode.disabled=true;

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
	
	var mCode = document.getElementById('mCode').value;
	var mName = document.getElementById('mName').value.trim();
    var mShow = document.getElementById('mShow').value;
	if(mName==""){
		rdShowMessageDialog("����д����ģ������");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
    if(rdShowConfirmDialog("���ֱ�����������޸ģ�ȷ��Ҫ������")==1)
    {
		//����mCode�Ƿ��Ѿ����� ����layout_op.jsp?opType=check----
		doCheck();
		if(checkMCode=="1"){//�����ڷ���true����������
	  		//���� layout_op.jsp?opType=add,������Ӳ���
			  var chkPacket = new AJAXPacket("layout_op.jsp","����ִ��,���Ժ�...");
		  	chkPacket.data.add("opType", "add");
		  	chkPacket.data.add("mCode", mCode.trim());
		  	chkPacket.data.add("mName", mName.trim());
		  	chkPacket.data.add("mShow", mShow.trim());
		 	  core.ajax.sendPacket(chkPacket,doFunction,true);
		  	chkPacket = null;  
		}else if(checkMCode=="0"){
			rdShowMessageDialog("����ģ���Ѿ����ڣ����������룡",0);
			document.getElementById('mCode').value="0";
			document.getElementById('mCode').focus();
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
    var mCode = document.getElementById('mCode').value;
	var mName = document.getElementById('mName').value.trim();
    var mShow = document.getElementById('mShow').value;
	if(mName==""){
		rdShowMessageDialog("����д����ģ������");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
	if(rdShowConfirmDialog("ȷ��Ҫ�޸���")==1)
    {
		//���� layout_op.jsp?opType=update,�����޸Ĳ���
		var chkPacket = new AJAXPacket("layout_op.jsp","����ִ��,���Ժ�...");
	  	chkPacket.data.add("opType", "update");
	  	chkPacket.data.add("mCode", mCode.trim());
	  	chkPacket.data.add("mName", mName.trim());
	  	chkPacket.data.add("mShow", mShow.trim());
	 	core.ajax.sendPacket(chkPacket,doFunction,true);
	  	chkPacket = null; 
	}
}


function doCheck()//У��ģ���Ƿ����
{     
      var mCode = document.getElementById('mCode').value;
      var chkPacket = new AJAXPacket("layout_op.jsp","����У��,���Ժ�...");
      chkPacket.data.add("opType", "check");
      chkPacket.data.add("mCode", mCode.trim());
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
	                checkMCode = "1";
	          	}else if(isAdd=="1"){//����1ʱ���������Ѿ�����
	          		checkMCode = "0";
	          	}else{//δ֪����
	          		checkMCode = "2";
	          	}
	        }
       }else if(opType.trim()=="update"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("�޸Ĳ���ģ��ɹ���",2);
	              window.opener.queryTemplate();
				  window.close();
	        }
       }else if(opType.trim()=="add"){
       		if(retCode=="000000"){                
	              rdShowMessageDialog("��������ģ��ɹ���",2);
				  window.opener.queryTemplate();
				  window.close(); 
	        }
       }
   }


</script> 
</body>
</html>