 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-10 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%
       	String opCode = "4112";	
	String opName = "批量付费计划变更";	//header.jsp需要的参数    
	      
       	String op_code ="4112";       	
        String orgCode = (String)session.getAttribute("orgCode");       
	String ip_Addr = request.getRemoteAddr();
	String error_code = "0";
	String error_msg="确认成功！";
	
	int valid = 1;  //0:正确，1：系统错误，2：业务错误
	String iErrorNo ="";
    	String sErrorMessage = " ";
    	String unit_id =request.getParameter("unit_id");    
    	System.out.println("==================unit_id"+unit_id);

	//ArrayList callData = null;
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String opType = request.getParameter("opMode");    
	String iRegion_Code = orgCode.substring(0,2);	
	
	String sSaveName="";	
	ArrayList  ParamsIn=new ArrayList();
	
	String server_ip_Addr=realip;//0.100主机隐藏ip用上面方法得到的是0.100非真实ip
	String srvIP=request.getServerName();
	
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	SmartUpload mySmartUpload = new SmartUpload();
	String filename="";
	String workNo="";
	String unit_name="";
	String userPhone="";
	String login_accept = request.getParameter("login_accept");  
	String unit_name2 = request.getParameter( "unit_name2" );
	String v_effectRule = request.getParameter( "v_effectRule" );//生效规则
	
	System.out.println("zhangyan unit_name2==="+unit_name2);
	if (opType.equals("file")){
		//按文件录入的操作
    		filename = "TYFF"+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
	}
	else
	sSaveName="";
	try {
	        mySmartUpload.initialize(pageContext);
	        mySmartUpload.upload();
		System.out.println("上传完毕!!");
    	} catch(Exception ex)   {
		System.out.println("异常抛出!!");
		ex.printStackTrace();
        	iErrorNo = "321099";
        	sErrorMessage = "上载文件传输中出错！";	
%>            
	<script language='jscript'>                 
		rdShowMessageDialog('上载文件传输中出错！',0);                 
		location = "s3705.jsp";
	</script>	
<%	
	}	
	try {        
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);        
		if (!myFile.isMissing())
		{
			myFile.saveAs(sSaveName);
		}    
	}
	catch(Exception ex)	{
		iErrorNo = "321098";        
		sErrorMessage = "上载文件存储时出错！";
	%>        
			<script language='jscript'>           
				rdShowMessageDialog('上载文件存储时出错！',0);           
				location = "s3705.jsp";        
			</script>
	<%	
	}
		//按文件录入操作结束	
		//ParamsIn = new String[24];		   
		String temFeeCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temFeeCode"));
		String temDetailCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temDetailCode"));
		String temRateCode=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temRateCode"));		 
		String temPayOrder=WtcUtil.repNull(mySmartUpload.getRequest().getParameter("temPayOrder"));	
		System.out.println("temFeeCode="+temFeeCode);
		System.out.println("temDetailCode="+temDetailCode);
		System.out.println("temRateCode="+temRateCode);
		System.out.println("temPayOrder="+temPayOrder);
			/****分解字符串****/
		StringTokenizer token1=new StringTokenizer(temFeeCode,"#");
		StringTokenizer token2=new StringTokenizer(temDetailCode,"#");
		StringTokenizer token3=new StringTokenizer(temRateCode,"#");
		StringTokenizer token4=new StringTokenizer(temPayOrder,"#");
		String feeCode []=new String [token1.countTokens()];
		System.out.println("%%%%%%%%%%%token1.countTokens()="+token1.countTokens());
		/* add by wanglm 20110407  鹤岗集团批量付费计划变更删除成员失败申告 
		   原因是 当token1.countTokens()为0时，数组没有初始化
		*/
		if(token1.countTokens() == 0){
		  feeCode=new String[1];
	      feeCode[0]="   ";
		}
		String detai1Code []=new String [token2.countTokens()];
		System.out.println("--------------detai1Code-------------  "+token2.countTokens());
		if(token2.countTokens() == 0){
		  detai1Code=new String[1];
	      detai1Code[0]="   ";
		}
		String feeRate []=new String [token3.countTokens()];
		if(token3.countTokens() == 0){
		  feeRate=new String[1];
	      feeRate[0]="   ";
		}
		/* add by wanglm 20110407  鹤岗集团批量付费计划变更删除成员失败申告*/
		String payOrder []=new String [token4.countTokens()];
		int i=0;
		while(token1.hasMoreElements()){
			feeCode[i]=(String)token1.nextElement();
			detai1Code[i]=(String)token2.nextElement();
			feeRate[i]=(String)token3.nextElement();
			payOrder[i]=(String)token4.nextElement();
			System.out.println("%%%%%%%%%%%"+feeCode[i]);
			System.out.println("%%%%%%%%%%%"+detai1Code[i]);
			System.out.println("%%%%%%%%%%%"+feeRate[i]);
			i++;
		}
		//wuxy add 20090531 为解决无明细时，服务报错 payOrder为空问题
		if(i==0)
	  {
	  	payOrder=new String[1];
	  	payOrder[0]="0";
	  }
		
		System.out.println("--------------payOrder="+payOrder);
		ParamsIn.add("0");	
		String kong=new String(" ");	
		//String kong = "";
		String 	opCode1=mySmartUpload.getRequest().getParameter("opCode");
		String 	workNo1=mySmartUpload.getRequest().getParameter("workNo");
		workNo=workNo1;
		String 	NoPass1=mySmartUpload.getRequest().getParameter("NoPass");
		
		String 	opType1=mySmartUpload.getRequest().getParameter("opType");
		String unit_name1=mySmartUpload.getRequest().getParameter("unit_name");
		unit_name=unit_name;
		String 	accountMsg1=mySmartUpload.getRequest().getParameter("accountMsg");
										
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("opCode")});	  /* 功能代码		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("workNo")});/* 操作工号		   */	
		ParamsIn.add( new String[]{ mySmartUpload.getRequest().getParameter("NoPass")});	 /* 经过加密的工号密码		   */
		ParamsIn.add( new String[]{orgCode});	 /* 操作工号归属		   */

		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("opType")});	   /* 操作类型			 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("unit_name")});   /* 集团用户ID		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("accountMsg")});	/* 付费帐户		  */
		ParamsIn.add( new String[]{" "});	/* 前一个帐单序号		  */
		ParamsIn.add( payOrder);	                                                /* 冲销顺序		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("limitNum")});	/* 限额		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("detailFlag")});	/* 明细标志		  */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("stopFlag")});	/* 停机标志		   */
		
		String limitNum1=mySmartUpload.getRequest().getParameter("limitNum");
		String detailFlag1=mySmartUpload.getRequest().getParameter("detailFlag");
		String stopFlag1=mySmartUpload.getRequest().getParameter("stopFlag");
		System.out.println("--------------------------------detailFlag1-------------------------    "+detailFlag1);
		String should_handfee1=mySmartUpload.getRequest().getParameter("should_handfee");
		String real_handfee1=mySmartUpload.getRequest().getParameter("real_handfee");
		String sysnote1=mySmartUpload.getRequest().getParameter("sysnote");
		String tonote1=mySmartUpload.getRequest().getParameter("tonote");
		String userPhone1=mySmartUpload.getRequest().getParameter("userPhone");
		userPhone=userPhone1;
		ParamsIn.add( feeCode);		                                               /* 费用代码	   */
		ParamsIn.add( detai1Code);		                                           /* 明细代码	 */
		ParamsIn.add( feeRate);		                                               /* 费用比率		 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("should_handfee")});	  /* 应收		   */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("real_handfee")});	  /* 实收	 */
		//ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("0.00")});		/* 应收		   */
		//ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("0.00")});		/* 实收	 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("sysnote")});	/* 系统备注	 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("tonote")});		/* 用户备注   */
		ParamsIn.add( new String[]{ip_Addr});		/* 本地业务办理IP地址		 */
		ParamsIn.add( new String[]{mySmartUpload.getRequest().getParameter("userPhone")});	/* 单个号码时输入 */
		ParamsIn.add( new String[]{sSaveName});														/* 批量操作文件名	   */
		ParamsIn.add( new String[]{server_ip_Addr});		/* 批量操作文件名上传主机地址 */
		
		//String[] retStr = callView.callService("s4112Cfm", ParamsIn, "3", "region", iRegion_Code);
		%>
		<wtc:service name="s4112Cfmexc" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
			<wtc:param value="<%=login_accept%>"/>			
			<wtc:param value="<%=opCode1%>"/>
			<wtc:param value="<%=workNo1%>"/>
			<wtc:param value="<%=NoPass1%>"/>									
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=opType1%>"/>
			<wtc:param value="<%=unit_name1%>"/>									
			<wtc:param value="<%=accountMsg1%>"/>
						
			<wtc:param value="<%=kong%>"/>
			
			<wtc:params value="<%=payOrder%>"/>					
			<wtc:param value="<%=limitNum1%>"/>
			<wtc:param value="<%=detailFlag1%>"/>
			<wtc:param value="<%=stopFlag1%>"/>	
									
			<wtc:params value="<%=feeCode%>"/>
			<wtc:params value="<%=detai1Code%>"/>
			<wtc:params value="<%=feeRate%>"/>	
						
			<wtc:param value="<%=should_handfee1%>"/>
			<wtc:param value="<%=real_handfee1%>"/>
			<wtc:param value="<%=sysnote1%>"/>			
			<wtc:param value="<%=tonote1%>"/>
			<wtc:param value="<%=ip_Addr%>"/>
			<wtc:param value="<%=userPhone1%>"/>			
			<wtc:param value="<%=sSaveName%>"/>
			<wtc:param value="<%=server_ip_Addr%>"/>	
			<wtc:param value="<%=v_effectRule%>"/>
		</wtc:service>
		<wtc:array id="retStr2" scope="end" start="1"  length="1"/>
		<wtc:array id="retStr3" scope="end"  start="2"  length="1"/>
		
		<%			
	    
	    	error_code=retCode1;
	    	error_msg=retMsg1;
	    	System.out.println("retStr================"+retStr2.length);
	    	System.out.println("retStr================"+retStr3.length);
	    	System.out.println("retCode1======================"+retCode1);
	    	System.out.println("retMsg1======================"+retMsg1);	   
	if(!error_code.equals("000000")){
		%>
	 <SCRIPT type=text/javascript>
	    var path="<%=request.getContextPath()%>/npage/s3700/f3705_2_printxls.jsp?";
     if (rdShowConfirmDialog("<br>错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>"+"<br>是否保存错误信息？",0)==1)	
			{
				path = path + "&returnMsg=" + "<%=retMsg1%>"+ "&phoneNo=" + "<%=userPhone1%>";
				path = path + "&grpName="+"<%=unit_name1%>";
				path = path + "&unitID="+"<%=unit_id%>";
    	  		path = path + "&op_Code=" + "<%=op_code%>";
    	  		path = path + "&orgCode=" + "<%=orgCode%>";
                window.open(path);
    			}	
                
            history.go(-1);    
     
     
     
     
		//rdShowMessageDialog("错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>",0);
		//history.go(-1);
	 </SCRIPT>
		<%
	}else{
		  String temp1="";
			for(int is=0;is<retStr2.length;is++) {
			    temp1+=retStr2[is][0];
			}
			String temp2="";
			for(int iss=0;iss<retStr3.length;iss++) {
			    temp2+=retStr3[iss][0];
			}

		String iPhoneNo = temp1.replaceAll("\\|","~");
		String retMsgForExcl = temp2.replaceAll("\\|","~");
		System.out.println("@@@@@@@@@@@@@@@@iPhoneNo="+iPhoneNo);
		System.out.println("@@@@@@@@@@@@@@@@retMsgForExcl"+retMsgForExcl);	
		System.out.println("@@@@@@@@@@@@@@@@temp1"+temp1);	
		System.out.println("@@@@@@@@@@@@@@@@temp2"+temp2);	
		strToken1=new StringTokenizer(temp1,"|");
		strToken2=new StringTokenizer(temp2,"|");
		%>

<html>
<head>
	<title>用户信息</title>
</head>
	<SCRIPT type=text/javascript>
		function previouStep(){
			frm.action="s3705.jsp";
			frm.method="post";
			frm.submit();
		}
	    function print_xls(){
	    	document.frm.action="/npage/public/pubExcl.jsp";
			document.frm.submit();
	    }		
	</SCRIPT>
<body>
	<form name="frm" method="post" action="">
<%
java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String createTime = sf.format(sysdate);

String pnt_B1=unit_name2+"|"
	+unit_id+"|"
	+unit_name1+"|"
	+workNo+"|"
	+opName+"|"
	+createTime+"|"
	;
%>		
	
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">未成功号码列表</div>
		</div>			
	        <table  cellspacing="0" >
	                <TR> 			
	                  <Th>未添加成功号码(如果列表为空，则全部号码添加成功。)</Th>
	                  <Th>失败原因</Th>
	                </TR>		
	<%			

			while (strToken1.hasMoreTokens()) {
			
			%>
					<TR >
						<td> <%= strToken1.nextToken()%> </td>
						<td> <%= strToken2.nextToken()%> </td>
					</TR>
	<%
				}
	%>
			  
	 </table>    
	<table cellspacing="0">
		<tr>
	            <td id="footer"> 	  
	            	<input class="b_foot_long" name="prtxls" id="prtxls" type=button value="保存XLS文件" 
						onclick="print_xls()" style="cursor:hand">         
	                <input  name="previous"  class="b_foot" type=button value="返回" onclick="previouStep()">
	                &nbsp;
	                <input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="关闭">
	             </td>
	          </tr>
	        </table>
	        
<INPUT TYPE='hidden' ID = 'pnt_A' NAME = 'pnt_A' VALUE = '黑龙江移动通讯公司集团成员管理不成功记录|'>
<INPUT TYPE='hidden' ID = 'pnt_B' NAME = 'pnt_B' VALUE = '集团名称|集团编号|集团产品帐户|操作工号|操作功能|操作日期|'>
<INPUT TYPE='hidden' ID = 'pnt_B1' NAME = 'pnt_B1' VALUE = '<%=pnt_B1%>'>
<INPUT TYPE='hidden' ID = 'pnt_C' NAME = 'pnt_C' VALUE = '未成功号码|失败原因|'>
<INPUT TYPE='hidden' ID = 'pnt_C1' NAME = 'pnt_C1' VALUE = "<%=iPhoneNo%>|<%=retMsgForExcl%>|">
<INPUT TYPE='hidden' ID = 'opCode' NAME = 'opCode' VALUE = "<%=opCode%>">		        
        </form>
        <%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
<%}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+login_accept+"&pageActivePhone="+userPhone+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
	System.out.println("url======="+url);
%>
<jsp:include page="<%=url%>" flush="true" />
