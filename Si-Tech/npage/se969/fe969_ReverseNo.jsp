<%
    /*************************************
    * ��  ��: �����ն����۳��� e899
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String acceptNo = WtcUtil.repStr(request.getParameter("acceptNo"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String retOpCode = "";
	String isNetToFlag = "Y";//�����ն�������ת��ʶ
	
	String  inParams [] = new String[2];
  inParams[0] = "SELECT busi_code FROM dWebTermSale WHERE update_accept =:acceptno AND op_flag = 'Y' AND phone_no =:phoneno";
  inParams[1] = "acceptno="+acceptNo+",phoneno="+phoneNo;
  
  //System.out.println("---e969----inParams[0]="+inParams[0]);
  //System.out.println("---e969----inParams[1]="+inParams[1]);
	
%>
  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---e969--diling--retCode="+retCode);
  if("000000".equals(retCode)){
    if(ret.length>0){
      retOpCode = ret[0][0];
    }
  }
   System.out.println("---e969--diling--retOpCode="+retOpCode);
  if("e505".equals(retOpCode)){
%>
  <SCRIPT language="JavaScript">
    window.location.href="/npage/se505/se506.jsp?opCode=e506&opName=��Լ�ƻ���������&backaccept=<%=acceptNo%>&activePhone=<%=phoneNo%>&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%
  }else if("7955".equals(retOpCode)){
%>
  <SCRIPT language="JavaScript">
     window.location.href="/npage/s1141/f7956_1.jsp?opCode=7956&opName=���������ѣ����·���������&backaccept=<%=acceptNo%>&srv_no=<%=phoneNo%>&opcode=7956&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%
  }else if("d069".equals(retOpCode)){
%>
  <SCRIPT language="JavaScript">
    window.location.href="/npage/sd069/fd070_1.jsp?opCode=d070&opName=��Լ�ƻ�Ԥ�湺������&backAccept=<%=acceptNo%>&activePhone=<%=phoneNo%>&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%  
  }else{
%>
  <SCRIPT language="JavaScript">
    rdShowMessageDialog("û���ҵ���Ӧ�ĳ������ݣ����������룡",1);
    window.location.href="fe969_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
  </SCRIPT>
<%
  }
%>

	    