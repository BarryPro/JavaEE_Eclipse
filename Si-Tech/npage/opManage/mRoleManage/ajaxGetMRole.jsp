<%
/********************
 version v2.0
������: si-tech
*
*create:hejwa 2010��12��10��
 ����sqlȡ���������ͬ�����飬ת��Ϊjs����
 +����#@#@#����
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String sysRoleId     = (String)request.getParameter("sysRoleId");
		String mRoleName     = (String)request.getParameter("mRoleName");
		String regionCode = (String)session.getAttribute("regCode");
		
		String sql = "select mb_id,b_rolecode,m_rolecode,m_rolename ,B_ROLENAme from dmoprolerela where " ;
		
		if(!sysRoleId.equals("")){
			sql = sql + " m_rolecode='"+sysRoleId+"' and ";
		}
		
		if(!mRoleName.equals("")){
			sql = sql + " m_rolename like '%"+mRoleName+"%'  and ";
		}
		sql = sql +" 1= 1";
 	System.out.println("sql----"+sql);
%>		
 	<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=sql%></wtc:sql>
 	</wtc:pubselect>
	<wtc:array id="result_t2" scope="end"/>
	var retArray = new Array();
<%for(int i=0;i<result_t2.length;i++){%>
	retArray[<%=i%>] = new Array();
	<%for(int j=0;j<result_t2[i].length;j++){
	  	if(result_t2[i][j]!=null){%>
			retArray[<%=i%>][<%=j%>]="<%=result_t2[i][j]%>";
<%}}}%>

var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);