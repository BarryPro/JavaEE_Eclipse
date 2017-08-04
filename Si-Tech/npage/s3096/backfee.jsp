<%
/********************
 version v2.0
 ¿ª·¢ÉÌ: si-tech
 update hejw@2009-1-15
********************/
%>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%

	String regionCode = (String)session.getAttribute("regCode");
	String ret_code  = "";				//´íÎó´úÂë 
	String ret_message  = "";      		//´íÎóÏûÏ¢         
	String backprepay = "0";
	String nobackprepay = "0";
	String[][] retInfo = new String[][]{};
	String[][] result = new String[][]{};
	String retType = request.getParameter("retType");
	String account_id = request.getParameter("account_id");
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@222==="+retType);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@==="+account_id);
	System.out.println("wangdan ceshi          "+account_id);
	try
    {
     String sqlStr ="select trim(to_char(sum(case when j.refund_flag='Y' and end_dt>to_char(sysdate,'yyyymmdd') then nvl(i.prepay_fee, 0) else 0 end),999999999999.99)) co1,trim(to_char(sum(case when j.refund_flag <> 'Y' or j.refund_flag is null or end_dt<to_char(sysdate,'yyyymmdd') then nvl(i.prepay_fee, 0) else 0 end),999999999999.99)) col2 from dConMsgPre i,sPayType j where  i.pay_type = j.pay_type(+) and i.contract_no = "+account_id+" group by i.contract_no";
%>
    <wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result_t" scope="end"/>
<%
      
        //retArray = callView.sPubSelect("2",sqlStr);                                     
        result = result_t;                                           
        backprepay = result[0][0]; 
        nobackprepay = result[0][1];
        if("".equals(backprepay))
        	backprepay="0.00";
        if("".equals(nobackprepay))
        	nobackprepay="0.00";
                                     
		System.out.println("backprepay="+backprepay); 
		System.out.println("nobackprepay="+nobackprepay);                                         
        ret_code = "000000";                                                            
    }
    catch(Exception e)
    {
        ret_code = "000001";
        ret_message = "È¡Ô¤´æÊ§°Ü";
        System.out.println("È¡Ô¤´æÊ§°Ü           "+account_id);
    }
%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
backprepay = "<%=backprepay%>";
nobackprepay= "<%=nobackprepay%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("backprepay",backprepay);
response.data.add("nobackprepay",nobackprepay);
core.ajax.receivePacket(response);
