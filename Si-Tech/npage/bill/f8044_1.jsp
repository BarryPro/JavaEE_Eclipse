<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
    String opCode = "8044";
    String opName = "欢乐新农村神州行手机营销";

    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");

        //comImpl co1 = new comImpl();
    String paraStr[]=new String[1];
        //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
        //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();

  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    paraStr[0] = seq;
    System.out.println("loginAccept === "+paraStr[0]);
    printAccept = seq;
    ArrayList retList = new ArrayList();
        //String[][] tempArr= new String[][]{};

    String retFlag="",retMsg="";
    String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
    String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
    String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
    String sim_no="";


	String iPhoneNo = request.getParameter("srv_no");
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

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);
	
	System.out.println("------------------inputParsm[0]-------------"+inputParsm[0]);
	System.out.println("------------------inputParsm[1]-------------"+inputParsm[1]);
	System.out.println("------------------inputParsm[2]-------------"+inputParsm[2]);
	System.out.println("------------------inputParsm[3]-------------"+inputParsm[3]);
	
%>
<wtc:service name="s8044Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="s8044InitCode" retmsg="s8044InitMsg" outnum="30">
	<wtc:param value="<%=inputParsm[0]%>"/> 
	<wtc:param value="<%=inputParsm[1]%>"/> 
    <wtc:param value="<%=inputParsm[2]%>"/> 
    <wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="s8044InitArr" scope="end" />
<%
    String errCode = s8044InitCode;
    String errMsg = s8044InitMsg;

System.out.println("----------------errCode-------------"+errCode);
System.out.println("----------------errMsg-------------"+errMsg);
  if(s8044InitArr == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(s8044InitArr[0][3].equals(""))){
	    bp_name = s8044InitArr[0][3];           //机主姓名
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(s8044InitArr[0][4].equals(""))){
	    bp_add = s8044InitArr[0][4];            //客户地址
	  }

	  //tempArr = (String[][])retList.get(2);
	  if(!(s8044InitArr[0][2].equals(""))){
	    passwordFromSer = s8044InitArr[0][2];  //密码
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(s8044InitArr[0][11].equals(""))){
	    sm_code = s8044InitArr[0][11];         //业务类别
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(s8044InitArr[0][12].equals(""))){
	    sm_name = s8044InitArr[0][12];        //业务类别名称
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(s8044InitArr[0][13].equals(""))){
	    hand_fee = s8044InitArr[0][13];      //手续费
	  }
	  System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
	  System.out.println(hand_fee);

	  //tempArr = (String[][])retList.get(14);
	  if(!(s8044InitArr[0][14].equals(""))){
	    favorcode = s8044InitArr[0][14];     //优惠代码
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(s8044InitArr[0][5].equals(""))){
	    rate_code = s8044InitArr[0][5];     //资费代码
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(s8044InitArr[0][6].equals(""))){
	    rate_name = s8044InitArr[0][6];    //资费名称
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(s8044InitArr[0][7].equals(""))){
	    next_rate_code = s8044InitArr[0][7];//下月资费代码
	  }

	  //tempArr = (String[][])retList.get(8);
	  if(!(s8044InitArr[0][8].equals(""))){
	    next_rate_name = s8044InitArr[0][8];//下月资费名称
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(s8044InitArr[0][9].equals(""))){
	    bigCust_flag = s8044InitArr[0][9];//大客户标志
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(s8044InitArr[0][10].equals(""))){
	    bigCust_name = s8044InitArr[0][10];//大客户名称
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(s8044InitArr[0][15].equals(""))){
	    lack_fee = s8044InitArr[0][15];//总欠费
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(s8044InitArr[0][16].equals(""))){
	    prepay_fee = s8044InitArr[0][16];//总预交
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(s8044InitArr[0][17].equals(""))){
	    cardId_type = s8044InitArr[0][17];//证件类型
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(s8044InitArr[0][18].equals(""))){
	    cardId_no = s8044InitArr[0][18];//证件号码
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(s8044InitArr[0][19].equals(""))){
	    cust_id = s8044InitArr[0][19];//客户id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(s8044InitArr[0][20].equals(""))){
	    cust_belong_code = s8044InitArr[0][20];//客户归属id
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(s8044InitArr[0][21].equals(""))){
	    group_type_code = s8044InitArr[0][21];//集团客户类型
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(s8044InitArr[0][22].equals(""))){
	    group_type_name = s8044InitArr[0][22];//集团客户类型名称
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(s8044InitArr[0][23].equals(""))){
	    imain_stream = s8044InitArr[0][23];//当前资费开通流水
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(s8044InitArr[0][24].equals(""))){
	    next_main_stream = s8044InitArr[0][24];//预约资费开通流水
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(s8044InitArr[0][25].equals(""))){
	    print_note = s8044InitArr[0][25];//工单广告
	  }

	  //tempArr = (String[][])retList.get(27);
	  if(!(s8044InitArr[0][27].equals(""))){
	    contract_flag = s8044InitArr[0][27];//是否托收账户
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(s8044InitArr[0][28].equals(""))){
	    high_flag = s8044InitArr[0][28];//是否中高端用户
	  }
	  //tempArr = (String[][])retList.get(29);
	  if(!(s8044InitArr[0][29].equals(""))){
	    sim_no = s8044InitArr[0][29];//SIM卡号
	  }
	 }else{%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
	}
	//String rpcPage = "qryCus_s126hInit";
%>
<%
//******************得到下拉框数据***************************//

        //comImpl co=new comImpl();
    //手机品牌
        //String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='11' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
    String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='11' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";

    String [] paraIn = new String[2];
    paraIn[0] = sqlAgentCode;
    paraIn[1]="regionCode="+regionCode;

        //System.out.println("sqlAgentCode====="+sqlAgentCode);
        //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>
<wtc:array id="agentCodeStr" scope="end"/>
<%
        //String[][] agentCodeStr = (String[][])agentCodeArr.get(0);

    //手机类型
        //String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='11' and a.spec_type like 'P%' and is_valid='1'";
    String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code=:regionCode and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='11' and a.spec_type like 'P%' and is_valid='1'";

    paraIn[0] = sqlPhoneType;
    paraIn[1]="regionCode="+regionCode;

        //System.out.println("sqlPhoneType====="+sqlPhoneType);
        //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>
<wtc:array id="phoneTypeStr" scope="end"/>
<%
        //String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);

        //营销代码
        // String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='11' and valid_flag='Y' and a.spec_type like 'P%'";
        //System.out.println("sqlsaleType====="+sqlsaleType);
        //ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
        // String[][] saleTypeStr = (String[][])saleTypeArr.get(0);
        //营销明细


        //String sqlsaledet = "select prepay_gift,base_fee,CONSUME_TERM,MON_BASE_FEE,mode_code,sale_price,sale_code,sale_price-prepay_gift-base_fee,market_price from sPhoneSalCfg  where region_code='" + regionCode + "' and sale_type='11' and valid_flag='Y' and spec_type like 'P%'";
        //王良　2007年9月29日 修改
        // String sqlsaledet = "select prepay_gift,base_fee,CONSUME_TERM,MON_BASE_FEE,mode_code,sale_price,sale_code,case when base_fee = -1 then sale_price-prepay_gift else sale_price-prepay_gift-base_fee end,market_price from sPhoneSalCfg  where region_code='" + regionCode + "' and sale_type='11' and valid_flag='Y' and spec_type like 'P%'";
        // System.out.println("sqlsaledet====="+sqlsaledet);
        // ArrayList saledetArr = co.spubqry32("9",sqlsaledet);
        // String[][] saledetStr = (String[][])saledetArr.get(0);
        //新主资费(修改部分)
        //String sqlmodecode = "select a.mode_code,a.sale_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,sbillmodecode c where a.sale_code=b.sale_code and b.region_code='" + regionCode + "' and b.sale_type='11'  and valid_flag='Y' and spec_type like 'P%' and b.region_code=c.region_code and a.mode_code=c.mode_code";
        //System.out.println("sqlmodecode====="+sqlmodecode);
        //ArrayList modecodeArr = co.spubqry32("2",sqlmodecode);
        //String[][] modecodeStr = (String[][])modecodeArr.get(0);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>欢乐新农村神州行手机营销</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language="JavaScript">
<!--
  //core.loadUnit("debug");
  //core.loadUnit("rpccore");
  onload=function()
  {
  	document.all.phoneNo.focus();
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
  var arrdetphonemoney=new Array();
  var arrdetcostprice=new Array();
  //修改部分
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
   /*/修改部分 .............................................................
 // for(int l=0;l<modecodeStr.length;l++)
  //{
 // out.println("arrmodecode["+l+"]='"+modecodeStr[l][0]+"';\n");
 // out.println("arrmodesale["+l+"]='"+modecodeStr[l][1]+"';\n");
 // }*/
  /*
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
	out.println("arrdetconsume["+l+"]='"+saledetStr[l][2]+"';\n");
	out.println("arrdetmonbase["+l+"]='"+saledetStr[l][3]+"';\n");
	out.println("arrdetmode["+l+"]='"+saledetStr[l][4]+"';\n");
	out.println("arrdetsummoney["+l+"]='"+saledetStr[l][5]+"';\n");
	out.println("arrdetsalecode["+l+"]='"+saledetStr[l][6]+"';\n");
	out.println("arrdetphonemoney["+l+"]='"+saledetStr[l][7]+"';\n");
	out.println("arrdetcostprice["+l+"]='"+saledetStr[l][8]+"';\n");
  }
  */
%>
//--------1---------doProcess函数----------------

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
					rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
					return;
			}
		}
		/*begin huangrong add 获取新主资费 对应的备注和主资费名称 2011-3-9*/
		if(vRetPage == "getNote")
    {
	    var retCode = packet.data.findValueByName("retCode");
	    var retMsg = packet.data.findValueByName("retMsg");
	    var offerInfo_name = packet.data.findValueByName("offerInfo_name");
      var offerInfo_note = packet.data.findValueByName("offerInfo_note");
      
			if(retCode == 000000)
			{
				var msgStr= "描述信息：" + offerInfo_note;
				$("#msgDiv").children("span").html(msgStr);
		
				var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
	                            .css("position","absolute").css("z-index","99")
	                            .css("background-color","#dff6b3").css("padding","8");
	    	var pt = $("#New_Mode_Code");
	    	msgNode.css("left",pt.offset().left + 180 + "px").css("top",pt.offset().top + 0 + "px");
	    	msgNode.show();
				document.all.New_Mode_Code_Name.value=offerInfo_name;
			}
			else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
				return;
			}
		}
		/*end huangrong add 获取新主资费 对应的备注和主资费名称 2011-3-9*/
		if(retType == "checkAward")
		{
				var retCode = packet.data.findValueByName("retCode");
				var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!=0){
    			rdShowMessageDialog(retMessage,0);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    			return;
    		}
    		document.all.award_flag.value = 1;
    		//alert(document.all.award_flag.value);
    	}
		if(retType=="0"){
			var  retResult=packet.data.findValueByName("retResult");
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.commit.disabled=false;
					document.frm.IMEINo.readOnly = true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
					document.frm.commit.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
					document.frm.commit.disabled=true;
					return false;
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
			if(errCode == 1403)
			{
				rdShowMessageDialog("错误:"+ errCode + " -> " + "没有找到新主资费对应的品牌代码，数据录入可能有误！",0);
			}
			else
			{
				rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
			}
			return false;
		}
	}

	//added by hanfa 20070118 end
	if(retType == "getSaleCode")
	{
		var errCode = packet.data.findValueByName("errorMsg");
	    var errMsg = packet.data.findValueByName("errorCode");

		if(errCode == 0)
		{
			var values = packet.data.findValueByName("values");
			var names = packet.data.findValueByName("names");
			fillDropDown(document.all.sale_code,values,names);
			return;
		}else
		{
			if(errCode == 1403)
			{
				rdShowMessageDialog("错误:"+ errCode + " -> " + "没有找到新主资费对应的品牌代码，数据录入可能有误！",0);
			}
			else
			{
				rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
			}
			return false;
		}
	}
	if(retType == "getSaleDet")
	{
		var errCode = packet.data.findValueByName("errorMsg");
	    var errMsg = packet.data.findValueByName("errorCode");

		if(errCode == 0)
		{
			var values = packet.data.findValueByName("values");
			var modevalues= packet.data.findValueByName("modevalues");
			if(values.length == 8)
			{
				with(document.all)
				{
					Base_Fee.value=values[0];
        		    Free_Fee.value=values[1];
        		    if (-1 == Free_Fee.value){
        				Free_Fee.value = 0;
        			}
        			Consume_Term.value=values[2];
        			Mon_Base_Fee.value=values[3];
        			//New_Mode_Code.value=values[4];
        			Prepay_Fee.value=values[4];
        			phone_money.value=values[6];
        			cost_price.value=values[7];
				}
 
			}
			 var myEle4 ;

   			for (var q4=document.all.New_Mode_Code.options.length;q4>=0;q4--) document.all.New_Mode_Code.options[q4]=null;
   				myEle4 = document.createElement("option") ;
    			myEle4.value = "";
        		myEle4.text ="--请选择--";
        		document.all.New_Mode_Code.add(myEle4) ;
    		for ( x4 = 0 ; x4 < modevalues.length  ; x4++ )
			{
				//if ( arrmodesale[x4] == document.all.sale_code.value )
				//{
					myEle4 = document.createElement("option") ;
        			myEle4.value = modevalues[x4];
        			myEle4.text = modevalues[x4];
        			document.all.New_Mode_Code.add(myEle4);
				//}
			}
			document.frm.i1.value=document.frm.phoneNo.value;


    		document.all.do_note.value = "用户"+document.all.phoneNo.value+"办理欢乐新农村神州行手机营销";

			return;
		}else
		{
			if(errCode == 1403)
			{
				rdShowMessageDialog("错误:"+ errCode + " -> " + "没有找到新主资费对应的品牌代码，数据录入可能有误！",0);
			}
			else
			{
				rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
			}
			return false;
		}
	}
 }

  //--------2---------验证按钮专用函数-------------

  function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.commit.disabled = true;
	  return false;
     }

	var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.iOpCode.value).trim());
	myPacket.data.add("retType","0");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	//alert(document.frm.Free_Fee.value);
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

  var myPacket = new AJAXPacket("checkSMZ.jsp","正在查询客户是否是实名制客户，请稍候......");
	myPacket.data.add("PhoneNo",(document.frm.phoneNo.value).trim());
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}
 /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 begin *****/

  function formCommit()
  {
  	  var userCardCode = '<%=cardCode%>';
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
			  			rdShowMessageDialog("非全球通客户将不能参与VIP评定。	");
			  		}
		  		}else if(document.all.oSmCode.value == "dn"){
		  			//rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分或M值将于品牌变更生效时失效，请您在新资费生效前及时兑换。");
		  		}
		  				  		if(document.all.oSmCode.value != "zn" && document.all.m_smCode.value=="zn" && document.all.oSmCode.value !="") {//
		  			checksmz();
		  			var smzvalues =document.all.smzvalue.value.trim();
		  			if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
		  				rdShowMessageDialog("<%=readValue("8044","ps","jf",Readpaths)%>");
		  			}
		  		}
	  		}

  		}
		    frmCfm();

  }

  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 end *****/

 function frmCfm()
  {
		document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+"|"
	 +document.frm.Prepay_Fee.value+"|"+document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"
	 +document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"|"
	 +document.frm.Consume_Term.value+"|"+document.frm.sim_no.value+"|"
	 +document.frm.Mon_Base_Fee.value+"|"+document.frm.IMEINo.value+"|"+document.frm.phone_money.value+"|"+document.frm.cost_price.value+"|"
	 +document.frm.phone_type.value+"|"+document.frm.award_flag.value+"|";  
	 
	 
	// alert(document.frm.iAddStr.value);
  	//alert(document.frm.Free_Fee.value);

	 //alert(document.frm.award_flag.value);
	//alert(document.frm.iAddStr.value);

	 if(!checkElement(document.frm.phoneNo)) return;
     if(document.all.agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!");
      document.all.agent_code.focus();
	  return false;
	}
	if(document.all.phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!");
      document.all.phone_type.focus();
	  return false;
	}
	if(document.all.sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      document.all.sale_code.focus();
	  return false;
	}
	 //修改部分...............................................................................................
	if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("请输入新主资费!")
		document.all.New_Mode_Code.focus();
		return false;
    }
	if (document.all.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.all.IMEINo.focus();
      //document.all.confirm.disabled = true; //confirm 错了，应为 commit  //modified by hanfa 20070118
      document.all.commit.disabled = true;
	  return false;
     }
         if (document.all.i9.value == "Y")
         {
         	rdShowMessageDialog("该用户是托收用户,预存款将在下月托收时收回！");
         }    
        
        
         frm.submit();
  }
  /*huangrong add 2011-3-9 牡丹江关于欢乐新农村神州行手机营销界面显示资费名称的请示  */
  function getNote()
  {
  	var myPacket = new AJAXPacket("getNote.jsp","正在查询客户，请稍候......");
  	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	  myPacket.data.add("modeCode",(document.all.New_Mode_Code.value).trim());
		core.ajax.sendPacket(myPacket);
		myPacket = null;
  }
  
  function hideMessage()
  {
		$("#msgDiv").hide();
  }
  
  /*end add 2011-3-9 牡丹江关于欢乐新农村神州行手机营销界面显示资费名称的请示  */
 function judge_area()
 {
// alert("llllllllllllllll");
  var myPacket = new AJAXPacket("qryAreaFlag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("orgCode",(document.all.orgCode.value).trim());
	myPacket.data.add("modeCode",(document.all.New_Mode_Code.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
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
	  var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = " + document.frm.New_Mode_Code.value + " and a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' order by a.flag_code"
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "flag_code|flag_code_name";//返回赋值的域

    if(PubSimpSel1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,pageSize,pageWidth,pageHeight)
{
	pageSize = (pageSize == undefined ? "50" : pageSize);
	pageWidth = (pageWidth == undefined ? "600" : pageWidth);
	pageHeight = (pageHeight == undefined ? "400" : pageHeight);
	
    var path = "/npage/public/listFrame.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&pageSize="+pageSize;
	
	var param = "status:no;resizable:no;dialogHeight:"+pageHeight+"px;dialogWidth:"+pageWidth+"px;";
    retInfo = window.showModalDialog(path,"",param);	
	if(typeof(retInfo) == "undefined")     
    {   return false;   }
    var objArr = retToField.split("\|");
    var valueArr = retInfo.split("\|");
    for(i=0;i<objArr.length;i++){
    	document.all(objArr[i]).value = valueArr[i];
    }
    
  getMidPrompt("10442",document.all.flag_code.value,"showHitF1");
}
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
 //alert(document.all.licl.innerHTML);
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    document.all.Consume_Term.value="";
    document.all.Mon_Base_Fee.value="";
    document.all.New_Mode_Code.value="";
    document.all.Prepay_Fee.value="";
    document.all.phone_money.value="";
    document.all.cost_price.value="";
    document.all.Free_Fee.value="";
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--请选择--";
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
   document.frm.commit.disabled=true;
 }
 function typechange(){
  	document.frm.commit.disabled=true;
  	var myEle1 ;
   	var x1 ;
   	document.all.Consume_Term.value="";
    document.all.Mon_Base_Fee.value="";
    document.all.New_Mode_Code.value="";
    document.all.Prepay_Fee.value="";
    document.all.phone_money.value="";
    document.all.cost_price.value="";
    document.all.Free_Fee.value="";
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;
        document.all.need_award.checked = false;
    	  document.all.award_flag.value = 0;
        with(document.frm)
		{

			if (phone_type.selectedIndex >= 0)
			{
				var myPacket = new AJAXPacket("f8044_rpc.jsp","正在获取数据，请稍候......");
				myPacket.data.add("typecode","getSaleCode");
				myPacket.data.add("regionCode","<%=regionCode%>");
				myPacket.data.add("brandCode",agent_code.value);
				myPacket.data.add("typeCode",phone_type.value);
				core.ajax.sendPacket(myPacket);
				myPacket = null;
			}
		}

   	/*for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value )
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	*/

 }
  function salechage(){

  	var x3;
  	document.frm.commit.disabled=true;
  	document.all.Consume_Term.value="";
    document.all.Mon_Base_Fee.value="";
    document.all.New_Mode_Code.value="";
    document.all.Prepay_Fee.value="";
    document.all.phone_money.value="";
    document.all.cost_price.value="";
    document.all.Free_Fee.value="";

   	with(document.frm)
		{

			if (sale_code.selectedIndex >= 0)
			{
				var myPacket = new AJAXPacket("f8044_rpc.jsp","正在获取数据，请稍候......");
				myPacket.data.add("typecode","getSaleDet");
				myPacket.data.add("regionCode","<%=regionCode%>");
				myPacket.data.add("saleCode",sale_code.value);
				core.ajax.sendPacket(myPacket);
				myPacket = null;
			}
		}

 }

  function modechange()
 {
	var x4;

   document.frm.ip.value=document.frm.New_Mode_Code.value;
   judge_area();
	 getNote(); //huangrong add 2011-3-9 牡丹江关于欢乐新农村神州行手机营销界面显示资费名称的请示

    if(document.all.sale_code.value != "")
    {
    	querySmcode(); //added by hanfa 20070118
    }
    getMidPrompt("10442",codeChg($("#New_Mode_Code").val()),"ipTd");
 }

  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070118
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  //alert(document.frm.New_Mode_Code.value);
	  myPacket.data.add("modeCode",(document.frm.New_Mode_Code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
  }

 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("../s1141/phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8044");
 	 	 packet.data.add("style_code",document.all.phone_type.value );

 	 	 core.ajax.sendPacket(packet);
 	 	 packet = null;

 	 }
 	 //document.all.award_flag.value = 0;

 }
 function fillDropDown(obj,_value,_text){
    obj.options.length = 0;
    var option1 = new Option('--请选择--','');
    obj.add(option1);
    for(var i=0; i<_value.length;i++)
    {
      var option = new Option(_text[i],_value[i]);
      obj.add(option);
   }
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
function retFrm(){
	document.frm.IMEINo.readOnly = false;
	document.frm.reset();	
}
//-->
</script>

</head>


<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<!-- added by hanfa 20070118-->
	  	<input type="hidden" name="m_smCode" value="">

		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
		<input type="hidden" name="Gift_Code" value="">


<table cellspacing="0" >
    <tr>
        <td class="blue">手机号码</td>
        <td>
            <input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 index="3" readonly >
        </td>
        <td class="blue">机主姓名</td>
        <td>
            <input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">业务品牌</td>
        <td>
            <input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
        </td>
        <td class="blue">资费名称</td>
        <td>
            <input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
        </td>
    </tr>
    <tr bgcolor="#F5F5F5">
        <td class="blue">帐号预存</td>
        <td>
            <input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
        </td>
        <td class="blue">SIM卡号</td>
        <td>
            <input name="sim_no" type="text" class="InputGrey" id="sim_no" value="<%=sim_no%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">手机品牌</td>
        <td>
            <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
                <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                    <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
            </select>
            <font class="orange">*</font>
        </td>
        <td class="blue">手机型号</td>
        <td>
            <select size=1 name="phone_type" id="phone_type" v_must=1 onchange="typechange()">
            </select>
            <font class="orange">*</font>
        </td>
    </tr>
    <tr>
        <td class="blue">营销方案</td>
        <td>
            <select size=1 name="sale_code" id="sale_code" v_must=1 onchange="salechage()">
            </select>
            <font class="orange">*</font>
        </td>

        <td class="blue">是否参与赠礼</td>
        <td>
            <input type="checkbox" name="need_award" onclick="checkAward()" />
            <input type="hidden" name="award_flag" value="0" />
        </td>
    </tr>
    <tr>
        <td class="blue">赠送话费</td>
        <td>
            <input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
        </td>
        <td class="blue">彩铃预存</td>
        <td>
            <input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">话费月底线</td>
        <td>
            <input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
        </td>
        <td class="blue">消费期限</td>
        <td>
            <input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">新主资费</td>
        <td id="ipTd">
            <select name="New_Mode_Code" id="New_Mode_Code" onblur="hideMessage();"  v_must=1 onchange="modechange();">
            </select>
        </td>
        <!--begin huangrong  add 2011-3-9 1 -->
        <td class="blue">新资费名称</td>
        <td>
        	 <input name="New_Mode_Code_Name" type="text" class="InputGrey" id="New_Mode_Code_Name" size="60"  readonly>
        </td>
        <!--end huangrong  add 2011-3-9 1 -->
    </tr>
	<!-- ningtn add for pos start @ 20100512 -->
	<TR>
    <td class="blue">应收金额</td>
    <td colspan=3 >
        <input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" readonly>
    </td>
	</TR>
	<TR>	
		<TD class="blue">缴费方式</TD>
		<TD colspan=3 >
			<select name="payType" >
				<option value="0">现金缴费</option>
				<option value="BX">建设银行POS机缴费</option>
				<option value="BY">工商银行POS机缴费</option>
			</select>
		</TD>		
	</TR>	
	<!-- ningtn add for pos end @ 20100512 -->

    <tr id="flagCodeTr" style="display:none">
        <TD class="blue">小区代码</TD>
        <TD colspan=3 id="showHitF1">
            <input class="InputGrey" type="hidden" size="17" name="rate_code" id="rate_code" readonly>
            <input type="text" class="InputGrey" name="flag_code" size="8" maxlength="10" readonly>
            <input type="text" class="InputGrey" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
            <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=选择>
        </TD>
    </tr>
    <TR>
        <TD class="blue" nowrap>IMEI码</TD>
        <TD colspan=3>
            <input name="IMEINo" type="text" v_type="0_9" maxlength=15 value="" onblur="viewConfirm()">
            <input name="checkimei" class="b_text" type="button" value="校验"  onclick="checkimeino()">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR id=showHideTr >
        <TD class="blue" nowrap>付机时间</TD>
        <TD >
            <input name="payTime" type="text" value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
            (年月日)<font class="orange">*</font>
        </TD>
        <TD class="blue" nowrap>保修时限</TD>
        <TD >
            <input name="repairLimit" v_type="date.month" size="10" type="text" value="12" onblur="viewConfirm()">
            (个月)<font class="orange">*</font>
        </TD>
    </TR>
    <tr id="footer">
        <td colspan="4">
            <!-- modified by hanfa 20070118
            <input name="commit" id="commit" type="button" class="button"   value="下一步" onClick="frmCfm();" disabled >
            -->
            <!-- modified by hanfa 20070118-->
            <input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="formCommit();" disabled>
            <input name="reset11" type="button"  value="清除" class="b_foot" onclick="retFrm();">
            <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
        </td>
    </tr>
</table>

<div name="licl" id="licl">
    <input type="hidden" name="iOpCode" value="8044">
    <input type="hidden" name="opName" value="<%=opName%>">
    <input type="hidden" name="phone_money" >
    <input type="hidden" name="cost_price" >
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
    
    
    <input type="hidden" id="rate_code"  name="rate_code" value="">
    

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

    <input type="hidden" name="mode_type" value="">
    <input type="hidden" name="New_Mode_Name" value="新主资费名称">
    <input type="hidden" name="return_page" value="/npage/bill/f8044_1.jsp">
    <input type="hidden" name="cus_pass" value="<%=cus_pass%>">
    <input type="hidden" name="printAccept" value="<%=printAccept%>">
    <input type="hidden" name="opCode" value="8044">
    <input type="hidden" name="opName" value="<%=opName%>">
    <input type="hidden" name="beforeOpCode" value="8045">
    <input type="hidden" name="stream" value="<%=printAccept%>">
    <input type="hidden" name="smzvalue" >

</div>
<!--begin huangrong add 2011-3-9 -->
	<div id="msgDiv">
	    <span></span>
	</div>
<!--end huangrong add 2011-3-9  -->
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
