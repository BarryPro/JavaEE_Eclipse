<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
	public  String getCurrDateStr(String format) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				format);
		return objSimpleDateFormat.format(new java.util.Date());
	}
%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  String handlingDept=(String)session.getAttribute("groupId");//�鵵����
	String handlingStaff=(String) session.getAttribute("workNo");//�鵵Ա��
	String handlingComment="�ֶ��鵵";//�鵵���
	String handlingTime=getCurrDateStr("yyyy-MM-dd HH:mm:ss");//�鵵ʱ��
	String operType="HANDLING";//��������
	String logType="s4g05Snd";//�ӿ�����  
  
  String indictSeq = request.getParameter("indictSeq");

  String indictSeqphone = request.getParameter("indictSeqphone");
  
  String jsontext = request.getParameter("jsontext");
  
  String resultStrss = request.getParameter("resultStrss");
  String guidangflag = request.getParameter("guidangflag");
  
  


	String  inputParsm [] = new String[12];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = indictSeqphone;
	inputParsm[6] = "";


String retCodes="000000";
try{	
%>
	<wtc:service name="s4g05Snd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="2">
		<wtc:param value="<%=indictSeq%>"/>
		<wtc:param value="<%=handlingDept%>"/>
		<wtc:param value="<%=handlingStaff%>"/>
		<wtc:param value="<%=handlingComment%>"/>
		<wtc:param value="<%=handlingTime%>"/>
		<wtc:param value="<%=handlingStaff%>"/>
		<wtc:param value="<%=handlingDept%>"/>
	</wtc:service>
	<wtc:array id="userMsg" scope="end"/>
<%
  }catch(Exception e){
    retCodes="999999";
	}

String dateStr =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());		
String e828retcodes="000000";
String e828retmsgs="�ɹ�";
if("000000".equals(retCodes)){
		String[] inputParamssss = new String[15];
		inputParamssss[0] = "";
		inputParamssss[1] = "01";
		inputParamssss[2] = "e827";
		inputParamssss[3] = workNo;
		inputParamssss[4] = password;
		inputParamssss[5] = indictSeqphone;
		inputParamssss[6] = "";
		inputParamssss[7] = dateStr;
		inputParamssss[8] = "99";
		inputParamssss[9] = "02003";
		inputParamssss[10] = resultStrss;
		inputParamssss[11] ="";
    inputParamssss[12] ="";
		inputParamssss[13] = "451";
		inputParamssss[14] = jsontext;
	
	 try{	
%>
		<wtc:service name="sE828Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodee828" retmsg="retMsge828" outnum="1">
				<wtc:param value="<%=inputParamssss[0]%>"/>
				<wtc:param value="<%=inputParamssss[1]%>"/>
				<wtc:param value="<%=inputParamssss[2]%>"/>
				<wtc:param value="<%=inputParamssss[3]%>"/>
				<wtc:param value="<%=inputParamssss[4]%>"/>
				<wtc:param value="<%=inputParamssss[5]%>"/>
				<wtc:param value="<%=inputParamssss[6]%>"/>
				<wtc:param value="<%=inputParamssss[7]%>"/>
				<wtc:param value="<%=inputParamssss[8]%>"/>
				<wtc:param value="<%=inputParamssss[9]%>"/>
				<wtc:param value="<%=inputParamssss[10]%>"/>
				<wtc:param value="<%=inputParamssss[11]%>"/>
				<wtc:param value="<%=inputParamssss[12]%>"/>
				<wtc:param value="<%=inputParamssss[13]%>"/>
				<wtc:param value="<%=inputParamssss[14]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
e828retcodes=retCodee828;
e828retmsgs=retMsge828;

  		}catch(Exception ex){
			e828retcodes ="-1";
			e828retmsgs="����sE828Cfm��¼������־ʧ�ܣ�";
		 }	

}	

	if(!"000000".equals(e828retcodes)){

%>
  	<script language="javascript">
 	    rdShowMessageDialog("����sE828Cfm��¼������־ʧ�ܣ��������<%=e828retcodes%>������ԭ��<%=e828retmsgs%>",0);
 	  </script>
<%
	}

  
	if("000000".equals(retCodes)){

%>	
    <script language="javascript">
 	      rdShowMessageDialog("�鵵�����ɹ���",2);
 	      <%
 	      if("1".equals(guidangflag)) {
 	      %>
 	      removeCurrentTab();
 	      <%
 	    }else {
 	      %>
 	      window.location="fe827_1.jsp?activePhone=<%=indictSeqphone%>";
 	      <%}%>
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("�鵵����ʧ�ܣ�",0);
 		   	      <%
 	      if("1".equals(guidangflag)) {
 	      %>
 	      removeCurrentTab();
 	      <%
 	    }else {
 	      %>
 	      window.location="fe827_1.jsp?activePhone=<%=indictSeqphone%>";
 	      <%}%>
 	  </script>
<%
	}
%>
