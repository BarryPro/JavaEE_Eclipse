<%
  /*
   * 功能: 网站开户
   * 版本: 2.0
   * 日期: 2010/11/26
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%

	String opCode 	= "b893";
	String loginNo 	= (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	String offerId  = request.getParameter("offerId");
	String servBusId = request.getParameter("servBusId");
	String retCode = "";
	String retMsg = "";
	String sData = ",";
	String dataSql = "select offer_name from product_offer where offer_Id = '"+offerId+"'";
%>
 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="retMsg1" retcode="retCode1" routerKey="regionCode" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=dataSql%></wtc:sql>
 </wtc:pubselect>
 <wtc:array id="result11" scope="end"/>
<%
	System.out.println("=============ajaxGetData.jsp==============="+retCode1+"-----------"+result11.length);
	if("000000".equals(retCode1)){
		System.out.println("=============获得sData执行成功！===============");
		if(result11.length > 0){
			sData += result11[0][0];
		}else{
			sData += "";	
		}
		
		retCode = "000000";
		retMsg  = retMsg1;
	}else{
		System.out.println("获得sData执行失败 ["+retCode1+"],"+retMsg1+"");
	}
	sData += ",1,N,,"+offerId+",1104,"+servBusId+",20004,01";
%>
var response = new AJAXPacket();
response.data.add("sData","<%=sData%>");
core.ajax.receivePacket(response);