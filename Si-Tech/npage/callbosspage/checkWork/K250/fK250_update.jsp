<%
  /*
   * ����: ���ȼ�����
   * �汾: 1.0
   * ����: 2008/11/05
   * ����: kouwb
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
	
	String opCode = "K250";
	String opName = "���ȼ�����";
  request.setCharacterEncoding("gb2312");
  String sql = "";

	String workNo = (String)session.getAttribute("workNo");
	String opType = request.getParameter("op").trim();
	String error_level_id = new String();
	String parent_error_level_id = new String();
	String error_level_name = new String();
	String note = new String();
	String title = new String();
	String valid_flag = new String();
	String valid_yes = new String();
	String valid_no = new String();
	String readonly = new String();
	String parentnod = new String();
	if(opType.equals("add")){
		title = "����";
		parentnod = request.getParameter("parentnod");
		parent_error_level_id = parentnod;
		
		sql = "select to_char(sBaseId.nextval) from dual";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
		<wtc:param value="<%=sql%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>		
<%
		error_level_id = result[0][0];
	}else{
		title = "�޸�";
		error_level_id = request.getParameter("error_level_id");
		parent_error_level_id = request.getParameter("parent_error_level_id");
		error_level_name = request.getParameter("error_level_name");
		note = request.getParameter("note");
		valid_flag = request.getParameter("valid_flag");
		if(valid_flag.equals("Y"))
			valid_yes = "selected";
		else
			valid_no = "selected";
	}
%>
<html>
	<head>
		<title>���ȼ�<%=title%></title> 
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		
		<script language="javascript">
			$(document).ready(
					function()
					{
				    $("td").not("[input]").addClass("blue");
						$("#footer input:button").addClass("b_foot");
						$("td:not(#footer) input:button").addClass("b_text");
						
					
						$("a").hover(function() {
							$(this).css("color", "orange");
						}, function() {
							$(this).css("color", "blue");
						});
						}
			);
			
			function modCfm()
			{
				if(document.form1.error_level_id.value == ""){
					similarMSNPop("�������ţ�");
					document.form1.error_level_id.select();
					return;
				}else if(document.form1.error_level_name.value == ""){
					similarMSNPop("���������ƣ�");
					document.form1.error_level_name.select();
					return;
				}
				//added by tangsong 20100409 ��֤����
				else if(!checkElement(document.all("error_level_name"))) {
					similarMSNPop("����ֵ�Ƿ���");
					return;
				}
				else if(document.form1.parent_error_level_id.value == ""){
					similarMSNPop("�������ϲ�ڵ��ţ�");
					document.form1.parent_error_level_id.select();
					return;
				}else if(isNaN(document.form1.error_level_id.value)){
					similarMSNPop("��ű���Ϊ���֣�");
					document.form1.error_level_id.select();
					return;
				}else if(isNaN(document.form1.parent_error_level_id.value)){
					similarMSNPop("�������ϲ��ű���Ϊ���֣�");
					document.form1.parent_error_level_id.select();
					return;
				}
				var myPacket = new AJAXPacket("fK250I_AddMod.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("retType","<%=opType%>");
				myPacket.data.add("login_no","<%=workNo%>");
				myPacket.data.add("error_level_name",trim(document.form1.error_level_name.value));
				myPacket.data.add("note",trim(document.form1.note.value));
				myPacket.data.add("error_level_id",trim(document.form1.error_level_id.value));
				myPacket.data.add("parent_error_level_id",trim(document.form1.parent_error_level_id.value));
				myPacket.data.add("valid_flag",trim(document.form1.valid_flag.value));
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			} 
			
			
			function doProcess(packet)
			{
				var retType = packet.data.findValueByName("retType");		
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");		
				
				if(retCode=='000000')
				{
					similarMSNPop(retMsg + "[" + retCode + "]");
					window.returnValue = "" + retCode + "~" + retMsg + "~" + trim(document.form1.error_level_name.value) +
															"~" + trim(document.form1.note.value) +
															"~" + trim(document.form1.error_level_id.value) +
															"~" + trim(document.form1.parent_error_level_id.value) +
															"~" + trim(document.form1.valid_flag.value) +
															"~";
					document.getElementById("cfmfoot").disabled = true;
					window.close();		
				}
				else
				{
					similarMSNPop(retMsg + "[" + retCode + "]");
					window.returnValue = "" + retCode + "~" + retMsg + "~";
					window.close();
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
			<!--add by zhengjiang 20090930 start-->
		<div id="Main">
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  			<tr>
    			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
					<!--updated by tangsong 20100830 ����ʽ�ĸñ���������,��ȥ��
					<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
					-->
					<td valign="top">
		<div id="Operation_Title"><B>���ȼ�����</B></div>
		<!--add by zhengjiang 20090930 end-->
			<div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
			<!--modify by zhengjiang 20090930 ����<div id="title_zi"></div> -->	
				<div class="title"><div id="title_zi">���ȼ�<%=title%></div></div>
				<table cellspacing="0">
					<tr>
						<td>
							<div align="right">���</div>
						</td>
						<td>
							<div align="left"><input type="text" name="error_level_id" value="<%=error_level_id%>" maxlength="10" readonly /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">����</div>
						</td>
						<td>
							<div align="left"><input type="text" name="error_level_name" value="<%=error_level_name%>" maxlength="50"/></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">�ϲ�ڵ���</div>
						</td>
						<td>
							<div align="left"><input type="text" name="parent_error_level_id" value="<%=parent_error_level_id%>" maxlength="10" readonly/></div>
						</td>
					</tr>
					<tr>
						<td>
							<div align="right">�Ƿ����</div>
						</td>
						<%if("add".equals(opType)){%>
						<td>
							<div align="left">
								<select name="valid_flag">
									<option value="Y" <%=valid_yes%>>��</option>
									<option value="N" <%=valid_no%>>��</option>
								</select>
							</div>
						</td>
						<%} else{%>
						<td>
							<div align="left">
								<select name="valid_flag">
									<option value="Y" <%=valid_yes%>>��</option>
									<option value="N" <%=valid_no%>>��</option>
								</select>
							</div>
						</td>
						<%}%>
					</tr>
					<tr>
						<td style="border-right:0px;border-bottom:0px">
							<div align="right">����</div>
						</td>
						<td>
							<div align="left" style="border-bottom:0px">&nbsp;&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center"><textarea name="note" cols="40" rows="5"><%=note%></textarea></div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								<input type="button" name="cfm" id="cfmfoot" class="b_foot" value="ȷ��" onclick="modCfm()"/>
								<input type="button" name="clo" class="b_foot" value="�ر�" onclick="javascript:window.close();"/>
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<!--add by zhengjiang 20090930 start-->
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
<!--add by zhengjiang 20090930 end-->
		</form>
	</body>
</html>
