<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.8
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
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%            
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName"); 	
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
 
 /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
  
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept(); 
%>
<%
    ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
    
  
  String retFlag="",retMsg="";  
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";

	
	//String iLoginNo = request.getParameter("iLoginNo");
	//String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = request.getParameter("opCode");
	String cus_pass = request.getParameter("cus_pass");
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

  //retList = co2.callFXService("s126bInit", inputParsm, "29","phone",iPhoneNo);
%>
	<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">			
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String errCode = retCode2;
  String errMsg = retMsg2;

	//co2.printRetValue();

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {
	 
	    bp_name = tempArr[0][3];           //��������
	
	    bp_add = tempArr[0][4];            //�ͻ���ַ
	 
	    passwordFromSer = tempArr[0][2];  //����
	 
	    sm_code = tempArr[0][11];         //ҵ�����
	 
	    sm_name = tempArr[0][12];        //ҵ���������
	 
	    hand_fee = tempArr[0][13];      //������
	
	    favorcode = tempArr[0][14];     //�Żݴ���
	 
	    rate_code = tempArr[0][5];     //�ʷѴ���
	 
	    rate_name = tempArr[0][6];    //�ʷ�����
	 
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	  
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	  
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	 
	    bigCust_name = tempArr[0][10];//��ͻ�����
	 
	    lack_fee = tempArr[0][15];//��Ƿ��
	 
	    prepay_fee = tempArr[0][16];//��Ԥ��
	 
	    cardId_type = tempArr[0][17];//֤������
	 
	    cardId_no = tempArr[0][18];//֤������
	 
	    cust_id = tempArr[0][19];//�ͻ�id
	 
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	 
	    group_type_code = tempArr[0][21];//���ſͻ�����
	 
	    group_type_name = tempArr[0][22];//���ſͻ���������
	  
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	 
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	 
	    print_note = tempArr[0][25];//�������
	  
	    contract_flag = tempArr[0][27];//�Ƿ������˻�
	 
	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
	 
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
%>

<head>
<title>����Ӫ��������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
 
  onload=function()
  {

  	document.all.phoneNo.focus();
   	self.status="";
   }
//--------1---------doProcess����----------------

  function doProcess(packet)
  {
  
    var vRetPage=packet.data.findValueByName("rpc_page");
	var retType=packet.data.findValueByName("retType");



    if(vRetPage == "qryCus_s126hInit")
    {
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

    var pay_pre        = packet.data.findValueByName("pay_pre"        );
							
		if(retCode == 000000)
		{
		document.all.oPayPre.value = pay_pre;
		}
		else
		{
				rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
				return;
		}
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
			rdShowMessageDialog("����:"+ errCode + "->" + errMsg,0);
			return false;
		}  
	}//added by hanfa 20070118 end  	
 }

  //--------2---------��֤��ťר�ú���-------------
  function chkPass()
  {
  var myPacket = new AJAXPacket("qryCus_s126hInit.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("iPhoneNo",(document.all.phoneNo.value).trim());
	myPacket.data.add("iLoginNo",(document.all.loginNo.value).trim());
	myPacket.data.add("iOrgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("iOpCode",(document.all.iOpCode.value).trim());

	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }

  function qryPayPrepay()
  {
  if(!checkElement(document.all.oPayAccept)) return;

  var myPacket = new AJAXPacket("qryPayPrepay.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("PayAccept",(document.all.oPayAccept.value).trim());
	myPacket.data.add("IdNo",(document.all.i2.value).trim());
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());	

	core.ajax.sendPacket(myPacket);
	myPacket=null;  
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
  		if(document.all.sale_code.value==""){
  			rdShowMessageDialog("Ӫ�������벻��Ϊ�գ�");
  			return false;
  		}
  		//getAfterPrompt();
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
		  				rdShowMessageDialog("<%=readValue("7960","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}
		

		    frmCfm();
 		
  }
  /***** �ύǰ����Ʒ��ת����ʾ��Ϣ added by hanfa 20070118 end *****/
  
  function frmCfm()
  { 
     if(document.frm.oPrepayFee.value < 60)
     {
     	rdShowMessageDialog("�û���ǰԤ�治��С�ڲ�������");
		document.frm.action="f7960_login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>";
     }
     if(document.frm.op.value=="")
     document.frm.op.value="�û���ͨ�˲���Ӫ��������";
     document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.frm.color_mode.value+"|"+document.frm.pay_money.value+"|"+document.frm.begin_time.value+"|"+document.frm.op.value+"|"+document.all.imain_stream.value+"|";
     //alert(document.frm.iAddStr.value);
     document.frm.ip.value=document.frm.mode_code.value;
     document.frm.i1.value=document.frm.phoneNo.value;
    
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

 function judge_area()
 {
	var myPacket = new AJAXPacket("qryAreaFlag.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("modeCode",(document.all.mode_code.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null; 
 }

 //-------------------
  function salechage()
{ 
  	document.all.commit.disabled=true;
    document.getElementById("flagCodeTr").style.display="none";
	document.all.flag_code.value="";
	document.all.flag_code_name.value="";
	
  	//���ù���js
  	var mode_code=document.all.mode_code.value;
  	var color_mode=document.all.color_mode.value;
  	var regionCode = "<%=regionCode%>";
  	var rate_code = "<%=rate_code%>";
    var pageTitle = "Ӫ������Ϣ";
    var fieldName = "Ӫ��������|Ӫ��������|���ʷѴ���|���ʷ�����|�����ʷѴ���|�����ʷ�����|��������|�����ʷ�";//����������ʾ���С����� 
    /*
    var sqlStr = "select a.sale_code,a.sale_name,a.mode_code,b.mode_name,a.color_mode,c.mode_name color_name,e.pay_money,a.next_mode from DBCUSTADM.SCOLORRINGSALECFG a,sbillmodecode b,sbillmodecode c,cbillbbchg d,scolormode e "
               + "where a.region_code='"+regionCode+"' and a.region_code=b.region_code and a.region_code=c.region_code and a.color_mode=c.mode_code and sysdate between��a.begin_time and a.end_time and a.mode_code=b.mode_code and a.mode_code=d.new_mode and d.old_mode='"+rate_code+"' and d.op_code='"+document.all.opCode.value+"' and a.region_code=e.region_code and a.color_mode=e.product_code and e.mode_bind='1'";
               
    */
    
    var sqlStr = "select a.sale_code,a.sale_name,a.mode_code,b.offer_name,a.color_mode,c.offer_name color_name,e.pay_money,a.next_mode from DBCUSTADM.SCOLORRINGSALECFG a,product_offer b,product_offer c,PRODUCT_OFFER_RELATION d,scolormode e  where a.region_code='"+regionCode+"' and a.region_code=e.region_code and to_number(a.color_mode)=c.offer_id and rtrim(a.mode_code)=to_char(b.offer_id)  and to_number(a.mode_code)=d.OFFER_Z_ID and a.color_mode=e.product_code and sysdate between��a.begin_time and a.end_time and d.OFFER_A_ID="+rate_code+" and e.mode_bind='1' and d.RELATION_TYPE_ID=2";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2|3|4|5|6|7";//�����ֶ�
    var retToField = "sale_code|sale_name|mode_code|mode_name|color_mode|color_name|pay_money|next_mode";//���ظ�ֵ����
    //alert("test regionCode="+regionCode+"rate_code="+rate_code);
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));   
    document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.frm.color_mode.value+"|"+document.frm.pay_money.value+"|"+document.frm.begin_time.value+"|"+document.frm.op.value+"|"+document.all.imain_stream.value+"|"+document.all.next_mode.value+"|";
    //alert(document.frm.iAddStr.value);
     
    document.frm.ip.value=document.frm.mode_code.value;
	document.frm.i1.value=document.frm.phoneNo.value;
	getMidPrompt("10442",codeChg(document.frm.mode_code.value),"ipTd");
	getMidPrompt("10442",codeChg(document.frm.color_mode.value),"ipTd1"); 
    document.all.commit.disabled=false;  
     judge_area();
}


function getFlagCode()
{
  	
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|С������|��������";//����������ʾ���С����� 
    /*
    var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a where  a.region_code='" + document.frm.orgCode.value.substring(0,2) + "'  order by a.flag_code" ;
    */
    var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' and offer_id = "+ document.frm.mode_code.value +""

    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2";//�����ֶ�
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

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
  //������������ѯ�ʷѴ�����Ӧ��Ʒ�ƴ��� added by hanfa 20070118
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","���ڻ����Ϣ�����Ժ�......");
	  myPacket.data.add("modeCode",(document.frm.mode_code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
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

//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<!-- added by hanfa 20070118-->
	  	<input type="hidden" name="m_smCode" value="">

		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
		<input type="hidden" name="Gift_Code" value="">

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
            <td colspan=3>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
				<input name="begin_time" type="hidden" class="button" id="begion_time" readonly>
            	<input name="end_time" type="hidden" class="button" id="end_time" readonly>
			</td>
		</tr>
	</table>
</div>
	<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY> 
          	<tr>
            <td class="blue">Ӫ��������</td>
            <td colspan=3>
			  <input name="sale_code" type="text" class="button" id="sale_code" size="8" readonly>
              <input name="sale_name" type="hidden" class="InputGrey" id="sale_name" size="8" readonly>
              <input name="qry" class="b_text" type="button" value="��ѯ" onclick="salechage();">
         	</td>
		</tr>		
		<tr>
			<td class="blue">
				���ʷѴ���
			</td>
            <td id=ipTd>
				<input name="mode_code" type="text" class="InputGrey" id="mode_code"   readonly>
			</td>  
			 <td class="blue">
            	���ʷ�����
            </td>
            <td>
            	<input name="mode_name" type="text" class="InputGrey" id="mode_name"   readonly>
			</td>
		</tr>
		<tr> 

			<td class="blue">
				�����ʷѴ���
			</td>
            <td id=ipTd1>
				<input name="color_mode" type="text" class="InputGrey" id="color_mode" readonly>
			</td>  
			<td class="blue">
				�����ʷ�����
			</td>
            <td>
            	<input name="color_name" type="text" class="InputGrey" id="color_name" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">
            	��������
            </td>
            <td>
            	<input name="pay_money" type="text" class="InputGrey" id="pay_money" readonly>   	
            </td>            
         	<td colspan=2>
         		<input name="next_mode" type="hidden" class="button" id="next_mode" readonly>
        	</td>
        	<td>
        		<input name="op" type="hidden" class="button" id="op" maxlength=30>
        	</td>	
          </tr>
    
		<tr id="flagCodeTr" style="display:none">
		    <TD class="blue">С������</TD>
			  <TD colspan="3">
				    <input type="hidden" size="17" name="rate_code" id="rate_code" class="button" readonly>
           			<input type="text" class="button" name="flag_code" size="8" maxlength="10" readonly>
			      <input type="text" class="button" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=ѡ��>
       		 </TD>
      	</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="formCommit();" disabled >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp; 
				</div>
			</td>
		</tr>
	</table>
</div>
<div name="licl" id="licl">
			<input type="hidden" name="opCode" value="7960">
			<input type="hidden" name="iOpCode" value="7960">
			<input type="hidden" name="opName" value="<%=opName%>">
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
			<input type="hidden" name="i8" value="<%=sm_code%>--><%=sm_name%>">			
			<input type="hidden" name="i9" value="<%=contract_flag%>">			

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"��������">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">			
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			
			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">			
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">	
			<input type="hidden" name="return_page" value="/npage/bill/f7960_login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
			<input type="hidden" name="smzvalue" >
</div>		
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>
