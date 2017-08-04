<%
   /*名称：新旧服务代码并存 - 添加提交
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: liuweih
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%  
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));         //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));            //登陆密码
	String regionCode =WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));


	String opCode = "e715";	
	String opName = "新旧代码并存暂停恢复";
%>

<%
	String OprCode ="A";
	String ecid = request.getParameter("ecsiid");
	String codeprop = request.getParameter("BaseServCodeProp1");
	String oldcode = request.getParameter("OldBaseServCode");
	String newcode = request.getParameter("NewBaseServCode");
	

		

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
	<wtc:array id="retStr"  scope="end"/>
<%

	
	if(retCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("操作成功！"); 
        	window.location="fe715.jsp"; 
       
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("错误信息：<%=retMsg%>",0);	
	            history.go(-1);
	      </script>         
<%            
    }
    
%>
