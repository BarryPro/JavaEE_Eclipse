 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String errorCode="444444";	
	String regionCode=(String)session.getAttribute("regCode");  
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����

	String strArray="var arrMsg = new Array(); ";  //must 

    	String verifyType = request.getParameter("verifyType");
	String[][] input_paras = new String[1][6];  
	String[][] recv_num = new String[2][2];
	
		/*
		       iOpType     �������ͣ����ӡ�ɾ������ѯ
		       iPhoneType  �������ͣ�0--������1--����
		       iPhoneNo    �ֻ�����
		       iLoginNo    ��������
		       iOrgCode    ���Ż�������
		       iOpCode     ��������
      		 */

	String opType = request.getParameter("opType");			//��������
	String phoneType = request.getParameter("phoneType");	//��������
	String phoneNo = request.getParameter("phoneNo");	//���ֻ�����
	String workNo = request.getParameter("workNo");	//��������
	String orgCode = request.getParameter("orgCode");		//��������
	String op_code = request.getParameter("opCode");
  String password = (String)session.getAttribute("password"); 
	
	//retArray = callView.sPubSelect("3",sqlStr);
%>

		<wtc:service name="sCustTypeQryF" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=op_code%>" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />

</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
	//result  = (String[][])retArray.get(0);
	String id_iccid= "";
	String id_address= "";
	String sm_name= "";
	if(result!=null&&result.length>0){
		id_iccid= result[0][0];
		id_address= result[0][1];
		sm_name= result[0][2];
		System.out.println("id_iccid========zhenshabi========"+id_iccid);
		System.out.println("id_address========zhenshabi========"+id_address);
		System.out.println("id_iccid========zhenshabi========"+sm_name);
	}
	
	input_paras[0][0] = opType;	 
	input_paras[0][1] = phoneType;	
	input_paras[0][2] = phoneNo;	
	input_paras[0][3] = workNo;
	input_paras[0][4] = orgCode;
	input_paras[0][5] = op_code;
	


 
 	//[0]:��ʼλ��,[1]:����
	recv_num[0][0] = "0";
	recv_num[0][1] = "2";	
	recv_num[1][0] = "2";
	recv_num[1][1] = "7";	


	String region_code = orgCode.substring(0,2);	
	
	for(int i=0; i<input_paras[0].length; i++){
		
		if( input_paras[0][i] == null ){
			input_paras[0][i] = "";
		}
		//System.out.println("["+i+"]="+input_paras[0][i]);
	}

%>
	<wtc:service name="s1110Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="17" >
		<wtc:param value="<%=opType%>"/>
		<wtc:param value="<%=phoneType%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=op_code%>"/>
	</wtc:service>
	
	<wtc:array id="al" start="0" length="2" scope="end"/>
	<wtc:array id="callData" start="2" length="7" scope="end"/>
	
<%
  	//al = oneboss.get_commDyn( region_code, op_code,"s1110Qry",recv_num,input_paras );


 	if( al == null ){
		valid = 1;
	}else{

		//errCodeMsg = (String[][])al.get(0);
		//errorCode = errCodeMsg[0][0];
		errorCode=retCode2;
		//System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhherrorCode=["+errorCode+"]");		
		if(!errorCode.equals("000000")){
			valid = 2;
			//errorMsg = errCodeMsg[0][1];
			errorMsg=retMsg2;
			//System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhherrorMsg=["+errorMsg+"]");
		}else{
			//System.out.println("hhhhhhkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
			valid = 0;
			//callData = (String[][])al.get(1);				
			strArray = WtcUtil.createArray("arrMsg",callData.length);
		}
	}

%>
<%=strArray%>

<% if( valid == 0 ){  %>
<%
for(int i = 0 ; i < callData.length ; i ++){
      for(int j = 0 ; j < callData[i].length ; j ++){

if(callData[i][j].trim().equals("") || callData[i][j] == null){
   callData[i][j] = "";
}
//System.out.println("||---------" + callData[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>


<% } %>


var response = new AJAXPacket();

var id_iccid="<%=id_iccid%>"
var id_address="<%=id_address%>"
var sm_name="<%=sm_name%>"

response.data.add("verifyType","<%= verifyType %>");
response.data.add("phoneType","<%= phoneType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("id_iccid","<%= id_iccid %>");
response.data.add("id_address","<%= id_address %>");
response.data.add("sm_name","<%= sm_name %>");
response.data.add("backArrMsg",arrMsg );

core.ajax.receivePacket(response);


