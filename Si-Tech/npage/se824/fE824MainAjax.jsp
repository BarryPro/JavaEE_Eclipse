<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*��ҳ�洫�ݵĲ���*/
String phoneNo=(String)request.getParameter("phoneNo");

String regCode	=(String)session.getAttribute("regCode");
String workNo	=(String)session.getAttribute("workNo");

String iLoginAccept="";
String iChnSource="01";
String iOpCode="e824";
String iOpName="Я��ת���û���Ϣ��ѯ";
String iLoginNo=(String)session.getAttribute("workNo");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo=request.getParameter("phoneNo");
String iUserPwd="";

System.out.println("@zhangyan~~iLoginAccept="+iLoginAccept);
System.out.println("@zhangyan~~iChnSource="+iChnSource);
System.out.println("@zhangyan~~iOpCode="+iOpCode);
System.out.println("@zhangyan~~iOpName="+iOpName);
System.out.println("@zhangyan~~iLoginNo="+iLoginNo);
System.out.println("@zhangyan~~iLoginPwd="+iLoginPwd);
System.out.println("@zhangyan~~iPhoneNo="+iPhoneNo);
System.out.println("@zhangyan~~iUserPwd="+iUserPwd);
%>


<wtc:service name="se824Qry" 
	routerKey="regCode" routerValue="<%=regCode%>" 
	retcode="errCode" retmsg="errMsg"  outnum="6">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
</wtc:service>
<wtc:array id="arrSe824Qry" scope="end" />

/*�������ڴ��������������*/
var arrTabList = new Array;

/*���б�������������*/
<%
if ( errCode.equals("000000") )
{
	System.out.println("@zhangyan~~~~arrSe824Qry.length"+arrSe824Qry.length);
	for ( int i=0;i<arrSe824Qry.length;i++ )
	{
	%>
		arrTabList[<%=i%>]=new Array;
		<%
		
		/*����ÿ�������Ԫ��*/
		for ( int j=0;j<arrSe824Qry[i].length;j++ )
		{
			System.out.println("@zhangyan~~~~arrTabList"+arrSe824Qry[i][j]);
		%>
			arrTabList[<%=i%>][<%=j%>]="<%=arrSe824Qry[i][j]%>";
		<%
		}
		%>
	<%
	}
	%>

	var response = new AJAXPacket();
	response.data.add("arrTabList",arrTabList);
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);
<%
}
else
{
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
<%
}
%>
