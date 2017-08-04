 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-15 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	//读取session信息
	
	String regionCode = (String)session.getAttribute("regCode");   
			
	//错误信息，错误代码
	String errorCode = "0";
	String errorMsg = "";
	
	String groupNo = request.getParameter("groupNo");
	String sNo = request.getParameter("sNo");
	String lNo = request.getParameter("lNo");
	String verifyType = request.getParameter("retType");
	String smCode = request.getParameter("smCode");
	String idNo = request.getParameter("idNo");
	
	System.out.println("groupNo:"+groupNo);
	System.out.println("sNo:"+sNo);
	System.out.println("lNo:"+lNo);
	System.out.println("verifyType:"+verifyType);
	System.out.println("smCode:"+smCode);
	System.out.println("idNo:"+idNo);
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	//ArrayList retList1 = new ArrayList();
	String sqlStr1="";
	//baixf modify 20080427 申告处理，修改为精确匹配
	if ("j1".equals(smCode)) {
		sqlStr1 = "select short_no, phone_no, member_name, member_name_initial from dj1otherusermsg where id_no = '" + idNo + "' and short_no like '%" + sNo + "%' and phone_no like '%" + lNo + "%' order by short_no";
	} else if(!"".equals(lNo))
	{
//		sqlStr1 ="select a.short_no,a.phone_no, a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a,dVPMNGRPMSG b,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no   and a.group_no  = '"+groupNo+"'  and a.phone_no = '"+lNo+"' and rownum <= 50 order by a.GROUP_ID";
		sqlStr1 ="select a.short_no,a.phone_no, a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a, svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"'  and a.group_no  = '"+groupNo+"'  and a.phone_no = '"+lNo+"' and rownum <= 50 order by a.GROUP_ID";

	}
	else if(!"".equals(sNo)) 
	{
//		sqlStr1 ="select a.short_no,a.phone_no, a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a,dVPMNGRPMSG b,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no  and a.group_no  = '"+groupNo+"' and a.short_no = '"+sNo+"'  and rownum <= 50 order by a.GROUP_ID";
		sqlStr1 ="select a.short_no,a.phone_no, a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no  = '"+groupNo+"' and a.short_no = '"+sNo+"'  and rownum <= 50 order by a.GROUP_ID";
	}
	else
	{
//		sqlStr1 ="select a.short_no,a.phone_no,a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a,dVPMNGRPMSG b,svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"' and  a.group_no = b.group_no   and a.group_no  = '"+groupNo+"' and rownum <= 50 order by a.GROUP_ID";
		sqlStr1 ="select a.short_no,a.phone_no,a.CURPKGTYPE,e.PKG_NAME  from dvpmnotherusermsg a, svpmnpkgcode e where a.CURPKGTYPE=e.PKG_code and e.region_code='"+regionCode+"'   and a.group_no  = '"+groupNo+"' and rownum <= 50 order by a.GROUP_ID";
	}
	//retList1 = impl.sPubSelect("5",sqlStr1,"region",regionCode);	
	//String[][] retListString1 = (String[][])retList1.get(0);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retListString1" scope="end" />	
	<%
	//errorCode = impl.getErrCode(); //错误代码
	errorCode=retCode1;
	System.out.println("errorCode:=============="+errorCode);
	//errorMsg = impl.getErrMsg(); //错误信息
	errorMsg=retMsg1;
	System.out.println("errorMsg:================"+errorMsg);
	  
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
		cust_name[<%=i%>] = '';
		id_iccid[<%=i%>] = '';
		run_code[<%=i%>] = '<%=retListString1[i][2]%>';
		curpkgtype[<%=i%>] = '';
		pkg_name[<%=i%>] = '<%=retListString1[i][3]%>';
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
	response.data.add("retType","<%=verifyType%>");
	core.ajax.receivePacket(response);
