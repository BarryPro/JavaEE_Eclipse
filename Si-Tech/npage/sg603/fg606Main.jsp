<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String smzflag ="";
	
	String idIccid = request.getParameter("idIccid");
	String cus_pass = request.getParameter("cus_pass");
	String opnote =workNo+"����"+opCode+"��д�������������ѯ";


%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opnote%>"/>
		<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="dcust4" scope="end" />

<body>
	<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�����ۿ�����-��д��������</div>
			</div>
			
						<table >
							<tr >
								<th></th>						
								<th>�ֻ�����</th>
								<th>�ջ�������</th>
								<th>�ջ��˵绰</th>
								<th>�ջ��˵�ַ</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust4.length>0) {
							   for(int i=0;i<dcust4.length; i++) {
							%>
							<tr> 
								
 						<td width="3%"><input name="opFlag" type="radio" value="<%=dcust4[i][0]%>" ></td>
 						<td width="10%"><%=dcust4[i][0]%></td>
 						<td width="10%"><%=dcust4[i][1]%></td>
 						<td width="15%"><%=dcust4[i][2]%></td>
 						<td width="30%"><%=dcust4[i][3]%></td>
						  </tr>
						  		<%
		    }
		    %>
		    </table>
		    <br>
		    	<table cellspacing="0">
						<tr>
         		<td class='blue' width="15%">��������</td>
						<td ><input type="text" value=""  maxlength="80" id='wuliudanho' name='wuliudanho'></td>
         		<td class='blue' width="15%">������˾����</td>
						<td ><input type="text" value=""  size="40" maxlength="80" id='wuliucommpany' name='wuliucommpany'></td>																			
					 </tr>
		    		</table>
		    		
		    		
		    	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input class="b_foot" type="button" name="b_write" value="ȷ��" onmouseup="comitss()"   />
					<input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" />
			</div>
			</td>
		</tr>
	</table>
	<%
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='5'>��ѯ��ϢΪ�գ�</td></tr>
		<tr height='25' align='center'><td colspan='5'><input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" /></td>
					</tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<tr height='25' align='center'><td colspan='5'>��ѯ��ϢΪ�գ�</td>
						
					</tr>
					<tr height='25' align='center'>
						<td colspan='5'><input class="b_foot" type="button" name="b_return" value="����" onmouseup="doreturn()" /></td>
					</tr>
					
					<%
	}%>
						</table>
					</div>
				</div>
 <%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>
<script language="javascript">

	function comitss(){
		document.all.b_write.disabled=true;
		var phonenos=""
		var wulidanh =$("#wuliudanho").val();
		var wuliucommpany =$("#wuliucommpany").val();
		var radio1 = document.getElementsByName("opFlag");
		for(var i=0;i<radio1.length;i++) {
			if(radio1[i].checked) {
				var opFlag = radio1[i].value;
				phonenos=opFlag;
			}
		}
		
		if(phonenos.trim()=="") {
			rdShowMessageDialog("��ѡ��һ����в�����");
			document.all.b_write.disabled=false
			return false;
		}
		if(wulidanh.trim()=="") {
			rdShowMessageDialog("����д�������ţ�",0);
			document.all.b_write.disabled=false
			return false;
		}
		if(wuliucommpany.trim()=="") {
			rdShowMessageDialog("����д������˾���ƣ�",0);
			document.all.b_write.disabled=false
			return false;
		}
				     
    	var myPacket = new AJAXPacket("fg604Ajax.jsp","�����������������Ϣ���Ժ�......");
		myPacket.data.add("phonenos",phonenos);
		myPacket.data.add("wulidanh",wulidanh);
		myPacket.data.add("wuliucommpany",wuliucommpany);
		myPacket.data.add("opCode",'<%=opCode%>');
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
    }

	function doSetStsDate(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
				 rdShowMessageDialog("�ύ�ɹ���");
				 location = location;
		}else {
				 rdShowMessageDialog("�ύʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
		 document.all.b_write.disabled=false;//д���ɹ����ύ
	}						  	

	function doreturn(){
		if("<%=opCode%>"=="g843"){
			window.location.href = "/npage/sg603/fg606Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}else{
			window.location.href = "fg604Dispatch.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
</script>