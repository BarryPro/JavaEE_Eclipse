<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	request.setCharacterEncoding("GBK");
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept(); 
%>


<%
	String opCode = "2281";
	String opName = "签约赠礼品";
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");  
  /* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	
  String paraStr[]=new String[1];
  paraStr[0] = getMaxAccept(); 
  
  
  /*ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  String aftertrim = baseInfoSession[0][5].trim();

  comImpl co1 = new comImpl();
  String paraStr[]=new String[1];
  String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();*/
  
%>
<%
    /*ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);


  ArrayList retList = new ArrayList();
  String[][] tempArr= new String[][]{};*/

  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";


	String iPhoneNo = request.getParameter("srv_no");
	//String iLoginNo = request.getParameter("iLoginNo");
	//String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = request.getParameter("opcode");
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

	/*SPubCallSvrImpl co2 = new SPubCallSvrImpl();*/
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);


  /*retList = co2.callFXService("s126bInit", inputParsm, "29","phone",iPhoneNo);
  int errCode = co2.getErrCode();
  String errMsg = co2.getErrMsg();

	co2.printRetValue();*/
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
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else
  {
	  if (errCode.equals("0")||errCode.equals("000000")){
	  //retList[0][] = (String[][])retList.get(3);
	  if(!(retList[0][3]==null)){
	    bp_name = retList[0][3];           //机主姓名
	  }

	  //retList[0][] = (String[][])retList.get(4);
	  if(!(retList[0][4]==null)){
	    bp_add = retList[0][4];            //客户地址
	  }

	  //retList[0][] = (String[][])retList.get(2);
	  if(!(retList[0][2]==null)){
	    passwordFromSer = retList[0][2];  //密码
	  }

	 // retList[0][] = (String[][])retList.get(11);
	  if(!(retList[0][11]==null)){
	    sm_code = retList[0][11];         //业务类别
	  }

	  //retList[0][] = (String[][])retList.get(12);
	  if(!(retList[0][12]==null)){
	    sm_name = retList[0][12];        //业务类别名称
	  }

	  //retList[0][] = (String[][])retList.get(13);
	  if(!(retList[0][13]==null)){
	    hand_fee = retList[0][13];      //手续费
	  }
	  System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
	  System.out.println(hand_fee);

	  //retList[0][] = (String[][])retList.get(14);
	  if(!(retList[0][14]==null)){
	    favorcode = retList[0][14];     //优惠代码
	  }

	  //retList[0][] = (String[][])retList.get(5);
	  if(!(retList[0][5]==null)){
	    rate_code = retList[0][5];     //资费代码
	  }

	  //retList[0][] = (String[][])retList.get(6);
	  if(!(retList[0][6]==null)){
	    rate_name = retList[0][6];    //资费名称
	  }

	 // retList[0][] = (String[][])retList.get(7);
	  if(!(retList[0][7]==null)){
	    next_rate_code = retList[0][7];//下月资费代码
	  }

	  //retList[0][] = (String[][])retList.get(8);
	  if(!(retList[0][8]==null)){
	    next_rate_name = retList[0][8];//下月资费名称
	  }

	  //retList[0][] = (String[][])retList.get(9);
	  if(!(retList[0][9]==null)){
	    bigCust_flag = retList[0][9];//大客户标志
	  }

	 // retList[0][] = (String[][])retList.get(10);
	  if(!(retList[0][10]==null)){
	    bigCust_name = retList[0][10];//大客户名称
	  }

	  //retList[0][] = (String[][])retList.get(15);
	  if(!(retList[0][15]==null)){
	    lack_fee = retList[0][15];//总欠费
	  }

	  //retList[0][] = (String[][])retList.get(16);
	  if(!(retList[0][16]==null)){
	    prepay_fee = retList[0][16];//总预交
	  }

	  //retList[0][] = (String[][])retList.get(17);
	  if(!(retList[0][17]==null)){
	    cardId_type = retList[0][17];//证件类型
	  }

	  //retList[0][] = (String[][])retList.get(18);
	  if(!(retList[0][18]==null)){
	    cardId_no = retList[0][18];//证件号码
	  }

	  //retList[0][] = (String[][])retList.get(19);
	  if(!(retList[0][19]==null)){
	    cust_id = retList[0][19];//客户id
	  }

	  //retList[0][] = (String[][])retList.get(20);
	  if(!(retList[0][20]==null)){
	    cust_belong_code = retList[0][20];//客户归属id
	  }

	  //retList[0][] = (String[][])retList.get(21);
	  if(!(retList[0][21]==null)){
	    group_type_code = retList[0][21];//集团客户类型
	  }

	  //retList[0][] = (String[][])retList.get(22);
	  if(!(retList[0][22]==null)){
	    group_type_name = retList[0][22];//集团客户类型名称
	  }

	  //retList[0][] = (String[][])retList.get(23);
	  if(!(retList[0][23]==null)){
	    imain_stream = retList[0][23];//当前资费开通流水
	  }

	  //retList[0][] = (String[][])retList.get(24);
	  if(!(retList[0][24]==null)){
	    next_main_stream = retList[0][24];//预约资费开通流水
	  }

	  //retList[0][] = (String[][])retList.get(25);
	  if(!(retList[0][25]==null)){
	    print_note = retList[0][25];//工单广告
	  }

	  //retList[0][] = (String[][])retList.get(27);
	  if(!(retList[0][27]==null)){
	    contract_flag = retList[0][27];//是否托收账户
	  }

	  //retList[0][] = (String[][])retList.get(28);
	  if(!(retList[0][28]==null)){
	    high_flag = retList[0][28];//是否中高端用户
	  }
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}
	//String rpcPage = "qryCus_s2281Init";
	String[][] favInfo = (String[][])session.getAttribute("favInfo"); //数据格式为String[0][0]---String[n][0]
  boolean pwrf = false;//a272 密码免验证
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
				alert("密码验证错误，请重新输入密码！");
				history.go(-1);
			</script>
		<%}
	}       
  }*/


%>

<head>
<title>签约赠礼品</title>

<script language="JavaScript">
<!--
  /*core.loadUnit("debug");
  core.loadUnit("rpccore");*/
  onload=function()
  {

  	//document.all.phoneNo.focus();
   	//core.rpc.onreceive = doProcess;
   	self.status="";
   }
  var arrbrandcode = new Array();//手机型号代码
  var arrbrandname = new Array();//手机型号名称
  var arrbrandmoney = new Array();//代理商代码

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
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
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();
//--------1---------doProcess函数----------------
    //打印使用变量
  var modedxpay =""; 
  var goodbz    =""; 
  var bdbz      =""; 
  var bdts      =""; 
  var exeDate   ="";
  var note      =""; 
  function doProcess(packet)
  {

    var vRetPage=packet.data.findValueByName("rpc_page");
	var verifyType = packet.data.findValueByName("verifyType");
    if(vRetPage == "qryCus_s2281Init")
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
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
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
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
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
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
				return;
		}
	}

	if(vRetPage == "querySmcode") //added by hanfa 20070116
	{
		var errCode = packet.data.findValueByName("errCode");
	    var errMsg = packet.data.findValueByName("errMsg");
		var m_smCode = packet.data.findValueByName("m_smCode");

		if(errCode == 0)
		{
			document.all.m_smCode.value = m_smCode;
		}else
		{
			rdShowMessageDialog("错误:"+ errCode + "->" + errMsg);
			return false;
		}
	}
 }

  //--------2---------验证按钮专用函数-------------

  function chkPass()
  {
  var myPacket = new AJAXPacket("qryCus_s2281Init.jsp","正在查询客户，请稍候......");
	myPacket.data.add("iPhoneNo",document.all.phoneNo.value.trim());
	myPacket.data.add("iLoginNo",document.all.loginNo.value.trim());
	myPacket.data.add("iOrgCode",document.all.orgCode.value.trim());
	myPacket.data.add("iOpCode",document.all.iOpCode.value.trim());

	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }

  function qryPayPrepay()
  {
  if(!checkElement(document.all.oPayAccept)) return;

  var myPacket = new AJAXPacket("qryPayPrepay.jsp","正在查询客户，请稍候......");
	myPacket.data.add("PayAccept",document.all.oPayAccept.value.trim());
	myPacket.data.add("IdNo",document.all.i2.value.trim());
	myPacket.data.add("PhoneNo",document.all.phoneNo.value.trim());

	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }
    function checksmz()
  {

  var myPacket = new AJAXPacket("checkSMZ.jsp","正在查询客户是否是实名制客户，请稍候......");
	myPacket.data.add("PhoneNo",(document.all.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}
  function frmCfm()
  {
         var userCardCode = '<%=cardCode%>';
         if(!checkElement(document.all.phoneNo)) return;
	if(document.all.Gift_Code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      document.all.Gift_Code.focus();
	  return false;
	}
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("该用户是托收用户,预存款将在下月托收时收回！");
         }

         //if(document.all.i9.value == "N" && parseFloat(document.all.oPayPre.value)<parseFloat(document.all.Prepay_Fee.value))
         //{
          // rdShowMessageDialog("本次缴纳预存款不足,不能办理!");
           //return;
        // }

    //added and modified by hanfa 20070116
  		if(document.all.oSmCode.value == "zn" && document.all.m_smCode.value == "gn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  		}
  		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.oSmCode.value))
	  		{
		  		if(document.all.oSmCode.value == "gn"){
		  			if((userCardCode == "01" || userCardCode == "02" || userCardCode == "03")){
			  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分（或M值）将于品牌变更生效时失效，请您及时兑换; ");
			  			rdShowMessageDialog("您目前为全球通VIP会员，如变更品牌，您的VIP会员资格将于业务生效后自动取消。同时提醒您非全球通客户将不能参与VIP评定。");
			  		}else{
			  			rdShowMessageDialog("非全球通客户将不能参与VIP评定。");
			  		}
		  		}else if(document.all.oSmCode.value == "dn"){
		  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分或M值将于品牌变更生效时失效，请您在新资费生效前及时兑换。");
		  		}
		  			if(document.all.oSmCode.value != "zn" && document.all.m_smCode.value=="zn" && document.all.oSmCode.value !="") {//
		  			checksmz();
		  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
		  				rdShowMessageDialog("<%=readValue("2281","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}

		     frm.submit();
 
  }

 function getResInfo()
 {
  var myPacket = new AJAXPacket("getResInfo.jsp","正在查询库存信息，请稍候......");
	myPacket.data.add("LoginNo",document.all.loginNo.value.trim());
	myPacket.data.add("MisCode",document.all.Mis_Code.value.trim());
	myPacket.data.add("JtFlag","01");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
 }
 function judge_area()
 {
  var myPacket = new AJAXPacket("qryAreaFlag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("orgCode",document.all.orgCode.value.trim());
	myPacket.data.add("modeCode",document.all.New_Mode_Code.value.trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
 }

 //-------------------
 function getInfo_code()
 {
  	//调用公共js
  	var regionCode = "<%=regionCode%>";
    var pageTitle = "营销方案选择";
    var fieldName = "方案代码|方案名称|底线预存|活动预存|扣减积分|消费期限|月底线|新主资费|总预存|备注|";//弹出窗口显示的列、列名 
    var sqlStr = "select gift_code,gift_name,base_fee,free_fee,mark_subtract,consume_term,mon_base_fee,mode_code,prepay_fee,note from  sBargainGiftCode where region_code='"+regionCode+"' and flag='0' and op_type='0'";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";//返回字段
    var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|New_Mode_Code|Prepay_Fee|New_Mode_Name|";//返回赋值的域
    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50));

    document.frm.i1.value=document.frm.phoneNo.value;
    document.frm.ip.value=document.frm.New_Mode_Code.value;
	document.all.do_note.value = "用户"+document.all.phoneNo.value+"办理签约赠礼品，方案代码："+document.all.Gift_Code.value;
	document.frm.iAddStr.value=document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.Gift_Name.value+"|";
    judge_area();
    //getResInfo();
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
  	//调用公共js
    var pageTitle = "资费查询";
    var fieldName = "小区代码|小区名称|";//弹出窗口显示的列、列名
    /*var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;*/
    var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' and a.offer_id = " + document.frm.New_Mode_Code.value;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "flag_code|flag_code_name";//返回赋值的域

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
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

    //added by hanfa 20070116
    if(document.all.New_Mode_Code.value != "")
    {
    	querySmcode();
    }

	return true;
}

function getbrand(){

	var myEle2 ;
   	var x2 ;
   	for (var q2=document.all.agent_code.options.length;q2>=0;q2--) document.all.agent_code.options[q2]=null;

   	myEle2 = document.createElement("option") ;
    	myEle2.value = "";
        myEle2.text ="--请选择--";
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

  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070116
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  myPacket.data.add("modeCode",document.all.New_Mode_Code.value.trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
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


<body >
<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
	<table cellspacing="0">
	<tr >
		<td class="blue">手机号码</td>
	        <td >
			<input class="InputGrey"  type="text"  v_type="mobphone"  name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">机主姓名</td>
		<td >
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">业务品牌</td>
	        <td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
	        <td class="blue">资费名称</td>
	        <td>
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">
			帐号预存
		</td>
	        <td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
	        <td class="blue">
	        	当前积分
	        </td>
	        <td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>
	      <tr >
	
	        <td class="blue">方案代码</td>
	        <td>
	          <input class="InputGrey"  type="text" name="Gift_Code" id="Gift_Code" v_name="营销代码" readonly>
		  <input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
	          </select>
		  <font class="orange">*</font>
		</td>
	        <td class="blue">
	        	礼品名称
	        </td>
	        <td>
			<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" v_name="礼品名称" v_type="string" v_must=1 value="" readonly>
		</td>
	
	      </tr>
	</tr>
	
	<tr >
	
		<td class="blue">
			底线预存
		</td>
	        <td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
		</td>
		<td class="blue">
	        	活动预存
	        </td>
	        <td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
		</td>
	</tr>
	<tr >
	
		<td class="blue">
			扣减积分
		</td>
	        <td>
			<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"   readonly>
		</td>
		 <td class="blue">
	        	消费期限
	        </td>
	        <td>
	        	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
		</td>
	</tr>
	<tr >
	
		<td class="blue">
			月底线
		</td>
	        <td>
			<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
		</td>
	        <td class="blue">
	        	应收金额
	        </td>
	        <td >
	        	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
	        	<input name="Mis_Code" type="hidden" class="InputGrey" id="Mis_Code"   readonly>
		</td>
	</tr>
	<tr >
		<td class="blue">
			新主资费
		</td>
	        <td>
			<input name="New_Mode_Code" type="text" class="InputGrey" id="New_Mode_Code" value="" readonly>
		</td>
		<td>&nbsp;</td>
	  <td>&nbsp;</td>
	</tr>
	</tr>
	<tr >
		<td class="blue">
			备    注
		</td>
	        <td colspan="4" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" readonly>
		</td>
	</tr>
	  <tr  id="flagCodeTr" style="display:none">
	    <TD class="blue">小区代码</TD>
		  <TD >
			    <input class="InputGrey" type="hidden" size="17" name="rate_code" id="rate_code" readonly>
	        <input type="text" name="flag_code" size="8" maxlength="10" readonly>
		      <input type="text" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
		      <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=选择>
	    </TD>
	  </tr>
	<tr >
		<td colspan="4" id="footer">
			<div align="center">
	            &nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="frmCfm();">
	            &nbsp;
	            <input name="reset" type="reset" class="b_foot" value="清除" >
	            &nbsp;
	            <input name="close" onClick="parent.removeTab('b281');" type="button" class="b_foot" value="关闭">
	            &nbsp;
			</div>
		</td>
	</tr>
	</table>
		
		
		
		
		
		
		
		
		
		
		<input name="oSmCode" type="hidden" class="InputGrey" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="InputGrey" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
		<!-- added by hanfa 20070116-->
  		<input type="hidden" name="m_smCode" value="">
	
<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="2281">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--以下部分是为调f1270_3.jsp所定义的参数
			i2:客户ID
			i16:当前主套餐代码
			ip:申请主套餐代码
			belong_code:belong_code
			print_note:工单广告词
			iAddStr:

			i1:手机号码
			i4:客户名称
			i5:客户地址
			i6:证件类型
			i7:证件号码
			i8:业务品牌

			ipassword:密码
			group_type:集团客户类别
			ibig_cust:大客户类别
			do_note:用户备注
			favorcode:手续费优惠权限
			maincash_no:现主套餐代码（老）
			imain_stream:当前主资费开通流水
			next_main_stream:预约主资费开通流水

			i18:下月主套餐
			i19:手续费
			i20:最高手续费
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
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="新主资费名称">
			<input type="hidden" name="return_page" value="/npage/bill/f2281_1.jsp">
			<input type="hidden" name="smzvalue" >
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>