<script language="javascript">
	var ccbTran = "fail";
	function SetSysInfo()
	{
		/*set IP �˿�*/
		//var svrip= "10.109.180.9";   //tianyang
		//var svrip= "10.110.5.143";   //maoliang
		//var svrip= "10.110.191.23";
		//var svrip= "10.110.6.151";   //������Ӫҵ������
		svrip= "15.28.6.219";
		svrport = Number("3001");
		comport = Number("5");
		BankCtrl.SetServer(svrip,svrport,comport);
	}
	function CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code)
	{
			/*set �������*/
			var v_transerial    = transerial;  	                         //����Ψһ��
			var v_trantype      = trantype;                              //��������
			var v_tranamount    = padLeft(bMoney.replace(".",""),"0",12);//�ɷѽ��
			var v_tranoper      = tranoper;                         		 //���ײ���Ա
			var v_orgid         = orgid;                       					 //ӪҵԱ��������
			var v_trannum       = trannum;                        			 //�绰����
			var v_respstamp     = respstamp;       											 //�ύʱ��
			var v_transerialold = transerialold;			                   //ԭ����Ψһ��
			var v_org_code      = org_code;                       			 //ӪҵԱ����
			/* ���� posCCB.jsp �з������� IP���˿ڣ����ڶ˿� */
  	  SetSysInfo();
  	  /* ���ÿؼ������в������� */
			BankCtrl.SetTranData(v_transerial,v_trantype,v_tranamount,v_tranoper,v_orgid,v_trannum,v_respstamp,v_transerialold,v_org_code);
			/*���ÿ�ʼ����*/
			BankCtrl.StratTran();
	}
</script>
<!-- **********���пؼ�******** -->
<OBJECT id="BankCtrl" codeBase="../../ocx/BankCtrl.cab#version=1.0.0.42"  classid="CLSID:11F0BB5B-8105-4710-B1AD-BB6877CACA29" width="0" height="0" VIEWASTEXT>
</OBJECT>
<script language="javascript" FOR="BankCtrl" event="Completed()" >
	str = BankCtrl.GetTranData();
	if(str.split("|").length==21)
	{
			if (str.split("|")[6] !="00")
			{
					rdShowMessageDialog("���з��ش���!<br>������룺"+str.split("|")[6]+"��������Ϣ��"+str.split("|")[7]+"��");
			}else{
					document.all.MerchantNameChs.value = str.split("|")[9];  /*�̻����ƣ���Ӣ��)*/
					document.all.MerchantId.value      = str.split("|")[10]; /*�̻�����*/
					document.all.TerminalId.value      = str.split("|")[11]; /*�ն˱���*/
					document.all.IssCode.value         = str.split("|")[15]; /*�����к�*/
					document.all.AcqCode.value         = str.split("|")[16]; /*�յ��к�*/
					document.all.CardNo.value          = str.split("|")[8];	 /*����*/
					document.all.BatchNo.value         = str.split("|")[13]; /*���κ�*/
					document.all.Response_time.value   = str.split("|")[5];	 /*��Ӧ����ʱ��*/
					document.all.Rrn.value             = str.split("|")[14]; /*�ο���*/
					document.all.AuthNo.value          = "";                 /*��Ȩ��*/
					document.all.TraceNo.value         = str.split("|")[12]; /*��ˮ��*/
					/*�ύʱ�� ͨ������  getSysDate() �Ѿ��õ�*/
					document.all.CardNoPingBi.value    = getCardNoPingBi(str.split("|")[8]);/*���׿��ţ����Σ�*/
					document.all.ExpDate.value         = "";                 /*��Ƭ��Ч��*/
					document.all.Remak.value           = "";                 /*��ע��Ϣ*/
					document.all.TC.value              = "";                 /*��Ҫ��ӡ������EMV���ף�оƬ����*/
					// ccbTranֵ����ҳ���Ƿ��ύ
					ccbTran = "succ";
			}
	}else{
			rdShowMessageDialog("����ֵ��������");
	}
</script>