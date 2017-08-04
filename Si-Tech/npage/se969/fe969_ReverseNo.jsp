<%
    /*************************************
    * 功  能: 网上终端销售冲正 e899
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
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
	String isNetToFlag = "Y";//网上终端销售跳转标识
	
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
    window.location.href="/npage/se505/se506.jsp?opCode=e506&opName=合约计划购机冲正&backaccept=<%=acceptNo%>&activePhone=<%=phoneNo%>&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%
  }else if("7955".equals(retOpCode)){
%>
  <SCRIPT language="JavaScript">
     window.location.href="/npage/s1141/f7956_1.jsp?opCode=7956&opName=购机赠话费（按月返还）冲正&backaccept=<%=acceptNo%>&srv_no=<%=phoneNo%>&opcode=7956&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%
  }else if("d069".equals(retOpCode)){
%>
  <SCRIPT language="JavaScript">
    window.location.href="/npage/sd069/fd070_1.jsp?opCode=d070&opName=合约计划预存购机冲正&backAccept=<%=acceptNo%>&activePhone=<%=phoneNo%>&isNetToFlag=<%=isNetToFlag%>";
  </SCRIPT>
<%  
  }else{
%>
  <SCRIPT language="JavaScript">
    rdShowMessageDialog("没有找到对应的冲正内容，请重新输入！",1);
    window.location.href="fe969_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
  </SCRIPT>
<%
  }
%>

	    