<%
  /*
   * 功能: 电信管控恢复 d345
   * 版本: 1.0
   * 日期: 2011/3/25
   * 作者: huangrong 
   * 版权: si-tech
   * update:
  */
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
  	 
	String regCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String password =  (String)session.getAttribute("password");//读取工号密码 
	String []  inputParam = new String[16];
%>

<%      
/*--------------------------------组织s1246Cfm的传入参数-------------------------------*/
	String ilogin_accept = request.getParameter("stream");             //系统流水
	String iop_Code ="d345";                                          //操作代码					 
	String iwork_no = workNo;                                         //操作工号                  
	String iwork_pwd =password;                                       //工号密码						 
	String iorg_code = orgCode;                                       //org_code 
	String icust_id = request.getParameter("oid_no");                 //客户ID
	String icmd_code1 = request.getParameter("icmd_code");  
	String icmd_code = "";											//60,61
	if(icmd_code1.trim().equals("强开"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	String inew_runcode = request.getParameter("onew_run");            //新运行状态L,K.
	String ishould_fee = request.getParameter("ishould_fee");          //应交手续费
	String ireal_fee = request.getParameter("ohand_cash");            //实际手续费	 
	String ido_note = request.getParameter("donote");                 //操作备注
	String expDays = request.getParameter("expDays");                 //日期备注
	String ithe_ip = ipAddr;                                          //登陆IP		
	String ret_code = "";
	String ret_msg = "";

	if(ireal_fee.equals(""))
	ireal_fee = "0";
	if(ishould_fee.equals(""))
	ishould_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                    //手续费单精度
	System.out.println("sd344Cfm:"+icmd_code);
	/*--------------------------------开始调用s1246Cfm--------------------------------*/			                      
	inputParam[0] = ilogin_accept;
	inputParam[1] = "01";	
	inputParam[2] = iop_Code;
	inputParam[3] = iwork_no;
	inputParam[4] = iwork_pwd;
	inputParam[5] = phoneNo;	
	inputParam[6] = "";	
	inputParam[7] = orgCode;	
	inputParam[8] = icmd_code;
	inputParam[9] = inew_runcode;	
	inputParam[10] = ishould_fee;
	inputParam[11] = ireal_fee;	
	inputParam[12] = expDays;
	inputParam[13] = ido_note;
	inputParam[14] = ithe_ip;	
	String stream = "";
try{                                   
%>
	<wtc:service name="sd344Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inputParam[0]%>"/>	
	<wtc:param value="<%=inputParam[1]%>"/>	
	<wtc:param value="<%=inputParam[2]%>"/>	
	<wtc:param value="<%=inputParam[3]%>"/>	
	<wtc:param value="<%=inputParam[4]%>"/>	
	<wtc:param value="<%=inputParam[5]%>"/>	
	<wtc:param value="<%=inputParam[6]%>"/>	
	<wtc:param value="<%=inputParam[7]%>"/>	
	<wtc:param value="<%=inputParam[8]%>"/>	
	<wtc:param value="<%=inputParam[9]%>"/>	
	<wtc:param value="<%=inputParam[10]%>"/>	
	<wtc:param value="<%=inputParam[11]%>"/>	
	<wtc:param value="<%=inputParam[12]%>"/>
	<wtc:param value="<%=inputParam[13]%>"/>	
	<wtc:param value="<%=inputParam[14]%>"/>	
	<wtc:param value="<%=inputParam[15]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%

	stream = result[0][0];
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+stream+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	ret_code = retCode1;
	ret_msg = retMsg1;
	System.out.println("test ret_code="+ret_code); 
  System.out.println("test ret_msg="+ret_msg);                             
}
catch(Exception e){
  e.printStackTrace() ;
}


/*------------------------------依据调用服务返回结果进行页面跳转------------------------------*/
%>
<%
/*************************************获得打印发票的参数****************************************/
String cardno = request.getParameter("idIccid");               //身份证号码
String themob = request.getParameter("phoneNo");			             //移动号码  
String name =  request.getParameter("custName");               //用户名称  
String address = request.getParameter("custAddr");		     //用户地址  
String realcash = ireal_fee;   				                     //手续费    
/***********************************************************************************************/
%>
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+='<%=cardno%>'+"|";//身份证号码                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=name%>'+"|";//用户名称                                                
	 infoStr+='<%=address%>'+"|";//用户地址 
	 infoStr+="现金"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="强制开关机。*手续费："+'<%=realcash%>'+"*流水号："+'<%=stream%>'+"|";
	 var dirpage="<%=request.getContextPath()%>/npage/sd344/fd345_1.jsp?activePhone=<%=themob%>&opCode=d345&opName=电信管控恢复"
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirpage);                    
}
</script>


<%if(ret_code.equals("000000")&&handcash>0.0){%>
	<script language="jscript">
		rdShowMessageDialog('操作成功！打印发票.......',2);
		printBill();
	</script>
<%}%>

<%if(ret_code.equals("000000")){%>
	<script language='jscript'>
		rdShowMessageDialog('操作成功！',2);
		removeCurrentTab();
	</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
	<script language='jscript'>
		var ret_code = "<%=ret_code%>";
		var ret_msg = "<%=ret_msg%>";
		rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
		document.location.replace("fd345_1.jsp?activePhone=<%=themob%>&opName=电信管控恢复&opCode=d345");
	</script>
<%}%>




