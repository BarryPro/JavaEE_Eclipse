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
<body >
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">��Ӳ���ģ��</div>
				</div>
					<table cellspacing="0">
						<tr>
							<td class="blue" width="25%">����ģ����</td>
							<td class="blue" width="25%">
								<input type='text' id="mCode" maxlength="10" onclick="showBGuidStep(2);"><font class="orange">*</font>
							</td>
							<td class="blue" width="25%">����ģ������</td>
							<td class="blue" width="25%"><input type="text" v_must=1 v_type="string" maxlength="32" id="mName" onclick="showBGuidStep(3);"  value=""/><font class="orange">*</font></td>
						</tr>
						<tr>
							
							<td class="blue">�Ƿ񷢲�</td>
							<td class="blue">
							    <select id="mShow">
										<option value="0">��</option>	
										<option value="1" selected>��</option>
								</select>
							</td>
							<td class="blue">Ĭ�����</td>
							<td class="blue"> 
								<select id="defLay" onchange="setLay()">
										<option value='0'>���������</option>
										<option value='1' selected>��ʾȫ��</option>
										<option value='2'>�޲˵�</option>
										<option value='3'>����</option>
								</select>
							</td>
							
						</tr>
						<tr>	
							<td  class="blue">
							ѡ����ʾ�����		
							</td>
							<td colspan="3">
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="0">���������
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="1">��ʾȫ��
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="2">�޲˵�
									<input type="checkbox" id="layche" onclick="showBGuidStep(4);" name="layche" value="3">����			
							</td>
						</tr>
					</table>
					<div class="title">
					<div id="title_zi">����������</div>
				</div>
				<table cellspacing="0">
						<tr>
							<th width="5%">
									ѡ��<input type="checkbox" id="defChecbox" name="defChecbox" onclick="setWche(this)">
								</th>
								<th width="20%">
									ģ����
								</th>
								<th width="20%">
									ģ������
								</th>
								<th width="20%">
									ģ��·��
								</th>
								<th width="20%">
									����̨��ɫ
								</th>
								  
								<th>
									 ����
								</th>
							</tr>
							<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql>select wkspace_id,wkspace_name,IS_EFFECT,wkspace_src from dwkspacemsg</wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_th" scope="end"/>
		
		<%
		String outStr = "";
		for(int ih=0;ih<result_th.length;ih++){
		 	outStr += "<tr>";
		 	outStr += "<td><input type='checkbox' onclick='showBGuidStep(5);' id='wche' name='wche' value='"+result_th[ih][0]+"'></td>";
			outStr += "<td class='blue'>"+result_th[ih][0]+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][1]+"</td>";
			outStr += "<td class='blue'>"+("0".equals(result_th[ih][2])?"��":"��")+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][3]+"</td>";
			outStr += "<td><select ><option value='1'>�볤</option><option value='2'>ȫ��</option></select></td>";
		 	outStr += "</tr>";
		}
		 out.print(outStr);
		%>
				</table>
					<table cellspacing="0">
						<tr>
							<td  id="footer">
								<input class="b_foot"    id="addbut"  type=button value="����" onclick="addCfm()" >
							   
							  	<input class="b_foot" name="third" type=button value="�ر�" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>

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
});
$(document).keydown(function(event){
	if (event.keyCode == 13 && event.ctrlKey){
 		 addCfm();
	}
});
</script>

<script type="text/javascript">
var checkMCode = "";

function showBGuidStep(step){
	window.opener.parent.showBusiGuideStep("e484",step);
}
$(document).ready(function(){
	$("select").width("50");
	$("#defLay").width("150");
	$("#mShow").width("150");
	$("input[type='text']").width("150");
	setLay();
});
 

function setLay(){
	var id=$("#defLay").val();
	
	$("[name='layche'][value='"+id+"']").attr("checked",true);
	$("[name='layche'][value!='"+id+"']").attr("checked",false);
	
	$("[name='layche'][value='"+id+"']").attr("disabled",true);
	$("[name='layche'][value!='"+id+"']").attr("disabled",false);
	 
}
function setWche(bt){
	var bolFlag = $(bt).attr("checked");
	if(bolFlag){
		$("[name='wche']").attr("checked",true);
	}else{
		$("[name='wche']").attr("checked",false);
	}
}
//��ӹ���ģ�飬����Ϣ���ص�ǰ��ҳ����б�
function addCfm()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	
	var mCode = document.getElementById('mCode').value.trim();
	var mName = document.getElementById('mName').value.trim();
    if(mCode==""){
		rdShowMessageDialog("����д����ģ��ID");
		document.getElementById('mCode').value = "";
		document.getElementById('mCode').focus();
		return false;
	}
    if(mName==""){
		rdShowMessageDialog("����д����ģ������");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
	
	 var mm = /^\w+$/;
			if(!mm.test(mCode)){
				rdShowMessageDialog("ģ��IDֻ��������ĸ������");
				document.getElementById('mCode').value = "";
				document.getElementById('mCode').focus();
				return;
			}
		
		//����mCode�Ƿ��Ѿ����� ����layout_op.jsp?opType=check----
		doCheck();
		if(checkMCode=="1"){//�����ڷ���true����������
	  		//���� layout_op.jsp?opType=add,������Ӳ���
	  		var laycStr    = "";
	  		var wcheStr    = "";
	  		var wcheLenStr = "";
	  		$("[name='layche'][checked]").each(function(){
	  			laycStr+=$(this).val()+"~";
	  		});
			
			$("[name='wche'][checked]").each(function(){
	  			wcheStr    += $(this).val()+"~";
	  			wcheLenStr += $(this).parent().parent().find("select").val()+"~";
	  		});
	  		if(wcheStr==""){
	  			if(rdShowConfirmDialog("ȷ�������������ù���ģ��ô��")!=1){
	  				return;
	  			}
	  		}
	  		
	  		//alert("laycStr|"+laycStr+"\nwcheStr|"+wcheStr+"\nwcheLenStr|"+wcheLenStr);
			var chkPacket = new AJAXPacket("modelAddCfm.jsp","����ִ��,���Ժ�...");
		  	chkPacket.data.add("mCode", mCode.trim());
		  	chkPacket.data.add("mName", mName.trim());
		  	chkPacket.data.add("mShow", $("#mShow").val());
		  	chkPacket.data.add("defLay", $("#defLay").val());
		  	chkPacket.data.add("laycStr",laycStr);
		  	chkPacket.data.add("wcheStr",wcheStr);
		  	chkPacket.data.add("wcheLenStr",wcheLenStr);
		 	core.ajax.sendPacket(chkPacket,doAddCfm);
		  	chkPacket = null;  
		}else if(checkMCode=="0"){
			rdShowMessageDialog("����ģ���Ѿ����ڣ����������룡",0);
			document.getElementById('mCode').value="";
			document.getElementById('mCode').focus();
			return false;
		} 
}
function doAddCfm(packet){
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg  = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	window.opener.parent.showBusiGuideStep("e484",6);
    	rdShowMessageDialog("�����ɹ�",2);
    	window.opener.queryTemplate();
    	window.close();
    }else{
    	rdShowMessageDialog("����ʧ��",0);
    }
}
    
//�����޸ĺ������
function doUpate()
{
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
       }
    }
 
</script> 
</body>
</html>