<%
   /*
   * ����: ��������
�� * �汾: v1.0
�� * ����: 2011-7-25 16:08:52
�� * ��Ȩ: sitech
	 * ���ߣ�hejwa
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.util.page.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../login/dispatch.jsp" %>	
<%
       //��ֹIE����ҳ��
	  response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	  response.setHeader("Pragma","no-cache"); //HTTP 1.0
	  response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
	  String  powerCode= (String)session.getAttribute("powerCode");
		String tmp1 = getLink("4","urms/workflow/swf156/swf156Frame.jsp","97028",session,request);
		String tmp2 = getLink("4","urms/workflow/swf156/swf156Frame.jsp","97028",session,request);
		
%>
<wtc:service name="sWfInfo" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	String db_task = "0";
	String yb_task = "0";
	if("000000".equals(retCode)){
		if(result.length>0){
			db_task = result[0][1];
	    yb_task = result[0][2];
		}
	}
%>	
	
<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr> 					
					<th id="runTask">����������������ֲ鿴��ϸ���ݣ�</th>
			</tr>
			
			<tr> 		
					<!--w154 ��������-->			
					<td>���죺<a href="javascript:parent.openPage('4','w154','��������','<%=tmp1%>','000');"><%=db_task%></a></td>
			</tr>
			<tr>
					<!--w156 �Ѵ�����-->
					<td>�Ѱ죺<a href="javascript:parent.openPage('4','w156','�Ѵ�����','<%=tmp2%>','000')"><%=yb_task%></a></td> 
			</tr>
	</table>
</div>