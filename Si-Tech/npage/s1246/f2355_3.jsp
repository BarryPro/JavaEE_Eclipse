<%
/********************
 version v2.0
 开发商: si-tech
 模块:强制开关机恢复
 update zhaohaitao at 2009.1.6
********************/
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>

<%/*
* 黑龙江BOSS-开关机管理－强制开关机  2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("i1");
  	 
	String regCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");
	//在此处读取session信息
	String password =  (String)session.getAttribute("password");//读取工号密码 
	String outList[][] = new String [][]{{"0","1"}};
	String []  inputParam = new String[13];

%>
<!---------------------------------引用JS--引用页面风格样式表----------------------------->
<%      
	ArrayList retArray = new ArrayList();
	ArrayList getList = new ArrayList();
/*--------------------------------组织s1246Cfm的传入参数-------------------------------*/
	String ilogin_accept = request.getParameter("stream");             //系统流水
	String iop_Code ="2355";                                          //操作代码					 
	String iwork_no = workNo;                                         //操作工号                  
	String iwork_pwd =password;                                       //工号密码						 
	String iorg_code = orgCode;                                       //org_code 
	String icust_id = request.getParameter("oid_no");                 //客户ID
	String icmd_code1 = request.getParameter("icmd_code");  
	System.out.println("33333"+icmd_code1+"4444444");
	String icmd_code = "";											//60,61
	if(icmd_code1.trim().equals("强开"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	//String icmd_code = request.getParameter("icmd_code");            //命令函数
	String inew_runcode = request.getParameter("onew_run");            //新运行状态L,K.
	String ishould_fee = request.getParameter("ishould_fee");          //应交手续费
	String ireal_fee = request.getParameter("ohand_cash");            //实际手续费
	//String isys_note = request.getParameter("sysnote");               //系统备注					 
	String ido_note = request.getParameter("donote");                 //操作备注
	String expDays = request.getParameter("expDays");                 //日期备注
	String ithe_ip = ipAddr;                                          //登陆IP		
	String ret_code = "";
	String ret_msg = "";
	/*String themob = ReqUtil.get(request,"i1");                        //手机号码					 
	String do_string=ReqUtil.get(request,"do_string_add");            //操作命令串  1:申请 2:取消
	String addcash_string=ReqUtil.get(request,"addcash_string");      //可选资费代码串
	String favour = "a017";                                           //优惠代码					 
	String realcash = ReqUtil.get(request,"i19");                     //实际手续费				 
	String fircash = ReqUtil.get(request,"i20");                      //固定手续费				 
	*/
	if(ireal_fee.equals(""))
	ireal_fee = "0";
	if(ishould_fee.equals(""))
	ishould_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                    //手续费单精度
	System.out.println("s1246Cfm:"+icmd_code);
	/*--------------------------------开始调用s1246Cfm--------------------------------*/			                      
	inputParam[0] = ilogin_accept;
	inputParam[1] = iop_Code;
	inputParam[2] = iwork_no;
	inputParam[3] = iwork_pwd;
	inputParam[4] = iorg_code;
	inputParam[5] = icust_id;
	inputParam[6] = icmd_code;
	inputParam[7] = inew_runcode;
	inputParam[8] = ishould_fee;
	inputParam[9] = ireal_fee;
	inputParam[10] = expDays;
	inputParam[11] = ido_note;
	inputParam[12] = ithe_ip;
	
	String stream = "";
	String osm_code=request.getParameter( "osm_code" );
	String svcNm = "s1246Cfm";
	System.out.println("osm_code~~~"+osm_code);
	/**
	if ( osm_code.equals("PB") || osm_code.equals("PA") )
	{
		svcNm = "sWLWInterFace";
	}*/
	

try{                                  
    //result = callWrapper.callService("s1246Cfm",inputParam,"1");   
%>
	<wtc:service name="<%=svcNm%>" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
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
String cardno = request.getParameter("oid_iccid");               //身份证号码
String themob = request.getParameter("i1");			             //移动号码  
String name =  request.getParameter("ocust_name");               //用户名称  
String address = request.getParameter("ocust_addr");		     //用户地址  
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
	 var dirpage="<%=request.getContextPath()%>/npage/s1246/f1246_1.jsp?activePhone=<%=themob%>&opCode=1246&opName=强制开关机"
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
history.go(-1);
</script>
<%}%>



