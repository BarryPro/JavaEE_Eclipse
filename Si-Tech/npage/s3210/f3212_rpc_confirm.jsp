 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-15 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
    	String opName = "����ɾ�����ų�Ա";    	
    	String regionCode = (String)session.getAttribute("regCode");  
    	String loginAccept=request.getParameter("loginNo"); 
    	
    	String error_code = "";
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	//String[][] errCodeMsg = null;
    	//String[] retStr = null;
	//String[] callData = null;

  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	//boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
   
    	//SPubCallSvrImpl callView = new SPubCallSvrImpl();


	//String strArray="var arrMsg = new Array(); ";  //must 
  	//String strArray1="var arrMsg1 = new Array(); ";  //must 
  	String verifyType = request.getParameter("verifyType");
  	//String op_code = request.getParameter("opCode");
 
	String iLoginNo  = request.getParameter("loginNo"); 	/* ��������   */ 
	String iOrgCode  = request.getParameter("orgCode");	    /* ��������   */
	String iOpCode   = request.getParameter("opCode");		/* ��������   */
	String iOpNote   = request.getParameter("op_note");	    /* ������ע   */
	String iGrpId    = request.getParameter("GRPID");		/* ���ź�     */
	String iNoType   = request.getParameter("updateNoType");/* ��������   */
	String iPhoneAr  = request.getParameter("tmpR1");	    /* �̺��봮   */
    	String iGroup_Id = request.getParameter("group_id");    //����Ա��group_id
    	String iOrg_Id   = request.getParameter("org_id");      //����Ա��org_id
    	String IpAddr   = request.getParameter("IpAddr");      //����Ա��IpAddr

    	String iRegion_Code = iOrgCode.substring(0,2);
    	String[] ParamsIn = new String[] { iLoginNo, iOrgCode, iOpCode, iOpNote, iGrpId, iNoType, iPhoneAr, iGroup_Id, iOrg_Id,IpAddr };

	for(int i=0; i<ParamsIn.length; i++){
		if( ParamsIn[i] == null ){
			ParamsIn[i] = "";
		}
	}

    //callData = callView.callService("s3212Cfm", ParamsIn, "2", "region", iRegion_Code);
    %>
    
    <wtc:service name="s3212Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=ParamsIn%>" />
    </wtc:service>
    <wtc:array id="callData" scope="end" />	
    
   <%
	error_code = retCode1;
	error_msg= retMsg1;	
%>

var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= error_code %>");
response.data.add("errorMsg","<%= error_msg %>");
<%
	if (callData != null)
	{
%>
		response.data.add("backArrMsg","<%= callData[0][0]%>" );
		response.data.add("backArrMsg1","<%= callData[0][1]%>" );
<%
	}else{
	%>
		response.data.add("backArrMsg","" );
		response.data.add("backArrMsg1","" );
	<%}
%>

core.ajax.receivePacket(response);

<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+retCode1
	+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+loginAccept
	+"&pageActivePhone="+iPhoneAr+"&opBeginTime="+opBeginTime+"&contactId="+iGrpId+"&contactType=grp";
%>
<jsp:include page="<%=url%>" flush="true" />