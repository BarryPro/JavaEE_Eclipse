<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String iProjectType = request.getParameter("iProjectType");
		String phoneNo = request.getParameter("phoneNo");
		/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		System.out.println(" ==== start f8379_getInfo.jsp ==== " + iProjectType + " | " + loginAccept + " | " + phoneNo);
		
		String  inputParsm [] = new String[8];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 oneline */
		inputParsm[4] = op_strong_pwd;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = iProjectType;
%>
		<wtc:service name="s8379QryPro" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="14">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
	System.out.println("=== s8379QryPro ===" + retCode + "|" + retMsg);
	String vSrvName = "";
%>

<script language="javascript">
	function saveTo(){
		var opValue = $("input[@name='opFlag'][@checked]").val();
		if(typeof(opValue) == "undefined")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}
		opValue = parseInt(opValue) + 1;
		
		var val = "";
		for(var i = 1; i <= 12; i++){
			val = val + $("#tabData tr:eq("+opValue+") td:eq(" + i + ")").html() + "|";	
		}
		window.returnValue= val;
		window.close();
	}
</script>
</HEAD>
<body style="overflow-x:hidden">
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>
	<table cellspacing="0" id="tabData">
    <tr>
    	<th>ѡ��</th>
    	<th>��������</th>
    	<th>��������</th>
    	<th>�ֽ�</th>
    	<th>����Ԥ��</th>
    	<th>�Ԥ��</th>
    	<th>�ۼ�����</th>
    	<th>������������</th>
    	<th>���������</th>
    	<th>����Ԥ���</th>
    	<th>����Ԥ�������</th>
    	<th>��Ԥ��</th>
    	<th>ÿ���������</th>
    </tr>
    
    
    
    
    <%
    if("000000".equals(retCode)){
    	for(int i = 0; i < ret.length; i++){
    %>
    	<tr>
    		<td><input type="radio" name="opFlag" value="<%=i%>"/></td>
				<td><%=ret[i][0]%></td>
				<td><%=ret[i][1]%></td>
				<td><%=ret[i][2]%></td>
				<td><%=ret[i][3]%></td>
				<td><%=ret[i][4]%></td>
				<td><%=ret[i][5]%></td>
				<td><%=ret[i][6]%></td>
				<td><%=ret[i][7]%></td>
				<td><%=ret[i][8]%></td>
				<td><%=ret[i][9]%></td>
				<td><%=ret[i][10]%></td>
				<td><%=ret[i][11]%></td>
			</tr>
		<%
			}
		}else
			{
			//huangrong add �Դ�����Ϣ��չʾ 2011-7-13 15:39
    %>
      <tr>
    		<td colspan="31" align="center"><font color="red">��ѯ��������ʧ�ܣ�������Ϣ��"<%=retMsg%>"��������룺"<%=retCode%>"</font></td>
			</tr>
		<%
		}
		%>
  </table>

	<TABLE cellspacing="0">
    <%
    if("000000".equals(retCode)){
    %>		
		<TR>
			<TD id="footer">
				<input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=ȷ��>&nbsp;
				<input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=����>&nbsp;
			</TD>
		</TR>
    <%
     }else
     	{
    %>	
		<TR>
			<TD id="footer">
				<input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=����>&nbsp;
			</TD>
		</TR>
		<%
		}
		%>    	
	</TABLE>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body>
</HTML>