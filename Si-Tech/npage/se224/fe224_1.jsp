<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String ioprcode = request.getParameter("ioprcode");
  String loginAccept = request.getParameter("loginAccept");
  String offerIdHiden = WtcUtil.repNull((String)request.getParameter("offerIdHiden"));//��ѡ�ʷ�offerId
  String effectWayHiden = WtcUtil.repNull((String)request.getParameter("effectWayHiden"));//��Ч��ʽ
  String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
  String opName = WtcUtil.repNull((String)request.getParameter("opName"));
  String contrySel = WtcUtil.repNull((String)request.getParameter("contrySel"));//���Ҵ���
  String daynumSel = WtcUtil.repNull((String)request.getParameter("daynumSel"));//����
  
  
	String  inputParsm [] = new String[10];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = "e224";
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = ioprcode;
	inputParsm[8] = contrySel;
	inputParsm[9] = daynumSel;
%>
	<wtc:service name="se224Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	String vSrvName = "";
	if("000000".equals(retCode)){
		System.out.println(" ======== se224Cfm ���óɹ� ========");
%>	
    <script language="javascript">
  	  <%if(ioprcode.equals("03")) {%>
 	      rdShowMessageDialog("��������ɹ���",2);
 	      window.location="fe224.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}if(ioprcode.equals("04")) {%>
       	rdShowMessageDialog("����ȡ���ɹ���",2);
       	window.location="fe224.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	    <%}%>
 	  </script>
<%}else{
	  System.out.println(" ======== se224Cfm ����ʧ�� ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
 		  window.location="fe224.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
