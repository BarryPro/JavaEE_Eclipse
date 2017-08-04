<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String nodeId = request.getParameter("nodeId")==null?"":request.getParameter("nodeId");
%>
<s:service name="getTermInfoNew">
								<s:param name="ROOT">
								 <s:param name="REQUEST_INFO">
										<s:param name="OP_TYPE" type="string" value="res_code" />
										<s:param name="RES_VALUE" type="string" value="<%=nodeId %>" />
										<s:param name="RES_TYPE" type="string" value="0" />
									</s:param>
								</s:param>
</s:service>

<%
	StringBuffer buf = new StringBuffer(80);
	List data = result.getList("OUT_DATA.RES_LISTS.RES_INFO");
	if(data==null)return;
	Map a = new HashMap();
	for(int i =0;i<data.size();i++){
		a = MapBean.isMap(data.get(i));
		if(a==null) continue;
		
		String brandName = (String)a.get("BRAND_NAME");
		String resName = (String)a.get("RES_NAME");
		String res_price = (String)a.get("RES_PRICE");
		String RES_CODE = (String)a.get("RES_CODE");	//终端型号代码	
		String BRAND_CODE = (String)a.get("BRAND_CODE");//终端品牌代码
			
		buf.append(brandName).append(",").append(resName).append(",").append(res_price).append(",").append(RES_CODE).append(",").append(BRAND_CODE).append(";");
	}
	out.print(buf.toString());
%>

<%--<%
	StringBuffer buf = new StringBuffer(80);
	List data = result.getList("RESPONSE_INFO.RES_KIND_LIST");
	if(data==null)return;
	Map a = new HashMap();
	for(int i =0;i<data.size();i++){
		a = MapBean.isMap(data.get(i));
		if(a==null) continue;
		Map b = (HashMap)a.get("RES_KIND_INFO");
		Map c = (HashMap)b.get("RES_BRAND_LIST");
		Map e = (HashMap)c.get("RES_BRAND_INFO");
		Map f = MapBean.isMap(e.get("RES_CODE_LIST"));
		if(f==null){
			buf.append("9999");//没有查询到促销品列表
			break;
		}
		a = MapBean.isMap(f.get("RES_CODE_INFO"));
		if(a==null){
			List giftList = (List)f.get("RES_CODE_INFO");
			for(int j = 0 ; j < giftList.size() ; j++){
				Map d = MapBean.isMap(giftList.get(j));
				String giftCode = (String)d.get("RES_CODE");
				String clientType = (String)d.get("RES_MODE_ID");
				String giftName = (String)d.get("RES_CODE_NAME");
				String giftUnit = (String)d.get("RES_CODE_UNIT");
				String price = (String)d.get("RES_PRICE");
				if(price==null||"".equals(price)){
					price = "0";
				}
				String favPrice = (String)d.get("RES_FAVPRICE");
				buf.append(giftCode).append(",").append(clientType).append(",").append(giftName).append(",");
				buf.append(giftUnit).append(",").append(price).append(",");
				buf.append(favPrice).append(";");
			}
		}else{
			String giftCode = (String)a.get("RES_CODE");
			String clientType = (String)a.get("RES_MODE_ID");
			String giftName = (String)a.get("RES_CODE_NAME");
			String giftUnit = (String)a.get("RES_CODE_UNIT");
			String price = (String)a.get("RES_PRICE");
			if(price==null||"".equals(price)){
				price = "0";
			}
			String favPrice = (String)a.get("RES_FAVPRICE");
			buf.append(giftCode).append(",").append(clientType).append(",").append(giftName).append(",");
			buf.append(giftUnit).append(",").append(price).append(",");
			buf.append(favPrice).append(";");
		}
	}
	out.print(buf.toString());
%>--%>
