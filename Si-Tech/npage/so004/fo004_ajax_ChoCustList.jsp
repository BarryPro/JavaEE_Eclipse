<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ�б�
�� * �汾: v1.0
�� * ����: 2013-08-30
�� * ����: wangjxc	
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>
 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String  UnitId	     = (String)request.getParameter("UnitId");
		String  flag   = (String)request.getParameter("flag");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
%>

<wtc:service name="so001ChoCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	  <wtc:param value="<%=UnitId%>"/>
	  <wtc:param value="<%=flag%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>	

<%
		String ChoUnitName = "";
	String ChoCustId = "";
%>

<%
if("000000".equals(retCode)){

	 ChoUnitName = retList[0][0]; 
	 ChoCustId = retList[0][1];   
	}
	%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("ModFlag","<%=flag%>");
response.data.add("ChoUnitName","<%=ChoUnitName%>");
response.data.add("ChoCustId","<%=ChoCustId%>");
core.ajax.receivePacket(response);
	
