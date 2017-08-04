<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 用户属性修改1256
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String rightCode = (String)session.getAttribute("rightCode");
	String opCode="e068";
	String opName="信誉度综合管理页面";
	String phoneNo = (String)request.getParameter("activePhone");
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String org_codeT = (String)session.getAttribute("orgCode");
	String region_codeT = (String)session.getAttribute("regCode");
	String ipAdd = (String)session.getAttribute("ipAddr");
	//xl add for 联动
	String querysql = "select parent_code, child_code,child_name from sCreditCfg ";
	String limit_sql = "select to_char(limit_grade),to_char(child_code) from sCreditCfg ";

	//xl add for 首席查询
	String[] sx_sql0 = new String[2];
	sx_sql0[0] = "select to_char(sx_phone_no1),to_char(sx_job1) from wcreditcfgopr where phone_no =:s_no ";
	sx_sql0[1] = "s_no="+phoneNo;
	String[] sx_sql1 = new String[2];
	sx_sql1[0] = "select to_char(sx_phone_no2),to_char(sx_job2) from wcreditcfgopr where phone_no =:s_no ";
	sx_sql1[1] = "s_no="+phoneNo;
	String[] sx_sql2 = new String[2];
	sx_sql2[0] = "select to_char(sx_phone_no3),to_char(sx_job3) from wcreditcfgopr where phone_no =:s_no ";
	sx_sql2[1] = "s_no="+phoneNo;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode_sx0" retmsg="retMsg_sx0" outnum="2">
		<wtc:param value="<%=sx_sql0[0]%>"/>
		<wtc:param value="<%=sx_sql0[1]%>"/>	
		</wtc:service>
	<wtc:array id="sx_0" scope="end" />
	
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode_sx1" retmsg="retMsg_sx1" outnum="2">
		<wtc:param value="<%=sx_sql1[0]%>"/>
		<wtc:param value="<%=sx_sql1[1]%>"/>	
		</wtc:service>
	<wtc:array id="sx_1" scope="end" />

	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode_sx2" retmsg="retMsg_sx2" outnum="2">
		<wtc:param value="<%=sx_sql2[0]%>"/>
		<wtc:param value="<%=sx_sql2[1]%>"/>	
		</wtc:service>
	<wtc:array id="sx_2" scope="end" />

	<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode3" retmsg="retMsg3" outnum="3">
	<wtc:sql><%=querysql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="result0" start="0" length="3" scope="end" />
  
	<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode4" retmsg="retMsg4" outnum="2">
	<wtc:sql><%=limit_sql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="result01" scope="end" />



<%
	String sqIdtype = "select id_type,id_name from sidtype";
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_codeT%>" outnum="2">
   		<wtc:sql><%=sqIdtype%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="sIdTypeStr" scope="end"/>
<%
	int favFlag = 0 ;
	//int gradeFlag = 0;			//用户属性
	int gradeFlag = 1;			//xl 所有用户均可见属性修改
	int offonFlag = 0;			//用户停机
	int qryFlag = 0;			//用户详单查询
	for(int i = 0 ; i < favInfo.length ; i ++){
		if(favInfo[i][0].trim().equals("a1256")){
			gradeFlag = 1;
		}						//对用户属性操作判断
		if(favInfo[i][0].trim().equals("a1257")){
			offonFlag = 1;
		}						//对用户停开机权限判断
		if(favInfo[i][0].trim().equals("a1258")){
			qryFlag = 1;
		}						//对详单查询权限判断
	
	}
	
	//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = workNo;

	System.out.println("====wanghfa====f1232.jsp==== pwrf = " + pwrf);
	if (pwrf) {
		favFlag = 1;
	}
	//2011/6/23 wanghfa添加 对密码权限整改 end
	
	offonFlag=0;
	 String printAccept="";							/****得到打印流水****/
	 printAccept = getMaxAccept();
%>

<%
		String favorcode = "a1256";
		int m =0;
		for(int p = 0;p< favInfo.length;p++){//优惠资费代码
					for(int q = 0;q< favInfo[p].length;q++)
					{
					 if(favInfo[p][q].trim().equals(favorcode))
						 {
						   ++m;
					     }
						}
		       }
%>

<%
	String sql="select function_code,hand_fee,favour_code from sNewFunctionFee where region_code=:region_code and function_code='1256'";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="3" >
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=region_codeT%>"/> 
	</wtc:service>
	<wtc:array id="fee" scope="end"/>
<%
	String tHandFee = "0";
	int feeFlag = 0;
	if(fee.length==0){
		tHandFee="0";
		feeFlag = 0;
	}else{
		tHandFee=fee[0][1];
		for(int i = 0 ; i < favInfo.length ; i ++){
			if(favInfo[i][0].trim().equals(fee[0][2])){
				feeFlag = 1;
			}
		}
	}

/*xl add 722 在init的时候 取出用户属性的下拉框对应的值
 然后sql 先查 if count  owner_code in ('50','51') 52 ...
  如果count>0 说明有值 则是信誉度客户 此时的展现：咋整呢？
  else if  count ouwner_code in 一级 二级 说明是重要的
  else 在用sBillCond这个sql
*/
	
	String sBillCond = "select owner_code,type_name  from scustgradecode  where owner_code in('00','01','02','10','11','12','20', '92','93','94','95','96','97','99') and region_code = '" + region_codeT + "'";
	System.out.println(sBillCond);

	String[] inParas2 = new String[1];
	inParas2[0]="select to_char(job_id),job_name from ssx_jobscfg where job_id<>'0'";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=region_codeT%>"  retcode="retCodejb" retmsg="retMsgjb" outnum="2">
		<wtc:param value="<%=inParas2[0]%>"/> 	
	</wtc:service>
	<wtc:array id="ret_val_jb" scope="end" />

	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_codeT%>" retcode="code1" retmsg="msg1" outnum="2">
   		<wtc:sql><%=sBillCond%></wtc:sql>
   	</wtc:pubselect>
  	<wtc:array id="gradeStr" scope="end" />
<%
	//细化
	String sql_detail = "select parent_code, child_code,child_Name from sCreditCfg where parent_code = '?'  ";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户属性修改</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MShtml 5.00.3315.2870" name=GENERATOR>
</head>
<script language="javascript">
var printFlag=9;
var flag = 0;
var timeFlag = 0;

onload=function(){
	self.status="";
}

function doProcess(packet){
	
	var attr_new1 = packet.data.findValueByName("attr_new1");
	var attr_new2 = packet.data.findValueByName("attr_new2");
	//alert("attr_new1 is "+attr_new1+" and attr_new2 is "+attr_new2);
	document.all.attr1.value=attr_new1;
	document.all.attr2.value=attr_new2;
	var count1 = packet.data.findValueByName("count1");
	var count2 = packet.data.findValueByName("count2");
	//alert("count1 is "+count1+" and count2 is "+count2);
	if(count1>0 ||count2>0)
	{
		document.getElementById("show").value="ok";
	}
	else
	{
		document.getElementById("show").value="no";
	}
	var backString = packet.data.findValueByName("backString");
	var cfmFlag    = packet.data.findValueByName("flag");
	var show_flag    = packet.data.findValueByName("show_flag");
	if(show_flag==0 )
	{
		document.getElementById("Operation_Table2").style.display="block";
		//document.frm.submit2307.disabled=true;
	}
	if(show_flag==1)
	{
		document.getElementById("Operation_Table2").style.display="block";
		//document.frm.submit2307.disabled=true;
	}
	document.frm.submit2307.disabled=false;
	//new 判断“信誉度修改”的按钮是否可用 submit2307

	var backString2307 = packet.data.findValueByName("backString2307");
	var cfmFlag2307 = packet.data.findValueByName("flag1");
	 //e068Cfm
	var creditCfg = packet.data.findValueByName("creditCfg");
	var flag_new = packet.data.findValueByName("flag_new");
	var flagInit = packet.data.findValueByName("flagInit");
	if(cfmFlag==0 ||cfmFlag==9||cfmFlag==1||cfmFlag==99  )
	{
		if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			var errCodeInt = parseInt(errCode);
			if(errCodeInt==0){
				rdShowMessageDialog("操作成功！",2);
				document.frm.backLoginAccept.value=backString[0][0];
				if(document.frm.handFee.value!=0){
					printBill();
				}
			flag=0;
			resett();
			}else{
				rdShowMessageDialog(errCode + " : " + errMsg);
				resett();
				return;
			}
		}
	if(cfmFlag==9){
		rdShowMessageDialog("该号码不存在！");
		document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag=0;
				return;
	}
	if(cfmFlag ==0)
	{
		if(backString==""){
		rdShowMessageDialog("查询失败！");
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		document.frm.phoneNo.value="";
		}
		else
		{
			if(document.frm.favFlag.value==1)
			{
				//document.frm.submit.disabled=false;
			}
			document.frm.customPass.value=backString[0][4];
			document.frm.userId.value=backString[0][0];
			document.frm.smName.value=backString[0][2];
			document.frm.runName.value=backString[0][6];
			document.frm.cardType.value=backString[0][15];
			document.frm.custAddress.value=backString[0][11];
			document.frm.asCustName.value=backString[0][23];
			document.frm.asCustPhone.value=backString[0][24];
			var idI = 0 ;
			for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
				
				if(document.frm.asIdType.options[idI].value==backString[0][25]){
					document.frm.asIdType.options[idI].selected=true;
					break;
				}
			}
			document.frm.asIdIccid.value=backString[0][26];
			document.frm.asIdAddress.value=backString[0][27];
			document.frm.asContractAddress.value=backString[0][28];
			document.frm.asNotes.value=backString[0][29];
			document.frm.idCardNo.value=backString[0][14];
			document.frm.totalPrepay.value=backString[0][17];
			document.frm.totalOwe.value=backString[0][16];
			document.frm.custName.value=backString[0][3];
			var creditI = 0;
			if(document.frm.gradeCode.length>1){
				for(creditI = 0 ; creditI < document.frm.gradeCode.length ; creditI ++){
					if(document.frm.gradeCode.options[creditI].value==backString[0][21]){
						document.frm.gradeCode.options[creditI].selected=true;
						document.frm.oldGradeName.value=document.frm.gradeCode.options[creditI].text;
						creditI = 99;
						break;
					}
				}
			}
			var objSe1 = backString[0][21];
			if(objSe1 ==50 ||objSe1 ==51 ||objSe1 ==52 ||objSe1 ==53 ||objSe1 ==54 ||objSe1 ==55 ||objSe1 ==56)
			{
				document.getElementById("gradeCodeId").value = 10;
				document.getElementById("Operation_Table1").style.display="block";
				//document.frm.submit2307.disabled=true;
				if(flagInit==0)
				{
					var sCreditInit = packet.data.findValueByName("sCreditInit");
					document.all.xydpz_ed.value=sCreditInit[0][1];
					document.all.xydpz_dqsj.value=sCreditInit[0][2];
					document.all.xydpz_lxrxm.value=sCreditInit[0][3];
					document.all.xydpz_lxfs.value=sCreditInit[0][4];
					document.all.xydpz_jlxm.value=sCreditInit[0][5];
					document.all.xydpz_jllxfs.value=sCreditInit[0][6];
				 }
				//xl end e068Cfm返回值处理
				document.getElementById("Operation_Table3").style.display="none";
				var myEle1 ;
				var x1 ;
				for (var q1=document.all.codeDetail.options.length;q1>=0;q1--) document.all.codeDetail.options[q1]=null;
				myEle1 = document.createElement("option") ;
				myEle1.value = "";
				myEle1.text ="--请选择--";
				document.all.codeDetail.add(myEle1) ;
				for ( x1 = 0 ; x1 < user_code.length  ; x1++ )
				{		if ( user_code[x1] ==10)
						{
							myEle1 = document.createElement("option") ;
							myEle1.value = credit_code[x1];
							myEle1.text = credit_value[x1];
							document.all.codeDetail.add(myEle1) ;
						}
				}
				//xl add 此时如果div1的"细化用户属性-信誉客户"不是“请选择”，则确认按钮可用
				var test_1 = document.getElementById("codeDetail");
				var test_code = test_1.options[test_1.selectedIndex].value;
				
				var test_real_detail = objSe1;
				//alert("test_code is "+test_code+" and test_real_detail is "+test_real_detail);
				if(test_code!=" "  )
				{
					var _options = document.getElementById('codeDetail').options; 
					for(var i = 0 ; i < _options.length;i++) 
					{
						if(_options[i].value==test_real_detail)
						{
							 
							_options[i].selected=true;
							 
						}
					}//document.getElementById("codeDetail").options[index].selected=true; 
				//	document.frm.submit1_xydpz.disabled=false;
				}
				else
				{
				//	document.frm.submit1_xydpz.disabled=true;
					alert("此处需建表并传值给下拉框 "+test_code);
				}
			//xl end new
					//补充 e068cfm 下拉框选中值的处理
					//alert("flagInit is "+flagInit);
					if(flagInit==0)
					{
						var objSel = document.getElementById("codeDetail");
						for(var i=0;i<objSel.length;i++){  
							//alert("sCreditInit[0][0] is "+sCreditInit[0][0]);
							if(objSel.options[i].value==sCreditInit[0][0]){  
							 objSel.options[i].selected=true;  
							 break;  
						  }  
						}
					}
				document.all.grade_old.value=10;	 
			}
			//if(objSe1 ==90 ||objSe1 ==91)
			if(objSe1 ==80 ||objSe1 ==81)
			{
				document.getElementById("gradeCodeId").value = 12;
				//xl new
				document.getElementById("Operation_Table3").style.display="block";
				//document.frm.submit2307.disabled=true;
				document.getElementById("Operation_Table1").style.display="none";
				var myEle1 ;
				var x1 ;
				for (var q1=document.all.codeDetail2.options.length;q1>=0;q1--) document.all.codeDetail2.options[q1]=null;
				myEle1 = document.createElement("option") ;
				myEle1.value = "";
				myEle1.text ="--请选择--";
				document.all.codeDetail2.add(myEle1) ;
				
				for ( x1 = 0 ; x1 < user_code.length  ; x1++ )
				{		if ( user_code[x1] ==12)
						{
							//alert("123 "+objSel);
							myEle1 = document.createElement("option") ;
							myEle1.value = credit_code[x1];
							myEle1.text = credit_value[x1];
							document.all.codeDetail2.add(myEle1) ;
						}
				}
				//document.frm.submit_zykh.disabled=false;
				//xl end new
				//xl add 728 重要客户细节展示 begin
				if(flagInit==0)
				{
					var sCreditInit2 = packet.data.findValueByName("sCreditInit");
					document.all.zyed.value=sCreditInit2[0][1];
					document.all.zydqsj.value=sCreditInit2[0][2];
					document.all.zylxrxm.value=sCreditInit2[0][3];
					document.all.zylxfs.value=sCreditInit2[0][4];
					document.all.zyjlxm.value=sCreditInit2[0][5];
					document.all.zyjllxfs.value=sCreditInit2[0][6];
				 }
				 var test_code2 = document.getElementById("codeDetail2").value;
				var test_real_detail2 = objSe1;
				if(test_code2!=" "  )
				{
					var _options2 = document.getElementById('codeDetail2').options; 
					for(var i = 0 ; i < _options2.length;i++) 
					{
						if(_options2[i].value==test_real_detail2)
						{
							_options2[i].selected=true
						}
					}//document.getElementById("codeDetail").options[index].selected=true; 
					//document.frm.submit_zykh.disabled=false;
				}
				else
				{
					document.frm.submit_zykh.disabled=true;
					alert("此处需建表并传值给下拉框 "+test_code);
				}
				//补充 e068cfm 下拉框选中值的处理
					
					if(flagInit==0)
					{
						var objSel2 = document.getElementById("codeDetail2");
						for(var i=0;i<objSel2.length;i++){  
							if(objSel2.options[i].value==sCreditInit2[0][0]){  
							 objSel2.options[i].selected=true;  
							 break;  
						  }  
						}
					}
				document.all.grade_old.value=12;
				//xl add 728 重要客户细节展示 end
			}
			if(document.frm.openType.length>1){
				if(backString[0][22]=="N"){
					document.frm.openType.options[1].selected=true;
				}
				else{
					document.frm.openType.options[0].selected=true;
				}
			}
			if(document.frm.openType.length>1){
				if(backString[0][22]=="N"){
					document.frm.openType.options[1].selected=true;
				}
				else{
					document.frm.openType.options[0].selected=true;
				}
			}
			if(document.frm.ifDetail.length>1){
				if(backString[0][30]=="N"){
					document.frm.ifDetail.options[1].selected=true;
				}
				else{
					document.frm.ifDetail.options[0].selected=true;
				}
			}
			flag=1;
			document.frm.handFee.disabled=false;
			document.frm.factPay.disabled=false;
	
	}
		//document.frm.submit.disabled=false;
	}
	//alert("backString2307 is "+backString2307);
	}
	//xl add for 2307
	if(cfmFlag2307==0 ||cfmFlag2307==9||cfmFlag2307==1||cfmFlag2307==99  )
	{
		if(cfmFlag2307==0)
		{
			//alert("cfmFlag2307 is "+cfmFlag2307+"说明：1执行成功 0查询成功");
			document.frm.userId2307.value=backString2307[0][0];
			//alert("111"+backString2307[0][6]);
			document.frm.runName2307.value=backString2307[0][6];
			document.frm.cardType2307.value=backString2307[0][15];
			document.frm.gradeName2307.value=backString2307[0][8];
			document.frm.custAddress2307.value=backString2307[0][11]; //11
			document.frm.idCardNo2307.value=backString2307[0][14]; //14
			document.frm.totalPrepay2307.value=backString2307[0][17];
			document.frm.totalOwe2307.value=backString2307[0][16];
			document.frm.custName2307.value=backString2307[0][3];
			var creditI2307 = 0;
			document.frm.expireTime2307.value=backString2307[0][22];
			document.frm.asCustPhone2307.value=backString2307[0][23];
			
			var idI2307 = 0 ;
			for(idI2307 = 0 ; idI2307 < document.frm.asIdType2307.length ; idI2307 ++){
				
				if(document.frm.asIdType2307.options[idI2307].value==backString2307[0][24]){
					document.frm.asIdType2307.options[idI2307].selected=true;
				}
			}
			document.frm.asIdIccid2307.value=backString2307[0][14]; //25
			document.frm.asIdAddress2307.value=backString2307[0][11];//26
			document.frm.asContractAddress2307.value=backString2307[0][27];
			document.frm.asNotes2307.value=backString2307[0][28];
			

			document.frm.qryFlag2307.value=backString2307[0][21];
			document.frm.oldCredit2307.value=backString2307[0][21];
			document.frm.qryFlagT2307.value=backString2307[0][21];
			document.frm.newCredit2307.value=backString2307[0][21];
			//？flag1=1;
			document.frm.handFee2307.disabled=false;
			document.frm.factPay2307.disabled=false;
			
		}
		if(cfmFlag2307==1 )
		{
			//alert("2307执行更新 ok");
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			var errCodeInt = parseInt(errCode);
			if(errCodeInt==0)
			{
				submitCfm_1256();
				//rdShowMessageDialog("操作成功！",2);
				document.frm.backLoginAccept.value=backString2307[0][0];
				
				
				if(document.frm.handFee.value!=0){
					//alert("test"+backString2307[0][0]);
					//printBill_2307();
				}else{
					window.location="e068.jsp?activePhone=<%=activePhone%>";
				}
			
			}
			else
			{
				
				rdShowMessageDialog(errCode + " : " + errMsg,0);
				window.location="e068.jsp?activePhone=<%=phoneNo%>";
			}
		}
	 
	}
	if(flag_new==1)
	{
		rdShowMessageDialog("操作成功!");
		//submitCfm_1256();
		window.location="e068.jsp?activePhone=<%=activePhone%>";
	}
	if(flag_new==2)
	{
		var errCode = packet.data.findValueByName("errCode_new");
		var errMsg = packet.data.findValueByName("errMsg_new");
		rdShowMessageDialog("程序执行错误.错误代码:"+errCode+",错误信息:"+errMsg);
		window.location="e068.jsp?activePhone=<%=activePhone%>";
	}
	
	//xl end for e068 信誉度配置
	var ed_old = document.all.qryFlag2307.value;
	var ed_xyd = document.getElementById("xydpz_ed").value;
	var ed_zy = document.getElementById("zyed").value;
	
	//alert("ed_old is "+ed_old+" and ed_xyd is "+ed_xyd+" and ed_zy is "+ed_zy);
	var flag_edit = packet.data.findValueByName("flag_edit");
	if(flag_edit==1)
	{
		if(document.getElementById("Operation_Table1").style.display=="block")
		{
			if(ed_old==ed_xyd)
			{
				return false;
			}
			else
			{
				document.all.qryFlag2307.value=ed_xyd;
				submitCfm1_2308();
			}
		}
		if(document.getElementById("Operation_Table3").style.display=="block")
		{
			if(ed_old==ed_zy)
			{
				return false;
			}
			else
			{
				document.all.qryFlag2307.value=ed_zy;
				submitCfm1_2308();
			}
		}
		
	}
	
}
//xl add for e068cfm

function printBill_2307(){
	  var infoStr="";  
      retInfo+='<%=workNo%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.custName.value+"|";
      retInfo+="手机号码："+document.all.phoneNo.value+"|";
      retInfo+="客户地址："+document.all.custAddress.value+"|";
      retInfo+="现金："+document.all.handFee.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="用户信誉度修改。*手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=document.all.sysRemark.value+"|";
      retInfo+=document.all.remark.value+"|"; 

	location.href="<%=request.getContextPath()%>/page/innet/hljPrint.jsp?retInfo="+infoStr+"&dirtPage=e068.jsp";  
                  
}
function submitt(){
      if(document.frm.phoneNo.value==""){
      	rdShowMessageDialog("请输入手机号码！");
      	return;
      }
      if(!checkElement(document.all.phoneNo)){
			document.frm.phoneNo.value = "";
			return;
		}
		//alert("getUserInfo_new.jsp 需增加是否是信誉度客户的判断");
		document.frm.qry.disabled=true;
		document.frm.phoneNo.disabled=true;
		var myPacket = new AJAXPacket("getUserInfo_new.jsp","正在提交，请稍候......");
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
		
}

function getRemain(){

	if(flag!=1){
		rdShowMessageDialog("请先查询用户信息！");
		return;
	}
	
	
	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
		return;
	}

	document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}

function submitCfm_1256(){
	getAfterPrompt();
	 
	if(flag==1){
		if(document.frm.remark.value.length==0){
			document.frm.remark.value="用户属性修改";
	}	
		
	if(!forReal(document.frm.handFee)){
				return;
	}
	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
		return;
	}
	var objSel = document.getElementById("gradeCodeId").value;
	if(objSel==10 )
	{
		var code_dtl = document.getElementById("codeDetail").value;
		//alert("此时需对其特殊处理 传的值是子节点而不是父节点的10和12! "+code_dtl);
		if(code_dtl ==0)
		{
			rdShowMessageDialog("请对信誉度客户进行细化选择");
			document.getElementById("codeDetail").focus();
			return false;
		}
		//myPacket.data.add("ownerCode",code_dtl);
	}
	else if(objSel==12)
	{
		var code_dt2 = document.getElementById("codeDetail2").value;
		if(code_dt2 ==0)
		{
			rdShowMessageDialog("请对重要客户进行细化选择");
			document.getElementById("codeDetail2").focus();
			return false;
		}
	}		 
	// xl add for 修改清0
		//printCommit(); 
		 
		 
		var creditI = 0;
		var newCredit = "";
		for(creditI = 0 ; creditI < document.frm.gradeCode.length ; creditI ++){
			if(document.frm.gradeCode.options[creditI].selected){
				newCredit = document.frm.gradeCode.options[creditI].value;
				
			}
		}
		//alert("newCredit is "+newCredit);
		var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
		var stopI = 0 ; 
		var newStopFlag = 0;
		for(stopI = 0 ; stopI < document.frm.openType.length ; stopI ++){
			if(document.frm.openType.options[stopI].selected){
				newStopFlag = document.frm.openType.options[stopI].value;
			}
		}
		
		var detailI = 0 ; 
		var newDetailFlag = 0;
		for(detailI = 0 ; detailI < document.frm.ifDetail.length ; detailI ++){
			if(document.frm.ifDetail.options[detailI].selected){
				newDetailFlag = document.frm.ifDetail.options[detailI].value;
			}
		}
		 
		//document.frm.submit.disabled=true;
	 
		var objSel = document.getElementById("gradeCodeId").value;
	 
		
		var myPacket = new AJAXPacket("e068Cfm_1256.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"正在提交，请稍候......");
		//alert("test2");
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("asIdType",inputIdType);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		//对 信誉客户 和 重要客户特殊处理
		if(objSel==10 )
		{
			var code_dtl = document.getElementById("codeDetail").value;
			//alert("此时需对其特殊处理 传的值是子节点而不是父节点的10和12! "+code_dtl);
			myPacket.data.add("ownerCode",code_dtl);
		}
		else if(objSel==12)
		{
			var code_dt2 = document.getElementById("codeDetail2").value;
			//alert("此时需对其特殊处理 传的值是子节点而不是父节点的10和12! "+code_dtl);
			myPacket.data.add("ownerCode",code_dt2);
		}
		else
		{
			myPacket.data.add("ownerCode",newCredit);
		}
		
		myPacket.data.add("stopFlag",newStopFlag);
		myPacket.data.add("ifDetail",newDetailFlag);
		
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);

		myPacket.data.add("ipAdd",document.frm.ipAdd.value);

		
    	core.ajax.sendPacket(myPacket);

    	myPacket=null;
    	}else{
    	rdShowMessageDialog("请先查询用户信息！");
    	}
	 
		
		
}
function verifyPass(){
	if(flag==1){
		var n = document.frm.customPass.value;
		var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("customPass",n);
		
		
    	core.ajax.sendPacket(myPacket);

    	myPacket=null;
		
		
	}else{
    		rdShowMessageDialog("请先查询用户信息！");
	}

}
function resett(){
	document.frm.customPass.value="";
	document.frm.userId.value="";
	document.frm.runName.value="";
	
	document.frm.idCardNo.value="";				
	document.frm.totalPrepay.value="";				
	document.frm.totalOwe.value="";
	document.frm.custName.value="";
	document.frm.phoneNo.value="";
	
	document.frm.qry.disabled=false;
	document.frm.phoneNo.disabled=false;
//	document.frm.submit.disabled=true;
	document.frm.custAddress.value="";
	document.frm.asCustName.value="";
	document.frm.asCustPhone.value="";
	document.frm.asIdType.options[0].selected=true;
	document.frm.asIdIccid.value="";
	document.frm.asIdAddress.value="";
	document.frm.asContractAddress.value="";
	document.frm.asNotes.value="";
	document.frm.cardType.value="";
	printFlag=9;
	timeFlag=0;
	flag=0;
	window.location="e068.jsp?activePhone=<%=activePhone%>";
}
//xl add new

//定义全局变量
  var user_code = new Array(); // 用户属性 parent_code 
  var credit_code = new Array();//信誉度属性 child_code 
  var credit_value = new Array();//信誉度属性名称 child_name 
  //xl add for 信誉度配置额度
  var credit_limit = new Array();
  var credit_limit_child = new Array();

  //xl add 取首席客户代码号码、职位信息
  var sx_0 = new Array(); 
  var sx_1 = new Array();
  var sx_2 = new Array();
	 
<%
	//xl add 首席
	 
	
	if(result0.length >0){
		for(int m1=0;m1<result0.length;m1++)
		  {
			out.println("user_code["+m1+"]='"+result0[m1][0]+"';\n");
			out.println("credit_code["+m1+" ]='"+result0[m1][1]+"';\n");
			out.println("credit_value["+m1+" ]='"+result0[m1][2]+"';\n");
		  }
	}
	else{
	//System.out.println("qweqwe9888800000000000000000111");
	}
	if(result01.length >0){
		for(int m11=0;m11<result01.length;m11++)
		  {
			out.println("credit_limit["+m11+" ]='"+result01[m11][0]+"';\n");
			out.println("credit_limit_child["+m11+" ]='"+result01[m11][1]+"';\n");
			
		  }
	}
	else{
	//System.out.println("qweqwe9888800000000000000000111");
	}
	


%> 
function showCredit()
{
	 
	var objSel = document.getElementById("gradeCodeId").value;
	
	if(objSel ==10) 
	{
		document.getElementById("Operation_Table1").style.display="block";
		document.getElementById("Operation_Table3").style.display="none";
		var myEle1 ;
		var x1 ;
		for (var q1=document.all.codeDetail.options.length;q1>=0;q1--) document.all.codeDetail.options[q1]=null;
		myEle1 = document.createElement("option") ;
		myEle1.value = "";
		myEle1.text ="--请选择--";
		document.all.codeDetail.add(myEle1) ;
		for ( x1 = 0 ; x1 < user_code.length  ; x1++ )
		{		if ( user_code[x1] ==objSel)
				{
					//alert("123 "+objSel);
					myEle1 = document.createElement("option") ;
					myEle1.value = credit_code[x1];
					myEle1.text = credit_value[x1];
					document.all.codeDetail.add(myEle1) ;
				}
		}
		document.frm.submit2307.disabled=true;
		
	}
	else if(objSel ==12) 
	{
		document.getElementById("Operation_Table1").style.display="none";
		document.getElementById("Operation_Table3").style.display="block";
		var myEle1 ;
		var x1 ;
		for (var q1=document.all.codeDetail2.options.length;q1>=0;q1--) document.all.codeDetail2.options[q1]=null;
		myEle1 = document.createElement("option") ;
		myEle1.value = "";
		myEle1.text ="--请选择--";
		document.all.codeDetail2.add(myEle1) ;
		for ( x1 = 0 ; x1 < user_code.length  ; x1++ )
		{		if ( user_code[x1] ==objSel)
				{
					myEle1 = document.createElement("option") ;
					myEle1.value = credit_code[x1];
					myEle1.text = credit_value[x1];
					document.all.codeDetail2.add(myEle1) ;
				}
		}
		var objSel_old = document.frm.grade_old.value;
		//取出 二级子节点 不可以是“普通”
		var sec_detail = document.getElementById("codeDetail"); //信誉客户的
		//alert("信誉客户value is "+sec_detail.value);
		if(objSel_old==10 &&sec_detail.value!=56)
		{
			var	prtFlag = rdShowConfirmDialog("客户已经是VIP客户，是否确定设置为重要客户?");
			if(prtFlag!=1)
			{
				//alert("还原成原状态");
				document.getElementById("Operation_Table1").style.display="block";
				document.getElementById("Operation_Table3").style.display="none";
				var index1 = 0;
				for(var j=0;j<document.getElementById("gradeCodeId").options.length;j++) 
				{ 
					if(document.getElementById("gradeCodeId").options[j].value==objSel_old) 
					index1=j; 
				}
				//alert("index1 is "+index1);
				if(index1>=0) 
				document.getElementById("gradeCodeId").options[index1].selected=true; 
			}
			else
			{
				//alert("此处可去掉");
			}
		}
		document.frm.submit2307.disabled=true;
	}
	else
	{
		document.frm.submit2307.disabled=false;
		document.getElementById("Operation_Table1").style.display="none";
		document.getElementById("Operation_Table3").style.display="none";
		document.getElementById("codeDetail").value="";
		document.getElementById("codeDetail2").value="";
	}
	
	//xl add for 重要客户 begin code_dt2
		 
	//xl add for 重要客户 end
}
function init1()
{
	document.getElementById("Operation_Table1").style.display="none";
	document.getElementById("Operation_Table2").style.display="none";
	document.getElementById("Operation_Table3").style.display="none";
	//alert("222");
}
function DateDiff(beginDate,endDate)    //计算两个日期之间相差几个月
{             
    var year1 =  beginDate.substr(0,4);
	var year2 =  endDate.substr(0,4); 
	var month1 = beginDate.substr(4,2);
	var month2 = endDate.substr(4,2);
	var len=(year2-year1)*12+(month2-month1);
	return len;
}
//xl add for 信誉度配置按钮
function submitCfm_xydpz(ItemArray,GroupArray)
{
	var objSel_dl = document.getElementById("codeDetail").value;
	//alert("objSel_dl is "+objSel_dl);
	if(objSel_dl!="50" && objSel_dl!="51"&& objSel_dl!="52" )
	{
		//alert("不需要催费短信联系人两项"); xydpz_lxrxm xydpz_lxfs
		if(document.all.xydpz_lxrxm.value=="" ||document.all.xydpz_lxfs.value=="" )
		{
			rdShowMessageDialog("请输入催费短信联系人姓名和联系方式相关信息!");
			document.all.xydpz_lxrxm.focus();
			return false;
		}
	}
	//xl add new 取出“用户属性”下拉框的值
	var attr_code = document.getElementById("gradeCodeId").value;
	//alert("tes attr_code is  "+attr_code);
	// 催费短信联系人！=客户本人
	if(document.all.custName.value==document.all.xydpz_lxrxm.value || document.all.phoneNo.value==document.all.xydpz_lxfs.value)
	{
		rdShowMessageDialog("催费短信联系人不可以是客户本人!");
		document.all.xydpz_lxfs.value="";
		document.all.xydpz_lxfs.focus();
		return false;
	}
	// xl add for 判断当前子节点信誉度的额度
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	{
		if ( ItemArray[x] == objSel_dl )
		{
			//document.getElementById("cz").value = GroupArray[x];
			//alert("当前额度是 "+GroupArray[x]);
			if(parseFloat(document.frm.xydpz_ed.value) >parseFloat(GroupArray[x]) )
			{
				rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
				return false;
			}
			//document.frm.xydpz_ed.value=GroupArray[x];
			//document.frm.xydpz_ed_hide.value=GroupArray[x];
		}
	}
	//alert("444");
	//xl add for 非空验证 begin
	if(document.frm.xydpz_jlxm.value=="")
	{
		rdShowMessageDialog("请输入客户经理姓名！");
		document.frm.xydpz_jlxm.focus();
		return false;
	}
	if(document.frm.xydpz_jllxfs.value=="")
	{
		rdShowMessageDialog("请输入客户经理联系方式！");
		document.frm.xydpz_jllxfs.focus();
		return false;
	}
	//xl add for 非空验证 end
	//xl add for 信誉度到期时间
	//js 判断当前时间与输入时间的月份差 
	var dates = new Date();
	var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
	var date2 =document.frm.xydpz_dqsj.value;
	//alert("开始时间 "+date1+" and 结束时间 "+date2);
	Month=DateDiff(date1,date2);
	
	if(document.frm.xydpz_ed.value=="")
	{
		rdShowMessageDialog("请输入信誉度额度！");
		document.frm.xydpz_ed.focus();
		return false;
	}
	if(document.frm.xydpz_dqsj.value=="")
	{
		rdShowMessageDialog("请输入信誉度到期时间！");
		document.frm.xydpz_dqsj.focus();
		return false;
	}
	//alert("555e ");
	if(document.frm.xydpz_dqsj.value=="205001" && document.frm.xydpz_ed.value=="0")
	{
			//rdShowMessageDialog("请输入正确的信誉度到期时间，格式为YYYYMM!");
		//return true;
		var	prtFlag = rdShowConfirmDialog("是否确定修改信誉度配置?");
		//alert("555 "+prtFlag);
		if(prtFlag==1)
		{
			//submitCfm_1256();
			var myPacket = new AJAXPacket("e068Cfm_new.jsp?phoneNo="+document.frm.phoneNo.value+"&detail_code="+objSel_dl+"&limit_grade="+0+"&credit_expire="+205001+"&CONTACT_PERSON="+document.frm.xydpz_lxrxm.value+"&CONTACT_PHONE="+document.frm.xydpz_lxfs.value+"&manager_name="+document.frm.xydpz_jlxm.value+"&manager_phone="+document.frm.xydpz_jllxfs.value+"&attr_code="+attr_code,"正在提交，请稍候......");
			//alert("test2");
			myPacket.data.add("workNo",document.frm.workNo.value);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
			//end 调用服务
		}
	}
	else
	{
			if(Month<0)
			{
				rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
				return false;
			}
			else if(Month>14)
			{
				rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
				return false;
			}
			else
			{
				var	prtFlag = rdShowConfirmDialog("是否确定修改信誉度配置?");
				//alert("33333");
				if(prtFlag==1)
				{
					//submitCfm_1256();
					var myPacket = new AJAXPacket("e068Cfm_new.jsp?phoneNo="+document.frm.phoneNo.value+"&detail_code="+objSel_dl+"&limit_grade="+document.frm.xydpz_ed.value+"&credit_expire="+date2+"&CONTACT_PERSON="+document.frm.xydpz_lxrxm.value+"&CONTACT_PHONE="+document.frm.xydpz_lxfs.value+"&manager_name="+document.frm.xydpz_jlxm.value+"&manager_phone="+document.frm.xydpz_jllxfs.value+"&attr_code="+attr_code,"正在提交，请稍候......");
					//alert("test2");
					myPacket.data.add("workNo",document.frm.workNo.value);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
					//end 调用服务
				}
				
			}
			
	}
	//alert("111");
	//submitCfm1_2308();
	//add 确认的事件
	//submitCfm_1256();
	//submitCfm_1256();
}
function show_qry(choose,ItemArray,GroupArray)
{
	var objSel_dl = document.getElementById("codeDetail").value;
	//alert("当选中的不是空的时候 确认按钮可用 "+objSel_dl);
	//add new cuiqi限制 begin
	var attr_flag = document.all.attr1.value; //1、2位 属性
	var card_flag = document.all.attr2.value;//3、4位 卡别
	//alert("attr_flag is "+attr_flag+" and card_flag is "+card_flag);
	if(card_flag=="01")
	{
		if( objSel_dl=="50" )
		{
			//return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于VIP钻石卡，只可以选择VIP钻石卡!");
			document.getElementById("codeDetail").value="50";
			//return false;
		}
	}
	else if(card_flag=="02")
	{
		if( objSel_dl=="51" )
		{
			//return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于VIP金卡，只可以选择VIP金卡!");
			document.getElementById("codeDetail").value="51";
			//return false;
		}
	} 
	else if(card_flag=="03")
	{
		if( objSel_dl=="52" )
		{
			//return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于VIP银卡，只可以选择VIP银卡!");
			document.getElementById("codeDetail").value="52";
			//return false;
		}
	} 
	else if(card_flag=="05")
	{
		if( objSel_dl=="53" )
		{
		//	return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于特批VIP钻石卡，只可以选择特批VIP钻石卡!");
			document.getElementById("codeDetail").value="53";
			//return false;
		}
	} 
	else if(card_flag=="06")
	{
		if( objSel_dl=="54" )
		{
			//return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于特批VIP金卡，只可以选择特批VIP金卡!");
			document.getElementById("codeDetail").value="54";
			//return false;
		}
	} 
	else if(card_flag=="07")
	{
		if( objSel_dl=="55" )
		{
			//return true;
		}
		else
		{
			rdShowMessageDialog("该号码属于特批VIP银卡，只可以选择特批VIP银卡!");
			document.getElementById("codeDetail").value="55";
			//return false;
		}
	} 
	else if(card_flag=="00")
	{
		if( objSel_dl=="56" )
		{
			//return true;
			document.frm.submit2307.disabled=false;
		}
		else
		{
			rdShowMessageDialog("该号码属于普通卡，只可以选择普通卡!");
			document.getElementById("codeDetail").value="56";
			//return false;
		}
	} 
	else
	{
		alert("什么情况？");
	}
	//add new cuiqi限制 end
	//alert("objSel_dl is "+objSel_dl);
	if(objSel_dl=="")
	{
		document.frm.submit2307.disabled=true;
	}
	else
	{
		document.frm.submit2307.disabled=false;
	}
	// xl add for 判断当前子节点信誉度的额度
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	{
		if ( ItemArray[x] == choose.value )
		{
			//document.getElementById("cz").value = GroupArray[x];
			//alert("当前额度是 "+GroupArray[x]);
			document.frm.xydpz_ed.value=GroupArray[x];
			//document.frm.xydpz_ed_hide.value=GroupArray[x];
			
		}
	}
	document.all.qryFlag2307.value=document.frm.xydpz_ed.value;	
	//926 add
	document.getElementById("codeDetail2").value="";
}
//728 重要客户配置
function zykh(choose,ItemArray,GroupArray)
{
	var objSel_dl = document.getElementById("codeDetail2").value;
	//alert("当选中的不是空的时候 确认按钮可用 "+objSel_dl);
	if(objSel_dl=="")
	{
		document.frm.submit2307.disabled=true;
	}
	else
	{
		document.frm.submit2307.disabled=false;
	}
	// xl add for 判断当前子节点信誉度的额度
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	{
		if ( ItemArray[x] == choose.value )
		{
			//document.getElementById("cz").value = GroupArray[x];
			//alert("当前额度是 "+GroupArray[x]);
			document.frm.zyed.value=GroupArray[x];
			//document.frm.xydpz_ed_hide.value=GroupArray[x];
		}
	}
	document.all.qryFlag2307.value=document.frm.zyed.value;	
	//926 add
	document.getElementById("codeDetail").value="";
}
//重要客户提交
function submitCfm_zykh(ItemArray,GroupArray)
{
	var objSel_dl = document.getElementById("codeDetail2").value;
	
	//xl add new 取出“用户属性”下拉框的值
	var attr_code = document.getElementById("gradeCodeId").value;
	//alert("tes attr_code is  "+attr_code);
	// 催费短信联系人！=客户本人
	if(document.all.custName.value==document.all.zylxrxm.value || document.all.phoneNo.value==document.all.zylxfs.value)
	{
		rdShowMessageDialog("催费短信联系人不可以是客户本人!");
		return false;
	}
	// xl add for 判断当前子节点信誉度的额度
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	{
		if ( ItemArray[x] == objSel_dl )
		{
			//document.getElementById("cz").value = GroupArray[x];
			//alert("当前额度是 "+GroupArray[x]);
			if(parseFloat(document.frm.zyed.value) >parseFloat(GroupArray[x]) )
			{
				rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
				return false;
			}
			//document.frm.xydpz_ed.value=GroupArray[x];
			//document.frm.xydpz_ed_hide.value=GroupArray[x];
		}
	}
	//xl add for 非空验证 begin
	if(document.frm.zyjlxm.value=="")
	{
		rdShowMessageDialog("请输入客户经理姓名！");
		document.frm.zyjlxm.focus();
		return false;
	}
	if(document.frm.zyjllxfs.value=="")
	{
		rdShowMessageDialog("请输入客户经理联系方式！");
		document.frm.zyjllxfs.focus();
		return false;
	}
	//xl add for 非空验证 end
	//xl add for 信誉度到期时间
	//js 判断当前时间与输入时间的月份差 
	var dates = new Date();
	var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
	var date2 =document.frm.zydqsj.value;
	//alert("开始时间 "+date1+" and 结束时间 "+date2);
	Month=DateDiff(date1,date2);
	/*
	
	
	
	*/
	if(document.frm.zyed.value=="")
	{
		rdShowMessageDialog("请输入信誉度额度！");
		document.frm.zyed.focus();
		return false;
	}
	if(document.frm.zydqsj.value=="")
	{
		rdShowMessageDialog("请输入信誉度到期时间！");
		document.frm.zydqsj.focus();
		return false;
	}
	if(document.frm.zydqsj.value=="205001" && document.frm.zyed.value=="0")
	{
			//rdShowMessageDialog("请输入正确的信誉度到期时间，格式为YYYYMM!");
		//return true;
		var	prtFlag = rdShowConfirmDialog("是否确定修改信誉度配置?");
		if(prtFlag==1)
		{
			//submitCfm_1256();
			var myPacket = new AJAXPacket("e068Cfm_new.jsp?phoneNo="+document.frm.phoneNo.value+"&detail_code="+objSel_dl+"&limit_grade="+document.frm.zyed.value+"&credit_expire="+date2+"&CONTACT_PERSON="+document.frm.zylxrxm.value+"&CONTACT_PHONE="+document.frm.zylxfs.value+"&manager_name="+document.frm.zyjlxm.value+"&manager_phone="+document.frm.zyjllxfs.value+"&attr_code="+attr_code,"正在提交，请稍候......");
					//alert("test2");
					myPacket.data.add("workNo",document.frm.workNo.value);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
			//end 调用服务
		}
	}
	else
	{
		if(Month<0)
		{
			rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
			return false;
		}
		else if(Month>14)
		{
			rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
			return false;
		}
		else
		{
			var	prtFlag = rdShowConfirmDialog("是否确定修改信誉度配置?");
			if(prtFlag==1)
			{
				//submitCfm_1256();
				var myPacket = new AJAXPacket("e068Cfm_new.jsp?phoneNo="+document.frm.phoneNo.value+"&detail_code="+objSel_dl+"&limit_grade="+document.frm.zyed.value+"&credit_expire="+date2+"&CONTACT_PERSON="+document.frm.zylxrxm.value+"&CONTACT_PHONE="+document.frm.zylxfs.value+"&manager_name="+document.frm.zyjlxm.value+"&manager_phone="+document.frm.zyjllxfs.value+"&attr_code="+attr_code,"正在提交，请稍候......");
				//alert("test2");
				myPacket.data.add("workNo",document.frm.workNo.value);
				core.ajax.sendPacket(myPacket);
				myPacket=null;
				//end 调用服务
			}
			
		}
			
		 
	}
	//?
	//submitCfm1_2308();
	submitCfm_1256();
	
}
</script>
<body onload = "init1()">
<input type="hidden" name="attr1" value=" ">
<input type="hidden" name="attr2" value=" ">
<form action="" method=post name="frm" >
<input type="hidden" name="show">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue"> 服务号码 </td>
		<td colspan="5">
			<input  id=Text2 type=text size=17 name=phoneNo value=<%=phoneNo%>  v_type="mobphone"  maxlength=11 index="0" class="InputGrey" readonly>
			<input class="b_text" id=Text22 type=button  size=17  name=qry  value="查询" onClick="submitt()">
		</td>
	</tr>
	<tr> 
		<td class="blue">用户I D</td>
		<td> 
			<input id=Text2 type=text size=17 name=userId class="InputGrey" readonly >
		</td>
		<td class="blue">当前状态</td>
		<td> 
			<input type=text size=17 name=runName class="InputGrey" readonly >
		</td>
		<td class="blue"> 客户名称</td>
		<td> 
			<input id=Text2 type=text size=17 name=custName class="InputGrey" readonly >
		</td>
	</tr>
	<tr> 
		<td class="blue"> 当前预存</td>
		<td> 
			<input id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly >
		</td>
		<td class="blue">当前欠费</td>
		<td> 
			<input id=Text2 type=text size=17 name=totalOwe class="InputGrey" readonly >
		</td>
		<td class="blue">大客户标志</td>
		<td> 
			<input type=text size=17 name=cardType class="InputGrey" readonly >
		</td>
	</tr>
</table>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">用户属性修改</div>
</div>
<table cellspacing="0">
	<tr>
		<%if(gradeFlag>0) {				%>
		<td class="blue"> 用户属性</td>
		<td> 
			<select name=gradeCode id="gradeCodeId" index="2" onChange="showCredit(),document.all.qryFlag2307.value=0" >
				
				<%for(int i = 0 ; i < gradeStr.length ; i ++){%>
				<option value="<%=gradeStr[i][0]%>"><%=gradeStr[i][1]%></option>
				<%}
			
				%>
			</select>
			<input type="hidden" name="grade_old">
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}if(offonFlag>0){				%>
		<td class="blue">停开机标志</td>
		<td colspan="3"> 
			<select name=openType index="3">
				<option value="Y">停机 </option>
				<option value="N">不停机 </option>
			</select>
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}if(qryFlag>0){			%>
		<td class="blue" style="display:none ">详单禁查标志</td>
		<td style="display:none "> 
			<select name=ifDetail index="4">
				<option value="Y">可以</option>
				<!--option value="N">不可以</option-->
			</select>
		</td>
			<%}else{%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
			<%}%>
	</tr>
	<tr> 
		<td class="blue"> 担保人名称</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asCustName maxlength=20 >
		</td>
		<td class="blue">担保人联系电话</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
		</td>
		<td class="blue">联系地址</td>
		<td colspan="2"> 
			<input class=button id=Text2 type=text size=17 name=asContractAddress  maxlength=20>
		</td>
	</tr>
	<tr> 
		<td class="blue"> 担保人证件类型</td>
		<td> 
			<select size=1 name=asIdType  >
				<%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
				<option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
				<%}%>
			</select>
		</td>
		<td class="blue">证件号码</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
		</td>
		<td class="blue">证件地址</td>
		<td colspan="2"> 
			<input class=button id=Text2 type=text size=17 name=asIdAddress  maxlength=20>
		</td>
	</tr>
	<tr> 
		<td class="blue"> 担保备注</td>
		<td colspan="5"> 
			<input class=button id=Text2 type=text size=30 name=asNotes  maxlength=30>
		</td>
	</tr>
	<tr> 
		<td class="blue">手续费</td>
		<td> 
			<input class=button id=Text2 type=text size=17 index="5" name=handFee <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type="float">
		</td>
		<td  class="blue">实收</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=factPay index="6" disabled onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
			<input class="b_text" id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()">
		</td>
		<td  class="blue">找零</td>
		<td>
			<input id=Text2 type=text size=17 name=remain class="InputGrey" readonly >
		</td>
	</tr>
	<tr>
		<td class="blue">用户备注</td>
		<td colspan="5">
			<input class="InputGrey" readOnly id=Text3 type=text size=60 name=remark value="" index="7">
		</td>
	</tr>
		<%if(gradeFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=gradeCode index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
		<%if(offonFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=openType index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
		<%if(qryFlag<=0){%>
        <tr  style="display:none">
        	<td colspan="6">
				<select name=ifDetail index="2">
					<option value="N_N">N_N</option>
				</select>
			</td>
		</tr>
		<%}%>
	<!--
	<tr align="center" id="footer">
		<td colspan="6">
			<input class="b_foot" name=submit type=button index="8" value="确认2" onclick="submitCfm_1256()" disabled onKeyUp="if(event.keyCode==13){submitCfm_1256()}">
			<input class="b_foot" name=back type=button value="清除" onclick="window.location='e068.jsp?activePhone=<%=activePhone%>'">
			<input class="b_foot" name=back type=button value="关闭" onclick="removeCurrentTab()">
		</td>
	</tr>
	-->
</table>

<!-- xl add new 信誉客户-->
<div id="Operation_Table1"> 
<div class="title">
	<div id="title_zi">用户信誉度配置</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">细化用户属性-信誉客户</td>
		<td colspan="5">
			<!--<select name=codeDetail id="codeDetail" onchange="if(beforeTest()==true){
			show_qry(this,credit_limit_child,credit_limit),document.all.qryFlag2307.value=document.all.xydpz_ed.value,document.all.qryFlag2307.readOnly=true
			}else{alert('有问题');} " >-->
			<select name=codeDetail id="codeDetail" onchange="
			show_qry(this,credit_limit_child,credit_limit),document.all.qryFlag2307.value=document.all.xydpz_ed.value,document.all.qryFlag2307.readOnly=true " >
				
			</select>
		</td>
	</tr>
	<tr> 
		<td class="blue">信誉度额度</td>
		<td> 
			<input class=button  v_type="float" name="xydpz_ed" value="0" onblur="editXydEd()" onKeyPress="return isKeyNumberdot(1)" >
			
		</td>
		<td class="blue">信誉度到期时间</td>
		<td> 
			<input class=button  name="xydpz_dqsj" maxlength=8 value="20500101" onKeyPress="return isKeyNumberdot(0)">(YYYYMMDD)
		</td>
		<td class="blue">催费短信联系人姓名</td>
		<td> 
			<input class=button name="xydpz_lxrxm" >
		</td>
	</tr>
	<tr> 
		<td class="blue">催费短信联系人的联系方式</td>
		<td> 
			<input class=button maxlength=11 size=20  name="xydpz_lxfs" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">客户经理姓名</td>
		<td> 
			<input class=button  name="xydpz_jlxm">
		</td>
		<td class="blue">客户经理联系方式</td>
		<td> 
			<input class=button  name="xydpz_jllxfs"  maxlength=11 size=20 onKeyPress="return isKeyNumberdot(0)">
		</td>
	</tr>
	<!--
	<tr align="center" id="footer">
		<td colspan="6">
			<input class="b_foot" name=submit1_xydpz type=button index="8" value="确认3" onclick="submitCfm_xydpz(credit_limit_child,credit_limit)" disabled onKeyUp="if(event.keyCode==13){submitCfm_xydpz(credit_limit_child,credit_limit)}">
			<input class="b_foot" name=back type=button value="清除" onclick="window.location='e068.jsp?activePhone=<%=activePhone%>'">
			<input class="b_foot" name=back type=button value="关闭" onclick="removeCurrentTab()">
		</td>
	</tr>
	-->
</table>
</div>
<!-- xl add end 信誉客户--> 
<!-- xl add new 重要客户-->
<div id="Operation_Table3"> 
<div class="title">
	<div id="title_zi">用户信誉度配置</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">细化用户属性-重要客户 </td>
		<td colspan="5">
			<select name=codeDetail2 id="codeDetail2" onchange="zykh(this,credit_limit_child,credit_limit),document.all.qryFlag2307.value=document.all.zyed.value,document.all.qryFlag2307.readOnly=true" >
				
			</select>
		</td>
	</tr>
	<tr> 
		<td class="blue">信誉度额度</td>
		<td> 
			<input class=button  v_type="float" name="zyed" value=0 onblur=editzyEd() onKeyPress="return isKeyNumberdot(1)" >
		</td>
		<td class="blue">信誉度到期时间</td>
		<td> 
			<input class=button name="zydqsj" maxlength=8 value="20500101" onKeyPress="return isKeyNumberdot(0)">(YYYYMMDD)
		</td>
		<td class="blue">催费短信联系人姓名</td>
		<td> 
			<input class=button name="zylxrxm"  >
		</td>
	</tr>
	<tr> 
		<td class="blue">催费短信联系人的联系方式</td>
		<td> 
			<input class=button name="zylxfs" maxlength=11 onKeyPress="return isKeyNumberdot(0)"  >
		</td>
		<td class="blue">客户经理姓名</td>
		<td> 
			<input class=button  name="zyjlxm">
		</td>
		<td class="blue">客户经理联系方式</td>
		<td> 
			<input class=button  name="zyjllxfs" maxlength=11 onKeyPress="return isKeyNumberdot(0)">
		</td>
	</tr>
	<!--xl add for fanyan begin-->
	<tr> 
		<td class="blue" colspan=6>重要客户的首席客户代表相关信息</td>
	</tr>
	<tr>
		<td class="blue">首席客户代表手机号码</td>
		<td>
		<%
			if(sx_0.length>0)
			{
				%>
				<input class=button maxlength=11 size=20  name="sx_phone_no0" value="<%=sx_0[0][0]%>" onKeyPress="return isKeyNumberdot(0)">
				<%
			}
			else
			{
				%>
				<input class=button maxlength=11 size=20  name="sx_phone_no0" onKeyPress="return isKeyNumberdot(0)">
				<%
			}
		%>
			
		</td>
		<td class="blue">首席客户代表职位</td>
		<td colspan=3> 
			<select name="sx_zw0" id="sx_zw_id0">
				<option value="0">-->请选择</option>
				<%
					if(sx_0.length>0)
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							if(ret_val_jb[i][0].equals(sx_0[0][1]))
							{
								%><option value="<%=ret_val_jb[i][0]%>" selected >
								  <%=ret_val_jb[i][1]%>
								  </option>	
								<%
							}
							else
							{
								%>
									<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
								<%
							}
						}
					}
					else
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							%>
								<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
							<%
						}
					}
					 
			
				%>
			</select>
			
		</td>
	</tr>
	<tr>
		<td class="blue">首席客户代表手机号码</td>
		<%
			if(sx_1.length>0)
			{
				%>
				<td> 
					<input class=button maxlength=11 size=20  name="sx_phone_no1" value="<%=sx_1[0][0]%>" onKeyPress="return isKeyNumberdot(0)">
				</td>
				<%
			}
			else
			{
				%>
				<td> 
					<input class=button maxlength=11 size=20  name="sx_phone_no1"   onKeyPress="return isKeyNumberdot(0)">
				</td>
				<%
			}
		%>
		
		<td class="blue">首席客户代表职位</td>
		<td colspan=3> 
			<select name="sx_zw1" id="sx_zw_id1">
				<option value="0">-->请选择</option>
				<%
					if(sx_1.length>0)
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							if(ret_val_jb[i][0].equals(sx_1[0][1]))
							{
								%><option value="<%=ret_val_jb[i][0]%>" selected >
								  <%=ret_val_jb[i][1]%>
								  </option>	
								<%
							}
							else
							{
								%>
									<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
								<%
							}
						}
					}
					else
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							%>
								<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
							<%
						}
					}
					 
			
				%>
			</select>
			
		</td>
	</tr>
	<tr>
		<td class="blue">首席客户代表手机号码</td>
		<%
			if(sx_2.length>0)
			{
				%>
				<td> 
					<input class=button maxlength=11 size=20  name="sx_phone_no2" value="<%=sx_2[0][0]%>" onKeyPress="return isKeyNumberdot(0)">
				</td>
				<%
			}
			else
			{
				%>
				<td> 
					<input class=button maxlength=11 size=20  name="sx_phone_no2"  onKeyPress="return isKeyNumberdot(0)">
				</td>
				<%
			}
		%>
		<td class="blue">首席客户代表职位</td>
		<td colspan=3> 
			<select name="sx_zw2" id="sx_zw_id2">
				<option value="0">-->请选择</option>
				<%
					if(sx_2.length>0)
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							if(ret_val_jb[i][0].equals(sx_2[0][1]))
							{
								%><option value="<%=ret_val_jb[i][0]%>" selected >
								  <%=ret_val_jb[i][1]%>
								  </option>	
								<%
							}
							else
							{
								%>
									<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
								<%
							}
						}
					}
					else
					{
						for(int i = 0 ; i < ret_val_jb.length ; i ++)
						{
							%>
								<option value="<%=ret_val_jb[i][0]%>"><%=ret_val_jb[i][1]%></option>
							<%
						}
					}
					 
			
				%>
			</select>
			
		</td>
	</tr>
	<!--xl add for fanyan end-->
</table>
</div>
<!-- xl add end 重要客户-->
<!--xl add for 信誉度修改 只对信誉度客户展示 2307-->
<div id="Operation_Table2"> 
<div class="title">
	<div id="title_zi">信誉度信息</div>
</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">用户I D</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=userId2307>
		</td>
		<td  class="blue">当前状态</td>
		<td> 
			<input class="InputGrey" readOnly type=text size=17 name=runName2307>
		</td>
		<td class="blue">级别</td>
		<td> 
			<input class="InputGrey" readOnly type=text size=17 name=gradeName2307>
		</td>
	</tr>
	
	<tr> 
		<td class="blue"> 当前预存</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=totalPrepay2307 >
		</td>
		<td class="blue">当前欠费</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=totalOwe2307>
		</td>
		<td class="blue">大客户标志</td>
		<td> 
			<input class="InputGrey orange" readOnly type=text size=17 name=cardType2307>
		</td>
	</tr>
	
	<tr> 
		<td class="blue"> 客户名称</td>
		<td> 
			<input class="InputGrey" readOnly id=Text2 type=text size=17 name=custName2307>
		</td>
		<td class="blue">当前信誉度</td>
		<td> 
			<input class="InputGrey" readOnly type=text size=17 name="qryFlag2307" v_must=1 v_type="int" onBlur="if(this.value!=''){if(checkElement(qryFlag2307)==false){return false;}};" onchange="modify()" onKeyPress="return isKeyNumberdot(1)" >
		</td>
		<td class="blue">业务类型</td>
		<td> 
			<input class="InputGrey orange" type=text size=17 name=chgStatusValue2307 value="信誉度修改" readonly >
			<input type=hidden name=chgStatus2307 value="Y">
		</td>
	</tr>
	
	 <tr style="display:none"> 
            <td width="10%" style="display='none'"> 担保人名称：</td>
            <td align=left width="23%" style="display='none'"> 
              <input class=button id=Text2 type=text size=17 name=asCustName2307 maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td  width="10%" style="display='none'">担保人联系电话：</td>
            <td  width="19%" style="display='none'"> 
              <input class=button id=Text2 type=text size=17 name=asCustPhone2307 maxlength=20  >
            </td>
            <td  width="14%"></td>
            <td  width="21%" colspan=5> 
              <input class="button" type=hidden size=17 name=expireTime2307 index="3">
              <input class=button id=Text2 type=hidden size=17 name=asContractAddress2307  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
      </tr>
      <tr bgcolor="e8e8e8" style="display:none"> 
            <td width="20%" > 担保人证件类型：</td>
            <td align=left width="23%" > 
              <select size=1 name=asIdType2307  >
              <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
              <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
              <%}%>
              </select>
            </td>
            <td  width="20%">证件号码：</td>
            <td  width="19%"> 
              <input class=button id=Text2 type=text size=17 name=asIdIccid2307  maxlength=20>
            </td>
            <td  width="24%">证件地址：</td>
            <td  width="19%" colspan=2> 
              <input class=button id=Text2 type=text size=17 name=asIdAddress2307  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr bgcolor="f5f5f5" style="display:none"> 
            <td width="10%" > 担保备注：</td>
            <td align=left width="23%" > 
              <input class=button id=Text2a type=text size=30 name=asNotes12307  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
         
	<tr style="display:none"> 
		<td class="blue">手续费</td>
		<td> 
			<input class=button id=Text2 type=text size=17 index="4" name=handFee2307 <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float>
		</td>
		<td class="blue">实收</td>
		<td> 
			<input class=button id=Text2 type=text size=17 name=factPay2307 index="5" onKeyUp="if(event.keyCode==13){getRemain()}" disabled >&nbsp;
			<input class=button id=Text2 type=button size=17 name=getUseInfo2307 value="-->" onclick="getRemain()">
		</td>
		<td class="blue">找零</td>
		<td>
			<input class=button id=Text2 type=text size=17 name=remain2307 disabled >
		</td>
	</tr>
	
	<tr style="display:none">
	<td>用户备注</td>
	<td>
		<input class=button id=Text3 type=text size=60 name=remark2307 value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');"></td>
	</tr>
	
	<tr> 
		<td class="blue">用户备注</td>
		<td colspan="5">
			<input class="InputGrey" readOnly id=Text2 type=text size=60 name=asNotes2307  maxlength=30 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
		</td>
	</tr>
        
	<TR>
		<TD align="center" id="footer" colspan="6">
			<!--
			<input class="b_foot" name=submit2307  index="7" type=button value="确认" onclick="submitCfm1_2308()" onKeyUp="if(event.keyCode==13){submitCfm1_2308()}"> -->
			<input class="b_foot" name=submit2307  index="7" type=button value="确认" onclick="submitCfm_final(credit_limit_child,credit_limit)" onKeyUp="if(event.keyCode==13){submitCfm_final()}">
			&nbsp;&nbsp; 
			<input class="b_foot" name=back2307  type=button value="清除" onclick="resett1_final()">
			&nbsp;&nbsp; 
			<!--
			<input class="b_foot" name=back2307  type=button value="关闭" onclick="removeCurrentTab1_final()">
			-->
		</TD>
	</TR>
</table>
<input type=hidden name=rightCode value=<%=rightCode%>>
<input type=hidden name=qryFlagT2307 value="">
<input type=hidden name=newCredit2307 value="">
<input type=hidden name=oldCredit2307 value="">
<input type=hidden name=idCardNo2307>
<input type=hidden name=custAddress2307>
 
 

</div>
<!--xl end for 信誉度修改 只对信誉度客户展示 2307-->

<input type=hidden name=loginAccept value="<%=printAccept%>">
<input type=hidden name=opCode value="e068">


<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=sysRemark value="e068修改">
<input type=hidden name=ipAdd value="<%=ipAdd%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">   
<input type=hidden name=qryFlagT value="">
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>    
<input type=hidden name=backLoginAccept>
<input type=hidden name=timeFlag value="0">
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">
<input type=hidden name=oldGradeName value="">
<input type=hidden name=smName value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
function  modify()
{
    var a = parseInt(document.frm.rightCode.value,10) ;
    var b = parseInt(document.frm.qryFlag2307.value,10) ;
    if(a == "0" && b > "0")
	{
		rdShowMessageDialog("对不起！您只能修改成负值,请重新操作！");
		document.frm.qryFlag.value= "0";
		document.frm.qryFlag.focus();
		return false;
	}
}
function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框 
	var h=180;
	var w=380;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

    var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="e068" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话


    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfn+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
			
     var ret=window.showModalDialog(path,printStr,prop);
     
	   if(typeof(ret)!="undefined")
	   {
		ret="confirm";
		 if((ret=="confirm")&&(submitCfn == "Yes"))
		 {

			
		   if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
		   {
			  printFlag=1;
		   }
		 }
	   }
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
    if(printType == "Detail")
    {
		  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		  cust_info+="客户姓名："+document.frm.custName.value+"|";
		  cust_info+="手机号码："+document.frm.phoneNo.value+"|";
		  cust_info+="客户地址："+document.frm.custAddress.value+"|";
		  cust_info+="证件号码："+document.frm.idCardNo.value+"|"; 
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  retInfo+=""+"|";
		  opr_info+="用户品牌："+document.frm.smName.value+"|";
		  opr_info+="办理业务：用户属性修改。"+"|";
		  opr_info+="操作流水："+document.frm.loginAccept.value+"|";
		  opr_info+="用户原属性："+document.frm.oldGradeName.value+"|";
		  opr_info+="用户新属性："+document.frm.gradeCode.options[document.frm.gradeCode.selectedIndex].text+"|";
    }  
    if(printType == "Bill")
    {	//打印发票
    }
	    retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	    return retInfo;	
}
</script>
<script>
function printBill(){
	 var infoStr="";                                                                         
	     infoStr+=" "+"|";                                                                        
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=document.frm.phoneNo.value+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+=document.frm.custName.value+"|";//用户名称                                                
	 infoStr+=document.frm.custAddress.value+"|";//用户地址     
	 infoStr+="现金"+"|";
	 infoStr+=document.frm.handFee.value+"|";                                            
	 infoStr+="详单禁查申请。*手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
	 location.href="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=e068.jsp";                    
}

//xl add for 2308的
function submitCfm1_2308(){
	getAfterPrompt();
	if(document.frm.remark2307.value.length==0){
			document.frm.remark2307.value="用户信誉度修改";
		}	
		
	if(!forReal(document.frm.handFee2307)){
			return;
		}
		if(parseFloat(document.frm.handFee2307.value) > parseFloat(document.frm.handFee2307.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
			return;
}
		
		var creditI = 0;
		var newCredit = "";
	for(creditI = 0 ; creditI < document.frm.qryFlag2307.length ; creditI ++){
		if(document.frm.qryFlag2307.options[creditI].selected){
			newCredit = document.frm.qryFlag2307.options[creditI].value;
			
		}
	}
	//alert("取出当前信誉度是"+newCredit);
	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType2307.length ; idJ ++){
			if(document.frm.asIdType2307.options[idJ].selected==true){
				inputIdType = document.frm.asIdType2307.options[idJ].value;
			}
		}
	var expireTimeValue = "";
	if(document.frm.chgStatus2307.value=="N"){
		if(!validDate(document.frm.expireTime2307)){
		return;
		}
		if(document.frm.nowDate2307.value>=document.frm.expireTime2307.value){
		rdShowMessageDialog("有效期应该大于当前日期");
		return false;
		}
		expireTimeValue=document.frm.expireTime2307.value+" 00:00:00";
		
	}
		var show = document.getElementById("show").value;
		//alert("show is "+show);
		if(show=="ok")
		{
			//alert("this ");
			var	prtFlag = rdShowConfirmDialog("该客户已办理了动态信誉度，本操作将导致其原信誉度失效，请确认是否需要提交。");
			if (prtFlag==1)
			{
				printCommit_2308();
				if(printFlag==1){
					return;
				}
				document.frm.submit2307.disabled=true;
				var myPacket = new AJAXPacket("e068_2308Cfm.jsp?asCustName="+document.frm.asCustName2307.value+"&asCustPhone="+document.frm.asCustPhone2307.value+"&asIdIccid="+document.frm.asIdIccid2307.value+"&asIdAddress="+document.frm.asIdAddress2307.value+"&asContractAddress="+document.frm.asContractAddress2307.value+"&asNotes="+document.frm.asNotes2307.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark2307.value,"正在提交，请稍候......");
				
				myPacket.data.add("loginAccept",document.frm.loginAccept.value);
				//myPacket.data.add("opCode",document.frm.opCode.value);
				myPacket.data.add("opCode","e068");
				myPacket.data.add("workNo",document.frm.workNo.value);
				myPacket.data.add("noPass",document.frm.noPass.value);
				myPacket.data.add("asIdType",inputIdType);
				myPacket.data.add("orgCode",document.frm.orgCode.value);
				myPacket.data.add("idNo",document.frm.userId.value);
				myPacket.data.add("oldCredit",document.frm.qryFlagT2307.value);
				
				myPacket.data.add("newCredit",document.all.qryFlag2307.value);
				//myPacket.data.add("newCredit",document.frm.chgStatus.value);
				myPacket.data.add("expireTime",expireTimeValue);
				myPacket.data.add("handFee",document.frm.handFeeT.value);
				myPacket.data.add("factPay",document.frm.handFee2307.value);

				//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
				myPacket.data.add("chgStatus",document.frm.chgStatus2307.value);
				myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());

				core.ajax.sendPacket(myPacket);

				myPacket=null;
			}
			else
			{
				return false;
			}
		}
		else
		{
				//alert("that ");
				printCommit_2308();
				if(printFlag==1){
					return;
				}
				document.frm.submit2307.disabled=true;
				var myPacket = new AJAXPacket("e068_2308Cfm.jsp?asCustName="+document.frm.asCustName2307.value+"&asCustPhone="+document.frm.asCustPhone2307.value+"&asIdIccid="+document.frm.asIdIccid2307.value+"&asIdAddress="+document.frm.asIdAddress2307.value+"&asContractAddress="+document.frm.asContractAddress2307.value+"&asNotes="+document.frm.asNotes2307.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark2307.value,"正在提交，请稍候......");
				
				myPacket.data.add("loginAccept",document.frm.loginAccept.value);
				//myPacket.data.add("opCode",document.frm.opCode.value);
				myPacket.data.add("opCode","e068");
				myPacket.data.add("workNo",document.frm.workNo.value);
				myPacket.data.add("noPass",document.frm.noPass.value);
				myPacket.data.add("asIdType",inputIdType);
				myPacket.data.add("orgCode",document.frm.orgCode.value);
				myPacket.data.add("idNo",document.frm.userId.value);
				myPacket.data.add("oldCredit",document.frm.qryFlagT2307.value);
				
				myPacket.data.add("newCredit",document.all.qryFlag2307.value);
				//myPacket.data.add("newCredit",document.frm.chgStatus.value);
				myPacket.data.add("expireTime",expireTimeValue);
				myPacket.data.add("handFee",document.frm.handFeeT.value);
				myPacket.data.add("factPay",document.frm.handFee2307.value);

				//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
				myPacket.data.add("chgStatus",document.frm.chgStatus2307.value);
				myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());

				core.ajax.sendPacket(myPacket);

				myPacket=null;
		}
		
		
		
    	 
}

function resett_2308(){
	document.frm.asCustName.value="";
	document.frm.asCustPhone.value="";
	document.frm.asIdType.options[0].selected=true;
	document.frm.asIdIccid.value="";
	document.frm.asIdAddress.value="";
	document.frm.asContractAddress.value="";
	document.frm.asNotes.value="";
	document.frm.userId.value="";
	document.frm.runName.value="";
	document.frm.gradeName.value="";
	document.frm.idCardNo.value="";				
	document.frm.totalPrepay.value="";				
	document.frm.totalOwe.value="";
	document.frm.custName.value="";
	
	document.frm.qry.disabled=false;
	document.frm.phoneNo.disabled=false;
//	document.frm.submit.disabled=true;
	document.frm.custAddress.value="";
	
	document.frm.cardType.value="";
	printFlag=9;
	timeFlag=0;
	flag1=0;
}
function printCommit_2308()
{          
	// in here form check
	showPrtDlg_2308("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg_2308(printType,DlgMessage,submitCfn)
{  
   document.all.sysRemark.value="用户"+document.all.phoneNo.value+"信誉度修改";
   if((document.all.asNotes2307.value).trim().length==0)
   {
	  document.all.asNotes2307.value="操作员<%=workNo%>"+"对用户"+document.all.phoneNo.value+"进行信誉度修改"
   }	
	
   //显示打印对话框 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo_2308(printType);			 		//调用printInfo_2308()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="e068" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm1="+submitCfn+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
   if(typeof(ret)!="undefined")
   {
	ret="confirm";
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {

       if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo_2308(printType)
{
    var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	
    if(printType == "Detail")
    {
	  //alert("test for document.all.custName.value is "+document.all.custName.value);
	  var retInfo = "";
      note_info2+='<%=workNo%>'+"|";
      note_info3+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="客户姓名：" +document.all.custName.value+"|";
      cust_info+="手机号码："+document.all.phoneNo.value+"|";
      cust_info+="客户地址："+document.all.custAddress.value+"|";
      cust_info+="证件号码："+document.all.idCardNo.value+"|";


      opr_info+="业务类型："+"用户信誉度修改"+"|";

	  
      opr_info+="业务办理前信誉度："+document.all.oldCredit2307.value+"|";
	  opr_info+="业务办理后信誉度："+document.all.qryFlag2307.value+"|";
      opr_info+="流水："+document.all.loginAccept.value+"|";

      note_info4+=document.all.remark2307.value+"|";
     // note_info4+=document.all.asNotes2307.value+" "+document.all.simBell.value+"|"; 
      note_info4+=document.all.asNotes2307.value;
    }  
    if(printType == "Bill")
    {	//打印发票
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}

//xl end for 2308的
function editEd2()
{
//alert("修改信誉度额度");
	document.frm.qryFlag2307.value=document.frm.zyed.value;
}
function editEd1()
{
//alert("修改信誉度额度");
	document.frm.qryFlag2307.value=document.frm.xydpz_ed.value;
}
function submitCfm_final(ItemArray,GroupArray)
{
	//alert("一步操作开始,需判断当前信誉属性or重要属性 对其是否需要输入的参数进行验证 假设当前为参数均正确；先调2308后1256");
	var gradeCodeId=document.getElementById("gradeCodeId").value;
	var codeDetail = document.getElementById("codeDetail").value;
	var codeDetail2 = document.getElementById("codeDetail2").value;
	//alert("gradeCodeId is "+gradeCodeId+" and codeDetail is "+codeDetail+" and codeDetail2 is "+codeDetail2);
	getAfterPrompt();

	//xl add for fanyan begin
	var sx_phone_no0 = document.frm.sx_phone_no0.value;
	var sx_zw0 = document.getElementById("sx_zw_id0").value;
	var sx_phone_no1 = document.frm.sx_phone_no1.value;
	var sx_zw1 = document.getElementById("sx_zw_id1").value;
	var sx_phone_no2 = document.frm.sx_phone_no2.value;
	var sx_zw2 = document.getElementById("sx_zw_id2").value;
	//alert("sx_phone_no0 is "+sx_phone_no0+" and sx_zw0 is "+sx_zw0);
	//如果填手机号码 但是职位为空 不可以
	if(sx_phone_no0!="" &&sx_zw0=="0" )
	{
		rdShowMessageDialog("请选择首席客户代表职位");
		return false;
	}
	if(sx_phone_no1!="" &&sx_zw1=="0")
	{
		rdShowMessageDialog("请选择首席客户代表职位");
		return false;
	}
	if(sx_phone_no2!="" &&sx_zw2=="0")
	{
		rdShowMessageDialog("请选择首席客户代表职位");
		return false;
	}
	//如果选职位了 但是手机号码为空 不可以
	if(sx_phone_no0=="" &&sx_zw0!="0" )
	{
		rdShowMessageDialog("请输入首席客户代表手机号码");
		return false;
	}
	if(sx_phone_no1=="" &&sx_zw1!="0" )
	{
		rdShowMessageDialog("请输入首席客户代表手机号码");
		return false;
	}
	if(sx_phone_no2=="" &&sx_zw2!="0" )
	{
		rdShowMessageDialog("请输入首席客户代表手机号码");
		return false;
	}
	//xl add for fanyan end
	


	if(document.frm.remark2307.value.length==0){
			document.frm.remark2307.value="用户信誉度修改";
		}	
		
	if(!forReal(document.frm.handFee2307)){
			return;
	}
	if(parseFloat(document.frm.handFee2307.value) > parseFloat(document.frm.handFee2307.value)){
			rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
			return;
	}
		
	var creditI = 0;
	var newCredit = "";
	for(creditI = 0 ; creditI < document.frm.qryFlag2307.length ; creditI ++){
		if(document.frm.qryFlag2307.options[creditI].selected){
			newCredit = document.frm.qryFlag2307.options[creditI].value;
			
		}
	}
	//alert("取出当前信誉度是"+newCredit);
	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType2307.length ; idJ ++){
			if(document.frm.asIdType2307.options[idJ].selected==true){
				inputIdType = document.frm.asIdType2307.options[idJ].value;
			}
		}
	var expireTimeValue = "";
	if(document.frm.chgStatus2307.value=="N"){
		if(!validDate(document.frm.expireTime2307)){
		return;
		}
		if(document.frm.nowDate2307.value>=document.frm.expireTime2307.value){
		rdShowMessageDialog("有效期应该大于当前日期");
		return false;
		}
		expireTimeValue=document.frm.expireTime2307.value+" 00:00:00";
		
	}
		var show = document.getElementById("show").value;
		//alert("show is 什么纸？ "+show);
		if(show=="ok")
		{
			//alert("this ");
			var	prtFlag = rdShowConfirmDialog("该客户已办理了动态信誉度，本操作将导致其原信誉度失效，请确认是否需要提交。");
			if (prtFlag==1)
			{
				//printCommit_2308();
				if(printFlag==1){
					return;
				}
				//document.frm.submit2307.disabled=true;
				var myPacket = new AJAXPacket("e068_2308Cfm.jsp?asCustName="+document.frm.asCustName2307.value+"&asCustPhone="+document.frm.asCustPhone2307.value+"&asIdIccid="+document.frm.asIdIccid2307.value+"&asIdAddress="+document.frm.asIdAddress2307.value+"&asContractAddress="+document.frm.asContractAddress2307.value+"&asNotes="+document.frm.asNotes2307.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark2307.value,"正在提交，请稍候......");
				
				myPacket.data.add("loginAccept",document.frm.loginAccept.value);
				//myPacket.data.add("opCode",document.frm.opCode.value);
				myPacket.data.add("opCode","e068");
				myPacket.data.add("workNo",document.frm.workNo.value);
				myPacket.data.add("noPass",document.frm.noPass.value);
				myPacket.data.add("asIdType",inputIdType);
				myPacket.data.add("orgCode",document.frm.orgCode.value);
				myPacket.data.add("idNo",document.frm.userId.value);
				myPacket.data.add("oldCredit",document.frm.qryFlagT2307.value);
				
				//myPacket.data.add("newCredit",document.all.qryFlag2307.value);
				//myPacket.data.add("newCredit",document.frm.chgStatus.value);
				myPacket.data.add("expireTime",expireTimeValue);
				myPacket.data.add("handFee",document.frm.handFeeT.value);
				myPacket.data.add("factPay",document.frm.handFee2307.value);

				//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
				myPacket.data.add("chgStatus",document.frm.chgStatus2307.value);
				myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
				//xl add for 插入配置信誉度操作
			//	alert("codeDetail is "+codeDetail+" and codeDetail2 is "+codeDetail2);
				//当用户属性不是信誉or重要的时候 要将codeDetail和codeDetail2置为空
				/*
				if(gradeCodeId!="12"||gradeCodeId!="80"||gradeCodeId!="81"||gradeCodeId!="10"||gradeCodeId!="50"||gradeCodeId!="51"||gradeCodeId!="52"||gradeCodeId!="53"||gradeCodeId!="54"||gradeCodeId!="55"||gradeCodeId!="56")
				{
					alert("走着111");
					codeDetail="";
					codeDetail2="";
				}*/
				if(codeDetail!="" ||codeDetail2!="")
				{
				//	alert("不该走这里");
					myPacket.data.add("flag_final",1);
					if(codeDetail!="")
					{
						//alert("信誉的 VIP钻石卡客户、VIP金卡客户、VIP银卡客户 不需要催费短信联系人相关的两项信息");
						//alert("催费短信联系人不可以是用户本人");
						//alert("信誉的");
						for ( x = 0 ; x < ItemArray.length  ; x++ )
						{
							if ( ItemArray[x] == codeDetail )
							{
								//document.getElementById("cz").value = GroupArray[x];
								//alert("当前额度是 "+GroupArray[x]+" and输入额度是 "+document.frm.xydpz_ed.value);
								if(parseFloat(document.frm.xydpz_ed.value) >parseFloat(GroupArray[x]) )
								{
									rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
									document.frm.xydpz_ed.focus();
									return false;
								}
								//document.frm.xydpz_ed.value=GroupArray[x];
								//document.frm.xydpz_ed_hide.value=GroupArray[x];
							}
						}
						/*if(codeDetail!="50" &&codeDetail!="51" &&codeDetail!="52" )
						{
							if(document.all.xydpz_lxrxm.value=="")
							{
								rdShowMessageDialog("请输入催费短信联系人姓名！");
								document.all.xydpz_lxrxm.focus();	
								return false;
							}
							if(document.all.xydpz_lxfs.value=="")
							{
								rdShowMessageDialog("请输入催费短信联系人联系方式！");
								document.all.xydpz_lxfs.focus();	
								return false;
							}
						}*/
						//非本人
						if(document.all.xydpz_lxrxm.value==document.all.custName2307.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.xydpz_lxrxm.value="";
							document.all.xydpz_lxrxm.focus();	
							return false;
						}
						if(document.all.xydpz_lxfs.value==document.all.phoneNo.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.xydpz_lxfs.value="";
							document.all.xydpz_lxfs.focus();	
							return false;
						}
						//信誉度不可为空 到期时间 客户经理姓名 客户经理联系方式
						if(document.all.xydpz_ed.value=="")
						{
							rdShowMessageDialog("信誉度不可以为空！");
							document.all.xydpz_ed.focus();	
							return false;
						}
						if(document.all.xydpz_dqsj.value=="")
						{
							rdShowMessageDialog("信誉度到期时间不可以为空！");
							document.all.xydpz_dqsj.focus();	
							return false;
						}
						// new 普通 不需要经理和联系方式 begin
						if(codeDetail=="50" ||codeDetail=="51"||codeDetail=="52"||codeDetail=="53"||codeDetail=="54"||codeDetail=="55")
						{
							if(document.all.xydpz_jlxm.value=="")
							{
								rdShowMessageDialog("客户经理姓名不可以为空！");
								document.all.xydpz_jlxm.focus();	
								return false;
							}
							if(document.all.xydpz_jllxfs.value=="")
							{
								rdShowMessageDialog("客户经理联系方式不可以为空！");
								document.all.xydpz_jllxfs.focus();	
								return false;
							}
						}
						// new 普通 不需要经理和联系方式 end 
						//月份差
						if(document.frm.xydpz_dqsj.value=="20500101" && document.frm.xydpz_ed.value=="0")
						{
							//return true;
						}
						else
						{
							var dates = new Date();
							var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
							var date2 =document.frm.xydpz_dqsj.value;
							//alert("开始时间 "+date1+" and 结束时间 "+date2);
							Month=DateDiff(date1,date2);
							//alert("Month is "+Month);
							if(Month<0)
							{
								rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
								return false;
							}
							if(Month>14)
							{
								rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
								return false;
							}
							if(Month==14)
							{
								var fina_date=document.all.xydpz_dqsj.value.substr(6,2);
								var com_date = new String(dates.getDate().toString());
								if(parseInt(fina_date)>parseInt(com_date))
								{
									rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
									return false;
								}
							}
						}
						//new begin 长度11位限制
						if(document.all.xydpz_lxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.xydpz_lxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确催费短信联系人联系方式！");
								document.all.xydpz_lxfs.focus();	
								return false;
							}	
						}
						if(document.all.xydpz_jllxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.xydpz_jllxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确客户经理联系方式！");
								document.all.xydpz_jllxfs.focus();	
								return false;
							}	
						}
						//end 长度11限制
						//document.all.qryFlag2307.value=document.all.xydpz_ed.value;
						myPacket.data.add("newCredit",document.all.qryFlag2307.value);

						myPacket.data.add("codeDetail",codeDetail);
					//	alert("1当前codeDetail是 "+codeDetail);
						myPacket.data.add("ed",document.frm.xydpz_ed.value);
						myPacket.data.add("dqsj",document.frm.xydpz_dqsj.value);
						myPacket.data.add("lxrxm",document.frm.xydpz_lxrxm.value);	
						myPacket.data.add("lxfs",document.frm.xydpz_lxfs.value);	
						myPacket.data.add("jlxm",document.frm.xydpz_jlxm.value);	
						myPacket.data.add("jllxfs",document.frm.xydpz_jllxfs.value);	
					}
					if(codeDetail2!="")
					{
						//alert("重要的");
						for ( x = 0 ; x < ItemArray.length  ; x++ )
						{
							if ( ItemArray[x] == codeDetail2 )
							{
								//document.getElementById("cz").value = GroupArray[x];
								//alert("当前额度是 "+GroupArray[x]+" and输入额度是 "+document.frm.zyed.value);
								if(parseFloat(document.frm.zyed.value) >parseFloat(GroupArray[x]) )
								{
									rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
									document.frm.zyed.focus();
									return false;
								}
								//document.frm.xydpz_ed.value=GroupArray[x];
								//document.frm.xydpz_ed_hide.value=GroupArray[x];
							}
						}
						//alert("中药的 所有不可为空 否则报错");
						//alert("催费短信联系人不可以是用户本人");
						//非本人
						if(document.all.zylxrxm.value==document.all.custName2307.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.zylxrxm.value="";
							document.all.zylxrxm.focus();	
							return false;
						}
						if(document.all.zylxfs.value==document.all.phoneNo.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.zylxfs.value="";
							document.all.zylxfs.focus();	
							return false;
						}
						//信誉度不可为空 到期时间 客户经理姓名 客户经理联系方式
						if(document.all.zyed.value=="")
						{
							rdShowMessageDialog("信誉度不可以为空！");
							document.all.zyed.focus();	
							return false;
						}
						if(document.all.zydqsj.value=="")
						{
							rdShowMessageDialog("信誉度到期时间不可以为空！");
							document.all.zydqsj.focus();	
							return false;
						}
						
						if(document.all.zyjlxm.value=="")
						{
							rdShowMessageDialog("客户经理姓名不可以为空！");
							document.all.zyjlxm.focus();	
							return false;
						}
						if(document.all.zyjllxfs.value=="")
						{
							rdShowMessageDialog("客户经理联系方式不可以为空！");
							document.all.zyjllxfs.focus();	
							return false;
						}
						if(document.all.zylxrxm.value=="")
						{
							rdShowMessageDialog("催费短信联系人姓名不可以为空！");
							document.all.zylxrxm.focus();	
							return false;
						}
						if(document.all.zylxfs.value=="")
						{
							rdShowMessageDialog("催费短信联系人的联系方式不可以为空！");
							document.all.zylxfs.focus();	
							return false;
						}
						//月份差
						if(document.frm.zydqsj.value=="20500101" && document.frm.zyed.value=="0")
						{
							//return true;
						}
						else
						{
							var dates = new Date();
							var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
							var date2 =document.frm.zydqsj.value;
							//alert("开始时间 "+date1+" and 结束时间 "+date2);
							Month=DateDiff(date1,date2);
							//alert("Month is "+Month);
							if(Month<0)
							{
								rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
								return false;
							}
							if(Month>14)
							{
								rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
								return false;
							}
							if(Month==14)
							{
								var fina_date=document.all.zydqsj.value.substr(6,2);
								var com_date = new String(dates.getDate().toString());
								if(parseInt(fina_date)>parseInt(com_date))
								{
									rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
									return false;
								}
							}
						}
						//new begin 长度11位限制
						if(document.all.zylxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.zylxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确催费短信联系人联系方式！");
								document.all.zylxfs.focus();	
								return false;
							}	
						}
						if(document.all.zyjllxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.zyjllxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确客户经理联系方式！");
								document.all.zyjllxfs.focus();	
								return false;
							}	
						}
						//end 长度11限制
						//document.all.qryFlag2307.value=document.all.zyed.value;
						myPacket.data.add("newCredit",document.all.qryFlag2307.value);

						myPacket.data.add("codeDetail",codeDetail2);
					//	alert("2当前codeDetail是 "+codeDetail2);
						myPacket.data.add("ed",document.frm.zyed.value);
						myPacket.data.add("dqsj",document.frm.zydqsj.value);
						myPacket.data.add("lxrxm",document.frm.zylxrxm.value);	
						myPacket.data.add("lxfs",document.frm.zylxfs.value);	
						myPacket.data.add("jlxm",document.frm.zyjlxm.value);	
						myPacket.data.add("jllxfs",document.frm.zyjllxfs.value);

						//xl add for fanyan begin
						myPacket.data.add("sx_phone_no0",sx_phone_no0);
						myPacket.data.add("sx_zw0",sx_zw0);
						myPacket.data.add("sx_phone_no1",sx_phone_no1);
						myPacket.data.add("sx_zw1",sx_zw1);
						myPacket.data.add("sx_phone_no2",sx_phone_no2);
						myPacket.data.add("sx_zw2",sx_zw2);
						//xl add for fanyan end
					}
					
					
				}
				core.ajax.sendPacket(myPacket);

				myPacket=null;
			}
			else
			{
				return false;
			}
		}
		else//非办理过的
		{
				var	prtFlag = rdShowConfirmDialog("是否确定提交?");
				if(prtFlag!=1)
				{
					return false;
				}
				//document.frm.submit2307.disabled=true;
				var myPacket = new AJAXPacket("e068_2308Cfm.jsp?asCustName="+document.frm.asCustName2307.value+"&asCustPhone="+document.frm.asCustPhone2307.value+"&asIdIccid="+document.frm.asIdIccid2307.value+"&asIdAddress="+document.frm.asIdAddress2307.value+"&asContractAddress="+document.frm.asContractAddress2307.value+"&asNotes="+document.frm.asNotes2307.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark2307.value+"&loginAccept="+document.frm.loginAccept.value+"&opCode=e068"+"&workNo="+document.frm.workNo.value,"正在提交，请稍候......");
			  
			 
				myPacket.data.add("noPass",document.frm.noPass.value);
				myPacket.data.add("asIdType",inputIdType);
				myPacket.data.add("orgCode",document.frm.orgCode.value);
				myPacket.data.add("idNo",document.frm.userId.value);
				myPacket.data.add("oldCredit",document.frm.qryFlagT2307.value);
				
				//myPacket.data.add("newCredit",document.all.qryFlag2307.value);
				myPacket.data.add("expireTime",expireTimeValue);
				myPacket.data.add("handFee",document.frm.handFeeT.value);
				myPacket.data.add("factPay",document.frm.handFee2307.value);

				//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
				myPacket.data.add("chgStatus",document.frm.chgStatus2307.value);
				myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
				//xl add for 插入配置信誉度操作
				//xl add for 插入配置信誉度操作
				if(codeDetail!="" || codeDetail2!="")
				{
					//alert("go Here111");

					myPacket.data.add("flag_final",1);
					if(codeDetail!="")
					{
						//codeDetail2="";
						for ( x = 0 ; x < ItemArray.length  ; x++ )
						{
							if ( ItemArray[x] == codeDetail )
							{
								//document.getElementById("cz").value = GroupArray[x];
								//alert("当前额度是 "+GroupArray[x]+" and输入额度是 "+document.frm.xydpz_ed.value);
								if(parseFloat(document.frm.xydpz_ed.value) >parseFloat(GroupArray[x]) )
								{
									rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
									document.frm.xydpz_ed.focus();
									return false;
								}
								//document.frm.xydpz_ed.value=GroupArray[x];
								//document.frm.xydpz_ed_hide.value=GroupArray[x];
							}
						}/*
						if(codeDetail!="50" &&codeDetail!="51" &&codeDetail!="52" )
						{
							if(document.all.xydpz_lxrxm.value=="")
							{
								rdShowMessageDialog("请输入催费短信联系人姓名！");
								document.all.xydpz_lxrxm.focus();	
								return false;
							}
							if(document.all.xydpz_lxfs.value=="")
							{
								rdShowMessageDialog("请输入催费短信联系人联系方式！");
								document.all.xydpz_lxfs.focus();	
								return false;
							}
						}*/
						
						//非本人
						if(document.all.xydpz_lxrxm.value==document.all.custName2307.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.xydpz_lxrxm.value="";
							document.all.xydpz_lxrxm.focus();	
							return false;
						}
						if(document.all.xydpz_lxfs.value==document.all.phoneNo.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.xydpz_lxfs.value="";
							document.all.xydpz_lxfs.focus();	
							return false;
						}
						//信誉度不可为空 到期时间 客户经理姓名 客户经理联系方式
						if(document.all.xydpz_ed.value=="")
						{
							rdShowMessageDialog("信誉度不可以为空！");
							document.all.xydpz_ed.focus();	
							return false;
						}
						if(document.all.xydpz_dqsj.value=="")
						{
							rdShowMessageDialog("信誉度到期时间不可以为空！");
							document.all.xydpz_dqsj.focus();	
							return false;
						}
						// new 普通 不需要经理和联系方式 begin
						if(codeDetail=="50" ||codeDetail=="51"||codeDetail=="52"||codeDetail=="53"||codeDetail=="54"||codeDetail=="55")
						{
							if(document.all.xydpz_jlxm.value=="")
							{
								rdShowMessageDialog("客户经理姓名不可以为空！");
								document.all.xydpz_jlxm.focus();	
								return false;
							}
							if(document.all.xydpz_jllxfs.value=="")
							{
								rdShowMessageDialog("客户经理联系方式不可以为空！");
								document.all.xydpz_jllxfs.focus();	
								return false;
							}
						}
						// new 普通 不需要经理和联系方式 end
						
						//月份差
						if(document.frm.xydpz_dqsj.value=="20500101" && document.frm.xydpz_ed.value=="0")
						{
							//return true;
						}
						else
						{
							var dates = new Date();
							var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
							var date2 =document.frm.xydpz_dqsj.value;
							//alert("开始时间 "+date1+" and 结束时间 "+date2);
							Month=DateDiff(date1,date2);
							if(Month<0)
							{
								rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
								return false;
							}
							if(Month>14)
							{
								rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
								return false;
							}
							if(Month==14)
							{
								var fina_date=document.all.xydpz_dqsj.value.substr(6,2);
								var com_date = new String(dates.getDate().toString());
								if(parseInt(fina_date)>parseInt(com_date))
								{
									rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
									return false;
								}
							}
						}
						//new begin 长度11位限制
						if(document.all.xydpz_lxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.xydpz_lxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确催费短信联系人联系方式！");
								document.all.xydpz_lxfs.focus();	
								return false;
							}	
						}
						if(document.all.xydpz_jllxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.xydpz_jllxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确客户经理联系方式！");
								document.all.xydpz_jllxfs.focus();	
								return false;
							}	
						}
						//end 长度11限制
					//	document.all.qryFlag2307.value=document.all.xydpz_ed.value;
						myPacket.data.add("newCredit",document.all.qryFlag2307.value);
						myPacket.data.add("codeDetail",codeDetail);
					//	alert("3当前codeDetail是 "+codeDetail);
						myPacket.data.add("ed",document.frm.xydpz_ed.value);
						myPacket.data.add("dqsj",document.frm.xydpz_dqsj.value);
						myPacket.data.add("lxrxm",document.frm.xydpz_lxrxm.value);	
						myPacket.data.add("lxfs",document.frm.xydpz_lxfs.value);	
						myPacket.data.add("jlxm",document.frm.xydpz_jlxm.value);	
						myPacket.data.add("jllxfs",document.frm.xydpz_jllxfs.value);	
					}
					if(codeDetail2!="")
					{
						//codeDetail="";
						for ( x = 0 ; x < ItemArray.length  ; x++ )
						{
							if ( ItemArray[x] == codeDetail2 )
							{
								//document.getElementById("cz").value = GroupArray[x];
								//alert("当前额度是 "+GroupArray[x]+" and输入额度是 "+document.frm.zyed.value);
								if(parseFloat(document.frm.zyed.value) >parseFloat(GroupArray[x]) )
								{
									rdShowMessageDialog("当前设置信誉度设置金额已大于可设置封顶额度!");
									document.frm.zyed.focus();
									return false;
								}
								//document.frm.xydpz_ed.value=GroupArray[x];
								//document.frm.xydpz_ed_hide.value=GroupArray[x];
							}
						}
						//alert("中药的 所有不可为空 否则报错");
						//alert("催费短信联系人不可以是用户本人");
						//非本人
						if(document.all.zylxrxm.value==document.all.custName2307.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.zylxrxm.value="";
							document.all.zylxrxm.focus();	
							return false;
						}
						if(document.all.zylxfs.value==document.all.phoneNo.value)
						{
							rdShowMessageDialog("催费短信联系人不可以是用户本人!");
							document.all.zylxfs.value="";
							document.all.zylxfs.focus();	
							return false;
						}
						//信誉度不可为空 到期时间 客户经理姓名 客户经理联系方式
						if(document.all.zyed.value=="")
						{
							rdShowMessageDialog("信誉度不可以为空！");
							document.all.zyed.focus();	
							return false;
						}
						if(document.all.zydqsj.value=="")
						{
							rdShowMessageDialog("信誉度到期时间不可以为空！");
							document.all.zydqsj.focus();	
							return false;
						}
						
						if(document.all.zyjlxm.value=="")
						{
							rdShowMessageDialog("客户经理姓名不可以为空！");
							document.all.zyjlxm.focus();	
							return false;
						}
						if(document.all.zyjllxfs.value=="")
						{
							rdShowMessageDialog("客户经理联系方式不可以为空！");
							document.all.zyjllxfs.focus();	
							return false;
						}
						if(document.all.zylxrxm.value=="")
						{
							rdShowMessageDialog("催费短信联系人姓名不可以为空！");
							document.all.zylxrxm.focus();	
							return false;
						}
						if(document.all.zylxfs.value=="")
						{
							rdShowMessageDialog("催费短信联系人的联系方式不可以为空！");
							document.all.zylxfs.focus();	
							return false;
						}
						//月份差
						if(document.frm.zydqsj.value=="20500101" && document.frm.zyed.value=="0")
						{
							//return true;
						}
						else
						{
							var dates = new Date();
							var date1 = new String(dates.getFullYear())+new String(dates.getMonth());
							var date2 =document.frm.zydqsj.value;
							//alert("开始时间 "+date1+" and 结束时间 "+date2);
							Month=DateDiff(date1,date2);
							if(Month<0)
							{
								rdShowMessageDialog("信誉度设置有效期不可以小于当前年月！");
								return false;
							}
							if(Month>14)
							{
								rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
								return false;
							}
							if(Month==14)
							{
								var fina_date=document.all.zydqsj.value.substr(6,2);
								var com_date = new String(dates.getDate().toString());
								if(parseInt(fina_date)>parseInt(com_date))
								{
									rdShowMessageDialog("信誉度设置有效期不可以超过14个月！");
									return false;
								}
							}
						}
						//new begin 长度11位限制
						if(document.all.zylxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.zylxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确催费短信联系人联系方式！");
								document.all.zylxfs.focus();	
								return false;
							}	
						}
						if(document.all.zyjllxfs.value!="")
						{
							//alert("document.all.xydpz_lxfs.length is "+document.all.xydpz_lxfs.value.length);
							if(document.all.zyjllxfs.value.length<11)
							{
								rdShowMessageDialog("请输入正确客户经理联系方式！");
								document.all.zyjllxfs.focus();	
								return false;
							}	
						}
						//end 长度11限制
						//document.all.qryFlag2307.value=document.all.zyed.value;
						//alert("4当前额度是 "+document.frm.zyed.value);
						myPacket.data.add("newCredit",document.all.qryFlag2307.value);
						myPacket.data.add("codeDetail",codeDetail2);
					//	alert("4当前codeDetail是 "+codeDetail2);
						myPacket.data.add("ed",document.frm.zyed.value);
						myPacket.data.add("dqsj",document.frm.zydqsj.value);
						myPacket.data.add("lxrxm",document.frm.zylxrxm.value);	
						myPacket.data.add("lxfs",document.frm.zylxfs.value);	
						myPacket.data.add("jlxm",document.frm.zyjlxm.value);	
						myPacket.data.add("jllxfs",document.frm.zyjllxfs.value);
						//xl add for fanyan begin
						myPacket.data.add("sx_phone_no0",sx_phone_no0);
						myPacket.data.add("sx_zw0",sx_zw0);
						myPacket.data.add("sx_phone_no1",sx_phone_no1);
						myPacket.data.add("sx_zw1",sx_zw1);
						myPacket.data.add("sx_phone_no2",sx_phone_no2);
						myPacket.data.add("sx_zw2",sx_zw2);
						//xl add for fanyan end
					}
					
					
				}
				
				core.ajax.sendPacket(myPacket);

				myPacket=null;
		}
		//add for 插入表和历史表 submitCfm_xydpz
		//alert("1");
		//alert("2");
		//alert("一步操作结束");
}
function editXydEd()
{
	//alert("document.all.xydpz_ed.value is "+document.all.xydpz_ed.value);
	document.all.qryFlag2307.value=document.all.xydpz_ed.value;
}
function editzyEd()
{
	document.all.qryFlag2307.value=document.all.zyed.value;
}
function resett1_final()
{
	window.location='e068.jsp?activePhone=<%=activePhone%>';
}
function removeCurrentTab1_final()
{

}
//showCredit
function beforeTest()
{
	//alert("校验属性是否可以修改 他的返回值是true才可以选择 否则");
	var obj_flag = document.all.attr1.value;
	var card_flag = document.all.attr2.value;
	var objSel_dl = document.getElementById("codeDetail").value;
	//var objSel_dl ="50"; // cardType 到时候改成 这两个值都从数据库查出来 建配置表
	//alert("obj_flag is "+obj_flag+" and card_flag is "+card_flag+" and objSel_dl is "+objSel_dl);
	if((objSel_dl!=card_flag)&&(card_flag=="01"))
	{
		alert("非VIP钻石卡不可以办理该信誉度!");
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.codeDetail.length ; idI ++){
				
				if(document.frm.codeDetail.options[idI].value==objSel_dl){
					document.frm.codeDetail.options[idI].selected=true;
					//alert("right~~"+objSel_dl);
					break;
				}
		}
		return false;
	}
	else if((objSel_dl!=card_flag)&&(card_flag=="02"))
	{
		alert("非VIP金卡不可以办理该信誉度!");
		return false;
	}
	else
	{
		alert("可以！");
		return true;
	}

}
</script>
</BODY></html>
