<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------查看手机用户是实名制用户 1：实名、 2：准实名、3：非实名
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";	
		String smzname ="";
		String PhoneNo = request.getParameter("PhoneNo");
		
	  String[] inParamsss2 = new String[2];
		inParamsss2[0] = "select to_char(a.TRUE_CODE) from dTrueNamemsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phonesNO ";
		inParamsss2[1] = "phonesNO="+PhoneNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust2" scope="end" />
<%
	if(dcust2.length>0) {
			smzflag=dcust2[0][0];
			
			if(smzflag.equals("1")) {
					smzname="实名";
			}
			if(smzflag.equals("2")) {
					smzname="准实名";
			}
			if(smzflag.equals("3")) {
					smzname="非实名";
			}
	}

%>		

	var response = new AJAXPacket();
	response.data.add("smzvalue","<%=smzflag%>");
	response.data.add("smzname","<%=smzname%>");
	core.ajax.receivePacket(response);