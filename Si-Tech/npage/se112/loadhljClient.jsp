<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>

<%
	String nodeId = request.getParameter("parentCode")==null?"":request.getParameter("parentCode");
	 System.out.println("nodeId=" + nodeId);
	 String[] s = nodeId.split("@");
	 String res_key = s[0];
	 String res_value = s[1];
%>
<s:service name="getTermInfoNew">
								<s:param name="ROOT">
								 <s:param name="REQUEST_INFO">
										<s:param name="OP_TYPE" type="string" value="<%=res_key %>" />
										<s:param name="RES_VALUE" type="string" value="<%=res_value %>" />
										<s:param name="RES_TYPE" type="string" value="0" />
									</s:param>
								</s:param>
</s:service>

<%
	System.out.println("aaaa");
	StringBuffer buf = new StringBuffer(80);
	List data = result.getList("OUT_DATA.RES_LISTS.RES_INFO");
	System.out.println(data.size());
	if(data==null)return;
	Map a = new HashMap();
	for(int i =0;i<data.size();i++){
		a = MapBean.isMap(data.get(i));
		if(a==null){
			buf.append("9999");
			break;
		}
		String resCode = (String)a.get("RES_CODE");
		String resName = (String)a.get("RES_NAME");
		String resKey = (String)a.get("RES_KEY");
		String isLeaf = (String)a.get("IS_LEAF");
		int ileaf = 1;
		String parentId = res_value;
		
		System.out.println(parentId);
		System.out.println(resCode);
		System.out.println(resKey);
		
		if(isLeaf.equals("Y")){
			ileaf = 0;
		}
		
		buf.append("N['").append(resKey + "@" + resCode).append("']='");
		buf.append(resKey + "@" + resCode).append(";").append(resName).append(";").append(nodeId).append(";").append(ileaf).append(";");
		buf.append("T(\"").append(resCode).append("\",\"").append(resName).append("\")';");
		//buf.append("N['0111']='0111;0111_50元有价卡;-1;0;T(\"0\",\"0111\",\"50元有价卡\")';");
		System.out.println(buf.toString());
		//Map c = (HashMap)b.get("RES_BRAND_LIST");
		//List brandList = (List)c.get("RES_BRAND_INFO");
		//System.out.println(brandList.size());
		//for(int j = 0 ; j < brandList.size() ; j++){
		//	Map d = MapBean.isMap(brandList.get(j));
		//	String brandCode = (String)d.get("BRAND_CODE");
		//	String brandName = (String)d.get("BRAND_CODE_NAME");
		//	buf.append("N[\"").append(brandCode).append("\"]=\"");
		//	buf.append(brandCode).append(";").append(brandName);
		//	buf.append(";").append("C").append(";");
		//	buf.append("0;T('").append(brandCode).append("','");
		//	buf.append(brandName).append("')\";");
		//}
	}
	out.print(buf.toString());
%>

<%--<%
	StringBuffer buf = new StringBuffer(80);
	List data = result.getList("OUT_DATA.RRES_LISTS.RES_INFO");
	if(data==null)return;
	Map a = new HashMap();
	for(int i =0;i<data.size();i++){
		a = MapBean.isMap(data.get(i));
		if(a==null) continue;
		Map b = (HashMap)a.get("RES_KIND_INFO");
		String resKind = (String)b.get("RES_KIND_CODE");
		String resKindName = (String)b.get("RES_KIND_NAME");
		Map c = (HashMap)b.get("RES_BRAND_LIST");
		List brandList = (List)c.get("RES_BRAND_INFO");
		System.out.println(brandList.size());
		for(int j = 0 ; j < brandList.size() ; j++){
			Map d = MapBean.isMap(brandList.get(j));
			String brandCode = (String)d.get("BRAND_CODE");
			String brandName = (String)d.get("BRAND_CODE_NAME");
			buf.append("N[\"").append(brandCode).append("\"]=\"");
			buf.append(brandCode).append(";").append(brandName);
			buf.append(";").append("Z").append(";");
			buf.append("0;T('").append(brandCode).append("','");
			buf.append(brandName).append("')\";");
		}
	}
	out.print(buf.toString());
%>--%>
