<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="LoginAccept" />
<%
    String work_no = request.getParameter("work_no");
    String password = request.getParameter("password");
    String op_code = request.getParameter("op_code");
		String SmCode = request.getParameter("SmCode");    
		String CustIdType = request.getParameter("CustIdType");          
		String custAuthId = request.getParameter("custAuthId");
		String gCustId = request.getParameter("gCustId");
		String IsLogAuthen = request.getParameter("IsLogAuthen");
		String IsLogContact = request.getParameter("IsLogContact");
		String tempString = request.getParameter("tempStr");
		StringTokenizer st = new StringTokenizer(tempString,"|");
		
		String phoneNo = request.getParameter("phoneNo");
		String contact_id = request.getParameter("contact_id");
		String interface_code = request.getParameter("interface_code");
		String group_id = request.getParameter("group_id");
		String contact_status = request.getParameter("contact_status");
		String begin_time = request.getParameter("begin_time");
		String contract_type = request.getParameter("contract_type");
		String contact_reason = request.getParameter("contact_reason");
		String contact_content = request.getParameter("contact_content");
		
		
		int len = st.countTokens();
		
		String[]AuthCodeArr = new String[len];
		String[]AuthIdArr = new String[len];
		String[]TempArr = new String[len];
		String TempArr1;
		String [] A;
		
		for(int j=0;j<len;j++){
			TempArr1=st.nextToken();
				A=TempArr1.split(",");
				
				if(A.length>1)
				{
						AuthCodeArr[j]=A[0];
						AuthIdArr[j]=A[1];
				}
				else{
					AuthCodeArr[j]=A[0];
					AuthIdArr[j]="";
				}
		}
		
	String paramsIn[] = new String[18];
   paramsIn[0]=work_no;
   paramsIn[1]=password;
   paramsIn[2]=op_code;
   paramsIn[3]=LoginAccept;
   paramsIn[4]=LoginAccept;
   paramsIn[5]=IsLogAuthen;
   paramsIn[6]=IsLogContact;
   paramsIn[7]=CustIdType;
   if (SmCode == null)
   {
     paramsIn[8]="";
   }
   else
   {
     paramsIn[8]=SmCode;
   }
   paramsIn[9]=custAuthId;
	 paramsIn[10]=interface_code;
	 paramsIn[11]=contact_reason;
	 paramsIn[12]=contact_content;
	 paramsIn[13]="5";//接触终端界面类型terminate_interface。5:Web。
	 paramsIn[14]=group_id;
	 paramsIn[15]=contact_status;
	 paramsIn[16]=contract_type;
	 paramsIn[17]=begin_time;
		
		
		  String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
		%>
		<wtc:service name="s3781Cfm"  outnum="4" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param   value="<%=paramsIn[0]%>"/>
			<wtc:param   value="<%=paramsIn[1]%>"/>
			<wtc:param   value="<%=paramsIn[2]%>"/>
			<wtc:param   value="<%=paramsIn[3]%>"/>
			<wtc:param   value="<%=paramsIn[4]%>"/>
			<wtc:param   value="<%=paramsIn[5]%>"/>
			<wtc:param   value="<%=paramsIn[6]%>"/>
			<wtc:param   value="<%=paramsIn[7]%>"/>
			<wtc:param   value="<%=paramsIn[8]%>"/>
			<wtc:param   value="<%=paramsIn[9]%>"/>
			<wtc:param   value="<%=paramsIn[10]%>"/>
			<wtc:param   value="<%=paramsIn[11]%>"/>
			<wtc:param   value="<%=paramsIn[12]%>"/>
			<wtc:param   value="<%=paramsIn[13]%>"/>
			<wtc:param   value="<%=paramsIn[14]%>"/>
			<wtc:param   value="<%=paramsIn[15]%>"/>
			<wtc:param   value="<%=paramsIn[16]%>"/>
			<wtc:param   value="<%=paramsIn[17]%>"/>
			<wtc:params   value="<%=AuthCodeArr%>"/>
			<wtc:params   value="<%=AuthIdArr%>"/>
		</wtc:service>
<%
	if(retCode.equals("000000"))
	{
	
		System.out.println("gCustId==="+gCustId);
		System.out.println("CustIdType==="+CustIdType);
		
		Map sessionMap = (HashMap)session.getAttribute(gCustId);
		if(sessionMap!=null)
		{
			Map map = null;
			if(CustIdType.equals("0"))//客户
			{
				map = (HashMap)sessionMap.get(CustIdType);
			}else if(CustIdType.equals("1"))//用户
			{
				map = (HashMap)sessionMap.get(phoneNo);
			}
			
			for(int i=0;i<AuthCodeArr.length;i++)
			{
				map.put(AuthCodeArr[i],AuthIdArr[i]);
				//System.out.println("AuthCodeArr["+i+"]==="+AuthCodeArr[i]);
				//System.out.println("AuthIdArr["+i+"]==="+AuthIdArr[i]);
			}
			
			if(CustIdType.equals("0"))//客户
			{
				sessionMap.put("0",map);
			}else if(CustIdType.equals("1"))//用户
			{
				sessionMap.put(phoneNo,map);
			}
		}
	
	}
%>

	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);