 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
   	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String phoneNo = (String)request.getParameter("activePhone");
	String regionCode= (String)session.getAttribute("regCode");
	
    String work_no = (String)session.getAttribute("workNo");
   	String loginName =(String)session.getAttribute("workName");
    String org_Code =  (String)session.getAttribute("orgCode");
    
    	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    	String[] favStr=new String[temfavStr.length];
    	for(int i=0;i<favStr.length;i++)
     		favStr[i]=temfavStr[i][0].trim();
    	boolean pwrf=false;    	
    	if(WtcUtil.haveStr(favStr,"a272")){		
	  pwrf=true;	  
	}
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String dirtPage=request.getParameter("dirtPage"); 
	String op_name= opName;
%>
<html>
	<head>
	<title><%=opName%></title>	

<%
	
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	//S1100View callView = new S1100View();
	String sqlStr = "";
	int recordNum=0;
	int j=0;

	String order_name = "";
	String prepay_fee = "";
	String free_fee  = "";
	String mon_base_fee   = "";
	String award_id   = "";
	String sysdate   = "";
	String consume_term   = "";
	String base_fee   = "";
	
	String retCode = "";
	String retMsgResult = "";
	//String[][]worldData = new String [][]{};
	String order_code = request.getParameter("order_code");
	System.out.println("order_code ===: "+ order_code);
	
	String SqlStr1 = "select ORDER_CODE,ORDER_CODE||'->'||ORDER_NAME, PREPAY_FEE, CONSUME_TERM, FREE_FEE,MON_BASE_FEE,AWARD_ID,to_char(sysdate,'yyyymmdd'), to_char(add_months(sysdate, consume_term),'yyyymmdd'),BASE_FEE,bill_code, sm_code,grade_code,bill_name from sWorldPlan where region_code = substr('" + org_Code + "',1,2) and flag='0'";
	System.out.println(SqlStr1);
	/*ArrayList arr1 = co1.spubqry32("14", SqlStr1);	
	if(arr1.size() != 0)
	{
		worldData = (String[][])arr1.get(0); 
	}*/

	//流水   
   	   String paraStr[]=new String[1];	
	   String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	  // paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	   %>
	   	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=prtSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />		
	   <%
	    paraStr[0]=result[0][0];
	   System.out.println("11111111111：" +paraStr[0]);   
%>
<script language=javascript>
<!--  
  	var pwdFlag="false";
  	pwdFlag="<%=pwrf%>";
 
 	 onload=function()
  	{
  		document.all.phoneno.focus();   	
    		self.status="";

	<%
		if(ReqPageName.equals("s1220Main"))
		{
		  String retMsgResult1=WtcUtil.repNull(request.getParameter("retMsg"));
	 	  if(!retMsgResult1.equals("100") && !retMsgResult1.equals("101"))
		  {        
	%>   	 
	    rdShowMessageDialog("<%=retMsgResult1%>");	 
	<%
		  }
		  else if(retMsgResult1.equals("100"))
		  {
	%>
    	rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费<%=WtcUtil.repNull(request.getParameter("oweFee"))%>元，不能办理业务！');	    
	<%
		  }
	      else if(retMsgResult1.equals("101"))
		  {
	%>
        rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
	<%
		  }
		}
	%>
	
	
	  }


	//--------3---------验证按钮专用函数-------------
 
	   function chkPass()
	  {
	        if((document.all.phoneno.value.trim()).length<1)
		{
	      rdShowMessageDialog("请输入手机号码！");
	 	  return;
		} 
		if( pwdFlag == "false")   //没有优惠权限时
		{		
				document.all.t_new_pass.disabled=false;
	
	       //不论什么品牌，都必须校验密码 
		   if((document.all.t_new_pass.value.trim()).length==0)
		   {
			 rdShowMessageDialog("用户密码不能为空！");
			 document.all.t_new_pass.focus();
			 return false;
		   }
			}
		else                                                     //有优惠权限时
		{
	       
	         document.all.t_new_pass.disabled=true;
		   }
		
	        //alert(document.all.phoneno.value);
	        //alert(document.all.t_new_pass.value);
	   	var myPacket = new AJAXPacket("qryCus_id.jsp","正在查询客户，请稍候......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.op_code.value.trim());
		myPacket.data.add("t_new_pass",document.all.t_new_pass.value.trim());
		
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	  }
 
 
	 function simChk()
	 {    
	    if((document.all.phoneno.value.trim()).length<1)
		{
	      rdShowMessageDialog("手机号码不能为空！");
	 	  return;
		} 
	
	   	var myPacket = new AJAXPacket("simChg.jsp","正在查询客户，请稍候......");
		myPacket.data.add("phoneNo",document.all.phoneno.value.trim());
		myPacket.data.add("opCode",document.all.op_code.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	
	  }
  
	  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070116
	  function querySmcode()
	  {
		  var myPacket = new AJAXPacket("/npage/bill/querySmcode_rpc.jsp","正在获得信息，请稍候......");
		  myPacket.data.add("modeCode",document.all.temp8.value.trim());
		  core.ajax.sendPacket(myPacket);
		 myPacket=null;
	  }


 //--------4---------doProcess函数----------------
 
 
	  function doProcess(packet)
	  {
	    var vRetPage=packet.data.findValueByName("rpc_page");  
		
	    if(vRetPage == "1295chgSim")
	    {
	
			var flag_code  = packet.data.findValueByName("flag_code");	
			document.all.flag_code.value = flag_code;	
	
	    }   
	    else if(vRetPage=="simChk")
	    {
	    
		    var retCode = packet.data.findValueByName("retCode");
		    var retMsgResult = packet.data.findValueByName("retMsg");
			var idNo = packet.data.findValueByName("idNo");
			var smCode = packet.data.findValueByName("smCode");
			var smName = packet.data.findValueByName("smName");
			var belongCode = packet.data.findValueByName("belongCode");
			var custName = packet.data.findValueByName("custName");
			var userPassword = packet.data.findValueByName("userPassword");
			var runCode = packet.data.findValueByName("runCode");
			var runName = packet.data.findValueByName("runName");
			var idName = packet.data.findValueByName("idName");
			var idIccid = packet.data.findValueByName("idIccid");
			var ownerGrade = packet.data.findValueByName("ownerGrade");
			var gradeName = packet.data.findValueByName("gradeName");
			var card_name = packet.data.findValueByName("card_name");
			var totalPrepay = packet.data.findValueByName("totalPrepay");
			var totalOwe = packet.data.findValueByName("totalOwe");
			var card_code = packet.data.findValueByName("card_code");
			var card_no = packet.data.findValueByName("card_no");
			var loginAccept = packet.data.findValueByName("loginAccept");
			
			var transMoney = packet.data.findValueByName("transMoney");
			var curModeCode = packet.data.findValueByName("curModeCode");
			var curModeName = packet.data.findValueByName("curModeName");
			var nextModeCode = packet.data.findValueByName("nextModeCode");
			var nextModeName = packet.data.findValueByName("nextModeName");
			var nextModeDate = packet.data.findValueByName("nextModeDate");
			var endPlanDate = packet.data.findValueByName("endPlanDate");
		    var orderNode = packet.data.findValueByName("orderNode");
			var ownerAddress 		= packet.data.findValueByName("ownerAddress"	);
			var iphoneNo 		= packet.data.findValueByName("iphoneNo"	);
			
		    
			if(retCode=="000000"){	
				document.all.idNo.value = idNo;
				document.all.smCode.value = smCode;
				document.all.smName.value = smName;
				document.all.belongCode.value = belongCode;
				document.all.custName.value = custName;
				document.all.userPassword.value = userPassword;
				document.all.runCode.value = runCode;
				document.all.runName.value = runName;
				document.all.idName.value = idName;
				document.all.idIccid.value = idIccid;
				document.all.ownerGrade.value = ownerGrade;
				document.all.gradeName.value = gradeName;
				document.all.ownerAddress.value = ownerAddress;
				document.all.iphoneNo.value = iphoneNo;
		
				document.all.goodbz.value = packet.data.findValueByName("goodbz"	);
				document.all.modedxpay.value = packet.data.findValueByName("modedxpay"	);
				
				
				if (orderNode != '') {
				    rdShowMessageDialog(orderNode);
				}				
				document.all.totalPrepay.value = totalPrepay;
				document.all.loginAccept.value = loginAccept;			
				document.all.transMoney.value = transMoney;
				
			}else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsgResult);
				return;
			}     
	    }
	    else if(vRetPage=="querySmcode") //added by hanfa 20070116
		{
			var errCode = packet.data.findValueByName("errCode");
		    var errMsg = packet.data.findValueByName("errMsg");
			var m_smCode = packet.data.findValueByName("m_smCode");
			
			if(errCode == 0)
			{
				document.all.m_smCode.value = m_smCode;			
			}else			
			{
				rdShowMessageDialog("错误:"+ errCode + "->" + errMsg);
				return false;
			}  
		}    
	    
	  }

	//-------2---------验证及提交函数-----------------
	
	function printCommit(){	
		getAfterPrompt();
		
		if (document.all.phoneno.value.length < 11) {
		    rdShowMessageDialog("无效的用户号码！");
		}
	    
		if(parseFloat(document.all.transMoney.value) < parseFloat(document.all.temp2.value)) {
			rdShowMessageDialog("用户帐户可转金额不足，请补交方案预存" + document.all.temp2.value + "元!");
			return false;
		}
	
		if(document.all.temp0.value == "") {
			rdShowMessageDialog("请选择方案代码!");
			return false;
		}
		
		//added by hanfa 20070117
		//alert(document.all.smCode.value);
		//alert(document.all.m_smCode.value);
		//alert(document.all.temp8.value);
		if(document.all.smCode.value == "zn" && document.all.m_smCode.value == "gn")
		{
			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
		}
		else
		{
			if(document.all.m_smCode.value != document.all.smCode.value && document.all.temp8.value != "xxxxxxxx")
			{
				if(rdShowConfirmDialog("该客户做品牌变更，积分将清零，请提示客户兑换积分。<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确认进行下一步操作吗？") == 1)
				{
					printSubmit();
				}
				else
				{			
					return false;
				}							
			}
			else
			{
				printSubmit();
			}
	  	}
	}	

	function printSubmit()
	{	
	   //打印工单并提交表单   
	   document.all.t_sys_remark.value="用户"  + document.all.phoneno.value + "全球通签约计划";
	   var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	   
	    if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
	        {  
		      　s3216.submit();	      
	        }
	
		    if(ret=="remark")
		    {
	         if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	         {
		       s3216.submit();	       
	         }
		   }
		}
	    else
	    {
	       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	       {
		     s3216.submit();	     
	       }
	    }
	
	    return true;
	}

	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  //显示打印对话框
		//显示打印对话框 		
		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept =document.all.loginAccept.value;                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = <%=activePhone%>;                           //客户电话		
	   	var h=150;
	   	var w=350;
	   	var t=screen.availHeight/2-h/2;
	   	var l=screen.availWidth/2-w/2;
	   	
	   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
	
	}

	  function printInfo(printType){
		
		
		var cust_info=""; //客户信息
	      	var opr_info=""; //操作信息
	      	var retInfo = "";  //打印内容
	      	var note_info1=""; //备注1
	      	var note_info2=""; //备注2
	      	var note_info3=""; //备注3
	      	var note_info4=""; //备注4 
	      	if (document.all.qianyuemode.value=="A"){
	      	
	      		cust_info+="客户姓名：   " +document.all.custName.value+"|";
			cust_info+="手机号码：   "+document.all.phoneno.value+"|";  
			cust_info+="客户地址：   "+document.all.ownerAddress.value+"|";
			cust_info+="证件号码：   "+document.all.idIccid.value+"|";		
			cust_info+="联系人电话：   "+document.all.iphoneNo.value+"|";  
			cust_info+="客户级别：   "+document.all.gradeName.value+"|";
			
			opr_info+="预存话费总金额："+document.all.temp2.value+"   流水："+document.all.loginAccept.value+"|";
			opr_info+="单月底限消费："+document.all.temp5.value+"|";
			opr_info+="礼品类型："+document.all.temp7.value+"        底限预存："+document.all.temp3.value+"|";
			opr_info+="活动预存："+document.all.temp4.value+"        积分派送："+document.all.temp10.value+"|";
			opr_info+="积分使用期限（月）："+document.all.temp11.value+ "  消费期限（月）: " + document.all.temp15.value + "|";
			opr_info+="业务执行时间："+document.all.temp12.value+"至"+document.all.temp13.value+"|";
			
			if(document.all.goodbz.value=="Y"){
				opr_info+="签约期限（月）："+document.all.temp6.value+"       底线消费金额："+document.all.modedxpay.value+"元"+"|";
			}
			opr_info+="您办理此业务后，即成为我公司全球通签约客户，在业务执行时间起"+document.all.temp6.value+"个月内资费不能变更。 "+"|";										  
			if(document.all.goodbz.value=="Y"){
				opr_info+="在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。做为全球通客户，您将享受我公司为您提供的尊贵服务。备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			}else{
				opr_info+="在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。做为全球通客户，您将享受我公司为您提供的尊贵服务。"+"|";
			}
			
	      		
	      	}else{
	      		cust_info+="客户姓名：   " +document.all.custName.value+"|";
			cust_info+="手机号码：   "+document.all.phoneno.value+"|";  
			cust_info+="客户地址：   "+document.all.ownerAddress.value+"|";
			cust_info+="证件号码：   "+document.all.idIccid.value+"|";		
			cust_info+="联系人电话：   "+document.all.iphoneNo.value+"|";  
			cust_info+="客户级别：   "+document.all.gradeName.value+"|";
	      		
		      	opr_info+="业务类型："+'<%=op_name%>'+"		流水："+document.all.loginAccept.value+"|";
			opr_info+="预存话费总金额："+document.all.temp2.value+"  购机款："+document.all.temp14.value+"|";
			opr_info+="单月底限消费："+document.all.temp5.value+"|";
			opr_info+="机型："+document.all.temp7.value+"			  底限预存："+document.all.temp3.value+"|";
			opr_info+="活动预存："+document.all.temp4.value+"       积分派送："+document.all.temp10.value+"|";
			opr_info+="积分使用期限（月）："+document.all.temp11.value+ "  消费期限（月）: "  + document.all.temp15.value +"|";
			opr_info+="业务执行时间："+document.all.temp12.value+"至"+document.all.temp13.value+"|";
			
			if(document.all.goodbz.value=="Y"){
				opr_info+="签约期限（月）："+document.all.temp6.value+"       底线消费金额："+document.all.modedxpay.value+"元"+"|";
			}		
			
			if(document.all.goodbz.value=="Y"){
				note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			}
	      		
	      	}	
	
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      	return retInfo;	
		
	  }

	function getRemain(){	
		if(parseFloat(document.s3216.vHandFee.value) < parseFloat(document.s3216.vRealFee.value)){
		rdShowMessageDialog("手续费不能大于"+document.s3216.vHandFee.value);
		return;
		}	
		document.s3216.vPayChange.value=document.s3216.vHandFee.value-document.s3216.vRealFee.value;
	}

	function  submitreset(){
		s3216.reset();	
		self.location.reload();
		return false;
	}  

 function searchOrderCode() {
      	 var h=480;
	  var w=700;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;

	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	  var returnValue = window.showModalDialog('getOrderCode.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phoneno='+document.all.phoneno.value+'&qianyuemode='+document.all.qianyuemode.options[document.all.qianyuemode.selectedIndex].value,"",prop);
	  
	  if(returnValue==null) {
          rdShowMessageDialog("您还没有选择方案！");
      } else {
		   var returnTemp = returnValue.split("|");
           
		   if (returnTemp.length == 2) {
		        rdShowMessageDialog(returnTemp[1]);
		   } else {
		       if (returnTemp[0] == undefined) {
		          returnTemp[0] = "";
		        }

		        if (returnTemp[1] == undefined) {
		            returnTemp[1] = "";
		        }

		        if (returnTemp[2] == undefined) {
		           returnTemp[2] = "";
		        }

		        if (returnTemp[3] == undefined) {
		           returnTemp[3] = "";
		        }

		        if (returnTemp[4] == undefined) {
		           returnTemp[4] = "";
		        }

		        if (returnTemp[5] == undefined) {
		           returnTemp[5] = "";
		        }

		        if (returnTemp[6] == undefined) {
		           returnTemp[6] = "";
		        }

		        if (returnTemp[7] == undefined) {
		           returnTemp[7] = "";
		        }

		        if (returnTemp[8] == undefined) {
		           returnTemp[8] = "";
		        }

		        if (returnTemp[9] == undefined) {
		           returnTemp[9] = "";
		        }

		        if (returnTemp[10] == undefined) {
		           returnTemp[10] = "";
		        }

		        if (returnTemp[11] == undefined) {
		           returnTemp[11] = "";
		        }

		        if (returnTemp[12] == undefined) {
		           returnTemp[12] = "";
		        }

		        if (returnTemp[13] == undefined) {
		           returnTemp[13] = "";
		        }

		        if (returnTemp[14] == undefined) {
		           returnTemp[14] = "";
		        }

				if (returnTemp[15] == undefined) {
		           returnTemp[15] = "";
		        }
           
		        document.all.temp0.value = returnTemp[0];
	            document.all.temp1.value = returnTemp[1];
		        document.all.temp2.value = returnTemp[2];
		        document.all.temp3.value = returnTemp[3];
		        document.all.temp4.value = returnTemp[4];
		        document.all.temp5.value = returnTemp[5];
		        document.all.temp6.value = returnTemp[6];
		        document.all.temp7.value = returnTemp[7];
		        document.all.temp8.value = returnTemp[8];
		        document.all.temp9.value = returnTemp[9];
		        document.all.temp10.value = returnTemp[10];
		        document.all.temp11.value = returnTemp[11];
		        document.all.temp12.value = returnTemp[12];
		        document.all.temp13.value = returnTemp[13];
		        document.all.temp14.value = returnTemp[14];
				document.all.temp15.value = returnTemp[15];
				
				querySmcode(); //added by hanfa 20070116
		   }
	  }	
	  
	var myPacket = new AJAXPacket("1445Flag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("org_Code",document.all.org_Code.value.trim());
	myPacket.data.add("temp8",document.all.temp8.value.trim());
	core.ajax.sendPacket(myPacket);
	delete(myPacket);
	
	//if ( get_cookie('popped')=='') {
	setTimeout("getFlagCode1();",1000);
	//document.cookie="popped=yes" ;
//}
	  
 //-->
 }
 
function getFlagCode1(){
	if (document.s3216.flag_code.value == 2) {
 	getFlagCode();
	}
}


 function dolist(){
    var ordercode = document.all.qianyuemode.options[document.all.qianyuemode.selectedIndex].value;
    
	if (ordercode == 'A') {
	   IList.style.display = "none";   
	} else if (ordercode == 'M') {
	   IList.style.display = "";
	}
}

	function getFlagCode()
	{ 
	  	//调用公共js
	    var pageTitle = "资费查询";
	    var fieldName = "小区代码|资费名称|资费代码";//弹出窗口显示的列、列名 
	    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + codeChg(document.s3216.org_Code.value.substring(0,2)) + "' and b.mode_code='" + codeChg(document.s3216.temp8.value) + "' order by a.flag_code" ;
	    var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '"+document.s3216.org_Code.value.substring(0,2)+"'and a.offer_id = "+(document.s3216.temp8.value).trim();
		//alert(sqlStr); 
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "3|0|1|2";//返回字段
	    var retToField = "flag_code1|flag_code_name|rateCode|";//返回赋值的域
	    
	    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	}
</script>
</head>
<body>  
<form action="1445BackCfm.jsp" method="POST" name="s3216"  onKeyUp="chgFocus(s3216)">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
  <input type="hidden" name="op_code" id="op_code" value="1445">
  <input type="hidden" name="op_name" id="op_name" value="<%=opName%>">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
  <input type="hidden" name="idNo" value="">
  <input type="hidden" name="smCode" value="">
  <input type="hidden" name="belongCode" value="">
  <input type="hidden" name="userPassword" value="">
  <input type="hidden" name="runCode" value="">
  <input type="hidden" name="runName" value="">
  <input type="hidden" name="idName" value="">
  <input type="hidden" name="ownerGrade" value="">
  <input type="hidden" name="card_name" value="">
  <input type="hidden" name="totalOwe" value="">
  <input type="hidden" name="card_code" value="">
  <input type="hidden" name="loginAccept" value="<%=paraStr[0]%>"> 
  <input type="hidden" name="base_fee" value="">  
   <input type="hidden" name="curModeCode" value="">
   <input type="hidden" name="curModeName" value="">
   <input type="hidden" name="nextModeCode" value="">
   <input type="hidden" name="nextModeName" value="">
   <input type="hidden" name="nextModeDate" value="">
  <input type="hidden" name="endPlanDate" value="">
  <input type="hidden" name="goodbz" value="">
  <input type="hidden" name="modedxpay" value="">
  <input type="hidden" name="ownerAddress" value="">
  <input type="hidden" name="iphoneNo" value="">
  <input type="hidden" name="org_Code" value="<%=org_Code%>">
  <input type="hidden" name="flag_code" value="">
  <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  index="28" maxlength=60> 
 
  <input type="hidden" name="m_smCode" value="">  
	
	<input type=hidden name=simBell value="   手机上网可选套餐优惠的GPRS流量仅指CMWAP节点产生的流量.  彩铃下载：1.购彩铃包年卡,送价值88元德赛电池。  2.登陆龙江风采（wap.hljmonternet.com）使用手机上网：体验图铃下载、新闻资讯、网络美文免费体验区下载铃音、时尚屏保,免收信息费！拨打1860开通GPRS 。">
	<input type=hidden name=worldSimBell value="    您办理此业务后，即成为我公司全球通签约客户，在签约期限内使用我公司业务及产品，同时执行月底限消费政策。您交纳的预存款需在消费期限内消费完毕，同时您获赠的积分在积分使用期限后方可使用。       在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。       做为全球通客户，您将享受我公司为您提供的尊贵服务。">

        <table  cellspacing="0">         
          <tr> 
            <td  nowrap width="16%" class="blue">用户号码</td>
            <td nowrap > 
              	<input   value =<%=phoneNo%>  readonly class="InputGrey" type="text" size="17" name="phoneno" id="phoneno"  maxlength=11  index="6" onkeyup="if(event.keyCode==13)chkPass(phoneno)">              
            	<input type="button" name="qryId_No" value="查询" class="b_text" onClick="simChk()" >            
            </td>
	    <td  nowrap width="16%" class="blue">签约模式</td>
            <td nowrap > 
                <select name="qianyuemode" onchange="dolist()">
                   <option  value="A" selected>礼品赠送</option>
                   <option  value="M" >终端捆绑</option>
                </select>
	   </td>
          </tr>
          <tr> 
            <td class="blue"  nowrap width="16%">用户名称</td>
            <td  nowrap  width="28%">               
                <input name="custName" readonly class="InputGrey" type="text"  size="17"  index="6" >
            </td>
            <td  nowrap  class="blue" width="16%">证件号码</td>
            <td  nowrap  width="40%"> 
             <input  type="text" size="16" value="" readonly class="InputGrey" tabindex="0" name="idIccid" >
            </td>
          </tr>
          <tr> 
            <td   class="blue" nowrap width="16%">用户品牌</td>
            <td  nowrap  width="28%"> 
              <input type="text"  name="smName" size="16" value="" readonly class="InputGrey" tabindex="0">
            </td>
            <td  nowrap class="blue" width="16%">用户类型</td>
            <td  nowrap  width="40%"> 
             <input type="text"  name="gradeName" size="50" value="" readonly class="InputGrey" tabindex="0">
            </td>
          </tr>
          <tr> 
            <td   class="blue" nowrap height=10>当前预存</td>
             <td   nowrap height=10>
              <input  type="test" name="totalPrepay" value="">
             </td>
            <td   class="blue" nowrap height=10>可转金额</td>
             <td   nowrap  height=10>
              <input  type="test" name="transMoney" value="">
             </td>
          </tr>
          <tr> 
            <td  nowrap width="16%" class="blue">方案代码</td>
            <td nowrap > 
              	<input  type="text" size="17" name="temp0" id="temp0" readonly  class="InputGrey" index="6">  
		<input  type="button" name="qryId_No1" class="b_text" value="查询" onClick="searchOrderCode()">       
	    </td>
	    <td  nowrap width="16%" class="blue">方案名称</td>
            <td nowrap> 
                <input  type="text" size="40" name="temp1" id="temp1" readonly class="InputGrey" index="6">
	    </td>
          </tr>
	  <tr> 
            <td  nowrap width="16%" class="blue">预存款</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp2" id="temp2" readonly class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%" class="blue">月底线</td>
            <td nowrap> 
                <input  type="text" size="17" name="temp3" id="temp3" readonly  class="InputGrey" index="6">
	    </td>
          </tr>
          <tr> 
            <td  nowrap width="16%" class="blue">活动预存</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp4" id="temp4" readonly class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%" class="blue">月底线消费</td>
            <td nowrap> 
                <input  type="text" size="17" name="temp5" id="temp5" readonly class="InputGrey" index="6">
	    </td>
          </tr>
	  <tr> 
            <td  nowrap width="16%" class="blue">消费期限（月）</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp6" id="temp6" readonly  class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%" class="blue">奖品名称或机器名称</td>
            <td nowrap> 
                <input  type="text" size="17" name="temp7" id="temp7" readonly class="InputGrey" index="6">
	    </td>
          </tr>
          <tr> 
            <td  nowrap width="16%" class="blue">资费代码</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp8" id="temp8" readonly class="InputGrey" index="6">
              <input  type="hidden" size="17" name="flag_code1" id="flag_code1" readonly class="InputGrey"  index="6">
              <input  type="hidden" size="17" name="rateCode" id="rateCode" readonly class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%" class="blue">资费名称</td>
            <td nowrap > 
                <input  type="text" size="17" name="temp9" id="temp9" readonly  class="InputGrey" index="6">
		<input type="hidden" size="17" name="flag_code_name" id="flag_code_name" readonly class="InputGrey" index="6">
	    </td>			
          </tr>
	  <tr> 
            <td  nowrap width="16%" class="blue">赠送积分</td>
            <td nowrap> 
              <input  type="text" size="17" name="temp10" id="temp10" readonly class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%" class="blue">积分使用期限（月）</td>
            <td nowrap> 
                <input  type="text" size="17" name="temp11" id="temp11" readonly  class="InputGrey" index="6">
		<!-- // 积分消费期限 -->
		<input type="hidden" name="temp15"  id="temp15"  value = "">
	   </td>
          </tr>
	  <tr> 
            <td  nowrap width="16%" class="blue">开始时间</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp12" id="temp12" readonly class="InputGrey"  index="6">
            </td>
	    <td  nowrap width="16%" class="blue">结束时间</td>
            <td nowrap  >
                <input  type="text" size="17" name="temp13" id="temp13" readonly class="InputGrey" index="6">
	    </td>
          </tr>
	  <tr style="display:none" id="IList"> 
            <td  nowrap width="16%">购机款</td>
            <td nowrap > 
              <input  type="text" size="17" name="temp14" id="temp14" readonly class="InputGrey" index="6">
            </td>
	    <td  nowrap width="16%">&nbsp;</td>
            <td> &nbsp;</td>
          </tr>        
          <tr> 
            <td class="blue">备注</td>
            <td colspan="3" > 
                <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly class="InputGrey"  maxlength=30>
            </td>
          </tr>          
          </table>
          <table  cellspacing="0">       
          <tr> 
            <td id="footer">             
                <input  type="button" name="confirm" class="b_foot_long" value="打印&确认"  onClick="printCommit()" index="26">
                <input type=button  class="b_foot" name=back value="清除" onClick="submitreset()"  >
                <input  type="button" class="b_foot" name="b_back" value="返回"  onClick="removeCurrentTab()" index="28">
           </td>
          </tr>	
        </table>
	<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
