<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%

	String regionCode = (String)session.getAttribute("regCode");	//地市 
	String groupId = (String)session.getAttribute("groupId");
	String offerId = request.getParameter("offerId");
  String offerName = "";
  String offerComments = "";
	String sql = "SELECT a.offer_name, a.offer_comments"
		 + " FROM product_offer a ,region b "
		 + "  WHERE a.offer_id = b.offer_id  "
		 + "    AND b.group_id in ( "
		 + "           select d.parent_group_id "
		 + "            from  dchngroupinfo d "
		 + "           where  d.group_id=:vGroupId ) "
		 + "    AND a.exp_date>sysdate "
		 + "    AND a.offer_type='10'"
		 + "    AND a.offer_id=to_number(:vOfferId)";
	String sqlVar1 = " vGroupId=" + groupId + ", vOfferId=" + offerId;
	System.out.println("====wanghfa====f8375_getOfferMsg.jsp==== sql = " + sql);
	System.out.println("====wanghfa====f8375_getOfferMsg.jsp==== sqlVar1 = " + sqlVar1);
%>
	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=sqlVar1%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%
	System.out.println("====wanghfa====f8375_getOfferMsg.jsp==== result1.length = " + result1.length);
	if("000000".equals(retCode1) && result1.length > 0) {
		offerName = result1[0][0];
		offerComments = result1[0][1];
	} else {
		
	}
%>

var response = new AJAXPacket(); 
response.data.add("retCode","<%=retCode1%>");
response.data.add("no","<%=result1.length%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("offerName","<%=offerName%>");
response.data.add("offerComments","<%=offerComments%>");
core.ajax.receivePacket(response);
