<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>

<head>
	<%
		//���������ۿ���ѯ
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		%>
<script language="javascript">
		onload=function(){
				document.all.cus_pass.disabled = false;
		}
		
		function doReset(){
				window.location.href = "fg610Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		
		function quechoosee() {
				var idIccid = document.frm.idIccid.value.trim();
	
				if(idIccid=="") {
						rdShowMessageDialog("���֤�Ų���Ϊ�գ����������룡");
						return false;
				}
	
				if((idIccid.indexOf("~")) != -1 || (idIccid.indexOf("|")) != -1 || (idIccid.indexOf(";")) != -1)
				{
					rdShowMessageDialog("���֤�Ų���������Ƿ��ַ������������룡");
		 	  		return false;
				}
				
				if(document.all.cus_pass.value.trim().len()==0){
					rdShowMessageDialog("�û����벻��Ϊ�գ�");
		 			document.all.cus_pass.focus();
		 			return false;
		 		}
	
			  document.all.quchoose.disabled = true;
			  
				var myPacket = new AJAXPacket("fg610_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				myPacket.data.add("idIccid",idIccid);
				myPacket.data.add("cus_pass",document.all.cus_pass.value.trim());
				core.ajax.sendPacketHtml(myPacket,checkSMZValue);
				getdataPacket = null;
		}
		
		function checkSMZValue(data) {
		  	document.all.quchoose.disabled = false;
		  	
				$("#gongdans").empty().append(data);
		}
				
</script>
<body >
	<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	
	<table cellspacing="0" >
	  <tr>
	    <td class="blue" width="15%">���֤��</td>
	    <td >
        <input name="idIccid"  id="idIccid"    v_type="string" maxlength="18" >
	    <td width="15%" class="blue">�û�����</td>
	    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
            <jsp:param name="irCus" value='1'/>
        </jsp:include>
   		</td>
		</tr>
	</table>
	
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="��ѯ" onclick="quechoosee()" />		
				&nbsp;
				<input name="back" onClick="doReset()" type="button" class="b_foot"  value="���">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
	
	<div id="gongdans">
	</div>
	
	<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>