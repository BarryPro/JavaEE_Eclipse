<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	/* 接受输入参数 */
	String spCode = request.getParameter("spCode");
	//String bizcodeadd = request.getParameter("bizCode");
	String hidProdCode = request.getParameter("hidProdCode");
	String prodCode = request.getParameter("prodCode");

	
    String errCode="";
    String errMsg="";
    
	String[] acceptList = null;
	ArrayList acceptList1 = null;
	
    String paramsIn[] = new String[7];
    paramsIn[0] = "289400";
    paramsIn[1] = hidProdCode;
   // paramsIn[2] = bizcodeadd;
    paramsIn[2] = prodCode;	
    paramsIn[3] = workNo;
    paramsIn[4] = prodCode;
    paramsIn[5] = hidProdCode;
    paramsIn[6] = prodCode;

	//acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
%>
    <wtc:service name="sDynSqlCfm" retcode="retCode" retmsg="retMsg" outnum="0" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paramsIn[0]%>"/>
    	<wtc:param value="<%=paramsIn[1]%>"/> 
        <wtc:param value="<%=paramsIn[2]%>"/> 
        <wtc:param value="<%=paramsIn[3]%>"/> 
        <wtc:param value="<%=paramsIn[4]%>"/> 
        <wtc:param value="<%=paramsIn[5]%>"/> 
        <wtc:param value="<%=paramsIn[6]%>"/> 
    </wtc:service>
<%
	errCode=retCode;
	errMsg =retMsg ;
	
if(!"000000".equals(errCode)){
%>
    <script language='javascript'>
        rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
        history.go(-1);
    </script>
<%}else{%>
    <script language='javascript'>
        rdShowMessageDialog("业务和产品对应关系配置成功！",2);
        window.close();
    </script>
<%}%>