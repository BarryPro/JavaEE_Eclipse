<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String giftModel = request.getParameter("giftModel");
	String groupId = request.getParameter("groupId");
	String giftNo = request.getParameter("giftNo");
	String resCode="";
	if("0".equals(giftModel.trim())){
		resCode="res_code";
	}else if("1".equals(giftModel.trim()))
	{
		resCode="package_code";
	}
		
 %>
	<s:service name="getGiftInfo">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="RES_KEY" type="string" value="<%=resCode%>" />
				<s:param name="RES_VALUE" type="string" value="<%=giftNo%>" />
				<s:param name="RES_TYPE" type="string" value="<%=giftModel%>" />
				<s:param name="GROUP_ID" type="string" value="<%=groupId%>" />
			</s:param>
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String Strgoodssub="";
	String StrbusInsub="";
	String split="";
	if("000000".equals(RETURN_CODE)){
		Map b = new HashMap();
		List felist = result.getList("OUT_DATA.RES_LISTS.RES_INFO");
		for(int i =0;i<felist.size();i++){
			b = MapBean.isMap(felist.get(i));
			if(b==null) continue;
			String RES_CODE= (String)b.get("RES_CODE");
			System.out.println("*RES_CODE***************************����"+RES_CODE);
			String RES_NAME= (String)b.get("RES_NAME");
			System.out.println("*RES_NAME***************************����"+RES_NAME);
			String RES_NUM= (String)b.get("RES_NUM");
			System.out.println("*RES_NUM***************************����"+RES_NUM);
			String PROV_CODE=(String) b.get("PROV_CODE");//�̼ұ���
			System.out.println("*PROV_CODE***************************����"+PROV_CODE);
			if(null == RES_CODE || "".equals(RES_CODE) || null == RES_NAME || "".equals(RES_NAME) 
			    ||null == RES_NUM || "".equals(RES_NUM)||null == PROV_CODE || "".equals(PROV_CODE)  ){
				RETURN_CODE ="-1";
				RETURN_MSG ="getGiftInfo����������������ϵ����Ա��";
			}else{
				Strgoodssub=Strgoodssub+RES_CODE+","+RES_NAME+","+RES_NUM+"#";
				StrbusInsub=StrbusInsub+PROV_CODE+",";
			}
		}
		if(!"".equals(Strgoodssub) && !"".equals(StrbusInsub)){
			Strgoodssub = Strgoodssub.substring(0,Strgoodssub.length()-1);
			StrbusInsub = StrbusInsub.substring(0,StrbusInsub.length()-1);
			System.out.println("Strgoodssub:"+Strgoodssub+"------StrbusInsub:"+StrbusInsub);
		}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("Strgoodssub","<%=Strgoodssub%>");
		response.data.add("StrbusInsub","<%=StrbusInsub%>");
		core.ajax.receivePacket(response);
<%
}
%>
