<%
/********************
 version v2.0
 开发商: si-tech
 update leimd at 2009.04.15
********************/
%>
	
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    //得到输入参数
    String grpIdNo = request.getParameter("grpIdNo");
    String regionCode = request.getParameter("regionCode");
    String retType = request.getParameter("retType");
    
    String[][] result = new String[][]{};
    String retCode="000000";
    String retMessage="密码校验成功！";
    try
    {
		String sqlStr =	 "SELECT a.attr_id, a.attr_val, b.offer_name"
					+"  FROM serv_attr a, product_offer b"
					+" WHERE a.attr_val = b.offer_id"
					+"   AND a.serv_id = " + grpIdNo
					+"   AND a.attr_id = any('10000', '10001')"
					+" ORDER BY a.attr_id";
		System.out.println("6666666666^^^^^^^^^^^^^^^^^^^"+sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultTemp" scope="end" />
<%
        result = resultTemp;
        retCode = retCode1;
        retMessage = retMsg1;
    }
    catch(Exception e)
    {
        retCode="100002";
        retMessage="密码校验失败！";
    }
    
    String oldMainRate = "";
    String oldOptionalRate = "";
    String oldMainRateName = "";
	if (result.length>0)
	{
		for (int i = 0; i < result.length; i ++)
		{
			if (result[i][0].equals("10000"))
			{
				oldMainRateName = result[i][1] + "-" + result[i][2];
				oldMainRate = result[i][1];
			}
			else
			{
				oldOptionalRate = oldOptionalRate + result[i][1] + "-" + result[i][2] + "|";
			}
		}
	}
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("oldMainRate","<%=oldMainRate%>");
response.data.add("oldOptionalRate","<%=oldOptionalRate%>");
response.data.add("oldMainRateName","<%=oldMainRateName%>");
core.ajax.receivePacket(response);
