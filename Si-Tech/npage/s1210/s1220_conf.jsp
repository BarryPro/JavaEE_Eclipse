<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080919
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");

  String op_name="";
  String op_code = request.getParameter("op_code");
  String oaNum = "";
  if(op_code.equals("1220")){
    op_name="换卡变更";
  	oaNum = WtcUtil.repStr(request.getParameter("oaNum"),"");
  }
  else if(op_code.equals("1217")){
    op_name="预销恢复";
  }
  else if(op_code.equals("1260")){
    op_name="预拆恢复";
  }

%>


 <%
    String srv_no=request.getParameter("srv_no");
	String cus_name=WtcUtil.repNull(request.getParameter("cus_name"));
    String cus_addr=WtcUtil.repNull(request.getParameter("cus_addr"));
    String cus_id=WtcUtil.repNull(request.getParameter("cus_id"));
   
  /**
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String nopass = ((String[][])arrSession.get(4))[0][0];

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
   	String paraStr[]=new String[24];
   	**/
   	
	String opCode = op_code;
	String opName = op_name;
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");
	String smCode = WtcUtil.repNull(request.getParameter("simCodeHide"));
	String paraStr[]=new String[27];
 
	paraStr[0]=WtcUtil.repNull(request.getParameter("loginAccept"));
 	paraStr[1]=op_code;
 	paraStr[2]=work_no;
	paraStr[3]=nopass;
	paraStr[4]=org_code;
    paraStr[5]=WtcUtil.repNull(request.getParameter("cus_id"));
  	paraStr[6]=WtcUtil.repNull(request.getParameter("simOldNo"));
	paraStr[7]=WtcUtil.repNull(request.getParameter("s_oldStatus"));
	paraStr[8]=WtcUtil.repNull(request.getParameter("t_newsimf"));
 	paraStr[9]=WtcUtil.repNull(request.getParameter("oriSimFee"));
	paraStr[10]=WtcUtil.repNull(request.getParameter("t_simFeef"));
 	paraStr[11]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[12]=WtcUtil.repNull(request.getParameter("t_handFee"));
    paraStr[13]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
    paraStr[14]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[15]=request.getRemoteAddr();

	paraStr[16]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[17]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[18]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[19]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[20]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[21]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[22]=WtcUtil.repNull(request.getParameter("assuNote"));
	paraStr[23]=request.getParameter("cardtype_bz");
	paraStr[24]=request.getParameter("cardstatus");
	paraStr[25]=request.getParameter("cardNO");
	System.out.println("gaopengSeelog1220~~~~~~~~~~~~~~smCode~~"+smCode);
	if("铁通e固话".equals(smCode)){
		System.out.println("gaopengSeelog1220~~~~~~~~~~~~~~simTypeOne~~"+WtcUtil.repNull(request.getParameter("simTypeOne")));
		paraStr[26]=WtcUtil.repNull(request.getParameter("simTypeOne"));
	}else{
		paraStr[26]="";
	}
	
	
  
    String totalFee=String.valueOf(Double.parseDouble(((paraStr[10].trim().equals(""))?("0"):(paraStr[10])))+Double.parseDouble(((paraStr[12].trim().equals(""))?("0"):(paraStr[12]))));
	// SPubCallSvrImpl co=new SPubCallSvrImpl();

	//String[] fg=co.callService("s1220Cfm",paraStr,"3","phone",srv_no);
	//int retCode =  co.getErrCode();
	//String retMsg = co.getErrMsg();
	%>
			<wtc:service name="s1220Cfm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="retCode" retmsg="retMsg"  outnum="3" >
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
			<wtc:param value="<%=paraStr[16]%>"/>
			<wtc:param value="<%=paraStr[17]%>"/>
			<wtc:param value="<%=paraStr[18]%>"/>
			<wtc:param value="<%=paraStr[19]%>"/>
			<wtc:param value="<%=paraStr[20]%>"/>
			<wtc:param value="<%=paraStr[21]%>"/>
			<wtc:param value="<%=paraStr[22]%>"/>
			<wtc:param value="<%=paraStr[23]%>"/>
			<wtc:param value="<%=paraStr[24]%>"/>
			<wtc:param value="<%=paraStr[25]%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=paraStr[26]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
			<%
			if(op_code.equals("1220")){
				String [] inputParam = new String [8] ;
				inputParam[0] = WtcUtil.repNull(request.getParameter("loginAccept"));
				inputParam[1] = "01";
				inputParam[2] = op_code;
				inputParam[3] = work_no;
				inputParam[4] = nopass;
				inputParam[5] = srv_no;
				inputParam[6] = "";
				inputParam[7] = oaNum;
			%>
				<wtc:service name="sTestCardOpr" routerKey="region" retcode="retCode1" retmsg="retMsg1" routerValue="<%=regionCode%>" outnum="1" >
					<wtc:param value="<%=inputParam[0]%>"/>
					<wtc:param value="<%=inputParam[1]%>"/>
					<wtc:param value="<%=inputParam[2]%>"/>
					<wtc:param value="<%=inputParam[3]%>"/>
					<wtc:param value="<%=inputParam[4]%>"/>
					<wtc:param value="<%=inputParam[5]%>"/>
					<wtc:param value="<%=inputParam[6]%>"/>
					<wtc:param value="<%=inputParam[7]%>"/>
				</wtc:service>
				<wtc:array id="retResult1" scope="end"/>
			<%}
String iLoginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));	
String iOpCode = 		"1220";
String iLoginNo = 		"";
String iLoginPwd = 		"";
String iPhoneNo = 		srv_no;	
String iUserPwd = 		"";
String inOpNote = 		"";
String iBookingId = 	"";

System.out.println("zhangyan add   iLoginAccept = ["+iLoginAccept+"]");
System.out.println("zhangyan add   iOpCode = ["+iOpCode+"]");
System.out.println("zhangyan add   iLoginNo = ["+iLoginNo+"]");
System.out.println("zhangyan add   iLoginPwd = ["+iLoginPwd+"]");
System.out.println("zhangyan add   iPhoneNo = ["+iPhoneNo+"]");
System.out.println("zhangyan add   iUserPwd = ["+iUserPwd+"]");
System.out.println("zhangyan add   inOpNote = ["+inOpNote+"]");
System.out.println("zhangyan add   iBookingId = ["+iBookingId+"]");

String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
	+"&iLoginNo="+iLoginNo
	+"&iLoginPwd="+iLoginPwd
	+"&iPhoneNo="+iPhoneNo
	+"&iUserPwd="+iUserPwd
	+"&inOpNote"+inOpNote
	+"&iLoginAccept="+iLoginAccept
	+"&iBookingId="+iBookingId;		
System.out.println("booking_url="+booking_url);
%>
<jsp:include page="<%=booking_url%>" flush="true" />
<%
System.out.println("%%%%%%%调用预约服务结束%%%%%%%%"); 


System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
			String retCodeForCntt = retCode ;
			String loginAccept =WtcUtil.repNull(request.getParameter("loginAccept")); 
			
			String url = "/npage/contact/upCnttInfo.jsp"
				+"?opCode="+opCode
				+"&retCodeForCntt="+retCode
				+"&opName="+opName
				+"&workNo="+work_no
				+"&loginAccept="+loginAccept
				+"&pageActivePhone="+srv_no
				+"&opBeginTime="+opBeginTime
				+"&contactId="+srv_no
				+"&contactType=user";;
			System.out.println("url="+url);
			
			
			%>
			<jsp:include page="<%=url%>" flush="true" />
			<%
System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	
	
	   if(retCode.equals("0")||retCode.equals("000000")){
          System.out.println("调用服务sa220CfmEx in sa220_conf.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	             
 	    String statisLoginAccept =loginAccept; /*流水*/
		String statisOpCode=opCode;
		String statisPhoneNo= srv_no;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	String statisUrl1 = "/npage/public/pubSendNPS.jsp"
	  			+"?statisLoginAccept="+statisLoginAccept
	  			+"&statisOpCode="+statisOpCode
	  			+"&statisPhoneNo="+statisPhoneNo;
   		if (statisOpCode.equals("1220"))
		{
		%>
		<jsp:include page="<%=statisUrl1%>" flush="true" />
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}		
 	             
 	             
								 	  if(Double.parseDouble(totalFee)<0.01)    
								 	  {
								%>
								        <script>
									     rdShowMessageDialog("客户<%=cus_name%>(<%=cus_id%>)<%=op_name%>已成功！");
								         location="s1220.jsp?op_code=<%=op_code%>&activePhone=<%=srv_no%>";
									    </script>
								<%
									  }
									  else
									  {
								%>
								        <script>
									var  billArgsObj = new Object();
							 		$(billArgsObj).attr("10001","<%=work_no%>");       //工号
							 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
							 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
							 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
							 		$(billArgsObj).attr("10005","<%=cus_name%>"); //客户名称
							 		$(billArgsObj).attr("10006","<%=op_name%>"); //业务类别
							 		$(billArgsObj).attr("10008","<%=srv_no%>"); //用户号码
							 		$(billArgsObj).attr("10015", "<%=totalFee%>"); //本次发票金额(小写)￥
							 		$(billArgsObj).attr("10016", "<%=totalFee%>"); //大写金额合计
							 		var sumtypes1="*";
							 		var sumtypes2="";
							 		var sumtypes3="";
							 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
							 		$(billArgsObj).attr("10018",sumtypes2); //支票
							 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
							 		$(billArgsObj).attr("10021","<%=paraStr[12]%>"); //手续费
							 		$(billArgsObj).attr("10024","<%=paraStr[10]%>"); //SIM卡费
							 		$(billArgsObj).attr("10030","<%=request.getParameter("loginAccept")%>"); //流水号--业务流水
							 		$(billArgsObj).attr("10036","<%=op_code%>"); //操作代码
							 		
							 		$(billArgsObj).attr("10041","SIM卡"); //品名规格     
							 		$(billArgsObj).attr("10042","张"); //单位         
							 		$(billArgsObj).attr("10043","1"); //数量         
							 		$(billArgsObj).attr("10044","<%=paraStr[10]%>"); //单价         
							 		$(billArgsObj).attr("10061","<%=WtcUtil.repSpac(request.getParameter("simType"))%>"); //sim卡型号
							 		$(billArgsObj).attr("10071","7"); //模版
								  	var h=210;
									var w=400;
									var t=screen.availHeight/2-h/2;
									var l=screen.availWidth/2-w/2;
									var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
									
									
			//发票项目修改为新路径
			$(billArgsObj).attr("11214","HID_PR");	 //隐藏收据按钮
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=客户<%=cus_name%>(<%=cus_id%>)<%=op_name%>已成功，下面将打印发票！";


									var loginAccept = "<%=request.getParameter("loginAccept")%>";
									var path = path +"&loginAccept="+loginAccept+"&opCode=1220&submitCfm=Single";
									var ret = window.showModalDialog(path,billArgsObj,prop);
									location="<%=request.getContextPath()%>/npage/s1210/s1220.jsp?op_code=<%=op_code%>&activePhone=<%=srv_no%>";
									 </script>
								<%
									  }
 	        	
 	     	}else{
 	         	System.out.println(retCode+"    retCode");
 	     		System.out.println(retMsg+"    retMsg");
 		    	System.out.println("调用服务s1220CfmEx in s1220_conf.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 		    	%>
				     <script>
					   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！');
					  location="s1220.jsp?op_code=<%=op_code%>&activePhone=<%=srv_no%>";
					 </script>
				<%
 			}
%>
