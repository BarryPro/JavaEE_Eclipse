<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-26 ҳ�����,�޸���ʽ
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode =  (String)session.getAttribute("regCode");	
	
	String workNo    = request.getParameter("workNo");
	String nopass    = request.getParameter("nopass");
	String opCode    = request.getParameter("opCode");
	String accountNo = request.getParameter("accountNo");
	String opType    = request.getParameter("opType");
	String groupId   = request.getParameter("groupId");

	String paramsIn[] = new String[6];
	
	paramsIn[0] = workNo;          //����
	paramsIn[1] = nopass;          //����
	paramsIn[2] = opCode;          //OP_CODE
	paramsIn[3] = accountNo;       //�������ʺ�;
	paramsIn[4] = opType;          //�������� 2_�ͷ� 3_ְ��
	paramsIn[5] = groupId;         //��֯����
	
	String errCode="0";
	String errMsg="";	
	 //acceptList = impl.callFXService("sCheckAccNo",paramsIn,"1");
	
	String sq3 = "select SEQ_MailCode.NEXTVAL from dual";//20100317 add
	System.out.println(sq3);//20100317 add
%>
	<wtc:service name="sCheckAccNo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
//20100317 add
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:sql><%=sq3%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="SEQ_MailCodeStr" scope="end" />
//20100317 end
<%
	 
	errCode=retCode1;
	errMsg=retMsg1;
	
	
	if(errCode.equals("000000"))
    	{
%>		
		rdShowMessageDialog("����BOSS�ʺųɹ�,���������!",2);
<%	}
    else
    {%>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		history.go(-1);
<%
    }
    String[][] result = new String[][]{};
    result = result1;
    String loginNo="";
    if(result!=null&&result.length>0){
    	 loginNo=result[0][0];
    }  
%>
	var loginNo="";
	<%if(errCode.equals("000000")){%>
		loginNo = "<%=loginNo%>";
	<%}%>
var response = new AJAXPacket();
response.data.add("backString",loginNo);
response.data.add("SEQ_MailCode","<%=SEQ_MailCodeStr[0][0]%>");//20100317 add
response.data.add("flag","12");
core.ajax.receivePacket(response);




