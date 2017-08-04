<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-15 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<%
    //定义变量
    //输入参数：帐务日期，缴费流水，机构代码，工号，权限代码。
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String orgcode = (String)session.getAttribute("orgCode");
	System.out.println("ffffffffffffffffffffffffffffffffffff test orgcode is "+orgcode.substring(0,4));
    String totaldate  = request.getParameter("billdate").trim();//帐务月份
    String phoneNo = request.getParameter("phoneNo");
    String contractno = request.getParameter("TContractNo");
    if (contractno == null) {
        contractno = request.getParameter("contractno");
    }
    String loginaccept = request.getParameter("water_number").trim();//流水号
    //loginaccept流水 查询 dinvoiceprint201701 a where  a.login_accept=10003525076085 and a.invoice_flag='1';
	String inParas_ls[] = new String[2];
	int i_ls=0;
	
 
 
	 
	

	
		//xl add 增加校验 判断是否是不可以冲正的工号
		int i_count_cz=0;
		String inParas_cz[] = new String[2];
		inParas_cz[0]="select to_char(count(0)) from shighlogin_boss b where b.login_no in ( select decode(a.login_no_pay,'',login_no, login_no_pay) from wpay"+totaldate +" a where a.login_accept=:s_ls) and b.op_code='1310'";
		inParas_cz[1]="s_ls="+loginaccept;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" retcode="retCode1" outnum="1">
			<wtc:param value="<%=inParas_cz[0]%>"/>
			<wtc:param value="<%=inParas_cz[1]%>"/>
	   </wtc:service>
		<wtc:array id="result_cz" scope="end" />
		<%
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa retCode1 test is "+retCode1);
		if(result_cz.length>0)
		{
			i_count_cz = Integer.parseInt(result_cz[0][0]);
			System.out.println("ffffffffffffffffffffzzzzzzzzzzzzzzzzzzzzzzzzzzz test i_count_cz is "+i_count_cz);
		}
		if(i_count_cz>0)
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("限制该工号不允许冲正操作!");
					history.go(-1);
				</script>
			<%
		}
		else
		{
			String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		
		/*tianyang add for pos */
		String groupId = (String)session.getAttribute("groupId");
		String nopass = (String)session.getAttribute("password");
		
		String op_code = "1310" ;
		 
		//xl add for hanfeng PB的不可以办理
		String s_sm_code="";
		String inParas_sm[] = new String[6];
		inParas_sm[0]="select sm_code from dcustmsg where phone_no=:s_no ";
		inParas_sm[1]="s_no="+phoneNo;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="1">
			<wtc:param value="<%=inParas_sm[0]%>"/>
			<wtc:param value="<%=inParas_sm[1]%>"/>
	   </wtc:service>
		<wtc:array id="result_pp" scope="end" />
		<%
		if(result_pp!=null&&result_pp.length>0)
		{
			s_sm_code=result_pp[0][0];
		}
		//end of 韩风 物联网
		String inParas[] = new String[6];
		inParas[0] = totaldate;
		inParas[1] = contractno ;
		inParas[2] = loginaccept;
		inParas[3] = workno ;
		inParas[4] = nopass;
		inParas[5] =op_code;
		/*
		String outNum="17";
		 
		int[] lens={12,5};
		 
		ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
		
		CallRemoteResultValue value=  viewBean.callService("1",orgcode.substring(0,2),"s1310Init",outNum, lens, inParas); 
		ArrayList list  = value.getList();
		*/
	%>
		<wtc:service name="s1310Init" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="21">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=inParas[4]%>"/>
			<wtc:param value="<%=inParas[5]%>"/>
		</wtc:service>
		<wtc:array id="result" start="0"  length="12"  scope="end" />
		<wtc:array id="result2" start="12"  length="5"  scope="end" />
		<wtc:array id="result3" start="17"  length="4"  scope="end" />
	<%
		//String[][] result = (String[][])list.get(0);
		
		String return_code =result[0][0];
		String return_message =result[0][1];
		String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	%>
	<%
		if (return_code.equals("000000")) {
			String return_money =result[0][2];
			return_money = return_money.trim();
			String v_name =result[0][3];
			v_name = v_name.trim();
			String user_number =result[0][4];
			String payfee_time =result[0][5];
			String login_no =result[0][6];
			String pay_total =result[0][7];
			pay_total = pay_total.trim();
			String pay_type =result[0][8];
			String nopay_water = result[0][9];
			String pay_code = result[0][10];
			String contract_no = result[0][11];
			//String[][] result2= (String[][])list.get(1);
			
	  /* chenhu add */
				double PayMoney = 0-Double.parseDouble(pay_total);
				String sPayMoney = String.valueOf(PayMoney);
	%>
		<wtc:service name="bs_ChnPayLimit" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="5">
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=sPayMoney%>"/>
		</wtc:service>
		<wtc:array id="result4"   scope="end" />
		<wtc:array id="result5"  scope="end" /> 	
		<wtc:array id="result6"  scope="end" />
		<wtc:array id="result7"  scope="end" />
		<wtc:array id="result8"  scope="end" />
	<%      
					String t_return_code = result4[0][0].trim();
					String t_return_msg = result5[0][0].trim();
					String flag_status  = result6[0][0].trim(); 
					String pledge_fee  = result7[0][0].trim(); 
					String total_money = result8[0][0].trim(); 
					System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
					System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
					System.out.println("chenhu test ############################ test flag_status is "+flag_status);
					if(!t_return_code.equals("000000")){
	%>
	 <script language='jscript'>			
							rdShowMessageDialog("查代错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
							history.go(-1);
		</script>	    
	<%		
					}
	%>
	<%
			
		/* chenhu test end */    
			
			/********tianyang add for pos start*******/
					String response_time = result3[0][0].trim();                /*银行侧交易时间*/               
					String terminalId    = result3[0][1].trim();                /*银行终端号*/
					String rrn           = result3[0][2].trim();                /*银行侧交易唯一号*/
					String request_time  = result3[0][3].trim();                /*boss侧交易时间*/
					/*out.println("原交易终端号="+terminalId);
					out.println("检索号="+rrn);
					out.println("原交易日期="+response_time);*/
					/********tianyang add for pos end********/
			
			
	%>

	<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>缴费冲正</TITLE>
	<META content="text/html; charset=GBK" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>

	<script language="JavaScript">
	<!--

	onload=function form_load()
	{
		rdShowMessageDialog("营业员执行确认前，<br>请先收回普通缴费原始发票！");
		//document.form.remark.focus();
	}

	/*tianyang add for pos缴费 start*/
	function doProcess(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
	function padLeft(str, pad, count) 
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function formSubmit() 
	{
			getAfterPrompt();
			form.sure.disabled=true;
			form.reset.disabled=true;
			document.form.action="s1310_3.jsp";
			form.submit();
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/*tianyang add for pos缴费 end*/


	function dosubmit(s_sm_code)
	{
			//alert("s_sm_code is "+s_sm_code);
			if(s_sm_code=="PB")
			{
				rdShowMessageDialog("物联网号码不允许操作!");
				return false;
			}
			else
			{
				/*tianyang add for pos*/
				if("<%=pay_type%>"=="BY")
				{
						var TransType     = padLeft("04"," ",2);                             /*交易类型 */        
						var bMoney        = "<%=return_money%>";                                                  
						var Amount        = padLeft(bMoney.replace(".",""),"0",12);          /*交易金额 */        
						var OldAuthDate   = "<%=response_time%>";                            
						OldAuthDate       = padLeft(OldAuthDate.substr(0,8)," ",8);          /*原交易日期 */      
						var ReferNo       = padLeft("<%=rrn%>"," ",8);                       /*原交易系统检索号 */
						var InstNum       = padLeft(""," ",2);                               /*分期付款期数 */    
						var oldterid      = padLeft("<%=terminalId%>"," ",15);               /*原交易终端号 */                         
						getSysDate();   		/*取boss系统时间*/                               
						var requestTime   = padLeft(document.all.Request_time.value," ",14); /*交易提交日期 */    
						var login_no      = padLeft("<%=workno%>"," ",6);                    /*交易操作员 */      
						var org_code      = padLeft("<%=orgcode%>"," ",9);                   /*营业员归属 */      
						var org_id        = padLeft("<%=groupId%>"," ",10);                  /*营业员归属机构 */  
						var phone_no      = padLeft("<%=phoneNo%>"," ",15);                  /*交易缴费号 */      
						var toBeUpdate    = padLeft(""," ",100);                             /*预留字段 */        
						var inputStr = TransType+Amount+OldAuthDate+ReferNo+InstNum+oldterid+requestTime+login_no+org_code+org_id+phone_no+toBeUpdate;
						
						/* 调用 posICBC.jsp 中方法设置 IP，端口，串口端口 以及传入参数*/
						var str = SetICBCCfg(inputStr);
						
						if(str.split("|").length==21)
						{
							if (str.split("|")[19] !="00")
							{
								rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[19]+"错误信息："+str.split("|")[0]);
								form.sure.disabled=false;
							form.reset.disabled=false;
							}else{
								document.all.MerchantNameChs.value = str.split("|")[10]+str.split("|")[11]; /*商户名称（中英文)*/
								document.all.MerchantId.value      = str.split("|")[8];	    /*商户编码*/
								document.all.TerminalId.value      = str.split("|")[7];	    /*终端编码*/
								document.all.IssCode.value         = str.split("|")[14];		/*发卡行号*/
								document.all.AcqCode.value         = "ICBC";	              /*收单行号*/
								document.all.CardNo.value          = str.split("|")[3];			/*卡号*/
								document.all.BatchNo.value         = str.split("|")[13];		/*批次号*/
								document.all.Response_time.value   = str.split("|")[1]+str.split("|")[2];   /*回应日期时间*/
								document.all.Rrn.value             = str.split("|")[6];	    /*参考号*/
								document.all.AuthNo.value          = "";		                /*授权号*/
								document.all.TraceNo.value         = str.split("|")[12];		/*流水号*/
								/*提交时间 通过调用  getSysDate() 已经得到*/
								document.all.CardNoPingBi.value    = str.split("|")[4];     /*交易卡号（屏蔽）*/
								document.all.ExpDate.value         = str.split("|")[5];     /*卡片有效期*/
								document.all.Remak.value           = str.split("|")[17];    /*备注信息*/
								document.all.TC.value              = str.split("|")[9];     /*需要打印，用于EMV交易（芯片卡）*/
								formSubmit();
							}
						}else{
							rdShowMessageDialog("返回值数量错误！");
							form.sure.disabled=false;
						  Form.reset.disabled=false;
						}
				
				}else if("<%=pay_type%>"=="BX"){
									
						/*set 输入参数*/
						var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
						var trantype      = "01";                                  //交易类型01 当日冲正  (撤销)
						var bMoney        = "<%=return_money%>";
						var tranamount    = padLeft(bMoney.replace(".",""),"0",12);//缴费金额
						var tranoper      = "<%=workno%>";                         //交易操作员
						var orgid         = "<%=groupId%>";                        //营业员归属机构
						var trannum       = "<%=phoneNo%>";                        //电话号码			
						getSysDate();      	/*取系统时间*/
						var respstamp     = document.all.Request_time.value;       //提交时间	
						var transerialold = "<%=rrn%>";	                           //原交易唯一号,参考号
						var org_code      = "<%=orgcode%>";                        //营业员归属
						
						/* 调用 posCCB.jsp 中方法设置 IP，端口，串口端口 */
					SetSysInfo();
					/* 调用控件，进行参数传递 */
						BankCtrl.SetTranData(transerial,trantype,tranamount,tranoper,orgid,trannum,respstamp,transerialold,org_code);
						
						/*调用开始交易*/
						BankCtrl.StratTran();
				}else{
						formSubmit();
				}
			}
			
		
	}
	//-->
	</script>

	</HEAD>
	<BODY>
	<FORM action="" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">缴费信息</div>
	</div>
	<input type="hidden" name="nopaywater" value="<%=nopay_water%>">
	<input type="hidden" name="pay_code" value="<%=pay_code%>">
	<input type="hidden" name="pay_type" value="<%=pay_type%>">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">

	<!-- tianyang add at 20090928 for POS缴费需求*****start*****-->
	<input type="hidden" name="MerchantNameChs"  value="">
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- tianyang add at 20090928 for POS缴费需求*****end*******-->

		<table border=0>
			<tr> 
				<td class=blue>业务类型</td>
				<td colspan=2>缴费冲正</td>
				<td class=blue>部门</td>
				<td colspan=2><%=orgcode%></td>
			</tr>
			<tr> 
				<td class=blue>服务号码</td>
				<td colspan=2>
				<input type="text" readonly name="phoneNo" value="<%=phoneNo%>">
				</td>
				<td class=blue>缴费月份</td>
				<td colspan=2>
					<input type="text" readonly name="billdate" value="<%=totaldate%>">
				</td>
			</tr>
			<tr> 
				<td class=blue>帐户号码</td>
				<td colspan=2> 
					<input type="text" readonly name="contractno" value="<%=contract_no%>">
				</td>
				<td class=blue>缴费流水</td>
				<td colspan=2>
					<input type="text" readonly name="water_number" value="<%=loginaccept%>">
				</td>
			</tr>
			<tr> 
				<td class=blue>用户/帐户名称</td>
				<td colspan=2> 
					<input type="text" readonly name="user" value="<%=v_name%>">
				</td>
				<td class=blue>金额</td>
				<td colspan=2> 
					<input type="text" readonly name="textfield8" value="<%=pay_total%>">
				</td>
			</tr>
			<tr> 
				<td class=blue>用户数量</td>
				<td colspan=2> 
					<input type="text" readonly name="textfield6" value="<%=user_number%>">
				</td>
				<td class=blue>缴费时间</td>
				<td colspan=2> 
					<input type="text" readonly name="paytime" value="<%=payfee_time%>">
				</td>
			</tr>
			<tr> 
				<td class=blue>工号</td>
				<td colspan=5>
					<input type="text" readonly name="textfield5" value="<%=login_no%>">
				</td>
			</tr>
			
			<tr> 
				<td class=blue colspan=6>缴费信息</td>
			</tr>
			<tr> 
				<th>服务/帐户号码</th>
				<th>缴费金额</th>
				<th>预存款</th>
				<th>话费</th>
				<th colspan=2>滞纳金</th>
			</tr>
	<%
		for(int y=0;y<result2.length;y++)
		{
			if ((y%2)==1) %>
			
			<tr>
		<% else %>
			<tr> 
	<%  
		for(int j=0;j<result2[0].length;j++){
	%>
				<td><%= result2[y][j]%></td>
	<%	}  %>
			</tr>
	<%
		}
	%>


			<tr> 
				<td class=blue>退费金额</td>
				<td colspan=5> 
					<input readonly name=remark2 value="<%=return_money%>">
				</td>
			</tr>
			
		</table>
		<table cellspacing="0">
			<tbody>
				<tr>
					<td id="footer">
						<input class="b_foot" name=sure type=button value=确认 onClick="dosubmit('<%=s_sm_code%>');">
						<input class="b_foot" name=reset type=reset value=返回 onClick="window.history.go(-1)">
					</td>
				</tr>
			</tbody>
		</table>
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	<!-- **********加载建行控件页******** -->
	<%@ include file="/npage/s1300/posCCB.jsp" %>
	<script language="javascript" FOR="BankCtrl" event="Completed()" >
		str = BankCtrl.GetTranData();
		if(str.split("|").length==21)
		{
			if (str.split("|")[6] !="00")
			{
				rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[6]+"，错误信息："+str.split("|")[7]+"。");
			}else{
				document.all.MerchantNameChs.value = str.split("|")[9];  /*商户名称（中英文)*/
				document.all.MerchantId.value      = str.split("|")[10]; /*商户编码*/
				document.all.TerminalId.value      = str.split("|")[11]; /*终端编码*/
				document.all.IssCode.value         = str.split("|")[15]; /*发卡行号*/
				document.all.AcqCode.value         = str.split("|")[16]; /*收单行号*/
				document.all.CardNo.value          = str.split("|")[8];	 /*卡号*/
				document.all.BatchNo.value         = str.split("|")[13]; /*批次号*/
				document.all.Response_time.value   = str.split("|")[5];	 /*回应日期时间*/
				document.all.Rrn.value             = str.split("|")[14]; /*参考号*/
				document.all.AuthNo.value          = "";                 /*授权号*/
				document.all.TraceNo.value         = str.split("|")[12]; /*流水号*/
				/*提交时间 通过调用  getSysDate() 已经得到*/
				document.all.CardNoPingBi.value    = getCardNoPingBi(str.split("|")[8]);/*交易卡号（屏蔽）*/
				document.all.ExpDate.value         = "";                 /*卡片有效期*/
				document.all.Remak.value           = "";                 /*备注信息*/
				document.all.TC.value              = "";                 /*需要打印，用于EMV交易（芯片卡）*/
			formSubmit();
			}	    
		}else{
			rdShowMessageDialog("返回值数量错误！");
		}
	</script>

	<!-- **********加载工行控件页******** -->
	<%@ include file="/npage/s1300/posICBC.jsp" %>

	</BODY>
	</HTML>
	<%}
	else{
	%>
	<script language='JavaScript'>
			rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
			history.go(-1);
	</script>
	<%}%>

	<wtc:service name="sAwardStateB" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="2">
			  <wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=loginaccept%>"/>
	 </wtc:service>
	 <wtc:array id="result" start="0"  length="2"  scope="end" />
	 <%if(!result[0][0].equals("000000")){%>
		<script language='JavaScript'>
			rdShowMessageDialog("服务sAwardStateB错误！<br>错误代码：'<%=result[0][0]%>'。<br>错误信息：'<%=result[0][1]%>'。",0);
			history.go(-1);
	  </script>
		<%}
		}
		//end of 判断工号
		
		//end for sunqy
	
     
 
    
    %>