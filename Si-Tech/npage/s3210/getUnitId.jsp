 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-13 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String regionCode = (String)session.getAttribute("regCode");   
	List al = null;
	//String[][] errCodeMsg = null;
	String[][] callData = null;
	
  	List a2 = null;
  	//String[][] errCodeMsg1= null;
  	String[][] callData1 = null;
  	String[][] callData2 = null;
  
	//boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	int valid1 = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	int valid2 =1 ;//0:��ȷ��1��ϵͳ����2��ҵ�����
	String errorCode="444444";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray="var arrMsg; ";  //must 
	
	String errorCode1="444444";
	String errorMsg1="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	
	String errorCode2="444444";
	String errorMsg2="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray1="var arrMsg1; ";  //must 
	String strArray2="var arrMsg2; ";  //must 
    
  	String verifyType = request.getParameter("verifyType");
	String groupNo = request.getParameter("groupNo");
	String insql="select unit_id||'->'||unit_name from dbvipadm.dGrpCustMsg where unit_code not in (select unit_code from dbvipadm.d_unit_code_09)  and  boss_vpmn_code ='"+groupNo+"'";
	//add baixf 20080904 ��ѯ�ۺ�v��
	String insql1="select trim(field_value) from dgrpusermsgadd where id_no=(select group_id from dvpmngrpmsg where group_no = '" + groupNo+ "') and field_code='ZHWW0' and busi_type='1000' and field_order=0";
  //wuxy add 20090624 ��ȡ���Ų�Ʒ�ʷ�
  String insql2="select count(*) from dvpmngrpmsg a,svpmnlimitfeeindex b where a.interfee=b.feeindex and a.region_code=b.region_code and a.group_no='"+groupNo+"' ";
	//String insql="select group_no||'->'||trim(group_name) from dVPMNGRPMSG where group_no = '"+groupNo+"'";
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=insql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />	
	
	<%
	
	/*try{
   	al = s5010.getCommONESQL(insql,1,0);
	  errorCode="0";
	}
	catch(Exception e){
		e.printStackTrace();
	}*/
	
	
	
  //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
   if( result1 == null ){
		valid = 1;
	}else{
		//errCodeMsg = (String[][])al.get(0);
		//errorCode=errCodeMsg[0][0];
		errorCode=retCode1;
		if( Integer.parseInt(errorCode) != 0 ){
			valid = 2;
			errorMsg= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode));
			//errorMsg= WtcUtil.ISOtoGB(ErrorMsg.getErrorMsg(retCode1));
			
 		}else{
			valid = 0;
			//callData = (String[][])al.get(1);
			callData = result1;
			//System.out.println("callData.length="+callData.length);
			strArray = WtcUtil.createArray("arrMsg",callData.length);
		}
	}
	
	//�����ۺ�v������
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=insql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />	
	
	
	<%
		/*try{
	   	a2 = s5010.getCommONESQL(insql1,1,0);
		  errorCode1="0";
		}
		catch(Exception e){
			e.printStackTrace();
		}*/
	
	  //�������ʹ�����Ϣ�ڴ˴�ͳһ����.
	   if( result2 == null ){
			valid1 = 1;
		}else{
			//errCodeMsg1 = (String[][])a2.get(0);
			//errorCode1=errCodeMsg1[0][0];
			errorCode1=retCode2;
			if( Integer.parseInt(errorCode1) != 0 ){
				valid1 = 2;
				errorMsg1= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode1));
				//errorMsg1= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode1));
	 		}else{
				valid1 = 0;
				//callData1 = (String[][])a2.get(1);
	                        callData1=result2;
				//System.out.println("callData1.length="+callData1.length);
				strArray1 = WtcUtil.createArray("arrMsg1",callData1.length);
			}
		}
		
		//��ȡ��Ʒ���ʷ�
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
	 <wtc:sql><%=insql2%></wtc:sql>
	 </wtc:pubselect>
	 <wtc:array id="result3" scope="end" />
	 	
<%
    if( result3 == null ){
			valid2 = 1;
		}else{
			//errCodeMsg1 = (String[][])a2.get(0);
			//errorCode1=errCodeMsg1[0][0];
			errorCode2=retCode3;
			if( Integer.parseInt(errorCode2) != 0 ){
				valid2 = 2;
				errorMsg2= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode2));
				//errorMsg2= SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errorCode2));
	 		}else{
				valid2 = 0;
				//callData1 = (String[][])a2.get(1);
	                        callData2=result3;
				//System.out.println("callData1.length="+callData2.length);
				strArray2 = WtcUtil.createArray("arrMsg2",callData2.length);
			}
		}
 

		System.out.println("getUnitId.jsp1: valid="+valid);
		System.out.println("getUnitId.jsp: errorCode="+errorCode);
		System.out.println("getUnitId.jsp1: valid1="+valid1);
		System.out.println("getUnitId.jsp: errorCode1="+errorCode1);
		System.out.println("getUnitId.jsp2: valid2="+valid2);
		System.out.println("getUnitId.jsp: errorCode2="+errorCode2);
%>


<%=strArray%>
<%System.out.println(strArray);%>
<%=strArray1%>
<%System.out.println(strArray1);%>
<%=strArray2%>
<%System.out.println(strArray2);%>

<% if( valid == 0 ){  %>

<%
for(int i = 0 ; i < callData.length ; i ++){
      for(int j = 0 ; j < callData[i].length ; j ++){

if(callData[i][j].trim().equals("") || callData[i][j] == null){
   callData[i][j] = "";
}
System.out.println("||---------" + callData[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
  }
}
%>
<% } %>


<% if( valid1 == 0 ){  %>
<%
for(int i = 0 ; i < callData1.length ; i ++){
      for(int j = 0 ; j < callData1[i].length ; j ++){

if(callData1[i][j].trim().equals("") || callData1[i][j] == null){
   callData1[i][j] = "";
}
System.out.println("||---------" + callData1[i][j].trim() + "-------------||");
%>

arrMsg1[<%=i%>][<%=j%>] = "<%=callData1[i][j].trim()%>";
<%
  }
}
%>


<% } %>


<% if( valid2 == 0 ){  %>
<%
for(int i = 0 ; i < callData2.length ; i ++){
      for(int j = 0 ; j < callData2[i].length ; j ++){

if(callData2[i][j].trim().equals("") || callData2[i][j] == null){
   callData2[i][j] = "";
}
System.out.println("callData2["+i+"]["+j+"]"+"||---------" + callData2[i][j].trim() + "-------------||");
%>

arrMsg2[<%=i%>][<%=j%>] = "<%=callData2[i][j].trim()%>";
<%
  }
}
%>


<% } %>



<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>

var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= errorCode1 %>");
response.data.add("errorMsg","<%= errorMsg1 %>");
response.data.add("backArrMsg",arrMsg);
response.data.add("backArrMsg1",arrMsg1);
response.data.add("backArrMsg2",arrMsg2);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>
