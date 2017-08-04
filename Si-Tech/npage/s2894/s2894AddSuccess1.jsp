<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String loginPwd  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	/* 接受输入参数 */
	String spCode = request.getParameter("spCode");
	String hidProdCode = request.getParameter("hidProdCode");
	String bizCode = request.getParameter("bizCode");
	
	String  mode_code	  =request.getParameter("mode_code");   //成员资费代码列
	String  mode_region	  =request.getParameter("mode_region");   //成员资费所在地区

	String errCode="";
  	String errMsg ="";
 
	String[] acceptList = null;
	ArrayList acceptList1 = null;
	
    String paramsIn[] = new String[13];
    paramsIn[0]=workNo ;
    paramsIn[1]=loginPwd ;
    paramsIn[2]="3052" ;
    paramsIn[3]=" " ;
    paramsIn[4]=ip_Addr ;
    paramsIn[5]=" " ;
    paramsIn[6]=bizCode ;
    paramsIn[7]=" " ;
    paramsIn[8]=" " ;
    paramsIn[9]=" " ;
    paramsIn[10]=" " ;
    paramsIn[11]=mode_code ;
    paramsIn[12]=mode_region ;

	//acceptList = impl.callService("s3052CfmNew",paramsIn,"2");
%>
    <wtc:service name="s3052CfmNew" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paramsIn[0]%>"/>
    	<wtc:param value="<%=paramsIn[1]%>"/> 
        <wtc:param value="<%=paramsIn[2]%>"/> 
        <wtc:param value="<%=paramsIn[3]%>"/> 
        <wtc:param value="<%=paramsIn[4]%>"/> 
        <wtc:param value="<%=paramsIn[5]%>"/> 
        <wtc:param value="<%=paramsIn[6]%>"/>
    	<wtc:param value="<%=paramsIn[7]%>"/> 
        <wtc:param value="<%=paramsIn[8]%>"/> 
        <wtc:param value="<%=paramsIn[9]%>"/> 
        <wtc:param value="<%=paramsIn[10]%>"/> 
        <wtc:param value="<%=paramsIn[11]%>"/> 
        <wtc:param value="<%=paramsIn[12]%>"/>
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
    	rdShowMessageDialog("业务与资费对应关系配置成功！",2);
    	window.close();
    </script>
<%}%>
