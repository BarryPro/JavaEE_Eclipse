 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>


<%
   	String opCode = "3517";	
	String opName = "集团用户资料变更";	//header.jsp需要的参数  
	String op_code="3517";
	String unit_id = request.getParameter("unit_id");
    	String ip_Addr = (String)session.getAttribute("ipAddr");
    	String workno = (String)session.getAttribute("workNo");
    	String org_code = ((String)session.getAttribute("orgCode")).substring(0,7);
    	String nopass  =(String)session.getAttribute("password"); 
    	String Department = (String)session.getAttribute("orgCode");
    	String regionCode = (String)session.getAttribute("regCode");
    	String districtCode = Department.substring(2,4);
    	
    	String sqlStr = "";
	String service_name = "";
	
    	ArrayList retArray = new ArrayList();
    	String[][] result = new String[][]{};
	String[][] resulta = new String[][]{};
	String[][] resultList = new String[][]{};
	String[][] resultList2 = new String[][]{};
	int resultListLength2=0;

    	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
    	productCfg prodcfg = new productCfg();
	int nextFlag=1; //标记是第一步还是第二步
	String listShow="none";
	
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();
	StringBuffer nameGroupList=new StringBuffer();
	StringBuffer nameListNew=new StringBuffer();
	StringBuffer nameGroupListNew=new StringBuffer();
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());	
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	//String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
	String ProvinceRun = "";
	if (result2 != null && result2.length != 0) {
		ProvinceRun = result2[0][0];
	}
	
	
	//得到页面参数
	String grpOutNo = "";
	String idcMebNo   ="";
	String smCode      ="";
	String smName    ="";
	String custName    ="";
	String userPassword    ="";
	String runCode      ="";
	String runName  ="";
	String ownerGrade   ="";
	String gradeName="";
	String ownerType ="";
	String ownerTypeName   ="";
	String custAddr   ="";
	String idType="";
	String idName="";
	String idIccid="";
	String card_name="";
	String totalOwe="";
	String totalPrepay="";
	String firstOweConNo="";
	String firstOweFee="";
	String bak_field="";
	String backPrepay="";
	String backInterest="";
	String notBackPrepay="";
	String openTime="";
	String grpIdNo="";
	String iccid="";
	String idNo="";
	String temp_buf="";
	Vector temp=new Vector();
	StringBuffer fieldCode=new StringBuffer();
	StringBuffer fieldCode2=new StringBuffer();//for add item


	StringBuffer numberList=new StringBuffer();
	System.out.println("1");
	//得到列表操作
	String action=request.getParameter("action");
	String []   paramsArray=new String [38];
	String [][] paramsOut=new String[][]{};	
	String [][] paramsOut26=new String[][]{};
	String [][] paramsOut27=new String[][]{};
	String [][] paramsOut28=new String[][]{};
	String [][] paramsOut29=new String[][]{};
	String [][] paramsOut30=new String[][]{};
	String [][] paramsOut31=new String[][]{};
	String [][] userFieldGrpNo=new String[][]{}; 
	String [][] userFieldGrpName=new String[][]{};
	String [][]userFieldMaxRows=new String[][]{};
	String [][]userFieldMinRows=new String[][]{};
	String [][]userFieldCtrlInfos=new String[][]{};
	String modeType=request.getParameter("userType");
	String error_code="9";
	String error_msg="";
	int resultListLength=0;
	if (action!=null&&action.equals("query")){
		//try{
			grpIdNo=request.getParameter("grpIdNo");
			iccid=request.getParameter("iccid");
			 idcMebNo=request.getParameter("idcMebNo");			
		     	 String [] paramsIn=new String []{workno,grpIdNo,"3517"};
		     	 %>
		     	 	<wtc:service name="s3517Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="38" >
					<wtc:param value="<%=workno%>"/>
					<wtc:param value="<%=grpIdNo%>"/>
					<wtc:param value="3517"/>					
				</wtc:service>
				<wtc:array id="paramsOut1" start="0" length="38" scope="end"/>
				<wtc:array id="paramsOut261" start="26" length="4" scope="end"/>
				<wtc:array id="paramsOut271" start="27" length="1" scope="end"/>
				<wtc:array id="paramsOut281" start="28" length="1" scope="end"/>
				<wtc:array id="paramsOut291" start="29" length="1" scope="end"/>
				<wtc:array id="paramsOut301" start="30" length="1" scope="end"/>
				<wtc:array id="paramsOut311" start="31" length="1" scope="end"/>
				<wtc:array id="userFieldGrpNo1" start="32" length="1" scope="end"/>
				<wtc:array id="userFieldGrpName1" start="33" length="1" scope="end"/>
				<wtc:array id="userFieldMaxRows1" start="34" length="1" scope="end"/>
				<wtc:array id="userFieldMinRows1" start="35" length="2" scope="end"/>				
				<wtc:array id="userFieldCtrlInfos1" start="37" length="1" scope="end"/>
		     	 <%
		     	 	paramsOut=paramsOut1;
		     	 	paramsOut26=paramsOut261;
		     	 	paramsOut27=paramsOut271;
		     	 	paramsOut28=paramsOut281;
		     	 	paramsOut29=paramsOut291;
		     	 	paramsOut30=paramsOut301;
		     	 	paramsOut31=paramsOut311;
		     	 	userFieldGrpNo=userFieldGrpNo1;
		     	 	userFieldGrpName=userFieldGrpName1;
		     	 	userFieldMaxRows=userFieldMaxRows1;
		     	 	userFieldMinRows=userFieldMinRows1;
		     	 	userFieldCtrlInfos=userFieldCtrlInfos1;
			if(paramsOut!=null&&paramsOut.length>0){
				 for (int i=0;i<26;i++){				
					paramsArray[i]=paramsOut[0][i];
				 }
			}
			
			for (int i=0;i<paramsOut26.length;i++){
				fieldCode.append(paramsOut26[i][0]+"|");				
			}
			
System.out.println("2");
			/*paramsOut27=(String[][])retArray.get(27);
			paramsOut28=(String[][])retArray.get(28);
			paramsOut29=(String[][])retArray.get(29);
			paramsOut30=(String[][])retArray.get(30);
			paramsOut31=(String[][])retArray.get(31);
			userFieldGrpNo=(String[][])retArray.get(32);
			userFieldGrpName=(String[][])retArray.get(33);
			userFieldMaxRows=(String[][])retArray.get(34);
			userFieldMinRows=(String[][])retArray.get(35);
			userFieldCtrlInfos=(String[][])retArray.get(37);*/
			
System.out.println("3");
			if(paramsOut30!=null&&paramsOut30.length>0){
				for (int i=0;i<paramsOut30.length;i++){		
					if (paramsOut30[i][0].equals("14")){
						temp.add(paramsOut26[i][0]);
					}
				}
			}
			System.out.println("000000000000000000000000000000000000000");
			
			 error_code=retCode2;             		
             		error_msg=retMsg2;
			 nextFlag=2;
			 listShow="";
				//得到数据的行数
				//得到具体数据
			//得到集团用户编码add
			if(!error_code.equals("000000"))
			{
%>
				<script language="javascript">
					rdShowMessageDialog("错误代码：<%=error_code%>错误信息：<%=error_msg%>",0);
					history.go(-1);
				</script>
<%
			}

//------------add by hansen-------------
//----得到该用户没有添加的项
		sqlStr="select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,b.ctrl_info"
         +"  from sUserFieldCode a,SGRPSMFIELDRELA b"
         +" where a.busi_type = b.busi_type"
            +" AND a.busi_type = '1000'"
         +"     AND a.field_code=b.field_code"
         +"     AND b.user_type = '"+paramsArray[9]+"'"
         +"   and a.field_code in("
         +" SELECT a.field_code"
             +"      FROM suserfieldcode a, SGRPSMFIELDRELA b"
             +"      WHERE a.busi_type = b.busi_type"
             +"      AND a.field_code = b.field_code"
             +"      AND a.busi_type = '1000'"
             +"      AND b.user_type = '"+paramsArray[9]+"'"
             +"      and b.field_grp_no ='0'"
             +"      MINUS"
             +"      SELECT a.field_code"
             +"      FROM DGRPUSERMSGADD a, SGRPSMFIELDRELA c"
             +"      WHERE a.busi_type = '1000'"
             +"      AND a.id_no = '"+paramsArray[0]+"'"
             +"      AND a.busi_type = c.busi_type"
             +"      AND a.field_code = c.field_code"
             +"      AND a.user_type = c.user_type)"
             +" order by b.field_order,a.field_type";
			//resultList2=(String[][])callView.sPubSelect("6",sqlStr).get(0);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="6">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result3" scope="end" />
			<%
			resultList2=result3;
			System.out.println("----------------"+resultList2.length+"----------------------");
			if (resultList2 != null&&resultList2.length>0)
			{
				if (resultList2[0][0].equals(""))
				{
					resultList2 = null;
				}
			}
			if (resultList2 != null&&resultList2.length>0)
			{
				for(int i=0;i<resultList2.length;i++)
				{
					if (resultList2[i][2].equals("10")){
						numberList.append(resultList2[i][0]+"|");
					}
				}
			}

			resultListLength2=0;
			if (resultList2 != null&&resultList2.length>0){
				resultListLength2=resultList2.length;
				//代码拼串传递到下个页面
			    for (int i=0;i<resultListLength2;i++){
					fieldCode2.append(resultList2[i][0]+"|");
					System.out.println("============:"+resultList2[i][0]);
				}
			}
		  	

//---------------------------


		
	}
%>
<HTML>
	<HEAD>
	<TITLE>集团产品资料变更</TITLE>	
	<SCRIPT type=text/javascript>	
		onload=function(){		    
		}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.userPassword.value = "";
	        	frm.userPassword.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.sysnote.value ="集团产品资料变更"+document.frm.idcMebNo.value;
                document.frm.tonote.value = "集团产品资料变更"+document.frm.idcMebNo.value;
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！");
    		return false;
        }
     }	
	 if(retType == "check_no") //集团用户编码
     {
        if(retCode == "000000")
        {
            var tmp_fld = packet.data.findValueByName("tmp_fld");
            if (tmp_fld == "false") {
    	    	rdShowMessageDialog("集团用户编码校验失败，请重新输入！",0);
    	    	return false;	        	
            } else {
				GetIdcMebNo();
            }
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
            rdShowMessageDialog(retMsg);
			document.frm.grpOutNo.focus();
    		return false;
        }
     }
	 if(retType == "getCheckInfo")
	{   //得到支票信息
        var obj = "checkShow"; 
        if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0.00"){
                frm.bankCode.value = "";
                frm.bankName.value = "";                
                frm.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("该支票的帐户余额为0！");
            }
            else {   
					document.all(obj).style.display = "";            
			        frm.bankCode.value = bankCode;
					frm.bankName.value = bankName;
		            frm.checkPrePay.value = checkPrePay;
					if(frm.real_handfee.value==''){//add
						frm.checkPay.value='0.00';
					}
					else
					{
					    frm.checkPay.value = frm.real_handfee.value;
					}
			}
		}
    	else
    	{
    		frm.checkNo.value = "";
            frm.bankCode.value = "";
            frm.bankName.value = "";
            document.all(obj).style.display = "none"; 
            frm.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}
	 //取流水
	if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
            var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;

			var prtFlag=0;
			var confirmFlag=0;
			prtFlag = rdShowConfirmDialog("是否打印电子免填单？");
			//提交打印界面		

			if (prtFlag==1) {

			var printPage="<%=request.getContextPath()%>/npage/s3517/sGrpPubPrint.jsp?op_code=3517"
														+"&phone_no=" +document.all.idcMebNo.value       
														+"&function_name=集团产品资料变更"   
														+"&work_no="+"<%=workno%>"        
														+"&cust_name="+document.all.custName.value     
														+"&login_accept="+document.all.login_accept.value 
														+"&idIccid=" +"<%=iccid%>"       
														+"&hand_fee=" +document.all.real_handfee.value       
														+"&mode_name="+document.all.smName.value       
														+"&custAddress="+document.all.custAddr.value     
														+"&system_note="+document.all.sysnote.value     
														+"&op_note="+document.all.tonote.value          
														+"&space="           
														+"&copynote="
														+"&pay_type=";

		   var printPage2 = window.open(printPage,"","width=200,height=200")
		   
	    } 
		confirmFlag = rdShowConfirmDialog("是否提交本次操作？");
		if (confirmFlag==1) {
	     //不打印需要的相应操作
		    spellList();
		    frm.action="f3517_2.jsp";
			frm.method="post";
		    frm.submit();
	    }
      }
        else
        {
                rdShowMessageDialog("查询流水出错,请重新获取！");
				return false;
        }
	 }
}
	function changePayType(){
		if (document.all.checkPayTR.style.display=="none"){
			document.all.checkPayTR.style.display="";
		}
		else {
			document.all.checkPayTR.style.display="none";
		}
	}
	function getBankCode()
	{ 
	  	//调用公共js得到银行代码
	    if(frm.checkNo.value.trim()== "")
	    {
	        rdShowMessageDialog("请输入支票号码！",0);
	        frm.checkNo.focus();
	        return false;
	    }
	    var getCheckInfo_Packet = new AJAXPacket("getBankCode.jsp","正在获得支票相关信息，请稍候......");
		getCheckInfo_Packet.data.add("retType","getCheckInfo");
	    getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
		core.ajax.sendPacket(getCheckInfo_Packet);
		getCheckInfo_Packet=null; 
	 }
	function check_HidPwd()
	{
	    var cust_id = document.frm.idcMebNo.value;
	    var Pwd1 = document.frm.userPassword.value;
	    var checkPwd_Packet = new AJAXPacket("pubCheckPwdIDC.jsp","正在进行密码校验，请稍候......");
	    checkPwd_Packet.data.add("retType","checkPwd");
		checkPwd_Packet.data.add("cust_id",cust_id);
		checkPwd_Packet.data.add("Pwd1",Pwd1);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;	
		
	}
	 //下一步
	function nextStep(){
		if(frm.grpIdNo.value.trim() == "")
	  {
	      rdShowMessageDialog("请输入集团用户编码！");
	      frm.grpIdNo.focus();
	      return false;
	  }
		frm.action="f3517_1.jsp?action=query";
		frm.method="post";
		frm.submit();
		frm.next.disabled=true;//add
	}
	//上一步
	function previouStep(){
		frm.action="f3517_1.jsp";
		frm.method="post";
		frm.submit();
	}
	//打印信息
	function printInfo(printType)
	{
	     var retInfo = "";
	    //getChinaFee(frm1104.sumPay.value);
	    if(printType == "Detail")
	    {	//打印电子免填单
	        retInfo+=document.frm.idcMebNo.value+"|"+"身份证号"+"|";
			retInfo+="<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
			retInfo = retInfo + "15|10|10|0|" +document.frm.idcMebNo.value+ "|";   //手机号	
	        retInfo = retInfo + "5|19|9|0|" + "集团产品资料变更（业务发票）" + "|"; //业务项目    
	 	}  
	 	return retInfo;	
	}
	//显示打印对话框
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  
	   var h=150;
	   var w=350;
	   var t=screen.availHeight/2-h/2;
	   var l=screen.availWidth/2-w/2;
	   var printStr = printInfo(printType);
	   if(printStr == "failed")
	   {    return false;   }
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	   var path = "gdPrint.jsp?DlgMsg=" + DlgMessage;
	   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	   var ret=window.showModalDialog(path,"",prop);
	}
	//取流水
	function getSysAccept()
	{
		var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
		getSysAccept_Packet.data.add("retType","getSysAccept");
		core.ajax.sendPacket(getSysAccept_Packet);
		getSysAccept_Packet=null;
	}
	function refMain(){
		getAfterPrompt();
			if(!checkDynaFieldValues(true))
				return false;
	
			//if(!checkDynaFieldValues2(true))
				//return false;
	
			if (!calcAllFieldValues())
				return false;
			if(document.frm.sm_code.value=="MM")
		{
			if(document.all.F10340.value=="01")
			{
				if(document.all.F10341.value.trim()=="")
				{
					rdShowMessageDialog("专用APN的APN值不能为空!!");
					document.all.F10341.select();
		            return false;
				}
			}
		}
			var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
			//判断金额
			/*if(!checkElement("real_handfee")) return false;
	        if (parseFloat(document.frm.real_handfee.value)>parseFloat(document.frm.should_handfee.value))
	        {
					rdShowMessageDialog("实收手续费不应大于应收手续费");
					document.frm.real_handfee.focus();
					return false;	
	        }
			if (parseFloat(document.frm.checkPay.value)!=parseFloat(document.frm.real_handfee.value))
	        {
					rdShowMessageDialog("支票交款应等于实收手续费");
					document.frm.checkPay.focus();
					return false;	
	        }
			if (parseFloat(document.frm.checkPay.value)>parseFloat(document.frm.checkPrePay.value))
	        {
					rdShowMessageDialog("支票交款应小于支票余额");
					document.frm.checkPay.focus();
					return false;	
	        }
			if (parseFloat(document.frm.should_handfee.value)==0)
			{
				document.frm.real_handfee.value="0.00";
			}*/
			//说明：检测分成两类,一类是数据是否是空,另一类是数据是否合法
			getSysAccept()
	}
	//判断集团用户编码是否存在
	function GetIdcMebNo2()
	{
		var my_Packet = new AJAXPacket("fpubcheck_no.jsp","正在检验集团用户编码，请稍候......");
		my_Packet.data.add("grpOutNo",document.frm.grpOutNo.value);
		my_Packet.data.add("retType","check_no");
		core.ajax.sendPacket(my_Packet);
		my_Packet=null
	}
	//获得主套餐
	function GetIdcMebNo()
	{
		var pageTitle = "IDC成员编码查询";
	    	var fieldName = "成员用户ID|成员编码|业务类型";
		var sqlStr = "select member_id,member_no,e.sm_name"
	              +"  from dGrpUserMebMsg a,dGrpUserMsg b,dAccountIdInfo c,"
	              +" sBusiTypeSmCode d,sSmCode e"
	              +" where a.id_no=b.id_no"
	              +" and b.user_no=c.msisdn"
	              +" and b.sm_code=c.service_type"
	              +" and c.service_no='"+document.frm.grpOutNo.value+"'"
	              +" and c.service_type=d.sm_code"
	              +" and d.busi_type='1000'"
	              +" and c.service_type=e.sm_code"
	              +" and e.region_code='"+document.frm.OrgCode.value.substring(0,2)+"'";
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "1|1";
		var retToField = "idcMebNo";
		var returnNum="3";
		PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum);
	}

	//调用公共界面，进行集团客户选择
		function getInfo_Cust()
	{
	    var pageTitle = "集团客户选择";
	    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团ID|付费帐户|品牌名称|品牌代码|";
		var sqlStr = "";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
	    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
	    var cust_id = document.frm.cust_id.value;
	    if(document.frm.iccid.value == "" &&
	       document.frm.cust_id.value == "" &&
	       document.frm.unit_id.value == "" &&
	       document.frm.user_no.value == "")
	    {
	        rdShowMessageDialog("请输入身份证号、客户ID、集团ID或集团用户编号进行查询！",0);
	        document.frm.iccid.focus();
	        return false;
	    }
	
	    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
	    {
	    	frm.cust_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
	    {
	    	frm.unit_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.user_no.value == "0")
	    {
	    	frm.user_no.value = "";
	        rdShowMessageDialog("集团用户编号不能为0！",0);
	    	return false;
	    }
	
	    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
	}

	function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	    var path = "<%=request.getContextPath()%>/npage/s3517/f3517_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
	    path = path + "&cust_id=" + document.all.cust_id.value;
	    path = path + "&unit_id=" + document.all.unit_id.value;
	    path = path + "&user_no=" + document.all.user_no.value;
	
	    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	
		return true;
	}
	function getvaluecust(retInfo)
	{
	  var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
	  if(retInfo ==undefined)      
	    {   return false;   }
	
		var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	        
	    }
	    nextStep()
	}
	
	
function ctrlF10340(selectId)
{
	var f10340txt = "";
	var f10341txt = "";
	if(selectId.value == "11")
	{
		f10340txt = "<select id='F10340' name='F10340' datatype=66 onchange='ctrlF10341(frm.F10340);'>";
		f10340txt = f10340txt + "<option  value='00'>00--无专用APN</option>";
		f10340txt = f10340txt + "<option  value='01'>01--专用APN</option>";
		f10340txt = f10340txt + "</select>";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";		
		
	}
	else
	{
		f10340txt = "<input id='F10340' name='F10340'  class='button' type='hidden' datatype=66  value='0'>&nbsp";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10340.innerHTML=f10340txt;
	divF10341.innerHTML=f10341txt;
}


function ctrlF10341(selectId)
{
	var f10341txt = "";
	if(selectId.value == "01")
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='text' datatype=67  value=''>";
	}
	else
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10341.innerHTML=f10341txt;
}	
	
	
	
</script>
</HEAD>
<BODY>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">集团用户资料变更</div>
		</div>	
		<input type="hidden" name="product_code" value="">
		<input type="hidden" name="product_level"  value="1">
		<input type="hidden" name="op_type" value="1">
		<input type="hidden" name="grp_no" value="0">
		<input type="hidden" name="tfFlag" value="n">
		<input type="hidden" name="chgpkg_day"   value="">
		<input type="hidden" name="TCustId"  value="">
		<input type="hidden" name="unit_name"  value="">
		<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
		<input type="hidden" name="op_code"  value="3517">
		<input type="hidden" name="OrgCode"  value="<%=org_code%>">
		<input type="hidden" name="region_code"  value="<%=regionCode%>">
		<input type="hidden" name="district_code"  value="<%=districtCode%>">
		<input type="hidden" name="WorkNo"   value="<%=workno%>">
		<input type="hidden" name="NoPass"   value="<%=nopass%>">
		<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
		<input type="hidden" name="grpOutNo"   value="">
		<input type="hidden" name="custAddr"   value="">
		<input type="hidden" name="idIccid"   value="">
		<input type="hidden" name="unit_idAdd"   value="<%=unit_id%>">


        <TABLE  cellSpacing=0>
	    <TR style="display:<%=listShow.equals("")?"none":""%>">
	        <TD width="18%" class="blue">
	              身份证号
	        </TD>
            	<TD width="32%">
                <input name=iccid  id="iccid" size="20" maxlength="18" v_type="string" v_must=1  index="1">
                <input name=custQuery class="b_text" type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor：hand" value=查询>
            </TD>
            <TD width="18%" class="blue">集团客户ID</TD>
            <TD width="32%">
             	<input  type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1  index="2">
            </TD>
          </TR>
          <TR style="display:<%=(listShow.equals("")?"none":"")%>">
            <TD class="blue">
               集团ID
            </TD>
            <TD>		    
               <input name=unit_id  id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1  index="3">            
            </TD>
            <TD class="blue" width="18%">集团用户编号</TD>
            <TD>
              <input  name="user_no" size="20" v_must=1 v_type=string  index="4">
            </TD>
          </TR>
          <TR>
	     <TD width=18% nowrap class="blue"> 集团用户ID</TD>
             <TD width="82%" colspan=3>
		<input name=grpIdNo  id="grpIdNo" size="24" maxlength="15" v_type="0_9" v_must=1  index="3" value="<%=grpIdNo%>">
		<font class="orange">*</font>
		              <input type="hidden" name="cust_name">
		              <input type="hidden" name="grp_name">
		              <input type="hidden" name="product_code2">
		              <input type="hidden" name="product_name2">
		              <input type="hidden" name="account_id">
		              <input type="hidden" name="sm_name">
		              <input type="hidden" name="sm_code">
	    </TD> 
					
	</TR>
        </TABLE>
	<!---- 隐藏的列表-->
        <TABLE  cellSpacing=0  style="display:<%=listShow%>">
	   <TR>
            <TD width="18%" class="blue">
              集团用户号码
            </TD>
            <TD width="32%">
                <input name="idcMebNo"  id="idcMebNo" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="<%=paramsArray[1]%>" readonly>
                <font class="orange">*</font>
            </TD>
	    <TD width=18% class="blue">客户名称</TD>
            <TD width="32%">
              <input name=custName  id="custName" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="<%=paramsArray[4]%>" readonly>
            </TD>
          </TR>
          <TR>
            <TD width="18%" class="blue">品牌名称</TD>
            <TD width="32%">
              <input  name="smName" size="24" readonly v_must=1 v_type=string  index="4" value="<%=paramsArray[2]%>" readonly>
            </TD>
            <TD class="blue">产品名称</TD>
            <TD>
              <input  name="smName" size="24" readonly v_must=1 v_type=string  index="4" value="<%=paramsArray[3]%>" readonly>
            </TD>
          </TR>
          <TR>
            <TD class="blue">集团产品密码</TD>
            <TD colspan="3">
           	<%if(!ProvinceRun.equals("20"))  //不是吉林
			  		{
					%>  
                <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
	            <jsp:param name="pname" value="userPassword"  />
	            <jsp:param name="pwd" value=""  />
 	            </jsp:include>
          <%}else{%>
 	            <input name=userPassword type="password"  id="custPwd" size="6" maxlength="6" v_must=1>
         <%}%>
            <input name=chkPass type=button onClick="check_HidPwd();"  class="b_text" style="cursor：hand" id="chkPass2" value=校验>
	    <font class="orange">*</font>
	   </TD>
          </TR>		
          </TABLE>
         
		  
	<%
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$111111");
		//为include文件提供数据
		int fieldCount=paramsOut28.length;
		
		//fieldCount=9;	//add
		boolean isGroup = false;
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];//add
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldGrpName=new String[fieldCount];
		String []fieldGrpNo=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		String userType=paramsArray[9];
		int iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=paramsOut26[iField][0];
			fieldNames[iField]=paramsOut28[iField][0];
			fieldPurposes[iField]=paramsOut29[iField][0];//add
			fieldValues[iField]=paramsOut27[iField][0];
			dataTypes[iField]=paramsOut30[iField][0];
			fieldLengths[iField]=paramsOut31[iField][0];
			fieldGrpNo[iField]=userFieldGrpNo[iField][0];
			fieldGrpName[iField]=userFieldGrpName[iField][0];
			fieldCtrlInfos[iField]=userFieldCtrlInfos[iField][0];
			
			iField++;
		}
	%>
	
		<% //------add by hansen-----
		//为include文件提供数据  
		int fieldCount2=resultListLength2;
		String []fieldCodes2=new String[fieldCount2];
		String []fieldNames2=new String[fieldCount2];
		String []fieldPurposes2=new String[fieldCount2];
		String []fieldValues2=new String[fieldCount2];
		String []dataTypes2=new String[fieldCount2];
		String []fieldLengths2=new String[fieldCount2];
		String []fieldCtrlInfos2=new String[fieldCount2];
		int iField2=0;
		while(iField2<fieldCount2)
		{
		
			fieldCodes2[iField2]=resultList2[iField2][0];
			fieldNames2[iField2]=resultList2[iField2][1];
			fieldPurposes2[iField2]=resultList2[iField2][2];
			fieldValues2[iField2]="";
			dataTypes2[iField2]=resultList2[iField2][3];
			fieldLengths2[iField2]=resultList2[iField2][4];
			fieldCtrlInfos2[iField2]=resultList2[iField2][5];
			
			iField2++;
		}
	%>
	<%@ include file="fpubDynaFields_modify.jsp"%>	
        <TABLE  cellSpacing=0  style="display:<%=listShow%>">
	<TR style='display:none'>
		  <%
			
				String result_hand = "0.0";	 
				sqlStr = "select hand_fee from snewfunctionfee where function_Code ='3517'";
				%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode30" retmsg="retMsg30" outnum="1">
							<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result35" scope="end" />
				<%
	                	//retArray = callView.sPubSelect("1",sqlStr);
		            	//result = (String[][])retArray.get(0); 
		            	if(result35!=null&&result35.length>0){
				           if (!"".equals(result35[0][0])){
						result_hand=result35[0][0];
					}
				 }					
				
				
			%>
			
				<TD width="18%" class="blue">应收手续费</TD>
				<TD width="32%">
				<input  name="should_handfee" id="should_handfee" value="<%=result_hand%>" readonly>
				</TD>
				<TD width="18%" class="blue">实收手续费</TD>
				<TD width="32%">
				<input  name="real_handfee" id="real_handfee" value="0" v_must=0  v_type=money>
			    </TD>
		   </TR>
		   <TR style='display:none'>
				<TD width="18%" class="blue">付款方式</TD>
				<TD width="32%" colspan="3">
				        <select name='payType' onchange='changePayType()'>
					<option value='1'>现金</option>
					<option value='2'>支票</option>
					</select><font class="orange">*</font>
				</TD>
		 </TR>
		<TR id='checkPayTR' style="display:none"> 
	                <TD width="18%" nowrap class="blue"> 
	                   支票号码
	                </TD>
	                <TD width="32%" nowrap> 
	                    <input  v_must=0  v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
	                    <font class="orange">*</font>
			    <input name=bankCodeQuery type=button  class="b_text" style="cursor:hand" onClick="getBankCode()" value=查询>
			</TD>
	                <TD width="18%" nowrap class="blue"> 
	                    银行代码
	                </TD>
	                <TD width="32%" nowrap> 
	                    <input name=bankCode size=12  maxlength="12" readonly>
			    <input name=bankName size=20  readonly>
	                </TD>                                              
            </TR>
	    <TR  id='checkShow' style='display:none'> 
                  <TD width=18% nowrap class="blue"> 
                    支票交款
                  </TD>
            	<TD width="32%">
              	    <input v_must=0  v_type=money v_account=subentry name=checkPay value=0.00 maxlength=15 index="51" >
                    <font class="orange">*</font> </TD> 
                  <TD width=18% class="blue"> 
                    支票余额
                  </TD>
                  <TD width=32%> 
                    <input  name="checkPrePay" value=0.00 readonly>
                  </TD>               
            </TR>
	    <TR >
               <TD width="18%" class="blue">备注</TD>
               <TD colspan="3">
               <input  name="sysnote" size="60" value="集团产品资料变更" readonly >
               </TD>
           </TR>       
       </TABLE>
 <!-----------隐藏的列表-->
        <TABLE cellSpacing="0">        
            <TR>
              <TD id="footer">
			 <%
			 if (nextFlag==1){
			 %>
			 &nbsp;
			  <input name="next"   type=button class="b_foot" value="查询" class="b_text" onclick="nextStep()">
			 <%
			 }else {
			 %>			
			 &nbsp;
			  <input  name="previous"  class="b_foot" type=button value="上一步" onclick="previouStep()">
			  &nbsp;
              		  <input  name="sure"  class="b_foot" type=button value="确认" onclick="refMain()" disabled>
			 <%
			 }
			 %>
              		&nbsp; 
              		<input  name=back  class="b_foot" type=button value="清除" onclick="window.location='f3517_1.jsp'">
			&nbsp;
              		<input  name="kkkk"  class="b_foot" onClick="removeCurrentTab()" type=button value="关闭">
              	     </TD>
            </TR>	
        </TABLE>
      			<!-------------隐藏域--------------->
			<input type="hidden" name="modeCode" value="">
			<input type="hidden" name="oldPwd" value="<%=(paramsArray[4])%>">
			<input type="hidden" name="modeType" value="<%=paramsArray%>">
			<input type="hidden" name="typeName">
			<input type="hidden" name="addMode">
			<input type="hidden" name="modeName">
			<input type="hidden" name="nameList"  value="<%=nameList%>">
			<input type="hidden" name="nameValueList"  value="<%=nameValueList%>">
			<input type="hidden" name="nameGroupList"  value="<%=nameGroupList%>">
			<input type="hidden" name="nameListNew"  value="<%=nameListNew%>">
			<input type="hidden" name="nameGroupListNew"  value="<%=nameGroupListNew%>">
			<input type="hidden" name="fieldNamesList">
			<input type="hidden" name="choiceFlag">
			<input type="hidden" name="tonote" size="60" value="集团产品资料变更">
			<!-------------隐藏域--------------->
			<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>  
</FORM>
	 <script language="JavaScript">
	 	 <%if (nextFlag==1){%>
	 		document.frm.grpIdNo.focus();
	  	<%}%>
		<%
		if (nextFlag==2){
			out.println("calcAllFieldValues();");
		}
		%>
	 </script>
</BODY>
</HTML>
