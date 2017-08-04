<%
  /*
   * 功能: 短信发送
   * update yinzx 20090827 修改   1.修改服务
   *
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    String opCode="K083";
    String opName="短信发送";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String user_phone = (String)request.getParameter("user_phone");
	  String msg_content = (String)request.getParameter("msg_content");
	  String send_login_no = (String)session.getAttribute("kfWorkNo");
	  String con_id     =  (String)request.getParameter("con_id");
	  String logSql ="";
    List sqlList=new ArrayList();
		String[] sqlArr = new String[]{};
		
	  if(con_id==null){
	  	con_id = "";
	  }
	  String strAcceptLogSql="";
	
 
	  
 
	  String scucc_flag = "1";
	  /* modify by yinzx 20090827   */


    
	   String[] user_phone_arr = null;
	   if(null!=user_phone&&!("".equals(user_phone))){
	  	  user_phone_arr = user_phone.split(",");
	    }	
	    
 	 
    
	     
   for(int i=0;i<user_phone_arr.length;i++){
       /**logSql="insert into sms_push_rec_log(serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no,serv_code)  select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'),'"+user_phone_arr[i]+"','10086',sysdate,'"+msg_content+"','1','"+loginNo+"','"+opCode+"'  from  dual ";
       */
       logSql="insert into sms_push_rec_log(serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no,serv_code)  select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'), :v1,'10086',sysdate, :v2,'1', :v3, :v4  from  dual ";
       logSql+= "&&"+user_phone_arr[i]+"^"+msg_content+"^"+loginNo+"^"+opCode;
	     if(user_phone_arr[i].length()!=11){
           	    scucc_flag = "-2";
           	   %>  	
           	        rdShowMessageDialog("您输入的号码<%=user_phone_arr[i]%>不正确！");  
           	   <%	
         	logSql="";   	
     	  }
     	  
     	 sqlList.add(logSql);
     }
     
      if(scucc_flag.equals("1"))   
   {
      sqlArr = (String[])sqlList.toArray(new String[0]);
      String regionCode = orgCode.substring(0,2); 
    %>    
 				<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:param value=""/>
				    <wtc:param value="dbchange"/>
				    <wtc:params value="<%=sqlArr%>"/>
				</wtc:service>
		<%
		   if(!"000000".equals(retCode))
       { 
              scucc_flag = "-1";
           	   %>  	
           	        rdShowMessageDialog("插入短信日志表出错！");  
           	   <%	       	   	
       }
    
   }  
  
   if(scucc_flag.equals("1"))   
   {
              
%>
	     <wtc:service name="sK083InsertNew" outnum="2">
	     	 <wtc:param value="<%=msg_content%>" />
	       <wtc:param value="<%=opCode%>" />
	       <wtc:param value="<%=loginNo%>" />
	       <wtc:params value="<%=user_phone_arr%>" />
 	
	     </wtc:service>
	     <wtc:array id="retList" scope="end" />
<%   
  
 
			 if(!"000000".equals(retCode)){
	     		scucc_flag = "0";
         }
    } 
  
   		 
 
    
     
%>



				var response = new AJAXPacket();
				response.data.add("scucc_flag",<%=scucc_flag%>);
				core.ajax.receivePacket(response);
