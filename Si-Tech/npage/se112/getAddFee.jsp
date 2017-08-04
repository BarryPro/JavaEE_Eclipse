<%
   /*
   * 功能: 快速检索
　 * 版本: v2.0
　 * 日期: 2013/11/19
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
String opType = "L";
String prodName = request.getParameter("prodName")==null?"":request.getParameter("prodName");
String actType = request.getParameter("actType")==null?"":request.getParameter("actType");
System.out.println("++++++prodName+++++++++++" + prodName);
System.out.println("++++++groupId++++++++++++" + groupId);

System.out.println("++++++actType++++++++++++" + actType);

if("76".equals(actType) || "95".equals(actType) || "97".equals(actType)|| "115".equals(actType)){//是这几个小类的查询接口传特殊标识
	opType = "T";
}
if("72".equals(actType)){
	opType = "H";
}
%>
<s:service name="smktProdQry" >
    <s:param name="Root">
		<s:param  name="GROUP_ID" type="string" value="" />
		<s:param  name="OFFER_NAME" type="string" value="<%=prodName%>" />
		<s:param  name="OP_TYPE" type="string" value="<%=opType%>" />
		<s:param  name="PRI_CODE" type="string" value="" />
		<s:param  name="LOGIN_NO" type="string" value="<%=loginNo%>" />
	</s:param>
</s:service>
<%
		StringBuffer  buf1 = new  StringBuffer();
		StringBuffer  buf2 = new  StringBuffer();
		StringBuffer  buf3 = new  StringBuffer();
		StringBuffer  buf4 = new  StringBuffer();
		StringBuffer  buf5 = new  StringBuffer();
		String rtnCode = result.getString("RETURN_CODE");
		String DETAIL_MSG = result.getString("DETAIL_MSG");
		String RETURN_MSG = result.getString("RETURN_MSG");
		
		List datainfo = result.getList("OUT_DATA.FEE_LIST.FEE_INFO");
		Map hmap = new HashMap();
		int j=0;
		for(int i=0;i<datainfo.size();i++){
			hmap = MapBean.isMap(datainfo.get(i));
			if(hmap==null) continue;
			String feeCode = (String)hmap.get("FEE_CODE");
			String feeName = (String)hmap.get("FEE_NAME");
			String feeMoney = (String)hmap.get("FEE_MONEY");
			String offsetType = (String)hmap.get("OFFSET_TYPE");
			String offsetUnit = (String)hmap.get("OFFSET_UNIT");
			buf1.append(feeCode+"^");
			buf2.append(feeCode+"_"+feeName+"^");
			buf3.append(feeMoney+"^");
			buf4.append(offsetType+"^");
			buf5.append(offsetUnit+"^");
		}
		out.print(buf1.substring(0,buf1.lastIndexOf("^"))+"#"+buf2.substring(0,buf2.lastIndexOf("^"))+"#"+buf3.substring(0,buf3.lastIndexOf("^"))+"#"+buf4.substring(0,buf4.lastIndexOf("^"))+"#"+buf5.substring(0,buf5.lastIndexOf("^")));
%>