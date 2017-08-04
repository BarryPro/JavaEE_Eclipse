<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*1270,1219,2266等模块中使用的页面.
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>

<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 

<%	 
		String opCode=request.getParameter("opCode");
		String login_accept=request.getParameter("login_accept");
		
	    String phoneNo = request.getParameter("phoneNo");
	    
	    String orderModelId = request.getParameter("orderModelId");
	    String agreeModelId = request.getParameter("agreeModelId");
	    System.out.println("------------pubHWPrtAcc orderModelId-----------------"+orderModelId);
	    System.out.println("------------pubHWPrtAcc agreeModelId-----------------"+agreeModelId);
	    
	    
	    String workNo = (String)session.getAttribute("workNo");
	    String groupId = (String)session.getAttribute("groupId");
	    
	    String errCode="";
	    String errMsg="";	    
		  String sql_hwprt = " insert into wHandWritePrt (OP_CODE, PHONE_NO, LOGIN_NO, GROUP_ID, PRINT_ACCEPT, OP_TIME, order_model_id, agree_model_id) "+
									" values ('"+opCode+"', '"+phoneNo+"', '"+workNo+"', '"+groupId+"', '"+login_accept+"', sysdate, '"+orderModelId+"', '"+agreeModelId+"') "	;
			System.out.println("sql_hwprt======="+sql_hwprt);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="hwMsg" retcode="hwCode" routerKey="phone" routerValue="<%=phoneNo%>">
  <wtc:sql><%=sql_hwprt%></wtc:sql>
</wtc:pubselect>
<%
	System.out.println("hwMsg=="+hwMsg);
	System.out.println("hwCode=="+hwCode);
	String sql_hwprt2 = " select print_accept from whandwriteprt where print_accept = "+ login_accept	;
	System.out.println("sql_hwprt2======="+sql_hwprt2);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="hwMsg2" retcode="hwCode2" routerKey="phone" routerValue="<%=phoneNo%>">
  <wtc:sql><%=sql_hwprt2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="hwArr" scope="end"/>
<%	
if(hwArr.length!=0){
	errCode = "000000";
	errMsg = "记录成功！";
}else{
	errCode = "000001";
	errMsg = "数据插入 wHandWritePrt表 失败！";
}
%>
var response = new AJAXPacket();

var errCode = ""
var errMsg = "";

errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);

core.ajax.receivePacket(response);

