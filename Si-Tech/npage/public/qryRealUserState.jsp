<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------�鿴�ֻ��û���ʵ�����û� 1��ʵ���� 2��׼ʵ����3����ʵ��
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
					smzname="ʵ��";
			}
			if(smzflag.equals("2")) {
					smzname="׼ʵ��";
			}
			if(smzflag.equals("3")) {
					smzname="��ʵ��";
			}
	}

%>		

	var response = new AJAXPacket();
	response.data.add("smzvalue","<%=smzflag%>");
	response.data.add("smzname","<%=smzname%>");
	core.ajax.receivePacket(response);