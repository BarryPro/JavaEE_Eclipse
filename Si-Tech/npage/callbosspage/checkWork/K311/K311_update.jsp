<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ��ȡ��������
   * �汾: 1.0
   * ����: 
   * ����: 
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String opCode = "K311";
	String opName = "��ȡ��������";
  request.setCharacterEncoding("GBK");
  String sql = "";

	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String id = new String();
	String title = new String();
	
	String count = new String();
	String description = new String();
	String valid_flag = new String();
	String valid_yes = new String();
	String valid_no = new String();
	String readonly = new String();
	if(opType.equals("add")){
		title = "����";
		
		sql = "select to_char(SEQ_DSERIALNOCOUNT.nextval) from dual";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
		<wtc:param value="<%=sql%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>		
<%
		id = result[0][0];
	}else{
		title = "�޸�";
		id = request.getParameter("id");
		description = request.getParameter("description");
		count = request.getParameter("count");
		if(valid_flag.equals("Y"))
			valid_yes = "selected";
		else
			valid_no = "selected";
	}
%>
<html>
	<head>
		<title>��ȡ����<%=title%></title> 
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
		<script language="javascript">
			function modCfm(){		
				var   r   =   /^\+?[1-9][0-9]*$/;
				var count = document.form1.count.value;
				
				if(count == ""){
					similarMSNPop("������������");
					document.form1.count.select();
					return;
				}else if(document.form1.description.value == ""){
					similarMSNPop("������������ ");
					document.form1.description.select();
					return;
				} else if(!r.test(count)){
					similarMSNPop("����ֻ������������ ");
					return;
				} else if(parseInt(count)>1000){
					similarMSNPop("��ȡ�������ֵ���ܴ���1000�� ");
					return;
				}
				
				var myPacket = new AJAXPacket("K311I_AddMod.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("retType","<%=opType%>");
				myPacket.data.add("id","<%=id%>");
				myPacket.data.add("count",trim(count));
				myPacket.data.add("description",trim(document.form1.description.value));
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			}
			
			function doProcess(packet){
				var retType = packet.data.findValueByName("retType");		
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");		
				
				if(retCode=='000000'){
					similarMSNPop("�޸ĳɹ�" + "[" + retCode + "]");
					window.returnValue =retCode+"~"+<%=id%>+"~"+trim(document.form1.count.value)+"~"+trim(document.form1.description.value) ;
					setTimeout("window.close()",2500);
					//window.close();					
				}
				else{
					similarMSNPop(retMsg + "[" + retCode + "]");
					window.returnValue =retCode+ "" ;
					//window.close();							
				}
			}			
			
			function ltrim(s){
			 	return s.replace( /^\s*/, ""); 
			} 
			function rtrim(s){
			 	return s.replace( /\s*$/, ""); 
			} 
			function trim(s){
			 	return rtrim(ltrim(s)); 
			}		
		</script>
	</head>
	<body>
		<form name="form1" method="POST">
			<div id="Main">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tr>
			    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
				<td valign="top">
				<div id="Operation_Title"><B>��ȡ��������</B></div>
    		<div id="Operation_Table" >
    
			<!--%@ include file="/npage/include/header.jsp" %-->
				 <div class="title"><div id="title_zi">�޸ĳ�ȡ����</div> </div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right" class="blue">����</div>
						</td>
						<td>
							<div align="left"><input type="text" name="count" value="<%=count%>" maxlength="10"  /> <font color='red'>*��ȡ������Ϊ������</font></div>
						</td>
					</tr>
					<tr>
						<td style="border-right:0px;border-bottom:0px">
							<div align="right" class="blue">����</div>
						</td>
						<td>
							<div align="left" style="border-bottom:0px">&nbsp;&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center"><textarea name="description" cols="40" rows="5"><%=description%></textarea></div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								<input type="button" name="cfm" class="b_foot" value="ȷ��" onclick="modCfm()"/>
								<input type="button" name="clo" class="b_foot" value="�ر�" onclick="javascript:window.close();"/>
							</div>
						</td>
					</tr>
				</table>
			<!--%@ include file="/npage/include/footer.jsp" %-->
			<br/>          
			  </td>
			  <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
			</tr>
			      
			<tr>
			  <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
			  <td valign="bottom">
			  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
			    <tr>
			      <td height="1"></td>
			    </tr>
			  </table>
			  </td>
			  <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
			</tr>
		</table>

</div>
		</form>
	</body>
</html>
