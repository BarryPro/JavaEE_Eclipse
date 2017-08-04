<%
  /*
   * 功能: 查询客户名称
   * 版本: 1.0
   * 日期: 20130610
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      String regCode = (String)session.getAttribute("regCode");	
        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
        String phoneNo = request.getParameter("phoneNo");
        String beizhussdese="根据phoneNo=["+phoneNo+"]进行查询";
        String custname="";
        String ZSCustName11="";
%>
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="2266" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
    		
          custname = (baseArr[0][5]);
          if(custname==null) {
          		custname="用户名称不存在";
          }
      if(!("").equals(custname)) {
	
			if(custname.length() == 2 ){
				ZSCustName11 = custname.substring(0,1)+"*";
			}
			if(custname.length() == 3 ){
				ZSCustName11 = custname.substring(0,1)+"**";
			}
			if(custname.length() == 4){
				ZSCustName11 = custname.substring(0,2)+"**";
			}
			if(custname.length() > 4){
				ZSCustName11 = custname.substring(0,2)+"******";
			}
		}
          
          System.out.println("-------------------custname="+ZSCustName11);

          }
    }
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("custname","<%=ZSCustName11%>");
core.ajax.receivePacket(response);
 