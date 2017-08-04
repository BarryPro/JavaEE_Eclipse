<%
/********************
 * version v2.0
 * 功能：获取新主资费 对应的备注和主资费名称
 * 开发商: si-tech
 * update by huangrong @ 2011-03-09
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";  
    String sqlStr = "";
    String offerInfo_name = "";
    String offerInfo_note = "";
  
		String orgCode = request.getParameter("orgCode");
		String modeCode = request.getParameter("modeCode");

    String sqlStr2 = " select  offer_name ,offer_comments from product_offer where offer_id='"+modeCode+"'";
%>
    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=sqlStr2%>"/>
    </wtc:service>
    <wtc:array id="offerInfoArr" scope="end"/>
<%
  System.out.println(sqlStr2);
  errCode = retCode;
  errMsg = retMsg;

    if(offerInfoArr!=null && offerInfoArr.length>0 && errCode.equals("000000"))
    {
    	offerInfo_name=offerInfoArr[0][0];
    	offerInfo_note=offerInfoArr[0][1];
    }
	
	String rpcPage = "getNote";
	
%>

var rpcPage="<%=rpcPage%>";
var offerInfo_name="<%=offerInfo_name%>";
var offerInfo_note="<%=offerInfo_note%>";

var response = new AJAXPacket();

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 
response.data.add("offerInfo_name",offerInfo_name);
response.data.add("offerInfo_note",offerInfo_note);
core.ajax.receivePacket(response);


