<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
        //得到输入参数
        String[][] result = new String[][]{};
        //--------------------------
        String regCode = (String)session.getAttribute("regCode");
        String retType = request.getParameter("retType");
        String sm_code = request.getParameter("sm_code");
        int vCount = 0;
        String product_attr = "";
        String retCode = "";
        String retMessage = "";
        String sqlStr = "";

        try
        {
            sqlStr = "select a.product_attrcode, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.sm_code = '" + sm_code + "'";
			String[] inParams = new String[2];
			inParams[0] = "select a.product_attrcode, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.sm_code =:sm_code";
            inParams[1] = "sm_code="+sm_code;
            //retArray = callView.sPubSelect("2",sqlStr);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>	
			</wtc:service>	
			<wtc:array id="result1"  scope="end"/>
<%
            result = result1;
			//System.out.println("retCode1====="+retCode1);
			//System.out.println("sqlStr====="+sqlStr);
            vCount = result.length;
            if(result.length>0)
            	product_attr = (result[0][0]).trim();

            retCode = "000000";
            retMessage = "查询产品属性信息成功";

        }catch(Exception e){
            e.printStackTrace();
            retCode = "190201";
        }
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var retnums = "";
var retname = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
retnums = "<%=vCount%>";
retname = "<%=product_attr%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retnums",retnums);
response.data.add("retname",retname);
core.ajax.receivePacket(response);