<%
/********************
 * Version   : v2.0
 * CopyRight : si-tech
 * Author    : qidp
 * Date      : 2009-12-10
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iGrpId = request.getParameter("grpId");
    String retType = request.getParameter("retType");
    
    String[][] result = new String[][]{};
    String retCode="";
    String retMessage="";
    String oOldAppend = "";
    try
    {
		String sqlStr =	"select  a.offer_id||'->'||b.offer_name from product_offer_instance a ,product_offer b " +
                        " where a.offer_id = b.offer_id and b.offer_type = '40' and a.eff_date <sysdate and a.exp_date >sysdate " +
                        " and b.offer_attr_type = 'JT' and  a.serv_id = '"+iGrpId+"'";
        System.out.println("@ sqlStr = "+sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultTemp" scope="end" />
<%
        result = resultTemp;
        retCode = retCode1;
        retMessage = retMsg1;
        if("000000".equals(retCode)){
            if(result.length>0){
                for (int i = 0; i < result.length; i ++){
        		    oOldAppend += result[i][0] + "@";
        		}
            }
        }
    }
    catch(Exception e)
    {
        retCode="999999";
        retMessage="查询旧集团附加资费失败!";
    }
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("oldAppend","<%=oOldAppend%>");
core.ajax.receivePacket(response);
