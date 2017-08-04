<%
    /*************************************
    * 功  能: 获取AZ端产品属性值 3690
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-11-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String a_prodCodeBtn = WtcUtil.repNull((String)request.getParameter("AProd_grpIdNoHidden"));//A端产品编码
	String custId = WtcUtil.repNull((String)request.getParameter("custId"));//Z端客户id
%>
 var array = new Array();

 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

  <wtc:service name="sUserChaQryA" routerKey="region" routerValue="<%=regCode%>" retcode="retCode_getAProdPoperty" retmsg="retMsg_getAProdPoperty" outnum="3">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=a_prodCodeBtn%>"/> 
		<wtc:param value="<%=custId%>"/> 
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
    
    //构造函数
    function Obj(v1,v2,v3) {
      this.v1 = v1;
      this.v2 = v2;
      this.v3 = v3;
    }
<%
    if("000000".equals(retCode_getAProdPoperty)){
    	System.out.println("liujian--3333----result1.length=" + result1.length);
      if(result1.length>0){
        for(int outter = 0 ; result1 != null && outter < result1.length; outter ++){
        	System.out.println("11111111");
        %>
        	array.push(new Obj("<%=result1[outter][0]%>","<%=result1[outter][1]%>","<%=result1[outter][2]%>"))
        <%
        }
      }
    }

%>
	  
var response = new AJAXPacket();
response.data.add("retCode_getAProdPoperty","<%=retCode_getAProdPoperty%>");
response.data.add("retMsg_getAProdPoperty","<%=retMsg_getAProdPoperty%>");
response.data.add("array",array);
core.ajax.receivePacket(response);
