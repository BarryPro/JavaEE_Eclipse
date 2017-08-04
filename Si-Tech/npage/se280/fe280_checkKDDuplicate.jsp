<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------验证宽带信息是否正确
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
		String smzflagMessage="";
	
		String Phone_NO = request.getParameter("Phone_NO");

			
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "SELECT COUNT(1) FROM dcustres  a WHERE (a.phone_no = :vPhoneNoMem AND substr(a.phone_no, 1, 3) = '157' AND a.no_type = '0000h') OR (a.phone_no = :vPhoneNoMem2 AND substr(a.phone_no, 1, 3) = '147' AND a.no_type = '0000h') OR (a.phone_no = :vPhoneNoMem3 AND substr(a.phone_no, 1, 3) = '184' AND a.no_type = '0000h')";
	inParamsss1[1] = "vPhoneNoMem="+Phone_NO+" ,vPhoneNoMem2="+Phone_NO+" ,vPhoneNoMem3="+Phone_NO;
	
System.out.println(Phone_NO+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(dcust.length>0) {
smzflag=dcust[0][0];
}

%>		

	var response = new AJAXPacket();
	response.data.add("smzvalue","<%=smzflag%>");
	core.ajax.receivePacket(response);