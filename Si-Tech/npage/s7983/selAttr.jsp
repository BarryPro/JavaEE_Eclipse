<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
    String regionCode = (String)session.getAttribute("regCode");
    String cust_id = request.getParameter("cust_id");
    String sql3 = "  select c.feeindex_name from dgrpusermsg a,dgrpusermsgadd b,svpmnfeeindex c "+
                  "  where a.cust_id = '"+cust_id+"' "+
                  "   and a.sm_code = 'vp'          "+
                  "   and a.id_no = b.id_no         "+
                  "   and b.field_code = '10317'     "+
                  "   and b.field_value = c.feeindex "+
                  "   and c.region_code = '"+regionCode+"' ";
	System.out.println("======================sql3===============================    "+sql3);
    String returnCode = "";
    String returnMsg = "";
    String flag = "";
    try{
        %>
        <wtc:pubselect name="sPubSelect"  retcode="retCode3" retmsg="retMsg3" routerKey="region" routerValue="<%=regionCode%>" outnum="1" >
  	    	 <wtc:sql><%=sql3%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result3" scope="end" />
        <%
        returnCode = retCode3;
        returnMsg = retMsg3;
        if(result3.length > 0 ){
           flag = result3[0][0] ;
        }
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnCode = "+returnCode);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnMsg  = "+returnMsg);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> flag  = "+flag);
    }catch(Exception e){
        returnCode = "999999";
        returnMsg = "调用服务sCheckPhoneNo失败！";
        e.printStackTrace();
    }

%>
var response = new AJAXPacket();
var result1 = "<%=flag%>";
var returnCode = "<%=returnCode%>";
var returnMessage = "<%=returnMsg%>";

response.data.add("result",result1);
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMessage);
core.ajax.receivePacket(response);
