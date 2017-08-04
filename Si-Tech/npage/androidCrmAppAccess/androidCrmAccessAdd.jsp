<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
   String input_group_id 	  = request.getParameter("input_group_id");
   String input_group_name	= request.getParameter("input_group_name");
   String opCode    = request.getParameter("opCode");
	 String opName    = request.getParameter("opName");
	 
	 //��ǰ����
	 String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	 //���������
	 java.util.Calendar calendar = java.util.Calendar.getInstance();
	 calendar.add(Calendar.MONTH, 6);
	 String hyDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()); 
	 
	 //һ�������
	 calendar.add(Calendar.MONTH, 6);//��6���¾�һ����
	 String oyDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()); 
	 
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������</title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" >



function setDateTr(){
	var allow_land_date_flag = $("#allow_land_date_sel").val();
	if(allow_land_date_flag=="0"){//��ѡ�����
		$("#allow_land_bDate").val("");
		$("#allow_land_eDate").val("");
	}else if(allow_land_date_flag=="1"){//����
		$("#allow_land_bDate").val("<%=currentDate%>");
		$("#allow_land_eDate").val("<%=hyDate%>");
	}else if(allow_land_date_flag=="2"){//һ��
		$("#allow_land_bDate").val("<%=currentDate%>");
		$("#allow_land_eDate").val("<%=oyDate%>");
	}else if(allow_land_date_flag=="5"){
		$("#allow_land_bDate").val("<%=currentDate%>");
		$("#allow_land_eDate").val("");
	}
} 
function setDateSel(){
	var bDate = $("#allow_land_bDate").val();
	var eDate = $("#allow_land_eDate").val();	
	//alert("bDate = "+bDate+"\neDate = "+eDate);
	if(bDate=="<%=currentDate%>"&&eDate=="<%=hyDate%>"){
		$("#allow_land_date_sel").val("1");
	}else if(bDate=="<%=currentDate%>"&&eDate=="<%=oyDate%>"){
		$("#allow_land_date_sel").val("2");
	}else if(bDate==""&&eDate==""){
		$("#allow_land_date_sel").val("0");
	}else{
		$("#allow_land_date_sel").val("5");
	}
} 
function setTimeTr(){
	var allow_land_time_flag = $("#allow_land_time_sel").val();
	
	if(allow_land_time_flag=="0"){
		$("#allow_land_bTime").val("");
		$("#allow_land_eTime").val("");
	}else if(allow_land_time_flag=="1"){ //��8��--��5��
		$("#allow_land_bTime").val("08:00:00");
		$("#allow_land_eTime").val("17:00:00");
	}else if(allow_land_time_flag=="2"){ //��8��--��6��
		$("#allow_land_bTime").val("08:00:00");
		$("#allow_land_eTime").val("18:00:00");
	}else if(allow_land_time_flag=="3"){ //��9��--��5��
		$("#allow_land_bTime").val("09:00:00");
		$("#allow_land_eTime").val("17:00:00");
	}else if(allow_land_time_flag=="4"){ //��9��--��6��
		$("#allow_land_bTime").val("09:00:00");
		$("#allow_land_eTime").val("18:00:00");
	}else if(allow_land_time_flag=="5"){  
		$("#allow_land_bTime").val("");
		$("#allow_land_eTime").val("");
	}
} 
function setTimeSle(){
	var bTime = $("#allow_land_bTime").val();
	var eTime = $("#allow_land_eTime").val();
	//alert("bTime = "+bTime+"\neTime = "+eTime);
	if(bTime=="08:00:00"&&eTime=="17:00:00"){
		$("#allow_land_time_sel").val("1");
	}else if(bTime=="08:00:00"&&eTime=="18:00:00"){
		$("#allow_land_time_sel").val("2");
	}else if(bTime=="08:00:00"&&eTime=="17:00:00"){
		$("#allow_land_time_sel").val("3");
	}else if(bTime=="09:00:00"&&eTime=="18:00:00"){
		$("#allow_land_time_sel").val("4");
	}else if(bTime==""&&eTime==""){
		$("#allow_land_time_sel").val("0");
	}else{
		$("#allow_land_time_sel").val("5");
	}
}
function checkLoginNo(){
	if($("#loginNo").val().trim()=="") return ;
	var getSimNaPacket = new AJAXPacket("ajaxCheckLoginNo.jsp","����ִ��,���Ժ�...");	
		getSimNaPacket.data.add("loginNo",$("#loginNo").val().trim());
		core.ajax.sendPacket(getSimNaPacket,doCheckLoginNo);
		getSimNaPacket = null; 
}
function doCheckLoginNo(packet){
	var countLoginno = packet.data.findValueByName("countLoginno"); 
	if(countLoginno=="0"){
		rdShowMessageDialog("���������������������",0);
		$("#loginNo").val("");
		$("#loginNo").focus();
	}
}
function twClose(){
	window.location = "androidCrmAccessMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}
</script>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">������������</div>
				</div>
					<table cellspacing="0">
 
						<tr>
							<td class="blue" width="15%">��������</td>
						 <td  width="18%"><input type="text" name="phoneName" id="phoneName"  value="" maxlength="5" /><font class="orange">*</font> 
						 	</td>
							
	 					<td class="blue" width="15%">IMEI����</td>
						 <td  width="18%"><input type="text" name="imeiNo" id="imeiNo"  maxlength="18"  ><font class="orange">*</font> </td>
						 
	 	 					<td class="blue" width="15%">�ֻ�����</td>
						 <td  width="18%"><input type="text" name="phoneNo" id="phoneNo"  value="" maxlength="11" v_type="mobphone"  onblur="checkElement(this)" />    </td>

						</tr>
						
						
						<tr>
							<td class="blue"  >�����½����</td>
							<td >
									<select id="allow_land_date_sel" onchange="setDateTr()">
										<option value="0">--��ѡ��--</option>
										<option value="1">����</option>
										<option value="2">һ��</option>
										<option value="5">�Զ���</option>
									</select>
							</td>
							
						 <td class="blue"  >��ʼ����</td>
						 <td><input type="text" id="allow_land_bDate" onPropertyChange="setDateSel()" value="" readOnly onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'<%=currentDate%>',onpicked:function(){}})"><font class="orange">*</font> </td>
						 
						 <td class="blue"  >��������</td>
						 <td><input type="text" id="allow_land_eDate" onPropertyChange="setDateSel()" value="" readOnly  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'<%=currentDate%>',onpicked:function(){}})"><font class="orange">*</font> </td>
						</tr>
						
						
						<tr>
							<td class="blue"  >�����½ʱ��</td>
							<td >
									<select id="allow_land_time_sel" onchange="setTimeTr()">
										<option value="0">--��ѡ��--</option>
										<option value="1">��8��--��5��</option>
										<option value="2">��8��--��6��</option>
										<option value="3">��9��--��5��</option>
										<option value="4">��9��--��6��</option>
										<option value="5">�Զ���</option>
									</select>
							</td>
						 <td class="blue"  >��ʼʱ��</td>
						 <td><input type="text" id="allow_land_bTime" onPropertyChange="setTimeSle()" readOnly onclick="WdatePicker({dateFmt:'HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						 
						 <td class="blue"  >����ʱ��</td>
						 <td><input type="text" id="allow_land_eTime" onPropertyChange="setTimeSle()"  readOnly  onclick="WdatePicker({dateFmt:'HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						</tr>
						
						 
						<tr>
							<td colspan="6" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="ȷ��" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="����" onclick="twClose()">
							</td>
						</tr>
					</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script type="text/javascript">
 
function doAdd(){
	
	if(document.all.phoneName.value.trim()==""){
		rdShowMessageDialog("�������������");
		document.all.phoneName.focus();
		return;
	}
	
	var mm = /^\w+$/;
	 
	if(document.all.imeiNo.value.trim()!=""){
		if(!mm.test(document.all.imeiNo.value.trim())){
			rdShowMessageDialog("IMEI�������벻��ȷ������������");
			
			document.all.imeiNo.focus();
			document.all.imeiNo.value="";
			return;
		}
	}else{
		rdShowMessageDialog("������IMEI��");
		document.all.imeiNo.focus();
		return;
	}
	
	
	if(!checkElement(document.all.phoneNo)){return false}
	
	if($("#allow_land_time_sel").val()=="0"){
		rdShowMessageDialog("��ѡ�������½ʱ��");
		return;
	}else{
		if(document.all.allow_land_eTime.value<document.all.allow_land_bTime.value){
			rdShowMessageDialog("����ʱ�䲻��С�ڿ�ʼʱ�䣬����������");
			document.all.allow_land_bTime.focus();
			document.all.allow_land_eTime.value="";
			document.all.allow_land_bTime.value="";
			return;
		}
	}
	
 
	if($("#allow_land_date_sel").val()=="0"){
	}else{
		if(document.all.allow_land_eDate.value<document.all.allow_land_bDate.value){
			rdShowMessageDialog("����ʱ�䲻��С�ڿ�ʼʱ�䣬����������");
			document.all.allow_land_bDate.focus();
			document.all.allow_land_eDate.value="";
			document.all.allow_land_bDate.value="";
			return;
		}
	}
	
	if("<%=input_group_id%>"=="null"){
		rdShowMessageDialog("��֯����id�����뷵������ѡ��");
		return;
	}
	
	var packet = new AJAXPacket("androidCrmAccessAddCfm.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode",     				 	"<%=opCode%>");
			packet.data.add("input_group_id",     "<%=input_group_id%>");
			packet.data.add("imeiNo",     					document.all.imeiNo.value.trim());
			packet.data.add("phoneName",     				document.all.phoneName.value.trim());
			packet.data.add("phoneNo",     				  document.all.phoneNo.value.trim());
			packet.data.add("allow_land_bTime",     document.all.allow_land_bTime.value.trim());
			packet.data.add("allow_land_eTime",     document.all.allow_land_eTime.value.trim());
			packet.data.add("allow_land_bDate",     document.all.allow_land_bDate.value.trim());
			packet.data.add("allow_land_eDate",     document.all.allow_land_eDate.value.trim());
			core.ajax.sendPacket(packet,doAddCfm);
			packet = null; 
}
function doAddCfm(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("�����ɹ�",2);
		window.location = "androidCrmAccessMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
}
</script> 
</body>
</html>
