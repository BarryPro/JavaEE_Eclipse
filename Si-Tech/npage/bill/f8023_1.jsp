<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	request.setCharacterEncoding("GBK");
%>

<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>

<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<%
	String opCode = "8023";
	String opName = "���ſͻ�Ԥ����������";

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
	
  /*comImpl co1 = new comImpl();
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();*/

%>
<%

  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";


	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	//String cus_pass = request.getParameter("cus_pass");
	
	String getCardCodeSql="select card_code from dbvipadm.dGrpBigUserMsg where phone_no ='"+iPhoneNo+"'";
	System.out.println("getCardCodeSql|"+getCardCodeSql);
	String cardCode="";	    
%>
<wtc:pubselect name="sPubSelect"  retcode="retCode1" retmsg="retMsg1" outnum="1">
 <wtc:sql><%=getCardCodeSql%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="result1" scope="end"/>		
<%
	if(result1.length!=0){
  		cardCode=result1[0][0];
	}
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

%>

<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="errCode" retmsg="errMsg" outnum="29" >
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=op_strong_pwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=inputParsm[2]%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>

<%

  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("0")||errCode.equals("000000")){
	  //retList[0][] = (String[][])retList.get(3);
	  if(!(retList[0][3]==null)){
	    bp_name = retList[0][3];           //��������
	  }

	  //retList[0][] = (String[][])retList.get(4);
	  if(!(retList[0][4]==null)){
	    bp_add = retList[0][4];            //�ͻ���ַ
	  }

	  //retList[0][] = (String[][])retList.get(2);
	  if(!(retList[0][2]==null)){
	    passwordFromSer = retList[0][2];  //����
	  }

	 // retList[0][] = (String[][])retList.get(11);
	  if(!(retList[0][11]==null)){
	    sm_code = retList[0][11];         //ҵ�����
	  }

	  //retList[0][] = (String[][])retList.get(12);
	  if(!(retList[0][12]==null)){
	    sm_name = retList[0][12];        //ҵ���������
	  }

	  //retList[0][] = (String[][])retList.get(13);
	  if(!(retList[0][13]==null)){
	    hand_fee = retList[0][13];      //������
	  }
	  System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
	  System.out.println(hand_fee);

	  //retList[0][] = (String[][])retList.get(14);
	  if(!(retList[0][14]==null)){
	    favorcode = retList[0][14];     //�Żݴ���
	  }

	  //retList[0][] = (String[][])retList.get(5);
	  if(!(retList[0][5]==null)){
	    rate_code = retList[0][5];     //�ʷѴ���
	  }

	  //retList[0][] = (String[][])retList.get(6);
	  if(!(retList[0][6]==null)){
	    rate_name = retList[0][6];    //�ʷ�����
	  }

	 // retList[0][] = (String[][])retList.get(7);
	  if(!(retList[0][7]==null)){
	    next_rate_code = retList[0][7];//�����ʷѴ���
	  }

	  //retList[0][] = (String[][])retList.get(8);
	  if(!(retList[0][8]==null)){
	    next_rate_name = retList[0][8];//�����ʷ�����
	  }

	  //retList[0][] = (String[][])retList.get(9);
	  if(!(retList[0][9]==null)){
	    bigCust_flag = retList[0][9];//��ͻ���־
	  }

	 // retList[0][] = (String[][])retList.get(10);
	  if(!(retList[0][10]==null)){
	    bigCust_name = retList[0][10];//��ͻ�����
	  }

	  //retList[0][] = (String[][])retList.get(15);
	  if(!(retList[0][15]==null)){
	    lack_fee = retList[0][15];//��Ƿ��
	  }

	  //retList[0][] = (String[][])retList.get(16);
	  if(!(retList[0][16]==null)){
	    prepay_fee = retList[0][16];//��Ԥ��
	  }

	  //retList[0][] = (String[][])retList.get(17);
	  if(!(retList[0][17]==null)){
	    cardId_type = retList[0][17];//֤������
	  }

	  //retList[0][] = (String[][])retList.get(18);
	  if(!(retList[0][18]==null)){
	    cardId_no = retList[0][18];//֤������
	  }

	  //retList[0][] = (String[][])retList.get(19);
	  if(!(retList[0][19]==null)){
	    cust_id = retList[0][19];//�ͻ�id
	  }

	  //retList[0][] = (String[][])retList.get(20);
	  if(!(retList[0][20]==null)){
	    cust_belong_code = retList[0][20];//�ͻ�����id
	  }

	  //retList[0][] = (String[][])retList.get(21);
	  if(!(retList[0][21]==null)){
	    group_type_code = retList[0][21];//���ſͻ�����
	  }

	  //retList[0][] = (String[][])retList.get(22);
	  if(!(retList[0][22]==null)){
	    group_type_name = retList[0][22];//���ſͻ���������
	  }

	  //retList[0][] = (String[][])retList.get(23);
	  if(!(retList[0][23]==null)){
	    imain_stream = retList[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

	  //retList[0][] = (String[][])retList.get(24);
	  if(!(retList[0][24]==null)){
	    next_main_stream = retList[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

	  //retList[0][] = (String[][])retList.get(25);
	  if(!(retList[0][25]==null)){
	    print_note = retList[0][25];//�������
	  }

	  //retList[0][] = (String[][])retList.get(27);
	  if(!(retList[0][27]==null)){
	    contract_flag = retList[0][27];//�Ƿ������˻�
	  }

	  //retList[0][] = (String[][])retList.get(28);
	  if(!(retList[0][28]==null)){
	    high_flag = retList[0][28];//�Ƿ��и߶��û�
	  }
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}

  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = false;//a272 ��������֤
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
  }

  /*if(!pwrf)
  {
	String passFromPage=Encrypt.encrypt(cus_pass);
	if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))
	{
		if(!retFlag.equals("1"))
		{%>
			<script language="JavaScript">
				alert("������֤�����������������룡");
				history.go(-1);
			</script>
		<%}
	}
  }*/


%>
<%
/*******************�õ�����������****************************/
  /*�ֻ�Ʒ��*/
  String sqlAgentCode = "select unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='?' and a.sale_type='13' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type not like 'P%' and is_valid='1'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="2">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end"/>
<%
  /*�ֻ�����*/
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='?' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.valid_flag='Y' and a.sale_type='13' and a.spec_type not like 'P%' and is_valid='1'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="3">
	<wtc:sql><%=sqlPhoneType%></wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end"/>
<%
  /*Ӫ������*/
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='?' and a.sale_type='13' and valid_flag='Y' and a.spec_type not like 'P%'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="4">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end"/>
<%
  /*Ӫ����ϸ*/
  String sqlsaledet = "select BASE_FEE,FREE_FEE,nvl(favour_cost,0),CONSUME_TERM,MON_BASE_FEE,prepay_limit,sale_code from sPhoneSalCfg  where region_code='?' and sale_type='13' and valid_flag='Y' and spec_type not like 'P%'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="7">
	<wtc:sql><%=sqlsaledet%></wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="saledetStr" scope="end"/>
<%
  /*�����ʷ�(�޸Ĳ���)*/
  String sqlmodecode = "select a.mode_code,a.sale_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,product_offer c where a.sale_code=b.sale_code and b.region_code='?' and b.sale_type='13'  and valid_flag='Y' and spec_type not like 'P%' and  a.mode_code=to_char(c.offer_id)";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="agentCodeErrCode" retmsg="agentCodeErrMsg" outnum="2">
	<wtc:sql><%=sqlmodecode%></wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="modecodeStr" scope="end"/>


<head>
<title>���ſͻ�Ԥ����������</title>

<script language="JavaScript">
	onload=function()
	{
		//document.all.phoneNo.focus();
		//core.rpc.onreceive = doProcess;
		self.status="";
	}

	var arrbrandcode = new Array();//�ֻ��ͺŴ���
  var arrbrandname = new Array();//�ֻ��ͺ�����
  var arrbrandmoney = new Array();//�����̴���

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  //var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();

  var arrmodecode=new Array();
  var arrmodesale=new Array();
  <%
  for(int m=0;m<agentCodeStr.length;m++)
  {
	out.println("arrbrandcode["+m+"]='"+agentCodeStr[m][0]+"';\n");
	out.println("arrbrandname["+m+"]='"+agentCodeStr[m][1]+"';\n");
  }
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");

  }
  for(int l=0;l<saledetStr.length;l++)
  {
	out.println("arrdetbase["+l+"]='"+saledetStr[l][0]+"';\n");
	out.println("arrdetfree["+l+"]='"+saledetStr[l][1]+"';\n");
	out.println("arrdetfavour["+l+"]='"+saledetStr[l][2]+"';\n");
	out.println("arrdetconsume["+l+"]='"+saledetStr[l][3]+"';\n");
	out.println("arrdetmonbase["+l+"]='"+saledetStr[l][4]+"';\n");

	out.println("arrdetsummoney["+l+"]='"+saledetStr[l][5]+"';\n");
	out.println("arrdetsalecode["+l+"]='"+saledetStr[l][6]+"';\n");

  }
  //�޸Ĳ��� .............................................................
  for(int l=0;l<modecodeStr.length;l++)
  {
  out.println("arrmodecode["+l+"]='"+modecodeStr[l][0]+"';\n");
  out.println("arrmodesale["+l+"]='"+modecodeStr[l][1]+"';\n");
  }
  %>

  //--------1---------doProcess����----------------
   var modedxpay ="";
  var goodbz    ="";
  var bdbz      ="";
  var bdts      ="";
  var exeDate   ="";
  var note      ="";
	function doProcess(packet)
  {

		var vRetPage=packet.data.findValueByName("rpc_page");
		var retType=packet.data.findValueByName("retType");
		var verifyType = packet.data.findValueByName("verifyType");


	  if(vRetPage == "qryCus_s126hInit")
	  {
	  //alert("run at doProcess");
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");

	    var bp_name        = packet.data.findValueByName("bp_name"        );
	    var sm_code         = packet.data.findValueByName("sm_code"        );
	    var family_code     = packet.data.findValueByName("family_code"    );
	    var rate_code       = packet.data.findValueByName("rate_code"      );
	    var bigCust_flag    = packet.data.findValueByName("bigCust_flag"   );
	    var sm_name         = packet.data.findValueByName("sm_name"        );
	    var rate_name       = packet.data.findValueByName("rate_name"      );
	    var bigCust_name    = packet.data.findValueByName("bigCust_name"   );
	    var next_rate_code  = packet.data.findValueByName("next_rate_code" );
	    var next_rate_name  = packet.data.findValueByName("next_rate_name" );
	    var lack_fee        = packet.data.findValueByName("lack_fee"       );
	    var prepay_fee      = packet.data.findValueByName("prepay_fee"     );
	    var bp_add          = packet.data.findValueByName("bp_add"         );
	    var cardId_type     = packet.data.findValueByName("cardId_type"    );
	    var cardId_no       = packet.data.findValueByName("cardId_no"      );
	    var cust_id         = packet.data.findValueByName("cust_id"        );
	    var cust_belong_code= packet.data.findValueByName("cust_belong_code");
	    var group_type_code = packet.data.findValueByName("group_type_code");
	    var group_type_name = packet.data.findValueByName("group_type_name");
	    var imain_stream    = packet.data.findValueByName("imain_stream"   );
	    var next_main_stream= packet.data.findValueByName("next_main_stream");
	    var hand_fee        = packet.data.findValueByName("hand_fee"       );
	    var favorcode       = packet.data.findValueByName("favorcode"      );
	    var card_no         = packet.data.findValueByName("card_no"        );
	    var print_note      = packet.data.findValueByName("print_note"     );
	    var contract_flag   = packet.data.findValueByName("contract_flag"  );
	    var high_flag       = packet.data.findValueByName("high_flag"      );

			if(retCode == 000000)
			{
				document.all.i2.value = cust_id;
				document.all.i16.value = rate_code;
				document.all.belong_code.value = cust_belong_code;
				document.all.print_note.value = print_note;

				document.all.i4.value = bp_name;
				document.all.i5.value = bp_add;
				document.all.i6.value = cardId_type;
				document.all.i7.value = cardId_no;
				document.all.i8.value = sm_code+"--"+sm_name;
				document.all.i9.value = contract_flag;

				document.all.ipassword.value = "";
				document.all.group_type.value = group_type_code+"--"+group_type_name;
				document.all.ibig_cust.value =  bigCust_flag+"--"+bigCust_name;

				document.all.favorcode.value = favorcode;
				document.all.maincash_no.value = rate_code;
				document.all.imain_stream.value =  imain_stream;
				document.all.next_main_stream.value =  next_main_stream;

				document.all.i18.value = next_rate_code+"--"+next_rate_name;
				document.all.i19.value = hand_fee;
				document.all.i20.value = hand_fee;

				document.all.oCustName.value = bp_name;
				document.all.oSmCode.value = sm_code;
				document.all.oSmName.value = sm_name;
				document.all.oModeCode.value = rate_code;
				document.all.oModeName.value = rate_name;
				document.all.oPrepayFee.value = prepay_fee;
				document.all.oMarkPoint.value = "0";
			}
			else
			{
				rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
				return;
			}
		}

	  if(vRetPage == "qryPayPrepay")
	  {
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");

			var pay_pre = packet.data.findValueByName("pay_pre"        );

			if(retCode == 000000)
			{
				document.all.oPayPre.value = pay_pre;
			}
			else
			{
				rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
				return;
			}
			getbrand();
	  }

	  if(vRetPage == "qryAreaFlag")
	  {
		  var retCode = packet.data.findValueByName("retCode");
		  var retMsg = packet.data.findValueByName("retMsg");
		  var area_flag        = packet.data.findValueByName("area_flag"        );

			if(retCode == 000000)
			{
			    if(parseInt(area_flag)>0)
			    {
			       document.all.flagCodeTr.style.display="";
			       getFlagCode();
			    }
			}
			else
			{
					rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
					return;
			}
		}
		if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��");
					document.frm.commit.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��");
					document.frm.commit.disabled=false;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
					document.frm.commit.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
					document.frm.commit.disabled=true;
					return false;
			}
		}
		else if(retType == "checkAward")
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMessage = packet.data.findValueByName("retMessage");
		  	window.status = "";
		  	if(retCode!=0){
		  		rdShowMessageDialog(retMessage);
		  		document.all.need_award.checked = false;
		  		document.all.award_flag.value = 0;
		  		retrun ;
		  	}
		  	document.all.award_flag.value = 1;
	  }


	//added by hanfa 20070118 begin
		if(vRetPage == "querySmcode")
		{
			var errCode = packet.data.findValueByName("errCode");
		    var errMsg = packet.data.findValueByName("errMsg");
			var m_smCode = packet.data.findValueByName("m_smCode");
			self.status="";

			if(errCode == 0)
			{
				document.all.m_smCode.value = m_smCode;
			}else
			{
				rdShowMessageDialog("����:"+ errCode + "->" + errMsg);
				return false;
			}
		}//added by hanfa 20070118 end
	}

	function selectChange(control, controlToPopulate, ItemArray, GroupArray)
	{
		//alert(document.all.licl.innerHTML);
		var myEle ;
		var x ;
		// Empty the second drop down box of any choices
		for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
		// ADD Default Choice - in case there are no values

		myEle = document.createElement("option") ;
		myEle.value = "";
		    myEle.text ="--��ѡ��--";
		    controlToPopulate.add(myEle) ;
		for ( x = 0 ; x < ItemArray.length  ; x++ )
		{
		  if ( GroupArray[x] == control.value )
		  {
		    myEle = document.createElement("option") ;
		    myEle.value = arrPhoneType[x] ;
		    myEle.text = ItemArray[x] ;
		    controlToPopulate.add(myEle) ;
		  }
		}

		document.all.need_award.checked = false;
		document.all.award_flag.value = 0;
	}

	function typechange(){
		var myEle1 ;
		var x1 ;
		for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
		myEle1 = document.createElement("option") ;
		myEle1.value = "";
		myEle1.text ="--��ѡ��--";
		document.all.sale_code.add(myEle1) ;

		for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
		{
		  		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value )
		  		{
		    		myEle1 = document.createElement("option") ;
		    		myEle1.value = arrsalecode[x1];
		    		myEle1.text = arrsaleName[x1];
		    		document.all.sale_code.add(myEle1) ;
		  		}
		}
		document.all.need_award.checked = false;
		document.all.award_flag.value = 0;
	}

	function salechage(){

		var x3;

		for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
	 	{
	    		if ( arrdetsalecode[x3] == document.all.sale_code.value )
	    		{
	      		document.all.Base_Fee.value=arrdetbase[x3];
	      		document.all.Free_Fee.value=arrdetfree[x3];
	      		document.all.Mark_Subtract.value=arrdetfavour[x3];
	      		document.all.Consume_Term.value=arrdetconsume[x3];
	      		document.all.Mon_Base_Fee.value=arrdetmonbase[x3];
	      		//document.all.New_Mode_Code.value=arrdetmode[x3];
	      		document.all.Prepay_Fee.value=arrdetsummoney[x3];
	    		}
	 	}
	  document.frm.i1.value=document.frm.phoneNo.value;
	  document.frm.ip.value=document.frm.New_Mode_Code.value;
	  document.all.do_note.value = "�û�"+document.all.phoneNo.value+"�����ſͻ�Ԥ����������";
	  document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"+document.frm.Prepay_Fee.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"+document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+document.frm.IMEINo.value+"|";
		document.frm.Prepay_Fee.value=parseFloat(document.all.Base_Fee.value)+parseFloat(document.all.Free_Fee.value);
	 	var myEle4 ;

	 	for (var q4=document.all.New_Mode_Code.options.length;q4>=0;q4--) document.all.New_Mode_Code.options[q4]=null;
	 	myEle4 = document.createElement("option") ;
	  myEle4.value = "";
	  myEle4.text ="--��ѡ��--";
	  document.all.New_Mode_Code.add(myEle4) ;
	  for ( x4 = 0 ; x4 < arrmodesale.length  ; x4++ )
		{
			if ( arrmodesale[x4] == document.all.sale_code.value )
			{
				//document.all.New_Mode_Code.value=arrmodecode[x4];
					myEle4 = document.createElement("option") ;
      		myEle4.value = arrmodecode[x4];
      		myEle4.text = arrmodecode[x4];
      		document.all.New_Mode_Code.add(myEle4) ;
			}
		}
	}

	function modechage()
	{
		var x4;

		document.frm.ip.value=document.frm.New_Mode_Code.value;
		judge_area();

		if(document.all.sale_code.value != "")
		{
			querySmcode(); //added by hanfa 20070118
		}
		document.frm.commit.disabled = true;
	}

	function judge_area()
	{
		var myPacket = new AJAXPacket("qryAreaFlag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("orgCode",document.all.orgCode.value.trim());
		myPacket.data.add("modeCode",document.all.New_Mode_Code.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}

	  //������������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070118
	function querySmcode()
	{
		var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
		myPacket.data.add("modeCode",document.frm.New_Mode_Code.value.trim());
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}


	  //--------2---------��֤��ťר�ú���-------------
	function checkimeino()
	{
		if (document.frm.IMEINo.value.length == 0) {
			rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
			document.frm.IMEINo.focus();
			document.frm.commit.disabled = true;
			return false;
		}

		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
		myPacket.data.add("imei_no",document.all.IMEINo.value.trim());
		myPacket.data.add("brand_code",document.all.agent_code.options[document.all.agent_code.selectedIndex].value.trim());
		myPacket.data.add("style_code",document.all.phone_type.options[document.all.phone_type.selectedIndex].value.trim());
		myPacket.data.add("opcode",document.all.iOpCode.value.trim());
		myPacket.data.add("retType","0");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}

	function viewConfirm()
	{
		if(document.frm.IMEINo.value=="")
		{
			document.frm.commit.disabled=true;
		}
	}






	/*----------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------*/
      function checksmz()
  {

  var myPacket = new AJAXPacket("checkSMZ.jsp","���ڲ�ѯ�ͻ��Ƿ���ʵ���ƿͻ������Ժ�......");
	myPacket.data.add("PhoneNo",(document.frm.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}



	  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 begin *****/
function formCommit()
{
		var userCardCode = '<%=cardCode%>';
		//checkimeino();
		if(document.all.oSmCode.value == "zn" && document.all.m_smCode.value == "gn")
		{
			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
		}
		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.oSmCode.value))
	  		{
		  		if(document.all.oSmCode.value == "gn"){
		  			if((userCardCode == "01" || userCardCode == "02" || userCardCode == "03")){
			  			//rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��֣���Mֵ������Ʒ�Ʊ����ЧʱʧЧ��������ʱ�һ�; ");
			  			rdShowMessageDialog("��ĿǰΪȫ��ͨVIP��Ա������Ʒ�ƣ�����VIP��Ա�ʸ���ҵ����Ч���Զ�ȡ����ͬʱ��������ȫ��ͨ�ͻ������ܲ���VIP������");
			  		}else{
			  			rdShowMessageDialog("��ȫ��ͨ�ͻ������ܲ���VIP������");
			  		}
		  		}else if(document.all.oSmCode.value == "dn"){
		  			//rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��ֻ�Mֵ����Ʒ�Ʊ����ЧʱʧЧ�����������ʷ���Чǰ��ʱ�һ���");
		  		}
		  				  		if(document.all.oSmCode.value != "zn" && document.all.m_smCode.value=="zn" && document.all.oSmCode.value !="") {//
		  			checksmz();
		  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//��ʵ����ȫ��ͨ�����еش��ͻ�ת��Ϊ�����пͻ�
		  				rdShowMessageDialog("<%=readValue("8023","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}
	/*var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	if(typeof(ret)!="undefined")
	{
	  if((ret=="confirm"))
	  {
		    if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
		    {
		     frmCfm();
		    }
		}
		if(ret=="continueSub")
		{
		    if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		    {
		     frmCfm();
		    }
		}
	}
	else
	{
	   if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	   {
	   	frmCfm();
	   }
	}
*/
frmCfm();
}
  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 end *****/

function frmCfm()
{
	 document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"+document.frm.Prepay_Fee.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"+document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"
	 +document.frm.IMEINo.value+"|"+document.frm.phone_type.value+"|"+document.frm.award_flag.value+"|";

	 if(!checkElement(document.all.phoneNo)) return;
     if(document.all.agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      document.all.agent_code.focus();
	  return false;
	}
	if(document.all.phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
      document.all.phone_type.focus();
	  return false;
	}
	if(document.all.sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      document.all.sale_code.focus();
	  return false;
	}
	//�޸Ĳ���...............................................................................................
	if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("�����������ʷѴ���!")
		document.all.New_Mode_Code.focus();
		return false;
	}
	if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.all.IMEINo.focus();
      //document.all.confirm.disabled = true; //confirm ���ˣ�ӦΪ commit  //modified by hanfa 20070118
      document.all.commit.disabled = true;

	  return false;
     }
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("���û��������û�,Ԥ������������ʱ�ջأ�");
         }

         //if(document.all.i9.value == "N" && parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         //{
          // rdShowMessageDialog("���ν���Ԥ����,���ܰ���!");
           //return;
        // }

	frm.submit();
}



 //-------------------
function getInfo_code()
{
	//���ù���js
	var regionCode = "<%=regionCode%>";
  var pageTitle = "��Ʒѡ��";
  var fieldName = "��Ʒ�ȼ�|��Ʒ����|��Ʒ����|��Ԥ��|��ѺԤ��|����Ԥ��|�Ԥ��|�ۼ�����|��������|�µ���|�����ʷ�|�ʷ�����|";//����������ʾ���С�����
  var sqlStr = "select b.Gift_Grade,b.Gift_Code,b.Gift_Name,b.Prepay_Fee,b.Deposit_Fee,b.Base_Fee,b.Free_Fee,b.Mark_Subtract,b.Consume_Term,b.Mon_Base_Fee,b.Mode_Code,c.Mode_Name from sgiftshowctrl a,sprepaygiftcode b,sbillmodecode c "
             + "where a.region_code='"+regionCode+"' and a.region_code=b.region_code and a.region_code=c.region_code and a.ctrl_type='0' and b.mode_code=c.mode_code and a.gift_grade=b.gift_grade and a.gift_code=b.gift_code "
             //+ "and a.ctrl_code=decode(a.ctrl_type,'0','"+document.all.oSmCode.value+"','1','"+document.all.oModeCode.value+"',a.ctrl_code) ";
             + "and a.ctrl_code=decode(a.ctrl_type,'0','"+document.all.oSmCode.value+"',a.ctrl_code) ";
  var selType = "S";    //'S'��ѡ��'M'��ѡ
  var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";//�����ֶ�
  var retToField = "Gift_Grade|Gift_Code|Gift_Name|Prepay_Fee|Deposit_Fee|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|New_Mode_Code|New_Mode_Name|";//���ظ�ֵ����

  if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50));

  document.frm.i1.value=document.frm.phoneNo.value;
  document.frm.ip.value=document.frm.New_Mode_Code.value;
	document.all.do_note.value = "�û�"+document.all.phoneNo.value+"�����ſͻ�Ԥ���������룬��Ʒ�ȼ���"+document.all.Gift_Grade.value+"����Ʒ���룺"+document.all.Gift_Code.value;
  document.frm.iAddStr.value=document.frm.Gift_Grade.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Deposit_Fee.value+"|"+document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+document.frm.Gift_Name.value+"|"+document.frm.IMEINo.value+"|";

  judge_area();

}

function getFlagCode1()
{
	document.all.commit.disabled=false;
	if (document.frm.back_flag_code.value == 2)
	{
 	  document.all.flagCodeTextTd.style.display = "";
  	document.all.flagCodeTd.style.display = "";
  }
}

function getFlagCode()
{
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|С������|";//����������ʾ���С�����
    /*var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;*/
    var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' and a.offer_id = " + document.frm.New_Mode_Code.value;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "flag_code|flag_code_name";//���ظ�ֵ����

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
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
	return true;
}
function getbrand(){

	var myEle2 ;
   	var x2 ;
   	for (var q2=document.all.agent_code.options.length;q2>=0;q2--) document.all.agent_code.options[q2]=null;

   	myEle2 = document.createElement("option") ;
    	myEle2.value = "";
        myEle2.text ="--��ѡ��--";
        document.all.agent_code.add(myEle2) ;
        for ( x2 = 0 ; x2 < arrbrandcode.length  ; x2++ )
   	{
      		if ( arrbrandmoney[x2] <=parseInt(document.all.oPayPre.value,10))
      		{
        		myEle2 = document.createElement("option") ;
        		myEle2.value = arrbrandcode[x2];
        		myEle2.text = arrbrandname[x2];
        		document.all.agent_code.add(myEle2) ;
      		}
   	}
}

function checkAward()
{
 if(document.all.phone_type.value == "")
 {
 	 rdShowMessageDialog("����ѡ�����");
 	 document.all.need_award.checked = false;
 	 document.all.award_flag.value = 0;
 	 return;
 }
 if(document.all.need_award.checked )
 {
 	 var packet = new RPCPacket("../s1141/phone_getAwardRpc.jsp","���ڻ�ý�Ʒ��ϸ�����Ժ�......");
 	 packet.data.add("retType","checkAward");
 	 packet.data.add("op_code","8023");
 	 packet.data.add("style_code",document.all.phone_type.value );

 	 core.rpc.sendPacket(packet);
 	 delete(packet);

 }
 document.all.award_flag.value = 0;
}
    function oneTokSelf(str,tok,loc)
  {
	    var temStr=str;
		var temLoc;
		var temLen;
	    for(ii=0;ii<loc-1;ii++)
		{
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
	 	}
		if(temStr.indexOf(tok)==-1)
		  	return temStr;
		else
	      	return temStr.substring(0,temStr.indexOf(tok));
  }
//���ſͻ�Ԥ����������
function printInfo()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.all.iAddStr.value;
	// rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr��ʽ ��Ʒ�ȼ�|��Ʒ����|Ԥ�滰��|����Ԥ��|�Ԥ��|��ѺԤ��|Ԥ�ۻ���|�����·�|�µ���|��Ʒ����|

	var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var gift_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	var base_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	var free_fee = oneTokSelf(tempStr,"|",5);       //�Ԥ��
	var mob_type = oneTokSelf(tempStr,"|",6);    //�ֻ��ͺ�
	var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	var IMEINo = oneTokSelf(tempStr,"|",10);

	var award_flag = oneTokSelf(tempStr,"|",12);//award_flag

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
	    var retInfo = "";  //��ӡ����
	/********������Ϣ��**********/
	cust_info+="�ͻ�������" +document.all.i4.value+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";
	/********������**********/

	opr_info+="ҵ�����ͣ����ſͻ�Ԥ����������"+"|";
	if(goodbz=="Y"){
	opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+modedxpay+"Ԫ"+"|";
	}else{
	opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
	}
	opr_info+="�ֻ��ͺţ�"+gift_code+mob_type+"      IMEI�룺"+IMEINo+"|";
	opr_info+="�ɿ�ϼƣ�"+document.all.Prepay_Fee.value+"Ԫ�����л���Ԥ��"+document.all.Prepay_Fee.value+"Ԫ��"+"|";
	/*******��ע��**********/
	if(bdbz=="Y"){
		note_info1+=bdts+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/

	note_info1+="�����뼯�ſͻ�Ԥ�滰�����ֻ����Ԥ�滰�Ѳ��˲�ת��ǩԼ��Ϊ1�꣬����Ԥ�水�·�����ǩԼ���ڲ��ܰ����ʷѱ�������Ҫ��ȡ�����ƣ���������Ʒ��������ԭ����ء��ʷ�ȡ����ʣ��İ���Ѱ�30%����ΥԼ��"+"|";
	/*
	if(document.all.modestr.value.length>0){
		note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
	}else{
		note_info1+=" "+"|";
	}
	*/
	if(goodbz=="Y"){
		note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	}
	note_info1+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";

	if(award_flag == "1")
	{
			note_info1 += "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
	    note_info1 += "  "+"|";
	}
	    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	    return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���

	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var printStr = printInfo();
	var old_code = "<%=rate_code%>"; //���ʷѴ���
	var new_code = "<%=next_rate_code%>"; //���ʷѴ���
	var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";               // ��ˮ��
	var mode_code=codeChg(new_code)+"~";               //�ʷѴ���
	var fav_code=null;                 //�ط�����
	var area_code=document.all.flag_code.value;             //С������
	var opCode="1270";                   //��������
	var phoneNo=document.all.i1.value;                  //�ͻ��绰
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	 var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}
</script>

</head>

<body>
<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr >
			<td class="blue">�ֻ�����</td>
			<td >
			<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">��������</td>
			<td >
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr >
			<td class="blue">ҵ��Ʒ��</td>
			<td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
			<td class="blue">�ʷ�����</td>
			<td>
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr >
			<td class="blue">�ʺ�Ԥ��</td>
			<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
			</td>
			<td class="blue">��ǰ����</td>
			<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
			</td>
		</tr>
		<tr >
			<td class="blue">�ֻ�Ʒ��</td>
			<td>
			<SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">
			<option value ="">--��ѡ��--</option>
			<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
			<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
			<%}%>
			</select>
			<font class="orange">*</font>
			</td>
			<td class="blue">�ֻ��ͺ�</td>
			<td>
			<select size=1 name="phone_type" id="phone_type" v_must=1 v_name="�ֻ��ͺ�" onchange="typechange()">
			</select>
			<font class="orange">*</font>
			</td>
		</tr>
		<tr >
			<td class="blue">Ӫ������</td>
			<td>
			<select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="salechage()">
			</select>
			<font class="orange">*</font>
			</td>
			<td></td>
			<td></td>
			<!--td colspan="2">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
			<input type="hidden" name="award_flag" value="0" />
			</td-->
		</tr>
		<tr >
			<td class="blue">����Ԥ��</td>
			<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
			</td>
			<td class="blue">�Ԥ��</td>
			<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
			</td>
		</tr>
		<tr >
			<td class="blue">�ۼ�����</td>
			<td>
			<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"   readonly>
			</td>
			<td class="blue">����������</td>
			<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly> (����)
			</td>
		</tr>
		<tr >
			<td class="blue">�µ���</td>
			<td>
			<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
			</td>
			<td class="blue">�����ʷ�</td>
			<td>
			<select name="New_Mode_Code" id="New_Mode_Code v_must=1 v_name="�����ʷ�" onchange="modechage()">
			</select>
			</td>
		</tr>
		<tr >
			<td class="blue">Ӧ�ս��</td>
			<td >
			<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
			</td>
			<td></td>
			<td></td>
		</tr>
		<tr  id="flagCodeTr" style="display:none">
			<TD class="blue">С������</TD>
			<TD >
			<input class="InputGrey" type="hidden" size="17" name="rate_code" id="rate_code" readonly>
			<input type="text" name="flag_code" size="8" maxlength="10" readonly>
			<input type="text" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			<input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=ѡ��>
			</TD>
		</tr>
		
		<!-- tianyang add for pos start -->
    <TR>
			<TD class="blue">
				<div align="left">�ɷѷ�ʽ</div>
			</TD>
			<TD colspan="3">
				<select name="payType" >
					<option value="0">�ֽ�ɷ�</option>
					<option value="BX">��������POS���ɷ�</option>
					<option value="BY">��������POS���ɷ�</option>
				</select>
			</TD>
		</TR>
		<!-- tianyang add for pos end -->
		
		<TR >
			<TD class="blue">
			<div align="left">IMEI��</div>
			</TD>
			<TD >
			<input name="IMEINo" type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
			<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
			<font class="orange">*</font>
			</TD>
			<TD></td>
			<td></td>
		</TR>
		<TR  id=showHideTr >
			<TD  class="blue">
			<div align="left">����ʱ��</div>
			</TD>
			<TD >
			<input name="payTime" type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
			(������)<font class="orange">*</font>
			</TD>
			<TD  class="blue">
			<div align="left">����ʱ��</div>
			</TD>
			<TD >
			<input name="repairLimit" v_type="date.month" size="10" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()">
			(����)<font class="orange">*</font>
			</TD>
		</TR>
		<tr >
			<td colspan="4" id="footer">
			<div align="center">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="formCommit();" disabled>
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="close" onClick="parent.removeTab('8023');" type="button" class="b_foot" value="�ر�">
			&nbsp;
			</div>
			</td>
		</tr>
	</table>





		<input name="oSmCode" type="hidden" class="InputGrey" id="oSmCode" value="<%=sm_code%>">
		<!-- added by hanfa 20070118-->
	  	<input type="hidden" name="m_smCode" value="">

		<input name="oModeCode" type="hidden" class="InputGrey" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=printAccept%>">
		<input type="hidden" name="Gift_Code" value="">


		<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="8023">
			<input type="hidden" name="opCode" value="8023">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2:�ͻ�ID
			i16:��ǰ���ײʹ���
			ip:�������ײʹ���
			belong_code:belong_code
			print_note:��������
			iAddStr:

			i1:�ֻ�����
			i4:�ͻ�����
			i5:�ͻ���ַ
			i6:֤������
			i7:֤������
			i8:ҵ��Ʒ��

			ipassword:����
			group_type:���ſͻ����
			ibig_cust:��ͻ����
			do_note:�û���ע
			favorcode:�������Ż�Ȩ��
			maincash_no:�����ײʹ��루�ϣ�
			imain_stream:��ǰ���ʷѿ�ͨ��ˮ
			next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ

			i18:�������ײ�
			i19:������
			i20:���������
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			
			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">			
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="�����ʷ�����">
			<input type="hidden" name="return_page" value="/npage/bill/f8023_1.jsp">
			<input type="hidden" name="award_flag" value="0" >
			<input type="hidden" name="need_award" value="0" >
			<input type="hidden" name="smzvalue" >
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>