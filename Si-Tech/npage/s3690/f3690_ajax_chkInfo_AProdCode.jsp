<%
    /*************************************
    * 功  能: 校验A端产品编码 3690
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
	String unit_id = WtcUtil.repNull((String)request.getParameter("unit_id"));
	String a_prodCodeBtn = WtcUtil.repNull((String)request.getParameter("AProd_grpIdNoHidden"));//A端产品编码
	String custId = WtcUtil.repNull((String)request.getParameter("custId"));//Z端客户ID
  String ret_prodCode = "";
  String ret_prodName = "";
  
  String ret_retCode = "000000";
  String ret_retMsg = "操作成功";
%>
 var array = new Array();

 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sUserCheckA" routerKey="region" routerValue="<%=regCode%>" retcode="retCode_chkProdCode" retmsg="retMsg_chkProdCode" outnum="2">
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
	<wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(retCode_chkProdCode)){
    if(ret.length>0){
      ret_prodCode = ret[0][0];
      ret_prodName = ret[0][1];
    }
    
%>
  <wtc:service name="sUserChaQryA" routerKey="region" routerValue="<%=regCode%>" retcode="retCode_chkProdCodeQry" retmsg="retMsg_chkProdCodeQry" outnum="3">
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
System.out.println("liujian------rretCode_chkProdCodeQry= " + retCode_chkProdCodeQry);
    if("000000".equals(retCode_chkProdCodeQry)){
    	System.out.println("liujian------result1.length=" + result1.length);
      if(result1.length>0){
        for(int outter = 0 ; result1 != null && outter < result1.length; outter ++){
        	System.out.println("11111111");
        %>
        	
        	array.push(new Obj("<%=result1[outter][0]%>","<%=result1[outter][1]%>","<%=result1[outter][2]%>"))
        <%
        }
      }
    }else{
      ret_retCode = retCode_chkProdCodeQry;
      ret_retMsg = retMsg_chkProdCodeQry;
    }
  }else{
    ret_retCode = retCode_chkProdCode;
    ret_retMsg = retMsg_chkProdCode;
  }
%>
	  
var response = new AJAXPacket();
response.data.add("retCode_chkProdCode","<%=ret_retCode%>");
response.data.add("retMsg_chkProdCode","<%=ret_retMsg%>");
response.data.add("array",array);
response.data.add("ret_prodCode","<%=ret_prodCode%>");
response.data.add("ret_prodName","<%=ret_prodName%>");
core.ajax.receivePacket(response);
