<%
    /*************************************
    * 功  能: 手机支付实名更新 e629
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-21
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	System.out.println("-------------8046--------phoneNo="+phoneNo);
	String v_yhje="";
%>
	<wtc:service name="se720Select" outnum="2" 
			retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=phoneNo%>">
		<wtc:param value="<%=phoneNo%>" />
	</wtc:service> 
	<wtc:array id="arrMoney" scope="end" />
<%
  if("000000".equals(code1)){
    if(arrMoney.length>0){
      v_yhje = arrMoney[0][0];
    }else{
      v_yhje = "";
    }
  }else{
    v_yhje = "";
  }
  
  System.out.println("-------------8046--------v_yhje="+v_yhje);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=code1%>");
response.data.add("retmsg","<%=msg1%>");
response.data.add("v_yhje","<%=v_yhje%>");
core.ajax.receivePacket(response);
 
	    