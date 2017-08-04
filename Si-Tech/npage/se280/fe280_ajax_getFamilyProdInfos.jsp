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
			*** �������ƣ�sFamProdUpChk
			*** ����ʱ�䣺2012/11/21
			*** ������Ա��shiyong
			*** ������������ͥ��Ʒ������ܲ�ѯ����
			*** 
			*** ���������
			***          0   ��ˮ             iLoginAccept           
			***          1   ������ʶ         iChnSource           
			***          2   ��������         iOpCode          
			***          3   ����             iLoginNo           
			***          4   ��������         iLoginPwd           
			***          5   �ҳ�����         iPhoneNo  
			***          6   ��������         iUserPwd       
			***          7   ��ѯ����         iQryType   0�������ڲ�Ʒ���ҳ���������˵���ֵ
			***          8   ��ͥ����         iFamCode   �� 'XFJT'
			***          9   ��Ʒ����         iProdCode  �� 1001 �������30Ԫ�ײ� 	
			*** ���Σ�
			***			 		 0	 ��Ʒ����		
			*** 	   		 1   ��Ʒ����         vProdCode	�� 1001,1002	
			***			 		 2	 ��Ʒ����		 			vProdName*/	
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