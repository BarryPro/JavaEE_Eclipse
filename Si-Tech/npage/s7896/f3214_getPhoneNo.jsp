 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	//读取session信息	
	
	String regionCode = (String)session.getAttribute("regCode");  
	String workPwd = WtcUtil.repNull((String)session.getAttribute("password")); 
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
				
	//错误信息，错误代码
	String errorCode = "0";
	String errorMsg = "";
	
	String groupNo = request.getParameter("groupNo");
	String sNo = request.getParameter("sNo");
	String lNo = request.getParameter("lNo");
	String retType = request.getParameter("retType");
	String offerId = request.getParameter("offerId");
	String idNo = request.getParameter("idNo");
	String opCode = request.getParameter("opCode");
	
	System.out.println("groupNo:"+groupNo);
	System.out.println("sNo:"+sNo);
	System.out.println("lNo:"+lNo);
	System.out.println("retType:"+retType);
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	//ArrayList retList1 = new ArrayList();
	String sqlStr1="";
	//baixf modify 20080427 申告处理，修改为精确匹配
	if(!"".equals(lNo))
	{
	//	sqlStr1 ="select a.short_no,a.phone_no,c.cust_name,c.id_iccid,a.note, substr(d.run_code, 2, 1),a.CURPKGTYPE,e.PKG_NAME  from dvpmnusrmsg a,dVPMNGRPMSG b,dcustdoc c,dcustmsg d,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no and a.id_no = d.id_no and c.cust_id =d.cust_id and a.group_no  = '"+groupNo+"'  and a.phone_no = '"+lNo+"' and rownum <= 50 order by a.GROUP_ID";
	sqlStr1="   select b.short_num, c.phone_no,d.cust_name,d.id_iccid, ' ', substr(c.run_code, 2, 1), e.pkg_code,e.pkg_name from product_offer_instance a,group_instance_member  b,dcustmsg c,dcustdoc d,svpmnpkgcode e where a.serv_id = '"+idNo+"' and trim(e.Pkg_code) =(select trim(field_value) from dcustmsgadd where id_no = c.id_no and field_code = '80003') and a.offer_id =  '"+offerId+"' and e.region_code = '"+regionCode+"' and a.group_id = b.group_id  and b.serv_id = c.id_no and c.phone_no = '"+lNo+"' and c.cust_id = d.cust_id";
	}
	else if(!"".equals(sNo)) 
	{
	//	sqlStr1 ="select a.short_no,a.phone_no,c.cust_name,c.id_iccid,a.note, substr(d.run_code, 2, 1),a.CURPKGTYPE,e.PKG_NAME  from dvpmnusrmsg a,dVPMNGRPMSG b,dcustdoc c,dcustmsg d,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no and a.id_no = d.id_no and c.cust_id =d.cust_id and a.group_no  = '"+groupNo+"' and a.short_no = '"+sNo+"'  and rownum <= 50 order by a.GROUP_ID";
	sqlStr1="   select b.short_num, c.phone_no,d.cust_name,d.id_iccid, ' ', substr(c.run_code, 2, 1), e.pkg_code,e.pkg_name from product_offer_instance a,group_instance_member  b,dcustmsg c,dcustdoc d,svpmnpkgcode e where a.serv_id = '"+idNo+"' and trim(e.Pkg_code) =(select trim(field_value) from dcustmsgadd where id_no = c.id_no and field_code = '80003') and a.offer_id =  '"+offerId+"' and e.region_code = '"+regionCode+"' and a.group_id = b.group_id  and b.serv_id = c.id_no and b.short_num = '"+sNo+"'  and c.cust_id = d.cust_id ";
	}
	else
	{
	//	sqlStr1 ="select a.short_no,a.phone_no,c.cust_name,c.id_iccid,a.note, substr(d.run_code, 2, 1),a.CURPKGTYPE,e.PKG_NAME  from dvpmnusrmsg a,dVPMNGRPMSG b,dcustdoc c,dcustmsg d,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no and a.id_no = d.id_no and c.cust_id =d.cust_id and a.group_no  = '"+groupNo+"' and rownum <= 50 order by a.GROUP_ID";
	
	sqlStr1="   select b.short_num, c.phone_no,d.cust_name,d.id_iccid, ' ', substr(c.run_code, 2, 1), e.pkg_code,e.pkg_name from product_offer_instance a,group_instance_member  b,dcustmsg c,dcustdoc d,svpmnpkgcode e where a.serv_id = '"+idNo+"' and trim(e.Pkg_code) =(select trim(field_value) from dcustmsgadd where id_no = c.id_no and field_code = '80003') and a.offer_id =  '"+offerId+"' and e.region_code = '"+regionCode+"' and a.group_id = b.group_id  and b.serv_id = c.id_no  and c.cust_id = d.cust_id";
	}
	//retList1 = impl.sPubSelect("8",sqlStr1,"region",regionCode);
	//String[][] retListString1 = (String[][])retList1.get(0);
	System.out.println("sqlStr1 = "+sqlStr1);
	%>
    <wtc:service name="sGetPhoneList" retcode="retCode1" retmsg="retMsg1" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=opCode%>"/>
    	<wtc:param value="<%=workNo%>"/>
    	<wtc:param value="<%=workPwd%>"/>
    	<wtc:param value=""/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=idNo%>"/>
    	<wtc:param value="<%=regionCode%>"/> 
    	<wtc:param value="<%=offerId%>"/> 
    	<wtc:param value="<%=lNo%>"/> 
    	<wtc:param value="<%=sNo%>"/> 
    </wtc:service>
    <wtc:array id="retListString1" scope="end"/>
	<%	
	//errorCode = impl.getErrCode(); //错误代码
	errorCode=retCode1;
	System.out.println("errorCode=============:"+errorCode);
	//errorMsg = impl.getErrMsg(); //错误信息
	errorMsg=retMsg1;
	System.out.println("errorMsg=================:"+errorMsg);
  
%>

	var short_no = new Array();
	var phone_no = new Array();
	var cust_name = new Array();
	var id_iccid = new Array();
	var note = new Array();
	var run_code = new Array();
	var run_code = new Array();
	var run_code = new Array();
	var curpkgtype = new Array();
	var pkg_name = new Array();
	var num = 0;
<%
	for(int i = 0;i < retListString1.length;i++){
%>
		short_no[<%=i%>] = '<%=retListString1[i][0]%>';
		phone_no[<%=i%>] = '<%=retListString1[i][1]%>';
		cust_name[<%=i%>] = '<%=retListString1[i][2]%>';
		id_iccid[<%=i%>] = '<%=retListString1[i][3]%>';
		run_code[<%=i%>] = '<%=retListString1[i][4]%>';
		curpkgtype[<%=i%>] = '<%=retListString1[i][5]%>';
		pkg_name[<%=i%>] = '<%=retListString1[i][6]%>';
		num++;
<%
	}
%>

	var response = new AJAXPacket();	
	response.data.add("short_no",short_no);
	response.data.add("phone_no",phone_no);
	response.data.add("cust_name",cust_name);
	response.data.add("id_iccid",id_iccid);
	response.data.add("run_code",run_code);
	response.data.add("curpkgtype",curpkgtype);
	response.data.add("pkg_name",pkg_name);
	response.data.add("num",num);
	response.data.add("errorCode","<%=errorCode%>");
	response.data.add("errorMsg","<%=errorMsg%>");
	response.data.add("retType","<%=retType%>");
	core.ajax.receivePacket(response);
