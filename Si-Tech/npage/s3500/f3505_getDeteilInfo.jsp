<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
//读取session信息
	    String loginNo = (String)session.getAttribute("workNo");
	    String loginName = (String)session.getAttribute("workName");
	    String powerCode= (String)session.getAttribute("powerCode");
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");
	    String regionCode = orgCode.substring(0,2);
			
//错误信息，错误代码
int retCode = 0;
String errMsg = "";

String phoneNo = request.getParameter("phoneNo");
String retType = request.getParameter("retType");

//SPubCallSvrImpl impl = new SPubCallSvrImpl();

ArrayList retList1 = new ArrayList();
String sqlStr1="";
sqlStr1 ="select field_value from dCustmsgadd where id_no = (select id_no from dcustmsg where phone_no=:phoneNo)"
					+"and busi_type = '1000' and field_code = any('10031','10032')"
					+"order by field_code";

//retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);

String [] paraIn = new String[2];
paraIn[0] = sqlStr1;    
paraIn[1]="phoneNo="+phoneNo;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="retArr1" scope="end"/>
<%
String[][] retListString1 = retArr1;
//String[][] retListString1 = (String[][])retList1.get(0);
retCode = Integer.parseInt(retCode1); //错误代码
System.out.println("retCode:"+Integer.toString(retCode));
errMsg = retMsg1; //错误信息
System.out.println("errMsg:"+errMsg);
System.out.println("retListString1.length:"+retListString1.length);
%>

var email = "";
var phoneType ="";
<%
if(retCode == 0 && retListString1.length!=0){
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