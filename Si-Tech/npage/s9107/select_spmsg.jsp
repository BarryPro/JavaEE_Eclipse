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
 String maxaccept = request.getParameter("maxaccept");
 String page_type = request.getParameter("page_type");
 String regionCode = (String)session.getAttribute("regCode");
 String sql1="";
 if(page_type.equals("2")){
 sql1 = "select OPERATOR_CODE,OPERATOR_NAME,SERV_TYPE,SERV_ATTR,COUNT,BILL_FLAG,OTHER_BAL_OBJ1,OTHER_BAL_OBJ2,VALID_DATE,EXPIRE_DATE,BAL_PROP from TDSMPSPBIZINFOMSG where MAXACCEPT ="+maxaccept;
}else{
 sql1 = "select OPERATOR_CODE,OPERATOR_NAME,SERV_TYPE,SERV_ATTR,COUNT,BILL_FLAG,OTHER_BAL_OBJ1,OTHER_BAL_OBJ2,VALID_DATE,EXPIRE_DATE,BAL_PROP from TDSMPSPBIZINFOPREMSG where MAXACCEPT ="+maxaccept;
}
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retval="val1" outnum="11">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" property="val1" scope="end" />
<%
for(int i=0;i<result.length;i++){
        for(int j=0;j<result[i].length;j++){
                System.out.println("result["+i+"]["+j+"] == "+result[i][j]);
        }
}
%>
var response = new AJAXPacket();	
response.guid = '<%=request.getParameter("guid") %>';
response.data.add("retCode",	"<%=retCode%>");
response.data.add("retMsg",	"<%=retMsg%>");
<% if (retCode.equals("000000")) { %>
	response.data.add("operator_code","<%=result[0][0]%>");
	response.data.add("operator_name","<%=result[0][1]%>");
	response.data.add("serv_type","<%=result[0][2]%>");
	response.data.add("serv_attr","<%=result[0][3]%>");
	response.data.add("count","<%=result[0][4]%>");
	response.data.add("bill_flag","<%=result[0][5]%>");
	response.data.add("other_bal_obj1","<%=result[0][6]%>");
	response.data.add("other_bal_obj2","<%=result[0][7]%>");
	response.data.add("valid_date","<%=result[0][8]%>");
	response.data.add("expire_date","<%=result[0][9]%>");
	response.data.add("bal_prop","<%=result[0][10]%>");
<% } %>
core.ajax.receivePacket(response);
