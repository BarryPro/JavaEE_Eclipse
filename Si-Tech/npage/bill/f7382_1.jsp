<%
/********************
 version v2.0
 开发商: si-tech
 update sunaj at 2009.4.30
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.io.*"%>

<%
  String opCode = request.getParameter("opcode");
  String opName = "预存优惠购卡营销案冲正";
  String iPhoneNo = request.getParameter("srv_no");

  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");

  //String paraStr[]=new String[1];
  //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>"  id="paraStr"/>
<%

  String  retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",back_rate_code="",back_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="";
  String  sale_code="",market_price="",sale_name="",type_name="",brand_name="";
  String  deposit_fee="",base_fee="",free_fee="",sale_price="",maket_price="";
  String  active_term="",consume_term="",mon_base_fee="",favour_cost="",all_gift_price="";

  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opcode");
  SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

	//sunzx add at 20070904
  String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+iPhoneNo+"'"+" and login_accept="+iLoginNoAccept ;
  String[] inParam = new String[2];
  inParam[0] = "select res_info from wawarddata where flag = 'Y' and phone_no =:phone_no and login_accept=:login_accept" ;
  inParam[1] = "phone_no=" + iPhoneNo + ",login_accept=" + iLoginNoAccept;
  //ArrayList retArray = co.sPubSelect("1",sqlStr);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParam[0]%>"/>
	<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
  if(retCode1.equals("000000") && result.length>0)
  {
	  String awardName = result[0][0];
	  System.out.println("awardName2="+awardName);
	  if(!awardName.equals("")){
%>
	 <script language="JavaScript" >

	  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
		location='f8044_login.jsp?opCode=8044&opName=欢乐新农村神州行手机营销';
		</script>
<%
		}
  }
	//sunzx add end

  //retList = co.callFXService("s7382Init", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s7382Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="41">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>	
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String errCode = retCode1;
  String errMsg = retMsg1;

	//co.printRetValue();
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s7382Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];           //机主姓名

	    bp_add = tempArr[0][4];            //客户地址

	    sm_code = tempArr[0][11];         //业务类别

	    sm_name = tempArr[0][12];        //业务类别名称

	    hand_fee = tempArr[0][13];      //手续费

	    favorcode = tempArr[0][14];     //优惠代码

	    rate_code = tempArr[0][5];     //资费代码

	    rate_name = tempArr[0][6];    //资费名称

	    next_rate_code = tempArr[0][7];//下月资费代码

	    next_rate_name = tempArr[0][8];//下月资费名称

	    bigCust_flag = tempArr[0][9];//大客户标志

	    bigCust_name = tempArr[0][10];//大客户名称

	    lack_fee = tempArr[0][15];//总欠费

	    total_prepay = tempArr[0][16];//总预交

	    cardId_type = tempArr[0][17];//证件类型

	    cardId_no = tempArr[0][18];//证件号码

	    cust_id = tempArr[0][19];//客户id

	    cust_belong_code = tempArr[0][20];//客户归属id

	    group_type_code = tempArr[0][21];//集团客户类型

	    group_type_name = tempArr[0][22];//集团客户类型名称

	    imain_stream = tempArr[0][23];//当前资费开通流水

	    next_main_stream = tempArr[0][24];//预约资费开通流水

	    market_price = tempArr[0][25];//市场价

	    sale_code = tempArr[0][26];//营销代码

	    sale_name = tempArr[0][27];//方案名称

	    favour_cost = tempArr[0][28];//优惠额度

	    base_fee = tempArr[0][29];//底线预存

	    consume_term = tempArr[0][30];//底线消费期限

	    free_fee = tempArr[0][31];//活动预存

	    active_term = tempArr[0][32];//活动消费期限

	    mon_base_fee = tempArr[0][33];//月底线

	    all_gift_price=tempArr[0][34];//购卡费用

	    sale_price = tempArr[0][35];//预存总金额

	    back_rate_code = tempArr[0][36];//冲正回资费

	    back_rate_name = tempArr[0][37];//冲正回资费名称

	    print_note = tempArr[0][38];//广告词

	    type_name = tempArr[0][39];//手机类型

	    brand_name = tempArr[0][40];//手机品牌



	 }
	else{%>
	 <script language="JavaScript">
	<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  		//window.location="f7379_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  	 history.go(-1);
  	//-->
  </script>
<%
	}
%>

<head>
<title>预存优惠购卡营销案冲正</title>
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

//--------1---------doProcess函数----------------

  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");

    if(vRetPage == "qryCus_s7382Init")
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
    var total_prepay    = packet.data.findValueByName("total_prepay"   );
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

    var market_price    = packet.data.findValueByName("market_price"   );
    var sale_code       = packet.data.findValueByName("sale_code"      );
    var sale_name       = packet.data.findValueByName("sale_name"      );
    var favour_cost     = packet.data.findValueByName("favour_cost"    );
    var base_fee        = packet.data.findValueByName("base_fee"       );
    var consume_term    = packet.data.findValueByName("consume_term"   );
    var free_fee        = packet.data.findValueByName("free_fee"       );
    var active_term     = packet.data.findValueByName("active_term"   );
    var all_gift_price  = packet.data.findValueByName("all_gift_price"  );
    var mon_base_fee    = packet.data.findValueByName("mon_base_fee"   );
    var sale_price      = packet.data.findValueByName("sale_price"     );
    var brand_name      = packet.data.findValueByName("brand_name"     );

		alert(retCode);
		if(retCode == 000000)
		{
		document.all.i1.value = document.all.phoneNo.value;
		document.all.i2.value = cust_id;
		document.all.i16.value = rate_code;
    	document.frm.ip.value= back_rate_code;
		document.all.belong_code.value = cust_belong_code;
		document.all.print_note.value = print_note;

		document.all.i4.value = bp_name;
		document.all.i5.value = bp_add;
		document.all.i6.value = cardId_type;
		document.all.i7.value = cardId_no;
		document.all.i8.value = sm_code+"--"+sm_name;

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
		document.all.oPrepayFee.value = total_prepay;
		//document.all.oMarkPoint.value = "0";

		document.all.Market_Price.value = market_price;
		document.all.Sale_Code.value = sale_code;
		document.all.Sale_Name.value = sale_name;
		document.all.Favour_Cost.value = favour_cost;
		document.all.Free_Fee.value = free_fee;
		document.all.Active_Term.value = active_term;
		document.all.Base_Fee.value = base_fee;
		document.all.Consume_Term.value = consume_term;
		document.all.All_Gift_Price.value = all_gift_price;
		document.all.Mon_Base_Fee.value = mon_base_fee;
		document.all.Sale_Price.value = sale_price;
		document.all.Brand_Name.value = brand_name;
		document.all.Type_Name.value = type_name;

		document.all.do_note.value = document.all.phoneNo.value+"预存优惠购卡营销案冲正，营销代码："+document.all.Sale_Code.value;
	  document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Sale_Code.value+"|"+document.all.Brand_Name.value+"|"+
	                        document.all.Type_Name.value+"|"+document.frm.Sale_Price.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Active_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.All_Gift_Price.value+"|"+document.frm.Market_Price.value+"|"+
	                        document.frm.IMEINO.value+"|";
		}else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
				return;
			}
  	}
 }

  //--------2---------验证按钮专用函数-------------

  function chkPass()
  {
  var myPacket = new AJAXPacket("qryCus_s7382Init.jsp","正在查询客户，请稍候......");
	myPacket.data.add("iPhoneNo",jtrim(document.all.phoneNo.value));
	myPacket.data.add("iLoginNo",jtrim(document.all.loginNo.value));
	myPacket.data.add("iOrgCode",jtrim(document.all.orgCode.value));
	myPacket.data.add("iOpCode",jtrim(document.all.iOpCode.value));

	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }

  function frmCfm()
  {
  		 //getAfterPrompt();
         if(!checkElement(document.all.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Sale_Code.value+"|"+document.all.Brand_Name.value+"|"+
	                        document.all.Type_Name.value+"|"+document.frm.Sale_Price.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Consume_Term.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Active_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.All_Gift_Price.value+"|"+document.frm.Market_Price.value+"|"+
	                        document.frm.IMEINO.value+"|";
	      //alert(document.frm.iAddStr.value);
         frm.submit();
  }

//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f1270_3.jsp?activePhone=<%=iPhoneNo%>" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">


	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
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
				<input name="oModeName" type="text" size='40' class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				帐号预存
			</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
			</td>
            <td class="blue">
            	营销代码
            </td>
            <td>
            	<input type="text" name="Sale_Code" value="<%=sale_code%>" readonly class="InputGrey">
				<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="" readonly>
				<input name="Market_Price" type="hidden" class="InputGrey" id="Market_Price" value="<%=market_price%>" readonly>
				<input name="IMEINO" type="hidden" class="InputGrey" id="IMEINO" value="" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">手机品牌</td>
            <td>
				<input name="Brand_Name" type="text" class="InputGrey" id="Brand_Name" value="<%=brand_name%>" readonly>
			</td>
			<td class="blue">手机类型</td>
            <td>
				<input name="Type_Name" type="text" class="InputGrey" id="Type_Name" value="<%=type_name%>" readonly>
			</td>
					</tr>
		<tr>
			<td class="blue">
            	优惠额度
            </td>
            <td>
				<input name="Favour_Cost" type="text" class="InputGrey" id="Favour_Cost" value="<%=favour_cost%>" readonly>
			</td>
			<td class="blue">
				底线预存
			</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" value="<%=base_fee%>" readonly >
			</td>
					</tr>
		<tr>
			<td class="blue">
            	      底线消费期限
                  </td>
                  <td>
				<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term" value="<%=consume_term%>"  readonly>
			</td>
            <td class="blue">
            	活动预存
            </td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
			</td>
					</tr>
		<tr>
			       <td class="blue">
            	活动消费期限
            </td>
            <td>
            	<input name="Active_Term" type="text" class="InputGrey" id="Active_Term"  value="<%=active_term%>" readonly>
			</td>
			<td class="blue">
				月底线
			</td>
            <td>
				<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" value="<%=mon_base_fee%>" readonly>
			</td>
					</tr>
		<tr>
			<td class="blue">
				购卡费用
			</td>
            <td>
				<input name="All_Gift_Price" type="text" class="InputGrey" id="All_Gift_Price"  value="<%=all_gift_price%>" readonly>
			</td>
            <td class="blue">
            	预存总金额
            </td>
            <td>
            	<input name="Sale_Price" type="text" class="InputGrey" id="Sale_Price" value="<%=sale_price%>"  readonly>
			</td>
		</tr>
		<tr>
			<td colspan="4" id="footer">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="frmCfm();">
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="7382">
			<input type="hidden" name="opName" value="<%=opName%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
	    <!--以下部分是为调f1270_3.jsp所定义的参数
			i2:客户ID
			i16:当前主套餐代码
			ip:申请主套餐代码
			belong_code:belong_code
			print_note:工单广告词

			i1:手机号码
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

			beforeOpCode:原业务办理的op_code
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16"  value="<%=rate_code%>">
			<input type="hidden" name="ip" 	value="<%=back_rate_code%>">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>"+"--"+"<%=sm_name%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"预存优惠购卡营销案冲正">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">		
			
			<input type="hidden" name="beforeOpCode" value="7379">	
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">		
			
			<input type="hidden" name="return_page" value="/npage/bill/f7382_1.jsp">	
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
			<%@ include file="/npage/include/footer.jsp" %>        	
</form>
</body>
</html>
