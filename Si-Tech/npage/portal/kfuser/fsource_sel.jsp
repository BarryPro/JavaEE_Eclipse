<%
   /*
   * ����: ��ѯ�û���Դռ��
�� * �汾: v1.0
�� * ����: 2008/03/30
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String password = (String)session.getAttribute("password");
     String phoneNo  = (String)session.getAttribute("activePhone");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 String op_cmd = "1300";
%>
<wtc:service name="sAccuGetEvInfo" outnum="15" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=op_cmd%>"/>
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result"scope="end" />
	
	
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	
<div  id="form">
	<div class="table_biaoge" style="overflow-x:auto">
		<table width="100%" class="ctl" cellpadding="0" cellspacing="0">
			<tr> 
				<td>��Ϊ����</td><td title="<%=result[0][3]%>"><%=result[0][3].equals("")?"&nbsp;":result[0][3]%></td>
			</tr>
			<tr>
				<td class="grey">��������</td><td title="<%=result[0][4]%>" class="grey"><%=result[0][4].equals("")?"&nbsp;":result[0][4]%></td>
			</tr>
			<tr>
				<td>�Ƿ��������û�</td><td title="<%=result[0][5]%>"><%=result[0][5].equals("")?"&nbsp;":result[0][5]%>
			</tr>
			<tr>
				</td><td class="grey">�Ƿ������û�</td><td class="grey" title="<%=result[0][6]%>"><%=result[0][6].equals("")?"&nbsp;":result[0][6]%></td>
			</tr>
		
		</table>
	</div>
</div>	
