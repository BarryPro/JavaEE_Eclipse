<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: �Ӵ�ʱ������
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

	String opCode = "K314";
	String opName = "�Ӵ�ʱ������";
  request.setCharacterEncoding("gb2312");
  String sql = "";

	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String id = new String();
	String title = new String();
	
	String minlength = new String();
	String maxlength = new String();
	String getcount = new String();
	String description = new String();
	String getCountResult = request.getParameter("getCountResult").trim();
	String getTCResult = request.getParameter("getTCResult").trim();
	String readonly = new String();
	if(opType.equals("add")){
		title = "����";
		
		sql = "select to_char(SEQ_dserialnodate.nextval) from dual";
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
		
		minlength = request.getParameter("minlength");
		maxlength = request.getParameter("maxlength");
		description = request.getParameter("description");
		getcount = request.getParameter("getcount");
		
	}
%>
<html>
	<head>
		<title>�Ӵ�ʱ��<%=title%></title> 
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
		<script language="javascript">
			function modCfm(){
				if(document.form1.minlength.value == ""){
					similarMSNPop("��������Сʱ����");
					document.form1.minlength.select();
					return;
				}
				if(document.form1.maxlength.value == ""){
					similarMSNPop("���������ʱ����");
					document.form1.maxlength.select();
					return;
				}
				if(document.form1.getcount.value == ""){
					similarMSNPop("������������");
					document.form1.getcount.select();
					return;
				}
				var   r   =   /^\+?[1-9][0-9]*$/;
				var count1 = document.form1.minlength.value;
				var count2 = document.form1.maxlength.value;
				var count = document.form1.getcount.value;
				if(!r.test(count1) && parseInt(count1) != 0){
					similarMSNPop("��Сʱ��ֻ����0���������� ");
					return;
				}
				if(!r.test(count2)){
					similarMSNPop("���ʱ��ֻ������������ ");
					return;
				}
				if(parseInt(count1)>parseInt(count2)){
					similarMSNPop("��Сʱ�����ܴ������ʱ����");
					return;
				}
				if(parseInt(count1)>10000){
					similarMSNPop("��Сʱ�����ܴ���10000�� ");
					return;
				}
				if(parseInt(count2)>10000){
					similarMSNPop("���ʱ�����ܴ���10000�� ");
					return;
				}
				if(!r.test(count)){
					similarMSNPop("����ֻ������������ ");
					return;
				}
				opType = '<%=opType%>';
				var getCountResult = '<%=getCountResult%>';
				var getTCResult = '<%=getTCResult%>';
				var tmpCount;
				if("add" == opType){
						tmpCount = parseInt(getTCResult) + parseInt(document.form1.getcount.value);
						if(tmpCount>parseInt(getCountResult)){
								var tNum = parseInt(getCountResult)-parseInt(getTCResult);
								similarMSNPop("������������������,Ŀǰ�������ӵ��������Ϊ��"+tNum+"����");
								return;
						}
				}else{
					var getNum = '<%=getcount%>';
					tmpCount = parseInt(getTCResult) + parseInt(document.form1.getcount.value)-parseInt(getNum);
					if(tmpCount>parseInt(getCountResult)){
								var tNum = parseInt(getCountResult)-parseInt(getTCResult)+parseInt(getNum);
								similarMSNPop("������������������,Ŀǰ�������õ��������Ϊ��"+tNum+"����");
								return;
						}
				}		
				
				var myPacket = new AJAXPacket("K314I_AddMod.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("retType","<%=opType%>");
				myPacket.data.add("id","<%=id%>");
				myPacket.data.add("minlength",trim(document.form1.minlength.value));
				myPacket.data.add("maxlength",trim(document.form1.maxlength.value));
				myPacket.data.add("getcount",trim(document.form1.getcount.value));
				myPacket.data.add("description",trim(document.form1.description.value));
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			
			}
			
			function doProcess(packet){
				var retType = packet.data.findValueByName("retType");		
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");	
				if(retCode=='000000'){
					similarMSNPop("�����ɹ�" + "[" + retCode + "]");
					window.returnValue =retCode+"~"+<%=id%>+"~"+trim(document.form1.minlength.value)+"~"+trim(document.form1.maxlength.value)+"~"+trim(document.form1.getcount.value)+"~"+trim(document.form1.description.value) ;
					setTimeout("window.close()",2500);
					//window.close();
				}
				else
				{
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
				<div id="Operation_Title"><B>�Ӵ�ʱ������</B></div>
    		<div id="Operation_Table" >
			<!--%@ include file="/npage/include/header.jsp" %-->	
				<div class="title"><div id="title_zi">�Ӵ�ʱ��</div> </div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right" class="blue" >��Сʱ��</div>
						</td>
						<td >
							<div align="left"><input type="text" name="minlength" value="<%=minlength%>" maxlength="8"  /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right"  class="blue" >���ʱ��</div>
						</td>
						<td>
							<div align="left"><input type="text" name="maxlength" value="<%=maxlength%>" maxlength="8"  /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right" class="blue" >����</div>
						</td>
						<td>
							<div align="left"><input type="text" name="getcount" value="<%=getcount%>" maxlength="4"  /></div>
						</td>
					</tr>
					<tr>
						<td style="border-right:0px;border-bottom:0px"  class="blue" >
							<div align="right">����</div>
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
		</form>
	</body>
</html>
