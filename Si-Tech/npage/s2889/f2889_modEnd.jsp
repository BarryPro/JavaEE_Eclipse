<%
   /*名称：集团客户项目申请 - 终止提交
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%  
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));         //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));            //登陆密码
	String regionCode =WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
	String opNote = workNo + "(" + strDate+ ")" + "业务终止";
	String opCode = "2889";	
	String opName = "合作伙伴业务终止";
%>

<%
	String OprCode = request.getParameter("OprCode");//02终止
	String spId = request.getParameter("parterId");//合作伙伴代码
	String bizCode = request.getParameter("operId");//业务代码
	
	ArrayList paramsIn = new ArrayList();
	
	paramsIn.add(new String[]{workNo    });	
	paramsIn.add(new String[]{nopass    });	
	paramsIn.add(new String[]{org_code    });	
	paramsIn.add(new String[]{opCode    });	
	paramsIn.add(new String[]{regionCode    });	
	paramsIn.add(new String[]{spId    });	
	paramsIn.add(new String[]{OprCode    });	
	paramsIn.add(new String[]{bizCode    });	
	
    %>
        <wtc:service name="s6300Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=nopass%>"/> 
            <wtc:param value="<%=org_code%>"/> 
            <wtc:param value="<%=opCode%>"/> 
            <wtc:param value="<%=regionCode%>"/> 
            <wtc:param value="<%=spId%>"/> 
            <wtc:param value="<%=OprCode%>"/> 
            <wtc:param value="<%=bizCode%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
	int errCode = Integer.parseInt(retArr[0][0]);
	String errMsg  = retArr[0][1];
	System.out.println("# errCode = "+errCode);
	System.out.println("# errMsg = "+errMsg);
%>

	var response = new AJAXPacket();
	response.data.add("retFlag","queryModEnd");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);
	