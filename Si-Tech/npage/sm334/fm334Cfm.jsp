<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  
  String loginAccept = request.getParameter("loginAccept");
  String zr_phone = request.getParameter("zr_phone");
  String offeridstr = request.getParameter("offeridstr");
  String offer_id = request.getParameter("offer_id");
  String offer_idchuan=offer_id+"#";
  
  String org_code = (String)session.getAttribute("orgCode");
  String ipAddrss = (String)session.getAttribute("ipAddr");

  String beizhu=workNo+"ȡ��"+zr_phone+"��������ѡ�ʷ�["+offer_id+"]";

%>
		
<wtc:service name="s1272Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
	
	<wtc:param value="<%=loginAccept%>"/>
  <wtc:param value="01"/>
  <wtc:param value="1272"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=zr_phone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=offer_idchuan%>"/>
	<wtc:param value="Y#"/>	
	<wtc:param value="0#"/>
	<wtc:param value="a017"/>
	<wtc:param value="0"/>
	<wtc:param value="0"/>
	<wtc:param value="<%=beizhu%>"/>
	<wtc:param value="<%=beizhu%>"/>
	<wtc:param value="<%=ipAddrss%>"/>
	<wtc:param value="-1#"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
				
<%
	if("000000".equals(retCode)){
		System.out.println(" ======== s1272Cfm ���óɹ� ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("ȡ��������ѡ�ʷѳɹ���",2);
 	      window.location="fm334.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{
	  System.out.println(" ======== sm185Req ����ʧ�� ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("ȡ��������ѡ�ʷ�ʧ�ܣ�������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
 		  window.location="fm334.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
