<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-15 ҳ�����,�޸���ʽ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<%
    //�������
    //����������������ڣ��ɷ���ˮ���������룬���ţ�Ȩ�޴��롣
    //xl
	
	String phone = request.getParameter("phoneNo");
	
	String TDcontractno="0";
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    String totaldate  = request.getParameter("billdate").trim();//�����·�
    String phoneNo = request.getParameter("phoneNo");
    String contractno = request.getParameter("TContractNo");
    if (contractno == null) {
        contractno = request.getParameter("contractno");
    }
    String loginaccept = request.getParameter("water_number").trim();//��ˮ��
     
     
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String orgcode = baseInfo[0][16];//��������
    //String[][] password = (String[][])arr.get(4);//��ȡ�������� 
    //String nopass = password[0][0];
    
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgcode = (String)session.getAttribute("orgCode");
    /*tianyang add for pos */
    String groupId = (String)session.getAttribute("groupId");
    String nopass = (String)session.getAttribute("password");
    
    String op_code = "b302" ;
     
    
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
     
    ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
    
    CallRemoteResultValue value=  viewBean.callService("1",orgcode.substring(0,2),"s1310Init",outNum, lens, inParas); 
    ArrayList list  = value.getList();
    */
%>
<%
 	

	String sqls = "select to_char(c.account_id)  from dcustmsgadd a,dcustmsg b,dgrpusermsg c  where b.id_no=a.id_no and a.field_code='1004' and  a.field_value=to_char(c.id_no) and c.sm_code='TG'  and c.run_code='A' and b.phone_no= '?' ";
	
	%>


	<wtc:pubselect name="TlsPubSelBoss" routerKey="phoneNo" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqls%></wtc:sql>
	<wtc:param value="<%=phoneNo%>"/>
	</wtc:pubselect>
	<wtc:array id="ret_vals" scope="end" />
	<%
	
		TDcontractno =ret_vals[0][0];
		
		
	%>
	
<!--xl end <wtc:array id="result" scope="end" />-->	
    <wtc:service name="s1310Init5" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="21">
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
        
        
        
        /********tianyang add for pos start*******/
				String response_time = result3[0][0].trim();                /*���вཻ��ʱ��*/               
				String terminalId    = result3[0][1].trim();                /*�����ն˺�*/
				String rrn           = result3[0][2].trim();                /*���вཻ��Ψһ��*/
				String request_time  = result3[0][3].trim();                /*boss�ཻ��ʱ��*/
				/*out.println("ԭ�����ն˺�="+terminalId);
				out.println("������="+rrn);
				out.println("ԭ��������="+response_time);*/
				/********tianyang add for pos end********/
        double PayMoney = 0-Double.parseDouble(pay_total);
  			String sPayMoney = String.valueOf(PayMoney);
        
%>
<!--chenhu add -->
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
				rdShowMessageDialog("��������˻�����<br>������룺'<%=t_return_code%>'��<br>������Ϣ��'<%=t_return_msg%>'��",0);
		    history.go(-1);
	</script>	    
<%				
				}
%>
<!--chenhu add end -->

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�ɷѳ���</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
<!--

onload=function form_load()
{
	rdShowMessageDialog("ӪҵԱִ��ȷ��ǰ��<br>�����ջ���ͨ�ɷ�ԭʼ��Ʊ��");
	//document.form.remark.focus();
}

/*tianyang add for pos�ɷ� start*/
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
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
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
		document.form.action="s1310_3td.jsp";
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
/*tianyang add for pos�ɷ� end*/


function dosubmit()
{
		/*tianyang add for pos*/
		if("<%=pay_type%>"=="BY")
		{
				var TransType     = padLeft("04"," ",2);                             /*�������� */        
				var bMoney        = "<%=return_money%>";                                                  
				var Amount        = padLeft(bMoney.replace(".",""),"0",12);          /*���׽�� */        
				var OldAuthDate   = "<%=response_time%>";                            
				OldAuthDate       = padLeft(OldAuthDate.substr(0,8)," ",8);          /*ԭ�������� */      
				var ReferNo       = padLeft("<%=rrn%>"," ",8);                       /*ԭ����ϵͳ������ */
				var InstNum       = padLeft(""," ",2);                               /*���ڸ������� */    
				var oldterid      = padLeft("<%=terminalId%>"," ",15);               /*ԭ�����ն˺� */                         
				getSysDate();   		/*ȡbossϵͳʱ��*/                               
				var requestTime   = padLeft(document.all.Request_time.value," ",14); /*�����ύ���� */    
				var login_no      = padLeft("<%=workno%>"," ",6);                    /*���ײ���Ա */      
				var org_code      = padLeft("<%=orgcode%>"," ",9);                   /*ӪҵԱ���� */      
				var org_id        = padLeft("<%=groupId%>"," ",10);                  /*ӪҵԱ�������� */  
				var phone_no      = padLeft("<%=phoneNo%>"," ",15);                  /*���׽ɷѺ� */      
				var toBeUpdate    = padLeft(""," ",100);                             /*Ԥ���ֶ� */        
				var inputStr = TransType+Amount+OldAuthDate+ReferNo+InstNum+oldterid+requestTime+login_no+org_code+org_id+phone_no+toBeUpdate;
				
				/* ���� posICBC.jsp �з������� IP���˿ڣ����ڶ˿� �Լ��������*/
				var str = SetICBCCfg(inputStr);
				
				if(str.split("|").length==21)
				{
					if (str.split("|")[19] !="00")
					{
						rdShowMessageDialog("���з��ش���!<br>������룺"+str.split("|")[19]+"������Ϣ��"+str.split("|")[0]);
						form.sure.disabled=false;
				    form.reset.disabled=false;
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
						formSubmit();
					}
				}else{
					rdShowMessageDialog("����ֵ��������");
					form.sure.disabled=false;
				  Form.reset.disabled=false;
				}
		
		}else if("<%=pay_type%>"=="BX"){
							
				/*set �������*/
				var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
				var trantype      = "01";                                  //��������01 ���ճ���  (����)
				var bMoney        = "<%=return_money%>";
				var tranamount    = padLeft(bMoney.replace(".",""),"0",12);//�ɷѽ��
				var tranoper      = "<%=workno%>";                         //���ײ���Ա
				var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
				var trannum       = "<%=phoneNo%>";                        //�绰����			
				getSysDate();      	/*ȡϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;       //�ύʱ��	
				var transerialold = "<%=rrn%>";	                           //ԭ����Ψһ��,�ο���
				var org_code      = "<%=orgcode%>";                        //ӪҵԱ����
				
				/* ���� posCCB.jsp �з������� IP���˿ڣ����ڶ˿� */
		    SetSysInfo();
		    /* ���ÿؼ������в������� */
				BankCtrl.SetTranData(transerial,trantype,tranamount,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				
				/*���ÿ�ʼ����*/
				BankCtrl.StratTran();
		}else{
				formSubmit();
		}
    
}
//-->
</script>

</HEAD>
<BODY>
<FORM action="" method="post" name="form">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�ɷ���Ϣ</div>
</div>
<!--xl <%=TDcontractno%>-->
<input type="hidden" name="tdno" value="<%=TDcontractno%>">

<input type="hidden" name="nopaywater" value="<%=nopay_water%>">
<input type="hidden" name="pay_code" value="<%=pay_code%>">
<input type="hidden" name="pay_type" value="<%=pay_type%>">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<!-- tianyang add at 20090928 for POS�ɷ�����*****start*****-->
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
<!-- tianyang add at 20090928 for POS�ɷ�����*****end*******-->

    <table border=0>
        <tr> 
            <td class=blue>ҵ������</td>
            <td colspan=2>�ɷѳ���</td>
            <td class=blue>����</td>
            <td colspan=2><%=orgcode%></td>
        </tr>
        <tr> 
            <td class=blue>�������</td>
            <td colspan=2>
            <input type="text" readonly name="phoneNo" value="<%=phoneNo%>">
            </td>
            <td class=blue>�ɷ��·�</td>
            <td colspan=2>
                <input type="text" readonly name="billdate" value="<%=totaldate%>">
            </td>
        </tr>
        <tr> 
            <td class=blue>�ʻ�����</td>
            <td colspan=2> 
                <input type="text" readonly name="contractno" value="<%=contract_no%>">
            </td>
            <td class=blue>�ɷ���ˮ</td>
            <td colspan=2>
                <input type="text" readonly name="water_number" value="<%=loginaccept%>">
            </td>
        </tr>
        <tr> 
            <td class=blue>�û�/�ʻ�����</td>
            <td colspan=2> 
                <input type="text" readonly name="user" value="<%=v_name%>">
            </td>
            <td class=blue>���</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield8" value="<%=pay_total%>">
            </td>
        </tr>
        <tr> 
            <td class=blue>�û�����</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield6" value="<%=user_number%>">
            </td>
            <td class=blue>�ɷ�ʱ��</td>
            <td colspan=2> 
                <input type="text" readonly name="paytime" value="<%=payfee_time%>">
            </td>
        </tr>
        <tr> 
            <td class=blue>����</td>
            <td colspan=5>
                <input type="text" readonly name="textfield5" value="<%=login_no%>">
            </td>
        </tr>
        
        <tr> 
            <td class=blue colspan=6>�ɷ���Ϣ</td>
        </tr>
        <tr> 
            <th>����/�ʻ�����</th>
            <th>�ɷѽ��</th>
            <th>Ԥ���</th>
            <th>����</th>
            <th colspan=2>���ɽ�</th>
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
            <td class=blue>�˷ѽ��</td>
            <td colspan=5> 
                <input readonly name=remark2 value="<%=return_money%>">
            </td>
        </tr>
        
    </table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type=button value=ȷ�� onClick="dosubmit();">
                    <input class="b_foot" name=reset type=reset value=���� onClick="window.history.go(-1)">
                </td>
            </tr>
        </tbody>
    </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<!-- **********���ؽ��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
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
	    formSubmit();
		}	    
	}else{
		rdShowMessageDialog("����ֵ��������");
	}
</script>

<!-- **********���ع��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

</BODY>
</HTML>
<%}
else{
%>
<script language='JavaScript'>
		rdShowMessageDialog("��ѯ����<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=return_message%>'��",0);
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
		rdShowMessageDialog("����sAwardStateB����<br>������룺'<%=result[0][0]%>'��<br>������Ϣ��'<%=result[0][1]%>'��",0);
		history.go(-1);
  </script>
 	<%}%>