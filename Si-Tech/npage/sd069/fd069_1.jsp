<%
/********************
 * ����: ��Լ�Żݹ���d069
 * �汾: 1.0
 * ����: 2011-1-11 
 * ����: 
 * ��Ȩ: si-tech
 * update:huangrong
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("activePhone");
  
  			//���Ӳ���������վԤԼ��ǰ̨���� wanghyd
	String banlitype =request.getParameter("banlitype");
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String region_code = orgCode.substring(0,2);
  String regionCode = (String)session.getAttribute("regCode");
 	String groupId = (String)session.getAttribute("groupId");
 	String loginPwd  = (String)session.getAttribute("password"); 
 	String sqlCustString = "select substr(belong_code ,1,2) from dcustmsg where phone_no ='"+iPhoneNo+"'";
 	String cust_name="";
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=sqlCustString%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultCustString" scope="end"/>
<%
  System.out.println("resultCustString"+resultCustString); 
	if(!code.equals("000000")&&!code.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("��ѯ�û�������ʧ�ܣ�������룺<%=code%>��������Ϣ��<%=msg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultCustString.length>0&&resultCustString[0][0]!=null)
		{
			cust_name = resultCustString[0][0];
			System.out.println("------------cust_name-------------"+cust_name);
			System.out.println("------------region_code-------------"+region_code);
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("�û�������Ϊ�գ�",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
	if(!cust_name.equals(region_code))
	{
%>
  	<script language="JavaScript">
			rdShowMessageDialog("�û���������ŷ�ͬһ���У����������а���",0);
			history.go(-1);
		</script>

<%
	}
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
 
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			����״̬��VIP���𣬵�ǰ����,�ʷѴ���,�ʷ�����,����Ԥ��
 */

  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_name="",run_name="",vip="",print_note="",prepay_fee1="",rate_code="",rate_name="",userpass="";
  String[][] result2  = null;
%>
<wtc:service  name="s1145Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="21"  retcode="errCode" retmsg="errMsg">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
	  <wtc:param  value="41"/>
</wtc:service>
<wtc:array id="retList"  start="0" length="14" scope="end"/>
<wtc:array id="retList2" start="14" length="7" scope="end"/>
<%
  System.out.println("retList"+retList);
  if(retList == null)
  {
		if(!retFlag.equals("1"))
		{
		   System.out.println("retFlag="+retFlag);
		   retFlag = "1";
		   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
		if(!errCode.equals("000000")&&!errCode.equals("0")){%>
			<script language="JavaScript">
				rdShowMessageDialog("���÷���s1145Qry����������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				history.go(-1);
			</script>
	<%}
		else
		{
		  bp_name = retList[0][2];
		  bp_add = retList[0][3];
		  cardId_type = retList[0][4];
		  cardId_no = retList[0][5];
		  sm_name = retList[0][6];
		  run_name = retList[0][8];
		  vip = retList[0][9];
		  print_note= retList[0][10];
		  prepay_fee1 = retList[0][11];
		  rate_code = retList[0][12];
		  
		  userpass = retList[0][13];
		  result2 = retList2;
		}
  }
%>
<%
//******************��ѯ�ʷ�����***************************//
  String sqlOffer_name = "select offer_name from product_offer where offer_id ='"+rate_code+"'";
  System.out.println("sqlOffer_name====="+sqlOffer_name);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlOffer_name%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultOffer_name" scope="end"/>
<%
  System.out.println("resultOffer_name"+resultOffer_name); 
	if(!code1.equals("000000")&&!code1.equals("0")){%>
		<script language="JavaScript">
			rdShowMessageDialog("��ѯ�ʷ����Ƴ���������룺<%=code1%>��������Ϣ��<%=msg1%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		if(resultOffer_name.length>0&&resultOffer_name[0][0]!=null)
		{
			rate_name = resultOffer_name[0][0];
		}
	  else
  	{%>
  	<script language="JavaScript">
			rdShowMessageDialog("�ʷ�����Ϊ�գ�",0);
			history.go(-1);
		</script>
  	<%
  	}
	}
%>

<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>

<%
//******************�õ�����������***************************//

  //�ֻ�Ʒ��
  String sqlAgentCode = "select unique a.brand_code, trim(b.brand_name) from dphoneSaleCode a, schnresbrand b where a.region_code = '" + regionCode + "' and a.sale_type = '41' and a.brand_code = b.brand_code and a.valid_flag = 'Y'";
  String[] inParamA = new String[2];
  inParamA[0] = "select unique a.brand_code, trim(b.brand_name) from dphoneSaleCode a, schnresbrand b where a.region_code = '" + regionCode + "' and a.sale_type = '41' and a.brand_code = b.brand_code and a.valid_flag = 'Y'"; 
  inParamA[1] = "region_code=" + regionCode ;
  System.out.println("sqlAgentCode====="+sqlAgentCode);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeA" retmsg="retMsgA" outnum="2">
	<wtc:param value="<%=inParamA[0]%>"/>
	<wtc:param value="<%=inParamA[1]%>"/>
	</wtc:service>
	<wtc:array id="agentCodeStr"  scope="end"/>
<%
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code, trim(b.res_name), b.brand_code from dphoneSaleCode a, schnrescode_chnterm b where a.region_code = '" + regionCode + "'  and a.type_code = b.res_code  and a.brand_code = b.brand_code and a.sale_type ='41' and a.valid_flag = 'Y'"; /*diling ��sale_type�ĸ�ֵ��number��Ϊvarchar���� 2011/8/30 11:19:39 */
  String[] inParamB = new String[2];
  inParamB[0] = "select unique a.type_code, trim(b.res_name), b.brand_code from dphoneSaleCode a, schnrescode_chnterm b where a.region_code = '" + regionCode + "'  and a.type_code = b.res_code  and a.brand_code = b.brand_code and a.sale_type ='41' and a.valid_flag = 'Y'"; 
  inParamB[1] = "region_code=" + regionCode ;
  System.out.println("sqlPhoneType====="+sqlPhoneType);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeB" retmsg="retMsgB" outnum="3">
	<wtc:param value="<%=inParamB[0]%>"/>
	<wtc:param value="<%=inParamB[1]%>"/>
	</wtc:service>
	<wtc:array id="phoneTypeStr"  scope="end"/>
<%
  //Ӫ������
  String sqlsaleType = "select unique trim(a.sale_code), trim(a.sale_name),  a.brand_code, a.type_code from dphoneSaleCode a where a.region_code = '" + regionCode + "'  and a.sale_type = '41'  and a.valid_flag = 'Y'"; 
  String[] inParamC = new String[2];
  inParamC[0] = "select unique trim(a.sale_code), trim(a.sale_name),  a.brand_code, a.type_code from dphoneSaleCode a where a.region_code = '" + regionCode + "'  and a.sale_type = '41'  and a.valid_flag = 'Y' and trim(a.sale_code) not in ('10456584','10456585','10456586','10456587','10456588','10456589','10456590','10456591','10456592','10456593','10456594','10456595','10456596','10456571','10456572','10456573','10456574','10456575','10456576','10456577','10456578','10456579','10456580','10456581','10456582','10456583') "; 
  inParamC[1] = "region_code=" + regionCode ;
  System.out.println("sqlsaleType============================================================"+sqlsaleType);
  
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeC" retmsg="retMsgC" outnum="4">
	<wtc:param value="<%=inParamC[0]%>"/>
	<wtc:param value="<%=inParamC[1]%>"/>
	</wtc:service>
	<wtc:array id="saleTypeStr"  scope="end"/>
<%
 //Ӫ����ϸ huangrong �޸�sqlsaledet���Ӷԡ��ֻ����ӷѡ��͡��ֻ����ӷ��������ޡ� �� FREE_FEE,ACTIVE_TERM �����ֶεĲ�ѯ 2011-2-17 14:13
  String sqlsaledet="select sale_price, prepay_gift , prepay_limit ,mon_base_fee  ,consume_term ,base_fee  ,sale_code,mode_code,free_fee,to_char(active_term) from dphoneSaleCode where region_code = '" + regionCode + "' and sale_type = '41' and valid_flag = 'Y'"; 
  String[] inParamD = new String[2];
  inParamD[0] = "select sale_price, prepay_gift , prepay_limit ,mon_base_fee  ,consume_term ,base_fee  ,sale_code,mode_code,free_fee,to_char(active_term) from dphoneSaleCode where region_code = '" + regionCode + "' and sale_type = '41' and valid_flag = 'Y' and sale_code not in ('10456584','10456585','10456586','10456587','10456588','10456589','10456590','10456591','10456592','10456593','10456594','10456595','10456596','10456571','10456572','10456573','10456574','10456575','10456576','10456577','10456578','10456579','10456580','10456581','10456582','10456583') "; 
  inParamD[1] = "region_code=" + regionCode ;
  System.out.println("sqlsaledet====="+sqlsaledet);
 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeD" retmsg="retMsgD" outnum="10">
	<wtc:param value="<%=inParamD[0]%>"/>
	<wtc:param value="<%=inParamD[1]%>"/>
	</wtc:service>
	<wtc:array id="saledetStr"  scope="end"/>
		
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--

  onload=function()
  {
  	document.all.phoneNo.focus();
   	self.status="";
   	
   	  var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/qryRealUserState.jsp","���ڲ�ѯ�ͻ��Ƿ���ʵ���ƿͻ������Ժ�......");
			myPacket.data.add("PhoneNo","<%=iPhoneNo%>");
			core.ajax.sendPacket(myPacket,checkSMZValue);
			myPacket=null;
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
  var arrdetmodecode=new Array();
  var arrdetsalecode=new Array();   
  var arrfreefee=new Array();
	var arractiveterm=new Array();
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
  System.out.println("444444444444444444444444444444445````````````````````"+saledetStr.length);
	out.println("arrdetbase["+l+"]='"+saledetStr[l][0]+"';\n");       //�ɷѺϼ�
	out.println("arrdetfree["+l+"]='"+saledetStr[l][1]+"';\n");       //�Ԥ��
	out.println("arrdetfavour["+l+"]='"+saledetStr[l][2]+"';\n");     //�·���
	out.println("arrdetconsume["+l+"]='"+saledetStr[l][3]+"';\n");    //�µ�������
	out.println("arrdetmonbase["+l+"]='"+saledetStr[l][4]+"';\n");    //��������

	out.println("arrdetsummoney["+l+"]='"+saledetStr[l][5]+"';\n");    //������
	out.println("arrdetmodecode["+l+"]='"+saledetStr[l][6]+"';\n");    //Ӫ����������
  out.println("arrdetsalecode["+l+"]='"+saledetStr[l][7]+"';\n");    //�ʷѴ���
	out.println("arrfreefee["+l+"]='"+saledetStr[l][8]+"';\n");       //�ֻ����ӷ�
	out.println("arractiveterm["+l+"]='"+saledetStr[l][9]+"';\n");       //�ֻ����ӷ���������
  }

%>
//--------1---------doProcess����----------------

  function doProcess(packet)
  {

    var vRetPage=packet.data.findValueByName("rpc_page");
		var retType=packet.data.findValueByName("retType");
		var verifyType = packet.data.findValueByName("verifyType");
		if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ���",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
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
 }

  function checkSMZValue(packet) {
      document.all.shiming_state.value="";
			var smzname = packet.data.findValueByName("smzname");
			var smzflag = packet.data.findValueByName("smzvalue");
      document.all.shiming_state.value=smzname;
      if(smzflag=="3") {
      $("#shiming_state").css({"font-weight":"bold" ,"color":"red"});     	
			}else {
			 $("#shiming_state").removeAttr("size"); 
			//alert($("#shiming_state").width());
			$("#shiming_state").width("125");
			//alert($("#shiming_state").width());
			}
}
  //--------2---------��֤��ťר�ú���-------------

  function checkimeino()
	{
	 if(document.frm.IMEINo.value.length == 0){
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      document.frm.commit.disabled = true;
	 	  return false;
     }

		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
		myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
		myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
		myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
		myPacket.data.add("opcode",(document.all.opCode.value).trim());
		myPacket.data.add("retType","0");
		core.ajax.sendPacket(myPacket);
		myPacket=null;

	}
	
 function viewConfirm()
 {
	if(document.frm.IMEINo.value=="")
	{
		document.frm.commit.disabled=true;
	}
 }

/*zhangyan add*/
function getMarkPoint()
{
	/*У��*/
	if(!checkElement(document.all.phoneNo)) return;
	
	if(document.all.agent_code.value=="")
	{
		rdShowMessageDialog("��ѡ���ֻ�Ʒ��!");
		document.all.agent_code.focus();
		return false;
	}
	
	if(document.all.phone_type.value=="")
	{
		rdShowMessageDialog("��ѡ���ֻ��ͺ�!");
		document.all.phone_type.focus();
		return false;
	}
	
	if(document.all.sale_code.value=="")
	{
		rdShowMessageDialog("��ѡ��Ӫ������!");
		document.all.sale_code.focus();
		return false;
	}	
	
	/*ָ��Ajax����ҳ*/
	var packet = new AJAXPacket("fd069Ajax.jsp","���Ժ�...");
		
	/*��ajaxҳ�洫�ݲ���*/
	packet.data.add("opCode","<%=opCode%>" );
	packet.data.add("ajaxType","getM" );
	packet.data.add("phoneNo",document.all.phoneNo.value );
	/*������*/
	packet.data.add("machPrice",document.all.Phone_Fee.value );
	/*���ѻ���*/
	packet.data.add("markPoint",  parseInt(document.all.markPoint.value ,10));
	
	/*����ҳ��,��ָ���ص�����*/
	core.ajax.sendPacket(packet,setMarkPoint,true);
	packet=null;
}

/*zhangyan add*/
function setMarkPoint(packet)
{
	/*Prepay_Fee Ӧ�ս��*/
	var rtCode=packet.data.findValueByName("rtCode"); 	
	var rtMsg=packet.data.findValueByName("rtMsg"); 	
	
	/* ����Ӧ�����ĳ�ʼֵ*/
	for ( x3 = 0 ; x3 < arrdetmodecode.length  ; x3++ )
   	{
  		if ( arrdetmodecode[x3] == document.all.sale_code.value )
  		{
    		document.all.Prepay_Fee.value=arrdetbase[x3];
  		}
   	}		
	if ( rtCode=="000000" )
	{
		
		/*���ֶ�Ӧ��Ǯ��*/
		var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
		
		/*����ֵ*/
		document.all.pointMoney.value	= rstMarkQry;
		
		var ppFee=document.all.Prepay_Fee.value ;
		
		/*Ӧ�ս��-���ֶһ���Ǯ��*/
		ppFee=parseFloat(ppFee-rstMarkQry).toFixed(2);
		
		document.all.Prepay_Fee.value=ppFee;
	}
	else
	{
		document.all.markPoint.value="0";
		rdShowMessageDialog(rtCode+":"+rtMsg);
		return false;
	}
}


 function printCommit()
 {
 	/*zhangyan add*/
	if(!check(document.frm) )
	{
		return false;
	}	


 		
		getAfterPrompt();
		document.frm.iAddStr.value=
			document.frm.sale_code.value+"|"
			+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"
			+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"
			+document.frm.Prepay_Fee.value+"|"
			+document.frm.Free_Fee.value+"|"
			+document.frm.Mon_back.value+"|"
			+document.frm.Mon_Base_Fee.value+"|"
			+parseFloat(document.frm.Phone_Fee.value-document.frm.pointMoney.value).toFixed(2)+"|"
			+document.frm.Consume_Term.value+"|"
			+document.frm.i2.value+"|"
			+document.frm.IMEINo.value+"|"
			+document.frm.PhoneFree_Fee.value+"|"
			+document.frm.Active_Term.value+"|";
		
		document.frm.p3.value=document.all.phone_type.options[document.all.phone_type.selectedIndex].innerHTML;
	
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
		if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.all.IMEINo.focus();
      document.all.commit.disabled = true;
	 		return false;
     }
     
     // add by wanglma 
        var myPacket = new AJAXPacket("selLimit.jsp","���Ժ�......");
		myPacket.data.add("printAccept",document.all.printAccept.value);
		myPacket.data.add("iPhoneNo",document.all.phoneNo.value);
		myPacket.data.add("phone_type",document.all.phone_type.options[document.all.phone_type.selectedIndex].value);
		core.ajax.sendPacket(myPacket,doMsg);
		myPacket=null;
		
}

function doMsg(packet){
  var retCode=packet.data.findValueByName("retCode");
  var retMsg=packet.data.findValueByName("retMsg");
  if(retCode == "000000"){
  	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  if(typeof(ret)!="undefined")
  { 
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
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
  }else{
     rdShowMessageDialog(" errCode :"+retCode +" errMsg : "+retMsg );	
     return;
  }
  
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             	//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="d069" ;                   			 	//��������
	var phoneNo="<%=iPhoneNo%>";                  //�ͻ��绰
		var iccidInfoStr = "";
	var accInfoStr = "";
		iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
			+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr +
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add �������ޱ����������� 2011/8/30 11:17:17 */
	
	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.oCustName.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";

	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="�û�Ʒ�ƣ�"+document.all.oSmName.value+"    ����ҵ��<%=opName%>"+"|";
  opr_info+="ҵ����ˮ��"+document.all.printAccept.value+"|";
  opr_info+="�ֻ��ͺţ�"+document.all.phone_type.options[document.all.phone_type.selectedIndex].innerHTML+"    IMEI�룺"+document.all.IMEINo.value+"|";
	opr_info+="�ɷѺϼƣ�"+document.all.Prepay_Fee.value+"Ԫ  ����Ԥ�滰��"+document.all.Save_Fee.value+"Ԫ��ÿ�·�����"+document.all.Mon_back.value+"Ԫ��һ���Է�����"+document.all.Free_Fee.value+"Ԫ���µ�������"+document.all.Mon_Base_Fee.value+"Ԫ���ֻ����ӷѣ�"+document.all.PhoneFree_Fee.value+"Ԫ��ÿ���˻���"+document.all.i3.value+"Ԫ��ҵ����Ч��"+_consumeTerm+"���£��������£�"+"|"; /*diling add  ����ҵ����Ч�� 2011/8/30 11:17:17 */

	note_info1+="��ע��"+document.all.do_note.value+"|";

	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function frmCfm()
{
	  document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  	{
    		/*set �������*/
				var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
				var trantype      = "00";         //��������
				var bMoney        = document.all.Prepay_Fee.value; 				//�ɷѽ��
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
				var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
				var trannum       = "<%=iPhoneNo%>";                      //�绰����
				getSysDate();       /*ȡbossϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;      //�ύʱ��
				var transerialold = "";																		//ԭ����Ψһ��,�ڽɷ�ʱ�����
				var org_code      = "<%=orgCode%>";                       //ӪҵԱ����						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";					/*�������� */         
				var bMoney        = document.all.Prepay_Fee.value;         /*���׽�� */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "";                								 		/*ԭ�������� */				
				var rrn           = "";                           				/*ԭ����ϵͳ������ */ 
				var instNum       = "";                                   /*���ڸ������� */     
				var terminalId    = "";                    								/*ԭ�����ն˺� */			
				getSysDate();       																			//ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=loginNo%>";                        /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=iPhoneNo%>";                       /*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
}

	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
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


 //-------------------

 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
 	/*zhangyan add �ֻ�Ʒ�Ʊ仯ʱ���ѻ�������*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
 	
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

   document.all.commit.disabled = "true";

 }

 function typechange(){
 	
 	/*zhangyan add �ֻ����ͱ仯ʱ���ѻ�������*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
 	
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
   	document.all.commit.disabled = "true";

 }

 
  function salechage(){
  	/*zhangyan add Ӫ�������仯ʱ,���ѻ��ֺ�Ӧ�ս����0*/
 	document.all.markPoint.value="0";
 	document.all.Prepay_Fee.value="0.00";
  	
	 document.all.commit.disabled = "true";
  	var x3;
	for ( x3 = 0 ; x3 < arrdetmodecode.length  ; x3++ )
   	{
      		if ( arrdetmodecode[x3] == document.all.sale_code.value )
      		{
        		document.all.Base_Fee.value=Number(arrdetfavour[x3])*Number(arrdetmonbase[x3]);
        		document.all.Mon_back.value=arrdetfavour[x3];
        		document.all.Free_Fee.value=arrdetfree[x3];
        		document.all.Consume_Term.value=arrdetmonbase[x3];
        		document.all.Mon_Base_Fee.value=arrdetconsume[x3];
        		document.all.Mon_Base_prefee.value=
        			(Number(Number(arrdetfavour[x3])*Number(arrdetmonbase[x3]))/Number(arrdetmonbase[x3])).toFixed(2);
        		document.all.Prepay_Fee.value=arrdetbase[x3];
        		document.all.Phone_Fee.value=arrdetsummoney[x3];
        		document.all.i2.value=arrdetsalecode[x3];
        		document.all.i3.value=arrfreefee[x3];		
        		document.all.PhoneFree_Fee.value=Number(arrfreefee[x3])*Number(arractiveterm[x3]);
        		document.all.mon_PhoneFree_Fee.value=Number(arrfreefee[x3]);
        		document.all.Active_Term.value=arractiveterm[x3];
        		document.all.Save_Fee.value=Number(arrdetbase[x3])-Number(arrdetsummoney[x3]);
      		}
   	}
    document.frm.i1.value=document.frm.phoneNo.value;
 }


function retFrm(){
	hiddenTip(document.frm.markPoint);
	document.frm.IMEINo.readOnly = false;
	document.frm.reset();
}
//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="fd069_2.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ʺ�Ԥ��</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee1%>" readonly>
			</td>
            <td class="blue">��ǰ����</td>
            <td>
				<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
			</td>
		</tr>
				<tr>
			<td class='blue' >ʵ��״̬</td>
      		<td colspan="3">
				<input name="shiming_state" type="text" class="InputGrey" id="shiming_state"  size='17' readonly>
			</td>
		</tr>
             <tr>
            <td class="blue">�ֻ�Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">
			   <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font color="orange">*</font>
			</td>
	 		<td class="blue">�ֻ��ͺ�</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="�ֻ��ͺ�" onchange="typechange()">

              </select>
			  <font color="orange">*</font>
			</td>
   </tr>
   <tr>
     <td class="blue">Ӫ������</td>
        <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="salechage()">
              </select>
			  <font color="orange">*</font>
			</td>
			
				<TD class="blue">
					<div align="left">�ɷѷ�ʽ</div>
				</TD>
				<TD colspan="3">
					<select name="payTypeSelect" >
						<option value="0">�ֽ�ɷ�</option>
						<option value="BX">��������POS���ɷ�</option>
						<option value="BY">��������POS���ɷ�</option>
					</select>
				</TD>
     </tr>
		<tr>
			<td class="blue">
				����Ԥ��
			</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
			</td>
			<td class="blue">
            	         �Ԥ��
                        </td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
			</td>
		</tr>
		<tr>
			 <td class="blue">
            	��������
            </td>
            <td>
            	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
			</td>


			<td class="blue">
				������
			</td>
            <td>
				<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee"   readonly>
			</td>

		</tr>
<!--begin huangrong add ���ֻ����ӷѡ��͡��ֻ����ӷ��������ޡ���չʾ 2011-2-17 14:18-->   
		<tr>
			<td class="blue">�ֻ����ӷ�</td>
			<td>
				<input name="PhoneFree_Fee" type="text" class="InputGrey" id="PhoneFree_Fee" readonly>
			</td>
			
      <td class="blue">�ֻ����ӷ���������</td>
      <td colspan="3">
      	<input name="Active_Term" type="text" class="InputGrey" id="Active_Term" readonly>
			</td>
		</tr>
		<tr>
			<td class='blue' >���ֻ����ӷ�</td>
			<td colspan="3">
				<input name="mon_PhoneFree_Fee" type="text" class="InputGrey" id="mon_PhoneFree_Fee" readonly>
			</td>
		</tr>
		
<!--end huangrong add ���ֻ����ӷѡ��͡��ֻ����ӷ��������ޡ���չʾ-->
		<tr>
			<!--zhangyan -->
			<td class="blue">���ѻ���</td>
      			<td> 
				<input name="markPoint" type="text"  id="markPoint" value='0'
					v_must='1' v_type='0_9' onchange='getMarkPoint()' >
			</td>
			
      <td class="blue">Ӧ�ս��</td>
      <td>
      	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" readonly>
			</td>
		</tr>
		<!--zhangyan -->
		<tr>
			<td class='blue' >�µ��߽��</td>
			<td colspan="3">
				<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
			</td>
		</tr>
		<TR>
			<td class='blue' >�µ���Ԥ��</td>
			<td>
				<input name="Mon_Base_prefee" type="text" class="InputGrey" id="Mon_Base_prefee" readonly>
			</td>			
			<TD class="blue">
				<div align="left">IMEI��</div>
			</TD>
			<TD>
				<input name="IMEINo" class="button" type="text" v_type="0_9" v_name="IMEI��"  
					maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
				<font color="orange">*</font>
			</TD>
		</TR>        
		  <TR id=showHideTr >
			<TD class="blue">
				<div align="left">����ʱ��</div>
            </TD>
			<TD >
				<input name="payTime" type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font color="orange">*</font>
			<TD class="blue">
				<div align="left">����ʱ��</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12" onblur="viewConfirm()">
				(����)<font color="orange">*</font>
			</TD>
   </TR>
   <tr>
		<td class="blue">��    ע</td>
		<td colspan="3" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >

		</td>
	</tr>   
</table>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>	
<table>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit();"  >
                &nbsp;
                <input name="reset11" type="button" class="b_foot" value="���" onclick="retFrm();" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

<div name="licl" id="licl">
      <input type="hidden" name="banlitype" value="<%=banlitype%>">
			<input type="hidden" name="opCode" value="<%=opCode%>">
			
			<!--zhangyan ���ֶһ���Ǯ��-->			
			<input type="hidden" name="pointMoney" value="">
			
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
		

			<input type="hidden" name="Mon_back" value=""><!--�·���-->
      <input type="hidden" name="Rate_Code" value="<%=rate_code%>"><!--�ʷѴ���-->
      <input type="hidden" name="iAddStr" value=""><!--ƴ��-->
      

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i2" value=""><!--�����ʷ�-->
			<input type="hidden" name="i3" value=""><!--ÿ���ֻ����ӷ�-->
			<input type="hidden" name="p3" value=""><!--�ֻ��ͺ�-->
			<input type="hidden" name="i4" value="<%=bp_name%>"><!--�ͻ�����-->
			<input type="hidden" name="i5" value="<%=bp_add%>"><!--�ͻ���ַ��-->
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>"><!--֤������-->
			<input type="hidden" name="Save_Fee" value=""><!--Ԥ�滰��-->
			
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			<input type="hidden" name="opName" value="<%=opName%>">
			
			
				<!-- pos�� begin-->		
					<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
					<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
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
			<!-- pos�� end-->	

</div>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ include file="/npage/public/hwObject.jsp" %> 
</body>
</html>

