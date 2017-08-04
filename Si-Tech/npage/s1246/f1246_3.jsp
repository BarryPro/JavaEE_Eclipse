<%
  /*
   * 功能: 强制开关机1246
   * 版本: 1.0
   * 日期: 2008/12/23
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
 <% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1246";
	String opName="强制开关机";
	String hdword_no =(String)session.getAttribute("workNo");//工号
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code 操作权限归属
	String hdwork_pwd =(String)session.getAttribute("password");//工号密码		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//登陆IP	
	String regionCode = (String)session.getAttribute("regCode");
	String ilogin_accept = ReqUtil.get(request,"stream");
%>

<%      
	/*--------------------------------组织s1246Cfm的传入参数-------------------------------*/
//	String ilogin_accept = ReqUtil.get(request,"stream");             //系统流水
%>
	<!--wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="ilogin_accept"/-->
<%	
	String iop_Code ="1246";                                          //操作代码					 
	String iwork_no = hdword_no;                                      //操作工号                  
	String iwork_pwd =hdwork_pwd;                                     //工号密码						 
	String iorg_code =hdorg_code;                                     //org_code 
	String icust_id = ReqUtil.get(request,"oid_no");                  //客户ID
	String icmd_code1 = ReqUtil.get(request,"icmd_code");
	String icmd_code = "";											  //60,61
	if(icmd_code1.trim().equals("强开"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	//String icmd_code = ReqUtil.get(request,"icmd_code");             //命令函数
	String inew_runcode = ReqUtil.get(request,"onew_run");             //新运行状态L,K.
	String ishould_fee = ReqUtil.get(request,"ishould_fee");           //应交手续费
	String ireal_fee = ReqUtil.get(request,"ohand_cash");              //实际手续费
	//String isys_note = ReqUtil.get(request,"sysnote");               //系统备注					 
	String ido_note = ReqUtil.get(request,"sysnote");                   //操作备注
	String expDays = ReqUtil.get(request,"expDays");                   //日期备注
	String ithe_ip = hdthe_ip;                                         //登陆IP		
	String ret_code = "";
	String ret_msg = "";
	String cardno = ReqUtil.get(request,"oid_iccid");                //身份证号码
	String themob = ReqUtil.get(request,"i1");					     //移动号码  
	String name =   ReqUtil.get(request,"ocust_name");               //用户名称  
	String address =  ReqUtil.get(request,"ocust_addr");			 //用户地址 	
	/*String themob = ReqUtil.get(request,"i1");                       //手机号码					 
	String do_string=ReqUtil.get(request,"do_string_add");             //操作命令串  1:申请 2:取消
	String addcash_string=ReqUtil.get(request,"addcash_string");       //可选资费代码串
	String favour = "a017";                                            //优惠代码					 
	String realcash = ReqUtil.get(request,"i19");                      //实际手续费				 
	String fircash = ReqUtil.get(request,"i20");                       //固定手续费				 
	*/
	if(ireal_fee.equals(""))
	ireal_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                     //手续费单精度
	
	/***zhangyan add new parm b*/
	String iforce_type=ReqUtil.get(request,"force_type");
	String ifource_reason=ReqUtil.get(request,"force_reason");
	String iforce_judgement=ReqUtil.get(request,"force_judgement");
	String ilargeticket_time=ReqUtil.get(request,"largeticket_time");
	String ilargeticket_fee=ReqUtil.get(request,"largeticket_fee");
	String iowning_fee=ReqUtil.get(request,"owning_fee");
	String isuboffice=ReqUtil.get(request,"suboffice");
	String isuboffice_phone=ReqUtil.get(request,"suboffice_phone");
	String idocument_number=ReqUtil.get(request,"document_number");
	String idocument_date=ReqUtil.get(request,"document_date");
	String ioperator_name=ReqUtil.get(request,"operator_name");
	String ioperator_phone=ReqUtil.get(request,"operator_phone");
	String icontact_name=ReqUtil.get(request,"contact_name");
	String icontact_phone=ReqUtil.get(request,"contact_phone");
	
	String svcNm = "s1246Cfm";
	String osm_code=ReqUtil.get(request,"osm_code");
	
	System.out.println("osm_code~~~"+osm_code);
	/**
	if ( osm_code.equals("PB") || osm_code.equals("PA") )
	{
		svcNm = "sWLWInterFace";
	}*/
	
	/*--------------------------------开始调用s1246Cfm--------------------------------*/			                      
%>	
	<wtc:service name="<%=svcNm%>" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=ilogin_accept%>"/>
		<wtc:param value="<%=iop_Code%>"/>
		<wtc:param value="<%=iwork_no%>"/>
		<wtc:param value="<%=iwork_pwd%>"/>
		<wtc:param value="<%=iorg_code%>"/>
		<wtc:param value="<%=icust_id%>"/>
		<wtc:param value="<%=icmd_code%>"/>
		<wtc:param value="<%=inew_runcode%>"/>
		<wtc:param value="<%=ishould_fee%>"/>
		<wtc:param value="<%=ireal_fee%>"/>
		<wtc:param value="<%=expDays%>"/>
		<wtc:param value="<%=ido_note%>"/>
		<wtc:param value="<%=ithe_ip%>"/>
		<wtc:param value="<%=iforce_type%>"/>      	
		<wtc:param value="<%=ifource_reason%>"/>   	
		<wtc:param value="<%=iforce_judgement%>"/> 	
		<wtc:param value="<%=ilargeticket_time%>"/>	
		<wtc:param value="<%=ilargeticket_fee%>"/> 	
		<wtc:param value="<%=iowning_fee%>"/> 		                                          
		<wtc:param value="<%=isuboffice%>"/>       	
		<wtc:param value="<%=isuboffice_phone%>"/> 	
		<wtc:param value="<%=idocument_number%>"/> 	
		<wtc:param value="<%=idocument_date%>"/>   	
		<wtc:param value="<%=ioperator_name%>"/>   	
		<wtc:param value="<%=ioperator_phone%>"/>  	
		<wtc:param value="<%=icontact_name%>"/>    	
		<wtc:param value="<%=icontact_phone%>"/>   	
	</wtc:service>
	<wtc:array id="result" scope="end"/>  
<%
	ret_code = retCode ;
	ret_msg = retMsg ;                                
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+hdword_no+"&loginAccept="+ilogin_accept+"&pageActivePhone="+themob+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
/*************************************获得打印发票的参数****************************************/
 
	String realcash = ireal_fee;   				                     //手续费    
	String stream = "";                                              //系统流水 
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
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s1246/f1246_1.jsp?activePhone=<%=themob%>";                    
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
	document.location.replace("f1246_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
<script language='javascript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
	history.go(-1);
</script>
<%}%>



