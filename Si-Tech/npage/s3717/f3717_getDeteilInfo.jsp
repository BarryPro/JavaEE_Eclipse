
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@page contentType="text/html;charset=gb2312" errorPage=""%>
<%
//读取session信息
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String loginNo = baseInfoSession[0][2];
	    String loginName = baseInfoSession[0][3];
	    String powerCode= otherInfoSession[0][4];
	    String orgCode = baseInfoSession[0][16];
	    String ip_Addr = request.getRemoteAddr();
	    String rpt_right = baseInfoSession[0][6];
	    String regionCode = orgCode.substring(0,2);
	    String regionName = otherInfoSession[0][5];
			
//错误信息，错误代码
int retCode = 0;
String errMsg = "";

String phoneNo = request.getParameter("phoneNo");
String retType = request.getParameter("retType");

SPubCallSvrImpl impl = new SPubCallSvrImpl();

ArrayList retList1 = new ArrayList();
String sqlStr1="";
sqlStr1 ="select field_value from dCustmsgadd where id_no = (select id_no from dcustmsg where phone_no='"+phoneNo+"')"
					+"and busi_type = '1000' and field_code = any('10208','10209')"
					+"order by field_code";

retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
String[][] retListString1 = (String[][])retList1.get(0);
retCode = impl.getErrCode(); //错误代码
System.out.println("retCode:"+Integer.toString(retCode));
errMsg = impl.getErrMsg(); //错误信息
System.out.println("errMsg:"+errMsg);
System.out.println("retListString1.length:"+retListString1.length);
%>

var email = "";
var phoneType ="";
<%
if(retListString1.length!=0){
%>
	email= '<%=retListString1[0][0]%>';
	phoneType= '<%=retListString1[1][0]%>';
<%
}
%>

var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("email",email);
response.data.add("phoneType",phoneType);
response.data.add("retCode","<%=retCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);

