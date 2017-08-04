<%
   /*
   * 功能: 根据新主资费和旧主资费返回必绑的附加资费和必退的附加资费
　 * 版本: v1.0
　 * 日期: 2014/11/24
　 * 作者: quyl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人         修改目的
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
String groupId = (String)session.getAttribute("groupId");
String loginNo = (String)session.getAttribute("workNo");
String password =(String)session.getAttribute("password");
String actType = request.getParameter("actType")==null?"":request.getParameter("actType");
String brandId = request.getParameter("brandId")==null?"":request.getParameter("brandId");
String mode_code = request.getParameter("mode_code")==null?"":request.getParameter("mode_code");
String powerRight = request.getParameter("powerRight")==null?"":request.getParameter("powerRight");
String belong_code = request.getParameter("belong_code")==null?"":request.getParameter("belong_code");
String id_no = request.getParameter("id_no")==null?"":request.getParameter("id_no");
String prodPrcId = request.getParameter("prodPrcId")==null?"":request.getParameter("prodPrcId");
System.out.println("++++++groupId++++++++++++" + groupId);
System.out.println("++111++++brandId++++++++++++" + brandId);
System.out.println("++111++++mode_code++++++++++++" + mode_code);
System.out.println("++111++++powerRight++++++++++++" + powerRight);
System.out.println("++111++++belong_code++++++++++++" + belong_code);
System.out.println("++111++++id_no++++++++++++" + id_no);
System.out.println("++111++++prodPrcId++++++++++++" + prodPrcId);
StringBuffer buf = new  StringBuffer();
if("76".equals(actType) || "95".equals(actType) || "97".equals(actType)|| "117".equals(actType)|| "140".equals(actType)|| "141".equals(actType)){//117是模板小类
%>
<s:service name="s1270MustYX">
	<s:param name="ROOT">
	 	<s:param name="LoginAccept" type="string" value="" />
	 	<s:param name="ChnSource" type="string" value="01" />
	 	<s:param name="OpCode" type="string" value="g794" />
	 	<s:param name="LoginNo" type="string" value="<%=loginNo%>" />
	 	<s:param name="LoginPwd" type="string" value="<%=password%>" />
	 	<s:param name="PhoneNo" type="string" value="" />
	 	<s:param name="UserPwd" type="string" value="" />
	 	<s:param name="LoginRight" type="string" value="<%=powerRight%>" />
	 	<s:param name="IdNo" type="string" value="<%=id_no%>" />
	 	<s:param name="OldMode" type="string" value="<%=mode_code %>" />
	 	<s:param name="NewMode" type="string" value="<%=prodPrcId %>" />
	 	<s:param name="BelongCode" type="string" value="<%=belong_code %>" />
	</s:param>
</s:service>
<%
		String rtnCode = result.getString("RETURN_CODE");
		String RETURN_MSG = result.getString("RETURN_MSG");
		
		String KX_CODE_BUNCH = result.getString("OUT_DATA.KX_CODE_BUNCH");
		String KX_NAME_BUNCH = result.getString("OUT_DATA.KX_NAME_BUNCH");
		String KX_HABITUS_BUNCH = result.getString("OUT_DATA.KX_HABITUS_BUNCH");
		String KX_OPERATION_BUNCH = result.getString("OUT_DATA.KX_OPERATION_BUNCH");
		String KX_STREAM_BUNCH = result.getString("OUT_DATA.KX_STREAM_BUNCH");
		String KX_BEGINTIME_BUNCH = result.getString("OUT_DATA.KX_BEGINTIME_BUNCH");
		String KX_ENDTIME_BUNCH = result.getString("OUT_DATA.KX_ENDTIME_BUNCH");

		System.out.println("++111++++KX_CODE_BUNCH++++++++++++" + KX_CODE_BUNCH);
		System.out.println("++111++++KX_NAME_BUNCH++++++++++++" + KX_NAME_BUNCH);
		System.out.println("++111++++KX_HABITUS_BUNCH++++++++++++" + KX_HABITUS_BUNCH);
		System.out.println("++111++++KX_OPERATION_BUNCH++++++++++++" + KX_OPERATION_BUNCH);
		System.out.println("++111++++KX_STREAM_BUNCH++++++++++++" + KX_STREAM_BUNCH);
		System.out.println("++111++++KX_BEGINTIME_BUNCH++++++++++++" + KX_BEGINTIME_BUNCH);
		System.out.println("++111++++KX_ENDTIME_BUNCH++++++++++++" + KX_ENDTIME_BUNCH);


	 	buf.append(rtnCode).append("~").append(RETURN_MSG).append("~").append(KX_CODE_BUNCH).append("~").append(KX_NAME_BUNCH)
	 	.append("~").append(KX_HABITUS_BUNCH).append("~").append(KX_OPERATION_BUNCH).append("~").append(KX_STREAM_BUNCH).append("~")
	 	.append(KX_BEGINTIME_BUNCH).append("~").append(KX_ENDTIME_BUNCH);	
}else{
		buf.append("000000~成功~~~~~~~");
}
		System.out.println("++111++++buf++++++++++++" + buf.toString());
		out.print(buf.toString());
%>