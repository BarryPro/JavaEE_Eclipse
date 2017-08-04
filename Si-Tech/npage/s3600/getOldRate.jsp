<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
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
		String sqlStr =	 "SELECT a.field_code, b.mode_code, b.mode_name"
					+"  FROM dGrpUserMsgAdd a, sBillModeCode b"
					+" WHERE trim(a.field_value) = b.mode_code"
					+"   AND id_no = " + grpIdNo
					+"   AND b.region_code = '" + regionCode + "'"
					+"   AND a.field_code = any('10000', '10001')"
					+" ORDER BY b.mode_code";
        //retArray = callView.sPubSelect("3",sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultTemp" scope="end" />
<%
        result = resultTemp;
        retCode = retCode1;
        retMessage = retMsg1;
	    //System.out.println(sqlStr);
    }
    catch(Exception e)
    {
        //System.out.println(e.toString());
        retCode="100002";
        retMessage="密码校验失败！";
    }
    
    //System.out.println(retCode + "--" + retMessage);
    String oldMainRate = "";
    String oldOptionalRate = "";
	if (result.length>0)
	{
		for (int i = 0; i < result.length; i ++)
		{
			if (result[i][0].equals("10000"))
			{
				oldMainRate = result[i][1] + "--" + result[i][2];
			}
			else
			{
				oldOptionalRate = oldOptionalRate + result[i][1] + "--" + result[i][2] + "|";
			}
		}
	}
	//System.out.println(oldMainRate);
	//System.out.println(oldOptionalRate);
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
core.ajax.receivePacket(response);
