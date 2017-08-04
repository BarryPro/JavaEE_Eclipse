<%
  /*
   * 功能: 电信管控 d344
   * 版本: 1.0
   * 日期: 2011/3/25
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
 <% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="d344";
	String opName="电信管控";
	String iwork_no =(String)session.getAttribute("workNo");//工号
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String iwork_pwd =(String)session.getAttribute("password");//工号密码		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//登陆IP	
	String regionCode = (String)session.getAttribute("regCode");
	String ilogin_accept = ReqUtil.get(request,"stream");
%>
	
<%			             
	String icmd_code1 = ReqUtil.get(request,"icmd_code");  //命令代码
	String icmd_code = "";											  //60,61
	if(icmd_code1.trim().equals("强开"))
	{
		System.out.println("11111111111111111111111");
		icmd_code="60";
	}else{
		System.out.println("22222222222222222222222");
		icmd_code="61";
	}

	String inew_runcode = ReqUtil.get(request,"onew_run");             //新运行状态L,K.
	String ishould_fee = ReqUtil.get(request,"ishould_fee");           //应交手续费
	String ireal_fee = ReqUtil.get(request,"ohand_cash");              //实际手续费
				 
	String ido_note = ReqUtil.get(request,"opNote");                   //操作备注
	String expDays = ReqUtil.get(request,"expDays");                   //日期备注	
	String ret_code = "";
	String ret_msg = "";
	String cardno = ReqUtil.get(request,"idIccid");                    //身份证号码
	String themob = ReqUtil.get(request,"phoneNo");					           //移动号码  
	String name =   ReqUtil.get(request,"custName");                   //用户名称  
	String address =  ReqUtil.get(request,"custAddr");			           //用户地址 	

	if(ireal_fee.equals(""))
	ireal_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                     //手续费单精度
System.out.println("1246Cfm:"+ilogin_accept);
System.out.println("1246Cfm:"+opCode);
System.out.println("1246Cfm:"+iwork_no);
System.out.println("1246Cfm:"+iwork_pwd);
System.out.println("1246Cfm:"+themob);
System.out.println("1246Cfm:"+hdorg_code);
System.out.println("1246Cfm:"+icmd_code);
System.out.println("1246Cfm:"+inew_runcode);
System.out.println("1246Cfm:"+ishould_fee);
System.out.println("1246Cfm:"+ireal_fee);
System.out.println("1246Cfm:"+expDays);
System.out.println("1246Cfm:"+ido_note);
System.out.println("1246Cfm:"+hdthe_ip);
													
	/*--------------------------------开始调用s1246Cfm--------------------------------*/			                      
%>	
	<wtc:service name="sd344Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=ilogin_accept%>"/>
		<wtc:param value="01"/>						
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=iwork_no%>"/>
		<wtc:param value="<%=iwork_pwd%>"/>
		<wtc:param value="<%=themob%>"/>			
		<wtc:param value=" "/>					
		<wtc:param value="<%=hdorg_code%>"/>
		<wtc:param value="<%=icmd_code%>"/>						
		<wtc:param value="<%=inew_runcode%>"/>							
		<wtc:param value="<%=ishould_fee%>"/>						
		<wtc:param value="<%=ireal_fee%>"/>		
		<wtc:param value="<%=expDays%>"/>		
		<wtc:param value="<%=ido_note%>"/>		
		<wtc:param value="<%=hdthe_ip%>"/>		
	</wtc:service>
	<wtc:array id="result" scope="end"/>  
<%
	ret_code = retCode ;
	ret_msg = retMsg ;                                
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+iwork_no+"&loginAccept="+ilogin_accept+"&pageActivePhone="+themob+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
/*************************************获得打印发票的参数****************************************/
 
	String realcash = ireal_fee;   				                            //手续费    
	String stream = "";                                               //系统流水 
	if(retCode.equals("000000")){
		if(result.length>0){
			stream = result[0][0];
		}		
	}
/***********************************************************************************************/
%>

<script language="javascript">
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
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/sd344/fd344_1.jsp?activePhone=<%=themob%>";                    
}
</script>

<%if(ret_code.equals("000000")&&handcash>0.0){%>
<script language="javascript">
	rdShowMessageDialog('操作成功！打印发票.......',2);
	printBill();
</script>
<%}%>

<%if(ret_code.equals("000000")){%>
<script language='javascript'>
	rdShowMessageDialog('操作成功！',2);
	document.location.replace("fd344_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
<script language='javascript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
	document.location.replace("fd344_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>




