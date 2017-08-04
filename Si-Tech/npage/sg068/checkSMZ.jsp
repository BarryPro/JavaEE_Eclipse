<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------查看手机用户是否是实名制用户
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");

			
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select to_char(id_no) from dcustmsg where phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+PhoneNo;
	
System.out.println(PhoneNo+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(dcust.length>0) {
	String[] inParamsss2 = new String[2];
	inParamsss2[0] = "select to_char(TRUE_CODE) from dTrueNamemsg where id_no=:ids_no";
	inParamsss2[1] = "ids_no="+dcust[0][0];
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust2" scope="end" />
<%
if(dcust2.length>0) {
smzflag=dcust2[0][0];
}
}
System.out.println(dcust[0][0]+"=======wanghyd");
//System.out.println(dcust2[0][0]+"=======wanghyd");
%>		

	var response = new AJAXPacket();
	response.data.add("smzvalue","<%=smzflag%>");
	core.ajax.receivePacket(response);