<%
   /*名称：新旧代码并存 - 变更提交
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
	String opNote = workNo + "(" + strDate+ ")" + "新旧代码变更";
	String opCode = "e715";	
	String opName = "新旧代码并存暂停恢复";
%>

<%
	String OprCode = request.getParameter("OprCode");//Z暂停，H恢复,E终止
	String ecid = request.getParameter("ecid");
	String codeprop = request.getParameter("codeprop");
	String oldcode = request.getParameter("oldcode")==null?"":request.getParameter("oldcode");
	String newcode = request.getParameter("newcode")==null?"":request.getParameter("newcode");
	

	
    %>
        <wtc:service name="se715Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=nopass%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=ecid%>"/> 
				<wtc:param value="<%=codeprop%>"/> 
				<wtc:param value="<%=oldcode%>"/> 
				<wtc:param value="<%=newcode%>"/> 
				<wtc:param value="<%=OprCode%>"/> 
				<wtc:param value="<%=regionCode%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%

	System.out.println("# errCode = "+retCode);
	System.out.println("# errMsg = "+retMsg);
%>

	var response = new AJAXPacket();
	response.data.add("retFlag","queryMod");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);
	