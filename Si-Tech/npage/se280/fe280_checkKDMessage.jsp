<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------��֤�����Ϣ�Ƿ���ȷ
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
		String smzflagMessage="";
	
		String iCfmLogin = request.getParameter("iCfmLogin");
		String familsyinfo = request.getParameter("familsyinfo");
			
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "SELECT b.sm_code FROM dbroadbandmsg a, dcustmsg b WHERE a.id_no = b.id_no AND a.cfm_login = :iCfmLogin";
	inParamsss1[1] = "iCfmLogin="+iCfmLogin;
	
System.out.println(iCfmLogin+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(dcust.length>0) {
	smzflag="000000";
	smzflagMessage="��֤�ɹ�";
	if("1020".equals(familsyinfo)||"1021".equals(familsyinfo)||"1026".equals(familsyinfo)||"1027".equals(familsyinfo)){
	  if("ke".equals(dcust[0][0])){
      smzflag="010012";
      smzflagMessage="ֻ����ͨЭͬ����û����ܰ����ҵ��";
	  }
	}else if("1022".equals(familsyinfo)||"1023".equals(familsyinfo)||"1024".equals(familsyinfo)||"1025".equals(familsyinfo)){
	  if(!"ke".equals(dcust[0][0])){
      smzflag="010012";
      smzflagMessage="ֻ�й�����û����ܰ����ҵ��";
	  }
	}
}
else {
	smzflag="010001";
	smzflagMessage="ȡ����û���Ϣ����";
}
System.out.println(smzflag+"==2222222222222222=====wanghyd"+iCfmLogin+"--"+dcust.length);
%>		

	var response = new AJAXPacket();
	response.data.add("retcode","<%=smzflag%>");
	response.data.add("retmsg","<%=smzflagMessage%>");
	core.ajax.receivePacket(response);