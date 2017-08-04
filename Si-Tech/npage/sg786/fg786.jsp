<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
		String opName = WtcUtil.repNull(request.getParameter("opName"));
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	
	<wtc:service name="sG786Qry" routerKey="region" routerValue="<%=regionCode%>" 
								outnum="4" retcode="retCode" retmsg="retMsg">
	  <wtc:param value=""/>
	  <wtc:param value="01"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=password%>"/>
	  <wtc:param value=""/>
	  <wtc:param value=""/>
	  <wtc:param value="XXXX"/>
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>
		
	<%
		if(!"000000".equals(retCode)){
	%>
			<script language="javascript">
	      rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
	      removeCurrentTab();
	   	</script>
	<%
		}
	%>
		
		
	<title><%=opName%></title>
	
	<script language="javascript">
		$(document).ready(function(){
			
			/*�޸�*/
			$(".updateBtn").click(function(){
				var trObj = $(this).parent().parent();
				var oprOpCode = trObj.find("td:eq(0)").text().trim();
				trObj.find(":text").removeAttr("readonly").removeClass("InputGrey").select();
				//alert(oprOpCode);
				
				/*�����а�ť����Ч*/
				$("#showTab").find(":button:visible").attr("disabled","disabled");
				/*��ǰ�а�ť�仯*/
				trObj.find(":button:lt(2)").hide();
				trObj.find(":button:gt(1)").show();
				
			});
			
			/*ɾ��*/
			$(".delBtn").click(function(){
				var trObj = $(this).parent().parent();
				var oprOpCode = trObj.find("td:eq(0)").text().trim();
				var oprOpName = trObj.find("td:eq(1)").text().trim();
				if(rdShowConfirmDialog("ȷ��ɾ��"+oprOpCode+oprOpName+"������Ϣ��")==1){
					var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sG786Cfm");
					getdataPacket.data.add("outnum","1");
					getdataPacket.data.add("inputParamsLength","10");
					getdataPacket.data.add("inParams0","");
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workNo%>");
					getdataPacket.data.add("inParams4","<%=password%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7","3");
					getdataPacket.data.add("inParams8",oprOpCode);
					getdataPacket.data.add("inParams9","");
					core.ajax.sendPacket(getdataPacket,doOprBack);
					getdataPacket = null;
				}
				
			});
			
			/*����*/
			$(".saveBtn").click(function(){
				var trObj = $(this).parent().parent();
				var oprOpCode = trObj.find("td:eq(0)").text().trim();
				var oprOpName = trObj.find("td:eq(1)").text().trim();
				var newMon = trObj.find(":text").val().trim();
				
				if(!f_check_number(newMon)){
					rdShowMessageDialog("�Զ���������������������",1);
					return false;
				}
				if(rdShowConfirmDialog("ȷ���޸�"+oprOpCode+oprOpName+"������Ϣ��")==1){
					/*����*/
					var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("serviceName","sG786Cfm");
					getdataPacket.data.add("outnum","1");
					getdataPacket.data.add("inputParamsLength","10");
					getdataPacket.data.add("inParams0","");
					getdataPacket.data.add("inParams1","01");
					getdataPacket.data.add("inParams2","<%=opCode%>");
					getdataPacket.data.add("inParams3","<%=workNo%>");
					getdataPacket.data.add("inParams4","<%=password%>");
					getdataPacket.data.add("inParams5","");
					getdataPacket.data.add("inParams6","");
					getdataPacket.data.add("inParams7","2");
					getdataPacket.data.add("inParams8",oprOpCode);
					getdataPacket.data.add("inParams9",newMon);
					core.ajax.sendPacket(getdataPacket,doOprBack);
					getdataPacket = null;
					
				}
				
			});
			
			
			/*����ȡ����ť*/
			$(".saveCancelBtn").click(function(){
				/*�ָ���ʼֵ*/
				var trObj = $(this).parent().parent();
				trObj.find(":text").val(trObj.find(":hidden").val());
				
				trObj.find(":text").attr("readonly","readonly").addClass("InputGrey");
				
				/*�����а�ť����Ч*/
				$("#showTab").find(":button").removeAttr("disabled");
				/*��ǰ�а�ť�仯*/
				trObj.find(":button:gt(1)").hide();
				trObj.find(":button:lt(2)").show();
				
				
			});
			
			
		});
		
		function f_check_number(strVal){
			if (/^[1-9]\d*$/.test(strVal)){
				return true;
			}else{
				return false;
			}
			
		}
		
		function doOprBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ�",2);
				resetPage();
			}else{
				rdShowMessageDialog("����ʧ��:"+retCode+retMsg,0);
				resetPage();
			}
		}
		function resetPage(){
			window.location="/npage/sg786/fg786.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>";
		}
	</script>
</head>
<body>
<form name="frm" method="POST" action="selectserv_Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0" id="showTab">
		<tr>
			<th>��������</th>
			<th>��������</th>
			<th>�Զ���������(��Ȼ��)</th>
			<th>��ǰ״̬</th>
			<th>�޸�/ɾ��</th>
		</tr>
		<%
			if(result_t1 != null && result_t1.length > 0){
				for(int i = 0; i < result_t1.length; i++){
		%>
			<tr>
			<td><%=result_t1[i][0]%></td>
			<td><%=result_t1[i][1]%></td>
			<td>
				<%
					if("1".equals(result_t1[i][3])){
				%>
				<input type="text" name="activate" value="<%=result_t1[i][2]%>"
					readonly="readonly" class="InputGrey" size="5" maxlength="5"/>
				<input type="hidden" name="initActivate" value="<%=result_t1[i][2]%>"/>
				<%}else if("0".equals(result_t1[i][3])){
				%>
				<input type="text" name="activate" value=""
					readonly="readonly" class="InputGrey" size="5" maxlength="5"/>
				<input type="hidden" name="initActivate" value=""/>
				<%}%>
			</td>
			<td>
				<%
					if("1".equals(result_t1[i][3])){
						out.print("����");
					}else if("0".equals(result_t1[i][3])){
						out.print("δ����");
					}
				%>
			</td>
			<td align="center">
					<input type="button" class="b_text updateBtn" value="�޸�" />
					<input type="button" class="b_text delBtn" value="ɾ��" />
					<input type="button" class="b_text saveBtn" value="����" style="display:none;"/>
					<input type="button" class="b_text saveCancelBtn" value="ȡ��" style="display:none;"/>
			</td>
		</tr>
		<%
			}
			}
		%>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>