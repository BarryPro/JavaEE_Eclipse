<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
 		String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 		
 		String zphoneNo = (String)request.getParameter("activePhone");
%>
<html>
<head>
	<title>�û���ֵ��¼��ѯ</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript">
		function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			if(!checkDateType($("#startTime")[0])){
				return false;
			}
			if(!checkDateType($("#endTime")[0])){
				return false;
			}
			
			/* ���ò�ѯ���� */

			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("serviceName","sD309Qry");
			getdataPacket.data.add("outnum","6");
			getdataPacket.data.add("inputParamsLength","9");
			getdataPacket.data.add("inParams0","");
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5",$("#phoneNo").val());
			getdataPacket.data.add("inParams7",$("#startTime").val());
			getdataPacket.data.add("inParams8",$("#endTime").val());
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if("000000" == retCode){
				var result = packet.data.findValueByName("result");
				var insertStr = "";
				$.each(result,function(i,n){
					insertStr += "<tr>";
					insertStr += "<td>"+n[0]+"</td>";
					insertStr += "<td>"+n[1]+"</td>";
					insertStr += "<td>"+n[2]+"</td>";
					insertStr += "<td>"+n[3]+"</td>";
					insertStr += "<td>"+n[4]+"</td>";
					insertStr += "<td>"+n[5]+"</td>";
					insertStr += "</tr>";
				});
				$("#resultTabContent").empty();
				$("#resultTabContent").append(insertStr);
				$("#resultTab").show("fast");
			}else{
				rdShowMessageDialog("��ѯʧ��" + retCode + ":" + retMsg);
				return false;
			}
		}
		function checkDateType(obj){
			if(!checkElement(obj)){
				return false;
			}

			return true;
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û���ֵ��¼��ѯ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
			<td colspan="3">
				<input name="phoneNo" id="phoneNo" type="text" maxlength="15" value="<%=zphoneNo%>"
				 v_must="1" v_type="mobphone" onblur="checkElement(this)" />
				<font class="orange"><span>*</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue">��ʼʱ��</td>
			<td>
				<input name="startTime" id="startTime" type="text" 
				readonly="readOnly" v_must="1" value="<%=dateStr%>"
				onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,alwaysUseStartDate:true})" />
				<font class="orange"><span>*(��ʽ��yyyy-MM-dd)</span></font>
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input name="endTime" id="endTime" type="text" 
				readonly="readOnly" v_must="1" value="<%=dateStr%>"
				onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,alwaysUseStartDate:true})" />
				<font class="orange"><span>*(��ʽ��yyyy-MM-dd)</span></font>
			</td>
		</tr>
	</table>
	<table id="resultTab" cellspacing="0" style="display:none;">
		<tr>
			<th>�мۿ������к�</th>
			<th>Ϊ��ֵ�������к���</th>
			<th>����ֵ�ʻ�����</th>
			<th>��ֵ���</th>
			<th>����ʱ��</th>
			<th>��ֵ��ʽ</th>
		</tr>
		<tbody id="resultTabContent">
			
		</tbody>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer">
				<input type="button" name="query" class="b_foot" value="��ѯ" 
          style="cursor:hand;" onClick="doQuery()">
				<input type="button" name="close" class="b_foot" value="�ر�" 
          style="cursor:hand;" onClick="removeCurrentTab()" />
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
