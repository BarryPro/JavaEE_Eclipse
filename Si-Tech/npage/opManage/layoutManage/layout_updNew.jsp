<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	String opName="��������ģ��";
	String modelId = request.getParameter("modelId")!=null?(String)request.getParameter("modelId"):"";
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("-----------------modelId------------"+modelId);
	
	String dlayoutmodelsql    = "select LAYOUT_MODEL_ID,LAYOUT_MODEL_NAME,IS_EFFECT,VERSION from DLAYOUTmodel where LAYOUT_MODEL_ID='"+modelId+"'";
	String dlayoutrole_relSql = "select LAYOUT_CSS,IS_DEFAULT  from dlayoutrole_rel  where OP_ROLE='XXXXXX' and LAYOUT_MODEL_ID='"+modelId+"'";
	String dwkspacerole_rel   = "select WKSPACE_ID,WKSPACE_LEN from dwkspacerole_rel where OP_ROLE='XXXXXX' and LAYOUT_MODEL_ID='"+modelId+"'";
%>
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=dlayoutmodelsql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t1" scope="end"/>
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=dlayoutrole_relSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t2" scope="end"/>
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=dwkspacerole_rel%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t3" scope="end"/>		
<%
String modelIdn  = "";
String modelName = "";
String isEFFect  = "";
String isDefault = "";
String layoutcSt = "#";
String wkspaceSt = "#";
String versionSt = "";
if(result_t1.length>0){
	modelIdn  = result_t1[0][0];
	modelName = result_t1[0][1];
	isEFFect  = result_t1[0][2];
	versionSt = result_t1[0][3];
}

for(int i=0;i<result_t2.length;i++){
	layoutcSt += result_t2[i][0].trim()+"#";
	if(result_t2[i][1].equals("1")){
		isDefault = result_t2[i][0];
	}
}

for(int i=0;i<result_t3.length;i++){
	wkspaceSt += result_t3[i][0].trim()+"#";
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
					<div id="title_zi">�޸Ĳ���ģ��</div>
				</div>
					<table cellspacing="0">
						<tr>
							<td class="blue" width="25%">����ģ����</td>
							<td class="blue" width="25%">
								<input type='text' id="mCode" maxlength="10" value="<%=modelIdn%>" disabled ><font class="orange">*</font>
							</td>
							<td class="blue" width="25%">����ģ������</td>
							<td class="blue" width="25%"><input type="text" v_must=1 v_type="string" maxlength="32" id="mName" value="<%=modelName%>"/><font class="orange">*</font></td>
						</tr>
						<tr>
							
							<td class="blue">�Ƿ񷢲�</td>
							<td class="blue">
							    <select id="mShow">
										<option value="0" <%if(isEFFect.equals("0")) out.print("selected");%>>��</option>	
										<option value="1" <%if(isEFFect.equals("1")) out.print("selected");%>>��</option>
								</select>
							</td>
							<td class="blue">Ĭ�����</td>
							<td class="blue"> 
								<select id="defLay" onchange="setLay()">
										<option value='0' <%if(isDefault.equals("0")) out.print("selected");%>>���������</option>
										<option value='1' <%if(isDefault.equals("1")) out.print("selected");%>>��ʾȫ��</option>
										<option value='2' <%if(isDefault.equals("2")) out.print("selected");%>>�޲˵�</option>
										<option value='3' <%if(isDefault.equals("3")) out.print("selected");%>>����</option>
								</select>
							</td>
							
						</tr>
						
						<tr>
							<td  class="blue">
							ģ��汾		
							</td>
							<td class="blue" colspan=3><%=versionSt%></td>
						</tr>
						<tr>	
							<td  class="blue">
							ѡ����ʾ�����		
							</td>
							<td colspan="3">
									<input type="checkbox" id="layche" name="layche" value="0" <%if(layoutcSt.indexOf("0")!=-1) out.print("checked"); if(isDefault.equals("0")) out.print(" disabled"); %>>���������
									<input type="checkbox" id="layche" name="layche" value="1" <%if(layoutcSt.indexOf("1")!=-1) out.print("checked"); if(isDefault.equals("1")) out.print(" disabled");%>>��ʾȫ��
									<input type="checkbox" id="layche" name="layche" value="2" <%if(layoutcSt.indexOf("2")!=-1) out.print("checked"); if(isDefault.equals("2")) out.print(" disabled");%>>�޲˵�
									<input type="checkbox" id="layche" name="layche" value="3" <%if(layoutcSt.indexOf("3")!=-1) out.print("checked"); if(isDefault.equals("3")) out.print(" disabled");%>>����			
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
			String checkedStr = "";
			String wkspaceLen1 = "",wkspaceLen2 = "";
		for(int ih=0;ih<result_th.length;ih++){
			checkedStr = ""; wkspaceLen1 = "";wkspaceLen2 = "";
			for(int i=0;i<result_t3.length;i++){
				if(result_t3[i][0].equals(result_th[ih][0])){
					checkedStr = "checked";
					if(result_t3[i][1].equals("1")){
						wkspaceLen1 = "selected";
						wkspaceLen2 = "";
					}else{
						wkspaceLen2 = "selected";
						wkspaceLen1 = "";
					}
					break;
				}
			}
			
		 	outStr += "<tr>";
		 	outStr += "<td><input type='checkbox'  id='wche' name='wche' value='"+result_th[ih][0]+"' "+checkedStr+"></td>";
			outStr += "<td class='blue'>"+result_th[ih][0]+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][1]+"</td>";
			outStr += "<td class='blue'>"+("0".equals(result_th[ih][2])?"��":"��")+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][3]+"</td>";
			outStr += "<td><select ><option value='1' "+wkspaceLen1+">�볤</option><option value='2' "+wkspaceLen2+">ȫ��</option></select></td>";
		 	outStr += "</tr>";
		}
		 out.print(outStr);
		%>
				</table>
					<table cellspacing="0">
						<tr>
							<td  id="footer">
								<input class="b_foot"  id="addbut"  type=button value="����" onclick="updCfm()">
							   
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
 		 updCfm();
	}
});
</script>
<script type="text/javascript">
var checkMCode = "";
 
$(document).ready(function(){
	$("select").width("50");
	$("#defLay").width("150");
	$("#mShow").width("150");
	$("input[type='text']").width("150");
	//setLay();
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
function updCfm()
{
	/*
	if(!check(frm)){
		return false;
	}
	*/
	
	var mName = document.getElementById('mName').value.trim();
    if(mName==""){
		rdShowMessageDialog("����д����ģ������");
		document.getElementById('mName').value = "";
		document.getElementById('mName').focus();
		return false;
	}
	 
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
			var chkPacket = new AJAXPacket("modelUpdCfm.jsp","����ִ��,���Ժ�...");
		  	chkPacket.data.add("mCode", "<%=modelId%>");
		  	chkPacket.data.add("mName", mName.trim());
		  	chkPacket.data.add("mShow", $("#mShow").val());
		  	chkPacket.data.add("defLay", $("#defLay").val());
		  	chkPacket.data.add("laycStr",laycStr);
		  	chkPacket.data.add("wcheStr",wcheStr);
		  	chkPacket.data.add("wcheLenStr",wcheLenStr);
		 	core.ajax.sendPacket(chkPacket,doUpdCfm);
		  	chkPacket = null;  
		 
}
function doUpdCfm(packet){
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg  = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	rdShowMessageDialog("�����ɹ�",2);
    	window.opener.queryTemplate();
    	window.close();
    }else{
    	rdShowMessageDialog("����ʧ�ܣ�"+retCode+"��"+retMsg,0);
    }
}
    
 
</script> 
</body>
</html>