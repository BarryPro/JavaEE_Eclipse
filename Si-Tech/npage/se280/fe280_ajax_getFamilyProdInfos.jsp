<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String operPhoneNo = request.getParameter("operPhoneNo");
	String loginAccept = request.getParameter("loginAccept");
	
	String familyCode = request.getParameter("familyCode")== null? "" : request.getParameter("familyCode");
	String famCode = request.getParameter("famCode")== null? "" : request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode")== null? "" : request.getParameter("prodCode");
	String famRole = request.getParameter("famRole")== null? "" : request.getParameter("famRole");
	String memRoleId = request.getParameter("memRoleId")== null? "" : request.getParameter("memRoleId");
	String busyType = request.getParameter("busyType")== null? "" : request.getParameter("busyType");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
%>
<%
		/************************************************************************
			*** 服务名称：sFamProdUpChk
			*** 编码时间：2012/11/21
			*** 编码人员：shiyong
			*** 功能描述：家庭产品变更功能查询服务
			*** 
			*** 输入参数：
			***          0   流水             iLoginAccept           
			***          1   渠道标识         iChnSource           
			***          2   操作代码         iOpCode          
			***          3   工号             iLoginNo           
			***          4   工号密码         iLoginPwd           
			***          5   家长号码         iPhoneNo  
			***          6   号码密码         iUserPwd       
			***          7   查询类型         iQryType   0：用于在产品变更页面向下拉菜单传值
			***          8   家庭编码         iFamCode   例 'XFJT'
			***          9   产品代码         iProdCode  例 1001 代表的是30元套餐 	
			*** 出参：
			***			 		 0	 产品总数		
			*** 	   		 1   产品代码         vProdCode	例 1001,1002	
			***			 		 2	 产品名称		 			vProdName*/	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sFamProdUpChk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=operPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="0"/>
		<wtc:param value="<%=familyCode%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result12" start="0" length="1" scope="end" />
	<wtc:array id="result23" start="1" length="3" scope="end" />
		
	var _code = new Array();
	var _text = new Array();
	var _sp_info = new Array();
<%
	if("000000".equals(retCode)){
    if(result23.length>0){
      for(int outter = 0 ; result23 != null && outter < result23.length; outter ++){
%>
      	_code[<%=outter%>] = "<%=result23[outter][0]%>";
      	_text[<%=outter%>] = "<%=result23[outter][1]%>";
      	_sp_info[<%=outter%>] = "<%=result23[outter][2]%>";
<%
				System.out.println("diling000---result23["+outter+"][0]="+result23[outter][0]);
				System.out.println("diling000---result23["+outter+"][1]="+result23[outter][1]);
				System.out.println("diling000---result23["+outter+"][2]="+result23[outter][2]);
        
      }
    }
  }
  
%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("_code",_code);
	response.data.add("_text",_text);
	response.data.add("_sp_info",_sp_info);
	core.ajax.receivePacket(response);