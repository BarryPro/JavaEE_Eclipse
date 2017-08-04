<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opr_type = request.getParameter("opr_type").trim();
	String catalog_item_id = request.getParameter("catalog_item_id").trim();
	String motive_code = (String)request.getParameter("motive_code").trim();
	String motive_name = (String)request.getParameter("motive_name").trim();
	System.out.println("# motive_code = "+motive_code);
	System.out.println("# motive_name = "+motive_name);
	String sm_code = request.getParameter("sm_code").trim();
	String motive_type = request.getParameter("motive_type").trim();
	String type_name = request.getParameter("type_name").trim();
	String offer_id = request.getParameter("offer_id").trim();
	String offer_name = request.getParameter("offer_name").trim();
	String eff_date = request.getParameter("eff_date").trim();
	String exp_date = request.getParameter("exp_date").trim();
	String login_no = request.getParameter("login_no").trim();
	String org_code = request.getParameter("org_code").trim();
	String login_accept = "";
	String motiveExtCode = request.getParameter("motiveExtCode").trim();
	//String motive_srv = request.getParameter("motive_srv").trim();
	//String motive_price = request.getParameter("motive_price").trim();
	//String motive_srvname = request.getParameter("motive_srvname").trim();
    
    String motive_price = request.getParameter("motive_price").trim();
    System.out.println("# motive_price = "+motive_price);
	String product_code = request.getParameter("product_code");
	String product_name = request.getParameter("product_name");
	String product_note = request.getParameter("product_note");
	String product_smcode = request.getParameter("product_smcode");
	//String product_srv = request.getParameter("product_srv");
	String product_type = request.getParameter("product_type");
	String product_discount = request.getParameter("product_discount");
	//String product_srvname = request.getParameter("product_srvname");
	//String smotive_price = request.getParameter("smotive_price");
	//String smode_code = request.getParameter("smode_code");
	//String smode_name = request.getParameter("smode_name");	
	int addRecordNum = Integer.parseInt(request.getParameter("addRecordNum"));
	String[] iproduct_code = {product_code};
	String[] iproduct_name = {product_name};
	String[] iproduct_note = {product_note};
	String[] iproduct_smcode = {product_smcode};
	//String[] iproduct_srv = {product_srv};
	String[] iproduct_type = {product_type};
	String[] iproduct_discount = {product_discount};
	//String[] iproduct_srvname = {product_srvname};
	//String[] ismotive_price = {smotive_price};
	//String[] ismode_code = {smode_code};
	//String[] ismode_name = {smode_name};
	System.out.println("product_smcode-"+product_smcode);
	if(addRecordNum > 0){
		iproduct_code = product_code.substring(0, product_code.length()-1).split("\\~",addRecordNum);
		iproduct_name = product_name.substring(0, product_name.length()-1).split("\\~",addRecordNum);
		iproduct_note = product_note.substring(0, product_note.length()-1).split("\\~",addRecordNum);
		iproduct_smcode = product_smcode.substring(0, product_smcode.length()-1).split("\\~",addRecordNum);
		//iproduct_srv = product_srv.substring(0, product_srv.length()-1).split("\\~",addRecordNum);
		iproduct_type = product_type.substring(0, product_type.length()-1).split("\\~",addRecordNum);
		iproduct_discount = product_discount.substring(0,product_discount.length()-1).split("\\~",addRecordNum);
		//iproduct_srvname = product_srvname.substring(0, product_srvname.length()-1).split("\\~",addRecordNum);
		//ismotive_price = smotive_price.substring(0, smotive_price.length()-1).split("\\~",addRecordNum);
		//ismode_code = smode_code.substring(0, smode_code.length()-1).split("\\~",addRecordNum);
		//ismode_name = smode_name.substring(0, smode_name.length()-1).split("\\~",addRecordNum);
	}
%>

<wtc:service name="s7411Cfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=opr_type%>"/>
	<wtc:param value="<%=motive_code%>"/>
	<wtc:param value="<%=sm_code%>"/>
	<wtc:param value="<%=motiveExtCode%>"/>
	<wtc:param value="<%=type_name%>"/>
	<wtc:param value="<%=offer_id%>"/>
	<wtc:param value="<%=motive_name%>"/>	
	<wtc:param value="<%=eff_date%>"/>
	<wtc:param value="<%=exp_date%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=org_code%>"/>			
	<wtc:param value="<%=login_accept%>"/>
	<wtc:param value="<%=motive_price%>"/>
	<wtc:params value="<%=iproduct_code%>"/>
	<wtc:params value="<%=iproduct_name%>"/>			
	<wtc:params value="<%=iproduct_note%>"/>
	<wtc:params value="<%=iproduct_smcode%>"/>
	<wtc:params value="<%=iproduct_type%>"/>
	<wtc:params value="<%=iproduct_discount%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	retCode="999999";
	retMsg="ÏµÍ³´íÎó";
	if(result.length>0){
	  	retCode = result[0][0];
	  	retMsg = result[0][1];
	} 
%>

var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid")%>';
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
