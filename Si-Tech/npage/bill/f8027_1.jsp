<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-16
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page language="java" import="java.sql.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
  String opCode = "8027";
  String opName = "���ֻ����ͻ���";
%>

<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");

	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */

%>

	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="paraStr" />


<%


  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
  String cus_pass ="";
  
    String goodbz="";
	String phone_good=iPhoneNo;
	String modedxpay="";
	String sqlStrgood = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 " and b.region_code = '"+regionCode+"'"+
   						 " and a.phone_no = '"+phone_good+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
  System.out.println("############################f1270_3->sqlStrgood->"+sqlStrgood);
	System.out.println("###################zhanghongzhanghong16################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1111" retmsg="retMsg1111">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultx" scope="end" />
<%
		System.out.println("###################zhanghongzhanghong17################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(resultx!=null&&resultx.length>0){
			if(resultx[0][0].equals(""))
			{
				goodbz="N";
			}else{
				goodbz="Y";
				modedxpay = resultx[0][0];
				System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
				System.out.println(modedxpay);
			}
		}
		
  try{
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo)map.get(iPhoneNo);
	cus_pass=contactInfo.getPasswdVal(2);
 	}catch(Exception e){
 	}
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

	//String iPhoneNo = request.getParameter("srv_no");
	//String iOpCode = request.getParameter("opcode");
  String[][] retList= new String[][]{};

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);
%>

    <wtc:service name="s126bInit" outnum="29" retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=iPhoneNo%>">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value="<%=op_strong_pwd%>"/>
				<wtc:param value="<%=iPhoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=inputParsm[2]%>"/>
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%

  //retList = co2.callFXService("s126bInit", inputParsm, "29","phone",iPhoneNo);
  String errCode = code1;
  String errMsg = msg1;

	retList = result_t;

  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000") ){
	    bp_name = retList[0][3];           //��������
	    bp_add = retList[0][4];            //�ͻ���ַ
	    passwordFromSer = retList[0][2];  //����
	    sm_code = retList[0][11];         //ҵ�����
	    sm_name = retList[0][12];        //ҵ���������
	    hand_fee = retList[0][13];      //������
	    favorcode = retList[0][14];     //�Żݴ���
	    rate_code = retList[0][5];     //�ʷѴ���
	    rate_name = retList[0][6];    //�ʷ�����
	    next_rate_code = retList[0][7];//�����ʷѴ���
	    next_rate_name = retList[0][8];//�����ʷ�����
	    bigCust_flag = retList[0][9];//��ͻ���־
	    bigCust_name = retList[0][10];//��ͻ�����
	    lack_fee = retList[0][15];//��Ƿ��
	    prepay_fee = retList[0][16];//��Ԥ��
	    cardId_type = retList[0][17];//֤������
	    cardId_no = retList[0][18];//֤������
	    cust_id = retList[0][19];//�ͻ�id
	    cust_belong_code = retList[0][20];//�ͻ�����id
	    group_type_code = retList[0][21];//���ſͻ�����
	    group_type_name = retList[0][22];//���ſͻ���������
	    imain_stream = retList[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = retList[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    print_note = retList[0][25];//�������
	    contract_flag = retList[0][27];//�Ƿ������˻�
	    high_flag = retList[0][28];//�Ƿ��и߶��û�

	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("�������<%=errCode%>��������Ϣ<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}

%>
<%
//******************�õ�����������***************************//

  //�ֻ�Ʒ��

  String sqlAgentCode = "select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "'  and a.sale_type='12' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  /*
    String sqlAgentCode = "select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
*/
  //�ֻ�����

  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y'  and a.sale_type='12' and a.spec_type like 'P%' and is_valid='1'";

/*
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
*/
  //Ӫ������

  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='12'  and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType="+sqlsaleType);
/*
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "'  and valid_flag='Y' and a.spec_type like 'P%'";
*/
  //Ӫ����ϸ
  /*
  String sqlsaledet = "select sale_price,prepay_limit,sale_code from sPhoneSalCfg  where region_code='" + regionCode + "'  and sale_type='12' and valid_flag='Y' and spec_type like 'P%'";

  */
    String sqlsaledet = "select sale_price,prepay_limit,sale_code from sPhoneSalCfg  where region_code='" + regionCode + "'  and sale_type='12' and valid_flag='Y' and spec_type like 'P%'";

System.out.println("sqlsaledet="+sqlsaledet);
  //�����ʷ�
  String modesql="select distinct a.mode_code,a.sale_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,product_offer c where a.sale_code=b.sale_code and b.region_code='" + regionCode + "' and b.sale_type='12' and valid_flag='Y' and spec_type like 'P%' and rtrim(a.mode_code)=to_char(c.offer_id) and c.state = 'A' ";
  System.out.println("modesql="+modesql);

/*
  String modesql="select a.mode_code,a.sale_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,sbillmodecode c where a.sale_code=b.sale_code and b.region_code='" + regionCode + "' and b.sale_type='12'  and valid_flag='Y' and spec_type like 'P%' and b.region_code=c.region_code and a.mode_code=c.mode_code";
*/

%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaledet%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>


	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=modesql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>
<%

  String[][] agentCodeStr = (String[][])result_t1;

  String[][] phoneTypeStr = (String[][])result_t2;

  String[][] saleTypeStr = (String[][])result_t3;

  String[][] saledetStr = (String[][])result_t4;

  String[][] modeCodeStr = (String[][])result_t5;
          String test[][] = modeCodeStr;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");

%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<%
	/* ningtn �Ų��ܼ����� */
	String password = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = printAccept;
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = password;
	paraAray4[5] = iPhoneNo;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=regionCode%>"  
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~����sAdTermQry�ɹ�~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~����sAdTermQryʧ��~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode4%>��������Ϣ��<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ֻ����ͻ���</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language="JavaScript">
<!--
  onload=function()
  {
  	document.all.phoneNo.focus();
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

  var arrdetmash=new Array();
  var arrdetprepay=new Array();
  var arrdetsalecode=new Array();

  var arrspchoice=new Array();

  var arrspcode=new Array();

  var arrmodecode=new Array();
  var arrmodesale=new Array();
  var arrmodename=new Array();
  var arrmodebrand=new Array();
  var arrmodetype=new Array();
  var arrmodesalecode = new Array();
  var dxfeeorder="";
 
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
  for(int k=0;k<saledetStr.length;k++)
  {
	out.println("arrdetmash["+k+"]='"+saledetStr[k][0]+"';\n");
	out.println("arrdetprepay["+k+"]='"+saledetStr[k][1]+"';\n");
	out.println("arrdetsalecode["+k+"]='"+saledetStr[k][2]+"';\n");

  }

  for(int j=0;j<modeCodeStr.length;j++)
  {
	/***out.println("arrmodecode["+j+"]='"+modeCodeStr[j][0]+"';\n");
	out.println("arrmodename["+j+"]='"+modeCodeStr[j][1]+"';\n");
	out.println("arrmodebrand["+j+"]='"+modeCodeStr[j][2]+"';\n");
	out.println("arrmodetype["+j+"]='"+modeCodeStr[j][3]+"';\n");
	****/
	out.println("arrmodecode["+j+"]='"+modeCodeStr[j][0]+"';\n");
	out.println("arrmodesale["+j+"]='"+modeCodeStr[j][1]+"';\n");

  }

%>
//--------1---------doProcess����----------------

  function doProcess(packet)
  {

    var vRetPage=packet.data.findValueByName("rpc_page");
	var retType=packet.data.findValueByName("retType");

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
		    }else{
		    	document.all.flagCodeTr.style.display="none";
		    	document.all.flag_code.value="";
		    	document.all.flag_code_name.value="";
		    	document.all.rate_code.value="";
		    }
		}
		else
		{
				rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
				return;
		}
	}
	if(retType=="0")
	{
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����",0);
					document.frm.commit.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�",0);
					document.frm.commit.disabled=true;
					return false;
			}
	}

	if(vRetPage == "querySmcode")
	{

		  var errCode = packet.data.findValueByName("errCode");
	    var errMsg = packet.data.findValueByName("errMsg");
		  var m_smCode = packet.data.findValueByName("m_smCode");
		self.status="";

		if(errCode == "000000")
		{
			document.all.m_smCode.value = m_smCode;
		}else
		{
			rdShowMessageDialog("����:"+ errCode + "->" + errMsg);
			return false;
		}
	}
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



	var myPacket = new AJAXPacket("/npage/s1141/queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.iOpCode.value).trim());
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
		  				rdShowMessageDialog("<%=readValue("8027","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}
		frmCfm();
  }
  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 end *****/


  function frmCfm()
  {
      document.frm.commit.disabled=true;
    //document.frm.commit.disabled=false;
//	document.frm.ip.value=document.frm.New_Mode_Code.value;
	document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"+document.frm.prepay_fee.value+"|"+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"+document.frm.pay_money.value+"|"+document.frm.IMEINo.value+"|";
//	alert(document.frm.iAddStr.value);
  if(!checkElement(document.frm.phoneNo)){ 
    document.frm.commit.disabled=false;
    return};
     if(document.all.agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      	  document.all.agent_code.focus();
      	   document.frm.commit.disabled=false;
	  return false;
	}
	if(document.all.phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
      document.all.phone_type.focus();
       document.frm.commit.disabled=false;
	  return false;
	}
	if(document.all.sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      document.all.sale_code.focus();
       document.frm.commit.disabled=false;
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
       	rdShowMessageDialog("���û��������û�,����������ҵ��");
		document.all.commit.disabled = true;
		return false;
	 }
	 
	      if ($('#mode_sale').val().trim() == "-1" )
     {
       	rdShowMessageDialog("�����ʷѲ���Ϊ�գ�");
		return false;
	 }
	 	      if ($('#mode_sale').val().trim() == "" )
     {
		document.all.commit.disabled = true;
		return false;
	 }

	 

      if( parseFloat(document.all.oPrepayFee.value)<parseFloat(document.all.prepay_fee.value))
      {
			rdShowMessageDialog("���ν��ɳ�ֵ��Ԥ����,���ܰ���!");
            document.all.commit.disabled = true;
			return false;
       }	  
       if((document.all.tonote.value.trim())=="")  {
       	document.all.tonote.value="��"+<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>+"�������ֻ����ͻ���ҵ��";//ϵͳ��ע
       }      
		    printCommit();
	

  }
   function printCommit()
 { 
  //У��
  //if(!check(frm)) return false;
  
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frm.submit();
             } else {
            document.frm.commit.disabled=false;
        }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frm.submit();
              } else {
            document.frm.commit.disabled=false;
        }
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frm.submit();
            } else {
            document.frm.commit.disabled=false;
        }
  }
  return true;
}
 function judge_area()
 {
	/******** added by hanfa 20070119 begin ***********/
	if(document.all.New_Mode_Code.value != "")
	{

	    getModeCode();

	    if(document.frm.modeCode.value != "")
	    {
	    	querySmcode();
	    }
	}
    /******** added by hanfa 20070119 end ***********/

// alert("llllllllllllllll");
    var myPacket = new AJAXPacket("qryAreaFlag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("modeCode",(document.all.New_Mode_Code.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
 }

 //-------------------

/******** �����ַ�������ʷѴ��� added by hanfa 20070119 begin ***********/
function getModeCode()
{
	var tempStr = document.all.New_Mode_Code.value;
	var modeCode = "";
//	alert("oneTokSelf(tempStr,1) = "+oneTokSelf(tempStr,"->",1));
	modeCode = oneTokSelf(tempStr,"->",1);

	document.frm.modeCode.value = modeCode;
}
/******** �����ַ�������ʷѴ���  added by hanfa 20070119 end ***********/
function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

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

//����������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070119


function getFlagCode()
{
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|С������|";//����������ʾ���С�����
    /*
    var sqlStr = "select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;*/
	  var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = " + document.frm.New_Mode_Code.value + " and a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' order by a.flag_code";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "flag_code|flag_code_name";//���ظ�ֵ����

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}


 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
 	 
 	 document.frm.commit.disabled = true;
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
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }

 function typechange(){
 //alert(document.all.phone_type.value);
  	document.frm.commit.disabled = true;
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
   	//document.all.need_award.checked = false;
   	//document.all.award_flag.value = 0;
 }

  function salechage(){
  	
  	//document.frm.commit.disabled = true;
  	var x3;
	for ( x3 = 0 ; x3 < arrdetsalecode.length  ; x3++ )
   	{
      		if ( arrdetsalecode[x3] == document.all.sale_code.value )
      		{
        		document.all.mash_fee.value=arrdetmash[x3];
        		document.all.prepay_fee.value=arrdetprepay[x3];
        		document.all.pay_money.value=arrdetmash[x3];

      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
   
    document.all.do_note.value = "�û�"+document.all.phoneNo.value+"�������ֻ����ͻ���";
     // document.frm.iAddStr.value=document.frm.Gift_Grade.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                       // document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Deposit_Fee.value+"|"+
	                       // document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+
	                       // document.frm.Gift_Name.value+"|";;

   //judge_area(); 
   
    				$("#mode_sale").empty();
						if(sale_code == -1 || sale_code == '-1'){
							reset();
							return;
						}
    				var sale_code = $('#sale_code').val();
    				var packet = new AJAXPacket("getDxoffer.jsp","���ڻ�������Ϣ�����Ժ�......");
    				var _data = packet.data;
						 _data.add("sale_code",sale_code);
						 core.ajax.sendPacket(packet,getModeSaleProcess);
						 packet = null;


 }
 	function getModeSaleProcess(package) {
	  	var retCode = package.data.findValueByName("retcode");
			var retMsg = package.data.findValueByName("retmsg");
			var result = package.data.findValueByName("result");
			if(retCode == "000000") {
				//���Ӫ����������dxfeeorder
				if(result!=undefined) {
				var txt = '<option value="-1" >--��ѡ��--</option>';
				for(var i=0;i<result.length;i++) {
					txt += '<option value="' + result[i][0]+ ','+result[i][2]+'">';
					txt +=     result[i][1];
					txt += '</option>'
				}
				$('#mode_sale').append(txt);
				}
				
			}else {
				rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				return false;
			}
	}
	function dxchange() {
  if($('#mode_sale').val().trim()=="") {
  }else {
  var dxianxiaofeiarray = $('#mode_sale').val().split(",");
  $('#dxzfoffer').val(dxianxiaofeiarray[0]);  
  }  
	}
/*
	function modechage()
	{
		var x4;


    	document.frm.ip.value=document.frm.New_Mode_Code.value;

		judge_area();

    	if(document.all.sale_code.value != "")
    	{
    	querySmcode();
    	}
    	var newcode=codeChg(document.frm.New_Mode_Code.value);
    	getMidPrompt("10442",newcode,"ipTd");
 	}
 	*/

 	function modechage()
	{
		var x4;


    	document.frm.ip.value=document.frm.New_Mode_Code.value;

		judge_area();

    	if(document.all.sale_code.value != "")
    	{
    	querySmcode();
    	}
    	var newcode=codeChg(document.frm.New_Mode_Code.value);
    	getMidPrompt("10442",newcode,"ipTd");
 	}

 	function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
	  myPacket.data.add("modeCode",(document.frm.New_Mode_Code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
  }
function retFrm(){
	document.frm.IMEINo.readOnly = false;
	document.frm.reset();	
}  
//-->
/* ningtn �Ų��ܼ����� */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
		function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   //var printStr = printInfo();
   /*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept =<%=printAccept%>;             			//��ˮ��
		var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
		var mode_code=null;           							//�ʷѴ���
		var fav_code=null;                				 		//�ط�����
		var area_code=null;             				 		//С������
		var opCode="8027" ;                   			 		//��������
		var phoneNo="<%=iPhoneNo%>";                  	 		//�ͻ��绰
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,"",prop);
		return ret;
}
function printInfo(printType)
{
	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.frm.iAddStr.value;
	 // alert(tempStr);
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ Ӫ������|�ֻ�Ʒ��|Ԥ�滰��|����|�շ�|IMEI��|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var phone_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	//var phone_type = oneTokSelf(tempStr,"|",4);    //�ֻ��ͺ�
	var phone_type = codeChg(oneTokSelf(tempStr,"|",4));
	var pay_money= oneTokSelf(tempStr,"|",5); //�շ�
	var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI��
  var dixianxiaofeiyuan = $('#mode_sale').val();
  var dixianqianshu="0.00";
  if(dixianxiaofeiyuan.trim()=="") {
  dixianqianshu="0.00";
  }else {
  var dxianxiaofeiarray = $('#mode_sale').val().split(",");
  dixianqianshu=dxianxiaofeiarray[1];
  }
  


	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	     /********������Ϣ��**********/
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.i1.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
     /********������**********/
      opr_info+="ҵ�����ͣ����ֻ����ͻ���"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+phone_code+phone_type+"      IMEI�룺"+IMEINo+"|";
	  opr_info+="�ɿ�ϼƣ�"+pay_money+"Ԫ�������ͣ�"+prepay_fee+"Ԫ���ѡ��µ�������"+dixianqianshu+"Ԫ"+"|";
			/*******��ע��**********/
	
	  	note_info1+=" "+"|";

	  /**********������*********/
      note_info1+="��ӭ���μ�'���ֻ����ͻ��ѻ'��1.����͵�Ԥ�滰��ÿ���������ʹ���ܶ��ʮ��֮һ��������Ļ����������н��ɣ������λ������ֻ�������ֻ�������һ��ʹ�ã����򽫲�����ʹ�����͵�Ԥ�滰�ѡ����͵�Ԥ�滰�ѱ�����10������������ϣ�ʣ���ȫ��������;2.�����͵�Ԥ���δ�������ǰ�����˿ת�ҵ���ں�����а�������ҵ������ǰ����ȡ������ΥԼ�涨�������ͻ��ѣ�����ʣ��Ԥ����30%����ΥԼ��"+"|";

      note_info1+=" "+"|";
      
      note_info1+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
			/* ningtn IMEI ���°�����*/
			note_info4 += "�������ֻ���ʧ����Ϊ�𻵵ȸ���ԭ���޷�ʹ�ö���ɻ������룬�뵽Ӫҵ�����¹��������򽫲��ܼ���ʹ��ʣ�໰�ѡ�" + "|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("sm_code"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn" && new_SmCode == "gn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		note_info1+=" "+"|";
	  		}

  		}
  				  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//��ʵ����ȫ��ͨ�����еش��ͻ�ת��Ϊ�����пͻ�
		  					note_info1+="<%=readValue("8027","ps","jf",Readpaths)%>"+"|";
		  			}
      <%if(goodbz.equals("Y")){%>
			//note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
	function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

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

  /***����������Ҫ�õ��Ĺ��˺���**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>

</head>


<body>
	<form name="frm" method="post" action="f8027Cfm.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>

		<input name="oSmCode" type="hidden"  id="oSmCode" value="<%=sm_code%>">
		<!-- added by hanfa 20070118-->
	  	<input type="hidden" name="m_smCode" value="">
		<input type="hidden" name="modeCode" value="">
<input type="hidden" name="opName" value="<%=opName%>">
		<input name="oModeCode" type="hidden"  id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
		<input type="hidden" name="Gift_Code" value="">
		<!-- /* ningtn �Ų��ܼ����� */  -->
		<div class="title" id="showMsg">
			<div id="title_zi">
			
			</div>
		</div>
	<div class="title">
		<div id="title_zi">���ֻ����ͻ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
            <td>
				<input   type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement(document.frm.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly Class="InputGrey">
			</td>
			<td class="blue" width="100">��������</td>
			<td>
				<input name="oCustName" type="text"  id="oCustName" value="<%=bp_name%>" readonly Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text"  id="oSmName" value="<%=sm_name%>" readonly Class="InputGrey">
			</td>
            <td class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" size="43" id="oModeName" value="<%=rate_name%>" readonly Class="InputGrey">
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ʺŽɷѿ�����Ԥ��
			</td>
            <td>
				<input name="oPrepayFee" type="text"  id="oPrepayFee" value="<%=prepay_fee%>" readonly Class="InputGrey">
			</td>
            <td class="blue">
            	��ǰ����
            </td>
            <td>
				<input name="oMarkPoint" type="text"  id="oMarkPoint" value="<%=print_note%>" readonly Class="InputGrey">
			</td>
		</tr>
             <tr>
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
          <tr>

            <td class="blue">Ӫ������</td>
            <td >
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="salechage()">
               <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < saleTypeStr.length ; i ++){%>
                <option value="<%=saleTypeStr[i][0]%>"><%=saleTypeStr[i][1]%></option>
                <%}%>

			  </select>
			   <font class="orange">*</font>
			</td>
				<td class="blue">�����ʷ� </td>
				<td> 
					<select id="mode_sale" onChange="dxchange()">
					</select>
				</td>

          </tr>
		</tr>

		<tr>

			<td class="blue">
				������
			</td>
            <td>
				<input name="mash_fee" type="text"  id="mash_fee" readonly Class="InputGrey">
			</td>
			<td class="blue">
            	���ͻ���
            </td>
            <td>
				<input name="prepay_fee" type="text"  id="prepay_fee"   readonly Class="InputGrey">
			</td>
		</tr>


		  <tr id="flagCodeTr" style="display:none">
		    <TD class="blue">С������</TD>
			  <TD >
				    <input  type="hidden" size="17" name="rate_code" id="rate_code" readonly>
					  <input type="text"  name="flag_code" size="8" maxlength="10" readonly>
			      <input type="text"  name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button"   style="cursor:hand" onClick="getFlagCode()" value=ѡ�� class="b_text">
        </TD>
        <td>&nbsp;
			</td>
			<td>&nbsp;
			</td>
      </tr>
		 <TR>
		 <td class="blue">
            	Ӧ�ս��
            </td>
            <td >
            	<input name="pay_money" type="text"  id="pay_money"   readonly Class="InputGrey">
			</td>
			<TD class="blue">
				<div align="left">IMEI��</div>
            </TD>
            <TD >
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei"  type="button" value="У��" onclick="checkimeino()" class="b_text">
                 <font class="orange">*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>
		  <TR id=showHideTr >
			<TD>
				<div   class="blue">����ʱ��</div>
            </TD>
			<TD >
				<input name="payTime"  type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������) <font class="orange">*</font>
			</TD>
			<TD  class="blue">
				<div >����ʱ��</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()" >
				(����) <font class="orange">*</font>
			</TD>
          </TR>
		<tr>
							  <tr style="display:block">
						     <td class="blue">�û���ע</td>
							 <td>
								<input name="tonote" id="tonote" size="40" maxlength="60" value="" >
							 </td>
						  </tr>
			<td colspan="4" id="footer">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button"    value="ȷ��&��ӡ" onClick="formCommit();" disabled class="b_foot">
                &nbsp;
                <input name="reset11" type="button"  value="���" class="b_foot" onclick="retFrm();">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button"  value="�ر�" class="b_foot">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="8027">
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
			<input type="hidden" name="dxzfoffer" id="dxzfoffer">
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
			<input type="hidden" name="return_page" value="/npage/bill/f8027_1.jsp?activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
			<input type="hidden" name="smzvalue" >
</div>			
<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
</html>
