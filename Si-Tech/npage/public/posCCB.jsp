<script language="javascript">
	var ccbTran = "fail";
	function SetSysInfo()
	{
		/*set IP 端口*/
		//var svrip= "10.109.180.9";   //tianyang
		//var svrip= "10.110.5.143";   //maoliang
		//var svrip= "10.110.191.23";
		//var svrip= "10.110.6.151";   //开发区营业厅测试
		svrip= "15.28.6.219";
		svrport = Number("3001");
		comport = Number("5");
		BankCtrl.SetServer(svrip,svrport,comport);
	}
	function CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code)
	{
			/*set 输入参数*/
			var v_transerial    = transerial;  	                         //交易唯一号
			var v_trantype      = trantype;                              //交易类型
			var v_tranamount    = padLeft(bMoney.replace(".",""),"0",12);//缴费金额
			var v_tranoper      = tranoper;                         		 //交易操作员
			var v_orgid         = orgid;                       					 //营业员归属机构
			var v_trannum       = trannum;                        			 //电话号码
			var v_respstamp     = respstamp;       											 //提交时间
			var v_transerialold = transerialold;			                   //原交易唯一号
			var v_org_code      = org_code;                       			 //营业员归属
			/* 调用 posCCB.jsp 中方法设置 IP，端口，串口端口 */
  	  SetSysInfo();
  	  /* 调用控件，进行参数传递 */
			BankCtrl.SetTranData(v_transerial,v_trantype,v_tranamount,v_tranoper,v_orgid,v_trannum,v_respstamp,v_transerialold,v_org_code);
			/*调用开始交易*/
			BankCtrl.StratTran();
	}
</script>
<!-- **********建行控件******** -->
<OBJECT id="BankCtrl" codeBase="../../ocx/BankCtrl.cab#version=1.0.0.42"  classid="CLSID:11F0BB5B-8105-4710-B1AD-BB6877CACA29" width="0" height="0" VIEWASTEXT>
</OBJECT>
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
					// ccbTran值决定页面是否提交
					ccbTran = "succ";
			}
	}else{
			rdShowMessageDialog("返回值数量错误！");
	}
</script>