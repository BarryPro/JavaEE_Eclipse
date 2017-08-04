<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	  String opCode = "1240";
	  String opName = "呼转设置";	
	  
	  request.setCharacterEncoding("GBK");
		String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
		String loginAccept=WtcUtil.repNull(request.getParameter("loginAccept"));
		String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
		String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
		String user_id=WtcUtil.repNull(request.getParameter("user_id"));
		String next_no=WtcUtil.repNull(request.getParameter("next_no"));
	  String op_type=WtcUtil.repNull(request.getParameter("s_optype"));
		String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	 	String callType=WtcUtil.repNull(request.getParameter("callType"));
	 	
	 	System.out.println("callType:" + callType);
	 	
		String work_no = (String)session.getAttribute("workNo");
		String loginName = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String op_code = "1240";
		String nopass = (String)session.getAttribute("password");
		String iUserPwd = "";  /*号码密码*/
		String iChnSource = "01"; /*渠道标识*/
 		String paraStr[]=new String[16];
		paraStr[0]=loginAccept;		//流水(可以输入，如果不输入则在服务中取流水)    
		paraStr[1]=iChnSource;		/*渠道标识*/                   
		paraStr[2]=op_code;			//功能代码                                                       
		paraStr[3]=work_no;			//操作工号                                                       
		paraStr[4]=nopass;		//经过加密的工号密码 
		paraStr[5]=srv_no;			//用户手机号码 
		paraStr[6]=iUserPwd;			/*号码密码*/                                          
		paraStr[7]=org_code;			//操作工号归属                                                                                             
		paraStr[8]=op_type;		    //操作类型(1_增加, 0_	取消)                                      
		paraStr[9]=callType;		//命令代码()                                                     
		paraStr[10]=next_no;		//呼转号码                                                           
		paraStr[11]=WtcUtil.repNull(request.getParameter("oriHandFee"));			//应收           
		paraStr[12]=WtcUtil.repNull(request.getParameter("t_handFee"));			//实收                
		paraStr[13]=WtcUtil.repNull(request.getParameter("t_sys_remark"));		//系统备注           
		paraStr[14]=WtcUtil.repSpac(request.getParameter("t_op_remark")); 			//用户备注                                  
		paraStr[15]=request.getRemoteAddr();			//IP地址    
	
	  //String [] fg=im1210.callService("s1240Cfm",paraStr,"1","phone",srv_no);
%>
		<wtc:service name="s1240Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="16" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>	
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/>
		<wtc:param value="<%=paraStr[12]%>"/>	
		<wtc:param value="<%=paraStr[13]%>"/>						
	  <wtc:param value="<%=paraStr[14]%>"/>	
		<wtc:param value="<%=paraStr[15]%>"/>										
		</wtc:service>
		<wtc:array id="s1240CfmArr" scope="end"/>
<%  
	  System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
		String cnttLoginAccept = s1240CfmArr.length>0?s1240CfmArr[0][0]:"";
		String cnttActivePhone = srv_no;
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+srv_no+"&contactType=user";
	  System.out.println("--------------url----:"+url);		
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
	 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
	  System.out.println("Double.parseDouble" + Double.parseDouble(((paraStr[11].trim().equals(""))?("0"):(paraStr[11]))));
%>

<%	 	
		String retCode= retCode1;
		String retMsg = retMsg1;
    if(Integer.parseInt(retCode)==0||Integer.parseInt(retCode)==000000){
	 	  if(Double.parseDouble(((paraStr[11].trim().equals(""))?("0"):(paraStr[11])))<0.01){
%>
        <script>
	     		rdShowMessageDialog("用户<%=cust_name%>(<%=srv_no%>)办理成功！",2);  
         	location="s1240Main.jsp?activePhone=<%=srv_no%>";
	    	</script>
<%
	  }else{
%>
        <script>
		     		rdShowMessageDialog("用户<%=cust_name%>(<%=srv_no%>)呼转业务办理成功，下面将打印发票！");
	 		 			var infoStr="";
	     		 infoStr+="<%=ic_no%>"+"|";
         	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			     infoStr+="<%=srv_no%>"+"|";
			     infoStr+=" "+"|";
			     infoStr+="<%=cust_name%>"+"|";
			     infoStr+="<%=cust_addr%>"+"|";
		   		 infoStr+="现金"+"|";
		       infoStr+="<%=paraStr[11]%>"+"|";

	         infoStr+="呼转 *手续费："+"<%=paraStr[11]%>"+"*流水号："+"<%=cnttLoginAccept%>"+"|";
		       location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=s1240Login.jsp&activePhone=<%=srv_no%>";
	    </script>
<%
	  }
   }else{
%>
     <script>
		   rdShowMessageDialog('错误<%=retMsg%>：'+'<%=retCode%>，请重新操作！');
		   location="s1240Main.jsp?activePhone=<%=srv_no%>";
		 </script>
<%
   }
%>
