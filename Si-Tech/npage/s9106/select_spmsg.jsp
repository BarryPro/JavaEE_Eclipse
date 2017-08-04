<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
 String sp_code = request.getParameter("sp_code");
 String page_type = request.getParameter("page_type");
 String regionCode = (String)session.getAttribute("regCode");
 String sql1="";
 if(page_type.equals("2")){
 sql1 = "select SP_CODE,SP_NAME,SP_TYPE,SERV_CODE,PROV_CODE,BAL_PROV,DEV_CODE,VALID_DATE,EXPIRE_DATE,DESCRIPTION,MAXACCEPT,SERV_TYPE from TDSMPSPINFOMSG where MAXACCEPT ="+sp_code;
}else{
 sql1 = "select SP_CODE,SP_NAME,SP_TYPE,SERV_CODE,PROV_CODE,BAL_PROV,DEV_CODE,VALID_DATE,EXPIRE_DATE,DESCRIPTION,MAXACCEPT,SERV_TYPE from TDSMPSPINFOPREMSG where MAXACCEPT ="+sp_code;
}
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val1" outnum="12">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" property="val1" scope="end" />
<%
	for(int i=0;i<result.length;i++){
		for(int j=0;j<result[i].length;j++){
			System.out.println("result["+i+"]["+j+"] = "+result[i][j]);
		}
	}
%>	
var response = new AJAXPacket();	
response.guid = '<%=request.getParameter("guid") %>';
response.data.add("retCode",	"<%=retCode%>");
response.data.add("retMsg",	"<%=retMsg%>");
<% if (retCode.equals("000000")) { %>
	response.data.add("spid","<%=result[0][0]%>");
	response.data.add("spname","<%=result[0][1]%>");
	response.data.add("sptype","<%=result[0][2]%>");
	response.data.add("spsvcid","<%=result[0][3]%>");
	response.data.add("provcode","<%=result[0][4]%>");
	response.data.add("balprov","<%=result[0][5]%>");
	response.data.add("devcode","<%=result[0][6]%>");
	response.data.add("validdate","<%=result[0][7]%>");
	response.data.add("expiredate","<%=result[0][8]%>");
	response.data.add("spdesc","<%=result[0][9]%>");
	response.data.add("maxaccept","<%=result[0][10]%>");
	response.data.add("serv_type","<%=result[0][11]%>");
<% } %>
core.ajax.receivePacket(response);
