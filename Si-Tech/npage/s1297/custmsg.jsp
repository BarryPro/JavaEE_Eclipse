   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
          
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>

<%
/* zhaoxin  20090825  s1397Init服务替换 */	
	String iLoginAccept = "0";
  String iChnSource = "01";
  String op_code = "1397";
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo")," ");
  String iUserPwd = "";
  String TranType = "1";
  String PostType = "2";
/*-- end --*/
//得到输入参数
  String type = WtcUtil.repStr(request.getParameter("type")," ");
  String regionCode = (String)session.getAttribute("regCode");    
  String opFlag = WtcUtil.repStr(request.getParameter("opFlag")," ");  
  String[][] result1 = new String[][]{};       
	String retResult = "";
	String id_iccid = "";
	String id_address = "";
	String cust_name = "";
%>
   <wtc:service name="sHfxsInit" outnum="3" retmsg="msg" retcode="code"  routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=iLoginAccept%>" />
			<wtc:param value="<%=iChnSource%>" />
			<wtc:param value="<%=op_code%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=iUserPwd%>" />
			<wtc:param value="<%=opFlag%>" />

		</wtc:service>
		<wtc:array id="result_t" scope="end"  />	
	
<%
	if (result_t != null && "000000".equals(code)){
		result1 = result_t;
		id_iccid = (result_t[0][0]).trim();
		id_address = (result_t[0][1]).trim();
		cust_name = (result_t[0][2]).trim();
	}
	System.out.println("-----------id_iccid--------------------"+id_iccid);
	System.out.println("-----------id_address-------------------"+id_address);
	System.out.println("----------------cust_name-----------------"+cust_name);
	System.out.println("--------------------------");       
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var type = "<%=type%>";
var id_iccid = "<%=id_iccid%>";
var id_address = "<%=id_address%>";
var cust_name = "<%=cust_name%>";
var retMsg = "<%=msg%>";
var retCode = <%=code%>;
response.data.add("id_iccid",id_iccid);
response.data.add("id_address",id_address);
response.data.add("cust_name",cust_name);
response.data.add("type",type);
response.data.add("retResult",retResult);
response.data.add("retMsg",retMsg);
response.data.add("retCode",retCode);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
