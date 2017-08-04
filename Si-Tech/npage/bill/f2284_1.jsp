<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>

<%              
    String opCode = "2284";
    String opName = "全球通签约送礼冲正";

            
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");
    
        //comImpl co1 = new comImpl();
    String paraStr[]=new String[1];
        //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
        //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();

%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    paraStr[0] = seq;
    System.out.println("sysAccept===   "+paraStr[0]);
    String printAccept=seq;
    String  retFlag="",retMsg="";  
    String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
    String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
    String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",card_no="",print_note="";
    String  gift_code="",gift_grade="",gift_name="";
    String  deposit_fee="",base_fee="",free_fee="";
    String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";
    
    String iPhoneNo = request.getParameter("srv_no");
    String iLoginNoAccept = request.getParameter("backaccept");
    //String iOrgCode = request.getParameter("iOrgCode");
    String iOpCode = request.getParameter("opcode");
    String[][] tempArr= new String[][]{};
    //SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

    //ArrayList retList = new ArrayList();
    //retList = co.callFXService("s2282Init", inputParsm, "39","phone",iPhoneNo);
%>
    <wtc:service name="s2282Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="s2282InitCode" retmsg="s2282InitMsg" outnum="39">
        <wtc:param value="<%=inputParsm[0]%>"/>
        <wtc:param value="<%=inputParsm[1]%>"/>
        <wtc:param value="<%=inputParsm[2]%>"/>
        <wtc:param value="<%=inputParsm[3]%>"/>
        <wtc:param value="<%=inputParsm[4]%>"/>
    </wtc:service>
    <wtc:array id="s2282InitArr" scope="end" />
<%
  String errCode = s2282InitCode;
  String errMsg = s2282InitMsg;

	//co.printRetValue();
  if(s2282InitArr == null)
  {
	   retFlag = "1";
	   retMsg = "s2282Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else
  {
	  if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(s2282InitArr[0][3].equals(""))){
	    bp_name = s2282InitArr[0][3];           //机主姓名
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(s2282InitArr[0][4].equals(""))){
	    bp_add = s2282InitArr[0][4];            //客户地址
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(s2282InitArr[0][11].equals(""))){
	    sm_code = s2282InitArr[0][11];         //业务类别
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(s2282InitArr[0][12].equals(""))){
	    sm_name = s2282InitArr[0][12];        //业务类别名称
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(s2282InitArr[0][13].equals(""))){
	    hand_fee = s2282InitArr[0][13];      //手续费
	  }

	  //tempArr = (String[][])retList.get(14);
	  if(!(s2282InitArr[0][14].equals(""))){
	    favorcode = s2282InitArr[0][14];     //优惠代码
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(s2282InitArr[0][5].equals(""))){
	    rate_code = s2282InitArr[0][5];     //资费代码
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(s2282InitArr[0][6].equals(""))){
	    rate_name = s2282InitArr[0][6];    //资费名称
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(s2282InitArr[0][7].equals(""))){
	    next_rate_code = s2282InitArr[0][7];//下月资费代码
	  }
	  System.out.println("--------next_rate_code-----"+next_rate_code);

	  //tempArr = (String[][])retList.get(8);
	  if(!(s2282InitArr[0][8].equals(""))){
	    next_rate_name = s2282InitArr[0][8];//下月资费名称
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(s2282InitArr[0][9].equals(""))){
	    bigCust_flag = s2282InitArr[0][9];//大客户标志
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(s2282InitArr[0][10].equals(""))){
	    bigCust_name = s2282InitArr[0][10];//大客户名称
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(s2282InitArr[0][15].equals(""))){
	    lack_fee = s2282InitArr[0][15];//总欠费
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(s2282InitArr[0][16].equals(""))){
	    total_prepay = s2282InitArr[0][16];//总预交
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(s2282InitArr[0][17].equals(""))){
	    cardId_type = s2282InitArr[0][17];//证件类型
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(s2282InitArr[0][18].equals(""))){
	    cardId_no = s2282InitArr[0][18];//证件号码
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(s2282InitArr[0][19].equals(""))){
	    cust_id = s2282InitArr[0][19];//客户id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(s2282InitArr[0][20].equals(""))){
	    cust_belong_code = s2282InitArr[0][20];//客户归属id
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(s2282InitArr[0][21].equals(""))){
	    group_type_code = s2282InitArr[0][21];//集团客户类型
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(s2282InitArr[0][22].equals(""))){
	    group_type_name = s2282InitArr[0][22];//集团客户类型名称
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(s2282InitArr[0][23].equals(""))){
	    imain_stream = s2282InitArr[0][23];//当前资费开通流水
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(s2282InitArr[0][24].equals(""))){
	    next_main_stream = s2282InitArr[0][24];//预约资费开通流水
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(s2282InitArr[0][25].equals(""))){
	    gift_grade = s2282InitArr[0][25];//礼品等级
	  }

	  //tempArr = (String[][])retList.get(26);
	  if(!(s2282InitArr[0][26].equals(""))){
	    gift_code = s2282InitArr[0][26];//礼品代码
	  }
	  
	  //tempArr = (String[][])retList.get(27);
	  if(!(s2282InitArr[0][27].equals(""))){
	    gift_name = s2282InitArr[0][27];//礼品名称
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(s2282InitArr[0][28].equals(""))){
	    deposit_fee = s2282InitArr[0][28];//抵押预存
	  }

	  //tempArr = (String[][])retList.get(29);
	  if(!(s2282InitArr[0][29].equals(""))){
	    base_fee = s2282InitArr[0][29];//底线预存
	  }

	  //tempArr = (String[][])retList.get(30);
	  if(!(s2282InitArr[0][30].equals(""))){
	    free_fee = s2282InitArr[0][30];//活动预存
	  }	  	  

	  //tempArr = (String[][])retList.get(31);
	  if(!(s2282InitArr[0][31].equals(""))){
	    mark_subtract = s2282InitArr[0][31];//扣减积分
	  }

	  //tempArr = (String[][])retList.get(32);
	  if(!(s2282InitArr[0][32].equals(""))){
	    consume_term = s2282InitArr[0][32];//消费期限
	  }

	  //tempArr = (String[][])retList.get(33);
	  if(!(s2282InitArr[0][33].equals(""))){
	    mon_base_fee = s2282InitArr[0][33];//月底线
	  }	  	 	  	  

	  //tempArr = (String[][])retList.get(34);
	  if(!(s2282InitArr[0][34].equals(""))){
	    prepay_fee = s2282InitArr[0][34];//预存总金额
	  }	  	  

	  //tempArr = (String[][])retList.get(37);
	  if(!(s2282InitArr[0][37].equals(""))){
	    print_note = s2282InitArr[0][37];//广告词
	  }		  
	 } 
	  else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>全球通签约送礼冲正</title>
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
   	//core.rpc.onreceive = doProcess;
   	self.status="";
   }

//--------1---------doProcess函数----------------
 
  function doProcess(packet)
  {
    var vRetPage=packet.data.findValueByName("rpc_page");
    
    if(vRetPage == "qryCus_s2284Init")
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

    var gift_grade      = packet.data.findValueByName("gift_grade"     );
    var gift_code       = packet.data.findValueByName("gift_code"      );
    var gift_name       = packet.data.findValueByName("gift_name"      );
    var deposit_fee     = packet.data.findValueByName("deposit_fee"    );
    var base_fee        = packet.data.findValueByName("base_fee"       );
    var free_fee        = packet.data.findValueByName("free_fee"       );
    var mark_subtract   = packet.data.findValueByName("mark_subtract"  );
    var consume_term    = packet.data.findValueByName("consume_term"   );
    var mon_base_fee    = packet.data.findValueByName("mon_base_fee"   );
    var prepay_fee      = packet.data.findValueByName("prepay_fee"     );
				
		if(retCode == 000000)
		{
		document.all.i1.value = document.all.phoneNo.value;
		document.all.i2.value = cust_id;
		document.all.i16.value = rate_code;
    document.frm.ip.value= next_rate_code;							
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
				
		document.all.Gift_Grade.value = gift_grade;
		document.all.Gift_Code.value = gift_code;		
		document.all.Gift_Name.value = gift_name;
		document.all.Deposit_Fee.value = deposit_fee;
		document.all.Free_Fee.value = free_fee;		
		document.all.Base_Fee.value = base_fee;
		document.all.Mark_Subtract.value = mark_subtract;	
		document.all.Consume_Term.value = consume_term;		
		document.all.Mon_Base_Fee.value = mon_base_fee;
		document.all.Prepay_Fee.value = prepay_fee;
		document.all.Consume_Term.value = consume_term;

		document.all.do_note.value = document.all.phoneNo.value+"全球通签约送礼冲正，礼品代码："+document.all.Gift_Code.value;
 		document.frm.iAddStr.value=document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.backaccept.value+"|"+
	                        document.frm.Gift_Name.value+"|";;
		}else
			{
				rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
				return;
			}    
  	}
   	
 }

  function frmCfm()
  {
         if(!checkElement(document.frm.phoneNo)) return;
 		document.frm.iAddStr.value=document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        document.frm.Mark_Subtract.value+"|"+document.frm.Consume_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.backaccept.value+"|"+
	                        document.frm.Gift_Name.value+"|";;

		    frm.submit();
                  
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
	<div id="title_zi">业务信息</div>
</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">

	<table cellspacing="0">
		<tr>
			<td class=blue>手机号码</td>
            <td >
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td> 
			<td class="blue">机主姓名</td>
			<td>
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
            			<input type="text" class="InputGrey" name="Gift_Code" value="<%=gift_code%>">
				<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="" readonly>
			</td>            
		</tr>
		
		<tr> 
			
            
				<input name="Gift_Grade" type="hidden" class="InputGrey" id="Gift_Grade" value="<%=gift_grade%>" readonly >
           
            <td class="blue">
            	礼品描述
            </td>
            <td>
				<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" value="<%=gift_name%>" readonly>
			</td>
			<td class="blue">
				底线预存
			</td>
            <td>
				<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly value="<%=base_fee%>">
			</td>  
		</tr>
		
				<input name="Deposit_Fee" type="hidden" class="InputGrey" id="Deposit_Fee" readonly value="<%=deposit_fee%>">
			
		<tr> 
            <td class="blue">
            	活动预存
            </td>
            <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
			</td>
			<td class="blue">
				扣减积分
			</td>
            <td>
				<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"  value="<%=mark_subtract%>" readonly>
			</td>             
		</tr>
		<tr> 
            <td class="blue">
            	消费期限
            </td>
            <td>
            	<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"  value="<%=consume_term%>" readonly>
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
            	预存总金额
            </td>
            <td colspan="3">
            	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>"  readonly>
			</td>
		</tr>
		<tr id="footer"> 
			<td colspan="4"> 
				<input name="commit" id="commit" type="button" class="b_foot"   value="下一步" onClick="frmCfm();">
                <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="2284">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="opName" value="<%=opName%>">
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
			<input type="hidden" name="ip" 	value="<%=next_rate_code%>">		

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
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"全球通签约送礼冲正">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">			
			<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			
			<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">		
			
			<input type="hidden" name="beforeOpCode" value="2283">	
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">		
			
			<input type="hidden" name="return_page" value="/npage/bill/f2284_1.jsp">			
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
