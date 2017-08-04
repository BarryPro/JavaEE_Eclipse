<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
        /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String myParamsOld="";
    String myParamsLast="";
    //String org_code = (String)session.getAttribute("orgCode");
 	  //String regionCode = org_code.substring(0,2);
    String retType = WtcUtil.repNull(request.getParameter("retType"));
		String workNo = WtcUtil.repNull(request.getParameter("work1No"));
		/*add wangyong 20090914 增加传入boss工号，不直接在session中获取，防止session失效后签出日志记录错误*/
		String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));  //取login_no		
		String sql= "select to_char(max(SERIAL_NO)) from DLOGINLOG "+
		"where LOGIN_NO=:loginNo  and KF_LOGIN_NO=:workNo ";
		myParams="loginNo="+loginNo+",workNo="+workNo;
		String sqlOld="select to_char(SIGN_IN_TIME,'yyyy-mm-dd hh24:mi:ss') from DLOGINLOG "+
		"where SERIAL_NO=:VSERIAL_NOOLD";
		String sqlLast="select to_char(SIGN_OUT_TIME,'yyyy-mm-dd hh24:mi:ss') from DLOGINLOG "+
		"where SERIAL_NO=:VSERIAL_NOLAST";
		String updatSql="update DLOGINLOG set SIGN_OUT_TIME=sysdate, ";
		String getCurrentDate="select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual";
%>
<%!
		public long getTime(String startTime)
		{
		  java.text.SimpleDateFormat   df   = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			long online_time=0;
			long s=0;
			Date ilog_time=null;
			try
			{
		  ilog_time=df.parse(startTime);
      Date olog_time=new Date();
      online_time=olog_time.getTime()-ilog_time.getTime();
      s=(long)online_time/1000;
		  }
		  catch(Exception e)
		  {
			
		  }

      return s;
		}
%>
<%!
	  public long getTime1(String startTime,String endTime)
		{
		  java.text.SimpleDateFormat   df   = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			long online_time=0;
			long s=0;
			Date ilog_time=null;
			Date olog_time=null;
			try
			{
		  ilog_time=df.parse(startTime);
      olog_time=df.parse(endTime);
      online_time=olog_time.getTime()-ilog_time.getTime();
      s=(long)online_time/1000;
		  }
		  catch(Exception e)
		  {
			
		  }

      return s;
		}


%>
<wtc:service name="TlsPubSelCrm" outnum="3">
<wtc:param value="<%=sql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>
	


	<%
	  if(queryList.length>0){
	   sql=  sql+" and SERIAL_NO<:VSERIAL_NO";
	   myParams+=",VSERIAL_NO="+queryList[0][0];
	   //sqlOld=sqlOld+queryList[0][0]+"'";
	   myParamsOld="VSERIAL_NOOLD="+queryList[0][0];
	 %>
				<wtc:service name="TlsPubSelCrm" outnum="3">
				<wtc:param value="<%=sqlOld%>"/>
				<wtc:param value="<%=myParamsOld%>"/>
				</wtc:service>
				<wtc:array id="queryOld"  scope="end"/>
	 
				<wtc:service name="TlsPubSelCrm" outnum="3">
				<wtc:param value="<%=sql%>"/>
				<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="queryList1"  scope="end"/>
					
				<wtc:service name="TlsPubSelCrm" outnum="3">
				<wtc:param value="<%=getCurrentDate%>"/>
				</wtc:service>
				<wtc:array id="querySysDate"  scope="end"/>
			<%  
	      long mi=0;
	      
				if(queryList1.length>0&&queryOld.length>0){
		   		if(queryList1[0][0].equals("")){
		   				 mi=getTime1(queryOld[0][0],querySysDate[0][0]);
		   				 updatSql=updatSql+" SIGN_IN_TIME_LONG=:v1 where SERIAL_NO=:v2";
		   				 System.out.println(updatSql);
		%>
							<wtc:service name="sPubModifyKfCfm" outnum="2" >
							<wtc:param value="<%=updatSql%>"/>
							<wtc:param value="dbchange"/>
							<wtc:param value="<%=mi+""%>"/>
							<wtc:param value="<%=queryList[0][0]%>"/>
					    </wtc:service>
					    <wtc:array id="rows"  scope="end"/>
		<%  
			 		    if(rows[0][0].equals("000001")){
		     				retCode = "000001";
		     				retMsg = "保存关系失败1";
		 					 }
		 		    }
		 		    else{
		 		    	//sqlLast=sqlLast+queryList1[0][0]+"'";
		 		    	myParamsLast="VSERIAL_NOLAST="+queryList1[0][0];
		 		    	
		 %>
		 					<wtc:service name="TlsPubSelCrm" outnum="3">
							<wtc:param value="<%=sqlLast%>"/>
							<wtc:param value="<%=myParamsLast%>"/>
							</wtc:service>
							<wtc:array id="queryLast"  scope="end"/>
		 
		 <%
		 						if(queryLast.length>0){
		 						long intime=getTime1(queryOld[0][0],querySysDate[0][0]);
		 						long outtime=getTime1(queryLast[0][0],queryOld[0][0]);
		 						updatSql=updatSql+" SIGN_IN_TIME_LONG=:v1 ,  SIGN_OUT_TIME_LONG=:v2 where SERIAL_NO=:v3";
		 	          
		 	          String initime_s = intime+"";
		 	          String outtime_s = outtime+"";
		 	          String seri_s = queryList[0][0];
		 	%>
									<wtc:service name="sPubModifyKfCfm" outnum="2" >
									<wtc:param value="<%=updatSql%>"/>
									<wtc:param value="dbchange"/>
									<wtc:param value="<%=initime_s%>"/>
									<wtc:param value="<%=outtime_s%>"/>
									<wtc:param value="<%=seri_s%>"/>
					    		</wtc:service>
					        <wtc:array id="rowsLast"  scope="end"/>	
		 	
		 	<%
		 							if(rowsLast[0][0].equals("000001")){
			     				retCode = "000001";
		     				  retMsg = "保存关系失败1";	 							
		 							}
		 						
		 						}
		 				}
	
				}
	  }     
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);




