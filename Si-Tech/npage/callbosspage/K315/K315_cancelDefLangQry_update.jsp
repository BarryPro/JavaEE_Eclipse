<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
     String languagetype = request.getParameter("languagetype"); 
     String telphoneno   = request.getParameter("telphoneno");
     String contactID    = request.getParameter("contactID");
     String workName     = request.getParameter("workName");
     String wordNo       = request.getParameter("wordNo");
     System.out.println(telphoneno+workName+wordNo);
     String phoneno      = telphoneno;
     languagetype        = languagetype + "";
     telphoneno          = "telphoneno="+ telphoneno;
     boolean  update_flag = false;

     String sqlInsert ="insert into t_sce_telinfo_crm (telphoneno,partid,languagetype,selectcount)values(" + phoneno +  "," + phoneno.substring(2,3) + "," + languagetype +"," + "2"  + ")";
     System.out.println("sqlInsert--->" + sqlInsert);
%>           	
     <wtc:service name="sPubModifyKfCfm" outnum="2">
	  <wtc:param value="<%=sqlInsert%>"/>
	  <wtc:param value="dbchange"/>
	  <wtc:param value="<%=phoneno%>"/>
     </wtc:service> 
     <wtc:array id="rowsDel4"  scope="end"/>           
<%            
     String[][] s=rowsDel4;
     if(s[0][0].equals("000000")) System.out.println("<<<<<<    sqlInsert Sucessfully    >>>>>>");
     String sqlSysdate= "select to_char(sysdate,'yyyymm') from dual";
%>
		 <wtc:service name="TlsPubSelCrm" outnum="2">
		    <wtc:param value="<%=sqlSysdate%>"/>
			  </wtc:service> 
		 <wtc:array id="systime"  scope="end"/>
<%
     String LogFileName = "dbcalladm.wKFOprLog";
	   String[][] sysdate=systime;

     if(sysdate.length!=0)
     {
         System.out.println("sysdate[0][0]"+sysdate[0][0]);
         LogFileName = LogFileName + sysdate[0][0]; 
     }
      String SERIALNO = telphoneno +""; 
      String OPER_DATE = request.getParameter("OPER_DATE"); 
      String LOGIN_NO = wordNo;
      String KF_LOGIN_NO = wordNo;
      String LOGIN_NAME = workName;
      String IPADDRESS = request.getParameter("IPADDRESS"); 
      String GRADE_CODE ="k315";
      String sqlWriteLog = "insert into " +  LogFileName ;
      sqlWriteLog = sqlWriteLog + " t (t.SERIALNO,t.LOGIN_NO,t.OPER_DATE,t.KF_LOGIN_NO,t.LOGIN_NAME,t.GRADE_CODE)";
      sqlWriteLog = sqlWriteLog + " values(Lpad(dbcalladm.sbaseid.nextval,20,'0'),:LOGIN_NO,sysdate,:KF_LOGIN_NO,:LOGIN_NAME,:GRADE_CODE)";
      System.out.println("sqlWriteLog \n"+sqlWriteLog);
%> 
			<wtc:service name="sPubModifyKfCfm" outnum="3">
			  <wtc:param value="<%=sqlWriteLog%>"/>
			  <wtc:param value="dbchange"/>
				<wtc:param value="<%=LOGIN_NO%>"/>  	
			  <wtc:param value="<%=KF_LOGIN_NO%>"/> 
			  <wtc:param value="<%=LOGIN_NAME%>"/>
			  <wtc:param value="<%=GRADE_CODE%>"/> 			  	
			</wtc:service> 
		  <wtc:array id="WriteLogFlag"  scope="end"/>
<%
	   String[][] WriteLog=WriteLogFlag;
     if(WriteLog.length!=0)
     {
         System.out.println("WriteLogFlag[0][0]"+WriteLog[0][0]);
     }
%>
			var response = new AJAXPacket();
			response.data.add("retCode","<%=s[0][0]%>");
			core.ajax.receivePacket(response);

