<!-- **********工行控件******** -->
<object name="KeeperClient" classid="clsid:9BB1BFD1-D279-462B-BB7B-74AEF30A6BDA" style="height:18pt;width:120;display:none
	"codebase='../../ocx/KeeperClient.CAB'#version=1,0,0,4">
</object>
<script language="javascript">
	var icbcTran = "fail";
	function SetICBCCfg(inputStr)
	{
		KeeperClient.SetICBCCfg("172.20.1.86","3210","COM5");
		var str = KeeperClient.misposTrans(inputStr,"1,0,5,1");
		return str;
	}
	
	
	function ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate){
						var v_TransType     = padLeft(transType," ",2);                 /*交易类型 */
						var v_Amount        = padLeft(bMoney.replace(".",""),"0",12);   /*交易金额 */
						var v_OldAuthDate   = padLeft(response_time," ",8);             /*原交易日期 */
						var v_ReferNo       = padLeft(rrn," ",8);                       /*原交易系统检索号 */
						var v_InstNum       = padLeft(instNum," ",2);                   /*分期付款期数 */
						var v_oldterid      = padLeft(terminalId," ",15);               /*原交易终端号 */						
						var v_requestTime   = padLeft(request_time," ",14);             /*交易提交日期 */
						var v_login_no      = padLeft(workno," ",6);                    /*交易操作员 */
						var v_org_code      = padLeft(orgCode," ",9);                   /*营业员归属 */
						var v_org_id        = padLeft(groupId," ",10);                  /*营业员归属机构 */
						var v_phone_no      = padLeft(phoneNo," ",15);                  /*交易缴费号 */
						var v_toBeUpdate    = padLeft(toBeUpdate," ",100);              /*预留字段 */
						var inputStr = v_TransType+v_Amount+v_OldAuthDate+v_ReferNo+v_InstNum+v_oldterid+v_requestTime+v_login_no+v_org_code+v_org_id+v_phone_no+v_toBeUpdate;
						alert("inputStr : " + inputStr);
						/* 调用 posICBC.jsp 中方法设置 IP，端口，串口端口 以及传入参数*/
						var str = SetICBCCfg(inputStr);

						if(str.split("|").length==21)
						{
							if (str.split("|")[19] !="00")
							{
								rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[19]+"错误信息："+str.split("|")[0]);
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
								//分期付款期数
								$("#iInstNum").val(v_InstNum);
								// icbcTran值决定页面是否提交
								icbcTran = "succ";
							}
						}else{
							rdShowMessageDialog("返回值数量错误！");
						}
	}
</script>