<!-- **********���пؼ�******** -->
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
						var v_TransType     = padLeft(transType," ",2);                 /*�������� */
						var v_Amount        = padLeft(bMoney.replace(".",""),"0",12);   /*���׽�� */
						var v_OldAuthDate   = padLeft(response_time," ",8);             /*ԭ�������� */
						var v_ReferNo       = padLeft(rrn," ",8);                       /*ԭ����ϵͳ������ */
						var v_InstNum       = padLeft(instNum," ",2);                   /*���ڸ������� */
						var v_oldterid      = padLeft(terminalId," ",15);               /*ԭ�����ն˺� */						
						var v_requestTime   = padLeft(request_time," ",14);             /*�����ύ���� */
						var v_login_no      = padLeft(workno," ",6);                    /*���ײ���Ա */
						var v_org_code      = padLeft(orgCode," ",9);                   /*ӪҵԱ���� */
						var v_org_id        = padLeft(groupId," ",10);                  /*ӪҵԱ�������� */
						var v_phone_no      = padLeft(phoneNo," ",15);                  /*���׽ɷѺ� */
						var v_toBeUpdate    = padLeft(toBeUpdate," ",100);              /*Ԥ���ֶ� */
						var inputStr = v_TransType+v_Amount+v_OldAuthDate+v_ReferNo+v_InstNum+v_oldterid+v_requestTime+v_login_no+v_org_code+v_org_id+v_phone_no+v_toBeUpdate;
						alert("inputStr : " + inputStr);
						/* ���� posICBC.jsp �з������� IP���˿ڣ����ڶ˿� �Լ��������*/
						var str = SetICBCCfg(inputStr);

						if(str.split("|").length==21)
						{
							if (str.split("|")[19] !="00")
							{
								rdShowMessageDialog("���з��ش���!<br>������룺"+str.split("|")[19]+"������Ϣ��"+str.split("|")[0]);
							}else{
								document.all.MerchantNameChs.value = str.split("|")[10]+str.split("|")[11]; /*�̻����ƣ���Ӣ��)*/
								document.all.MerchantId.value      = str.split("|")[8];	    /*�̻�����*/
								document.all.TerminalId.value      = str.split("|")[7];	    /*�ն˱���*/
								document.all.IssCode.value         = str.split("|")[14];		/*�����к�*/
								document.all.AcqCode.value         = "ICBC";	              /*�յ��к�*/
								document.all.CardNo.value          = str.split("|")[3];			/*����*/
								document.all.BatchNo.value         = str.split("|")[13];		/*���κ�*/
								document.all.Response_time.value   = str.split("|")[1]+str.split("|")[2];   /*��Ӧ����ʱ��*/
								document.all.Rrn.value             = str.split("|")[6];	    /*�ο���*/
								document.all.AuthNo.value          = "";		                /*��Ȩ��*/
								document.all.TraceNo.value         = str.split("|")[12];		/*��ˮ��*/
								/*�ύʱ�� ͨ������  getSysDate() �Ѿ��õ�*/
								document.all.CardNoPingBi.value    = str.split("|")[4];     /*���׿��ţ����Σ�*/
								document.all.ExpDate.value         = str.split("|")[5];     /*��Ƭ��Ч��*/
								document.all.Remak.value           = str.split("|")[17];    /*��ע��Ϣ*/
								document.all.TC.value              = str.split("|")[9];     /*��Ҫ��ӡ������EMV���ף�оƬ����*/
								//���ڸ�������
								$("#iInstNum").val(v_InstNum);
								// icbcTranֵ����ҳ���Ƿ��ύ
								icbcTran = "succ";
							}
						}else{
							rdShowMessageDialog("����ֵ��������");
						}
	}
</script>