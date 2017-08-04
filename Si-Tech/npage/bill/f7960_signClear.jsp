<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.1.8
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
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  
  //String paraStr[]=new String[1];
  //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>"  id="paraStr"/>
<%
   String printAccept = paraStr;
  String  retFlag="",retMsg="";  
  String  bp_name="",sm_code="",rate_code="",sm_name="",bigCust_flag="",bigCust_name="";
  String  rate_name="",next_rate_code="",next_rate_name="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  imain_stream="",next_main_stream="",favorcode="",hand_fee="";
  String  card_no="",print_note="",group_type_code="",group_type_name="";
  String  oSaleName="",oSaleCode="",omodeCode="";
  String  omodeName="",oColorMode="",oColorName="";
  String oBeginTime="",oEndTime="",oPayMoney="";
 
  
  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opCode");
  SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);
	

  //retList = co.callFXService("s7960cInit", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s7960cInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="39">			
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
	   retMsg = "s7960cInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {
	  
	    bp_name = tempArr[0][3];           //机主姓名
	 
	    bp_add = tempArr[0][4];            //客户地址
	 
	    sm_code = tempArr[0][11];         //业务类别
	
	    sm_name = tempArr[0][12];        //业务类别名称
	  
	    rate_code = tempArr[0][5];     //资费代码
	 
	    rate_name = tempArr[0][6];    //资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	
	    next_rate_name = tempArr[0][8];//下月资费名称
	    
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	    
	    hand_fee = tempArr[0][13];      //手续费
	    
	    favorcode = tempArr[0][14];     //优惠代码
	    
	    total_prepay = tempArr[0][16];//总预存
	 
	    cardId_type = tempArr[0][17];//证件类型
	  
	    cardId_no = tempArr[0][18];//证件号码
	 
	    cust_id = tempArr[0][19];//客户id
	  
	    cust_belong_code = tempArr[0][20];//客户归属id
	    
	    group_type_code = tempArr[0][21];//集团客户类型
	 
	    group_type_name = tempArr[0][22];//集团客户类型名称
	 
	    imain_stream = tempArr[0][23];//当前资费开通流水
	 
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	 
	    oSaleCode = tempArr[0][25];//营销案代码
	 
	    oSaleName = tempArr[0][26];//营销案名称
	 
	    omodeCode = tempArr[0][27];//主资费代码
	 
	    omodeName = tempArr[0][28];//主资费名称
	 
	    oColorMode = tempArr[0][29];//彩铃资费代码
	  
	    oColorName = tempArr[0][30];//彩铃资费名词
	 
	    oPayMoney = tempArr[0][31];//
	
	    oBeginTime = tempArr[0][32];//开通时间
	 
	    oEndTime = tempArr[0][33];//结束时间
	
	 
	    print_note = tempArr[0][37];//广告词
	 		  
	 } 
	else{%>
	 <script language="JavaScript">
  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);  		
  		history.go(-1); 	
  </script>
<%	
	}
%>

<head>
<title>彩铃申请冲正</title>
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
    
    if(vRetPage == "qryCus_s7960cInit")
    {    
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var bp_name        = packet.data.findValueByName("bp_name"        );
    var sm_code         = packet.data.findValueByName("sm_code"        );
   	var group_type_code = packet.data.findValueByName("group_type_code");
	var group_type_name = packet.data.findValueByName("group_type_name");
    var rate_code       = packet.data.findValueByName("rate_code"      );
    var sm_name         = packet.data.findValueByName("sm_name"        );
    var rate_name       = packet.data.findValueByName("rate_name"      );
   	var hand_fee        = packet.data.findValueByName("hand_fee"       );
	var favorcode       = packet.data.findValueByName("favorcode"      );  
    var next_rate_code  = packet.data.findValueByName("next_rate_code" );
    var next_rate_name  = packet.data.findValueByName("next_rate_name" );
   	var bigCust_name    = packet.data.findValueByName("bigCust_name"   );
    var total_prepay    = packet.data.findValueByName("total_prepay"   );
    var bp_add          = packet.data.findValueByName("bp_add"         );
    var cardId_type     = packet.data.findValueByName("cardId_type"    );
    var cardId_no       = packet.data.findValueByName("cardId_no"      );
    var cust_id         = packet.data.findValueByName("cust_id"        );
    var cust_belong_code= packet.data.findValueByName("cust_belong_code");
    var bigCust_flag    = packet.data.findValueByName("bigCust_flag"   );
    var imain_stream    = packet.data.findValueByName("imain_stream"   );
    var next_main_stream= packet.data.findValueByName("next_main_stream");
      
    var card_no         = packet.data.findValueByName("card_no"        );
    var print_note      = packet.data.findValueByName("print_note"     );
    var oSaleCode      = packet.data.findValueByName("oSaleCode"     );
    var oSaleName       = packet.data.findValueByName("oSaleName"      );
    var omodeCode       = packet.data.findValueByName("next_rate_code"      );
    var omodeName     = packet.data.findValueByName("next_rate_name"    );
    var oColorMode        = packet.data.findValueByName("oColorMode"       );
    var oColorName        = packet.data.findValueByName("oColorName"       );
       
		alert(retCode);		
		if(retCode == 000000)
		{
		document.all.i1.value = document.all.phoneNo.value;
		document.all.i2.value = cust_id;		
		document.all.belong_code.value = cust_belong_code;			
		document.all.print_note.value = print_note;			

		document.all.i4.value = bp_name;
		document.all.i5.value = bp_add;						
		document.all.i6.value = cardId_type;			
		document.all.i7.value = cardId_no;	
		document.all.i8.value = sm_code+"--"+sm_name;			

		document.all.ipassword.value = "";						
		document.all.ibig_cust.value =  bigCust_flag+"--"+bigCust_name;
		document.all.i19.value = hand_fee;
		document.all.i20.value = hand_fee;
		document.all.favorcode.value = favorcode;
		document.all.group_type.value = group_type_code+"--"+group_type_name;			
		document.all.maincash_no.value = rate_code;			
		document.all.imain_stream.value =  imain_stream;	
		document.all.next_main_stream.value =  next_main_stream;
		
		document.all.oCustName.value = bp_name;
		document.all.oSmCode.value = sm_code;
		document.all.oSmName.value = sm_name;
		document.all.oModeCode.value = rate_code;
		document.all.oModeName.value = rate_name;
		document.all.oPrepayFee.value = total_prepay;	
		//document.all.oMarkPoint.value = "0";
				
		document.all.Sale_Code.value = oSaleCode;
			
		document.all.Mode_Code.value = omodeCode;
		document.all.Mode_Name.value = omodeName;
		document.all.Color_Name.value = oColorName;		
		document.all.Color_Mode.value = oCorlorMode;
		document.all.Begin_Time.value = oBeginTime;
		document.all.End_Time.value = oEndTime;
		

		document.all.do_note.value = document.all.phoneNo.value+"彩铃申请冲正："+document.all.Sale_Code.value+"|";
	  document.frm.iAddStr.value=document.frm.backaccept.value+"|"+
	                        document.frm.Color_Mode.value+"|"+document.frm.Color_Name.value+"|"+document.frm.Mode_Name.value+"|"+
	                        document.frm.Mode_Code.value+"|";
	      //alert(document.frm.iAddStr.value);                  
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
  var myPacket = new AJAXPacket("qryCus_s7960cInit.jsp","正在查询客户，请稍候......");
	myPacket.data.add("iPhoneNo",jtrim(document.all.phoneNo.value));
	myPacket.data.add("iLoginNo",jtrim(document.all.loginNo.value));
	myPacket.data.add("iOrgCode",jtrim(document.all.orgCode.value));
	myPacket.data.add("iOpCode",jtrim(document.all.iOpCode.value));
	
	core.ajax.sendPacket(myPacket);
	myPacket=null;
  }

  function frmCfm()
  {
  		 if(document.frm.op.value=="")
     	document.frm.op.value="用户进行了彩铃营销案续签冲正操作";
  		 //getAfterPrompt();
         if(!checkElement(document.all.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.Sale_Code.value+"|"+document.frm.Color_Mode.value+"|"+document.frm.Pay_Money.value+"|"+
	                        document.frm.Begin_Time.value+"|"+document.frm.op.value+"|"+document.frm.backaccept.value+"|";
         //alert( document.frm.iAddStr.value);

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
	<form name="frm" method="post" action="f1270_3.jsp?activePhone=<%=iPhoneNo%>" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">用户信息</div>
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
			<td>
				<input name="Pay_Money" type="hidden" class="InputGrey" id="Pay_Money" value="<%=oPayMoney%>" readonly>
			</td>
			<td>
				<input type="hidden" name="Sale_Code" id="Sale_Code" value="<%=oSaleCode%>" readonly class="InputGrey">
			</td>
		</tr>
	</table>
</div>		
<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">新业务明细</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY> 		
		<tr>	
			<td class="blue">
				新主资费代码
			</td>
            <td>
				<input name="Mode_Code" type="text" class="InputGrey" id="Mode_Code" readonly value="<%=omodeCode%>">
			</td>  
			<td class="blue">
				新主资费名称
			</td>
			<td>
				<input name="Mode_Name" type="text" class="InputGrey" id="Mode_Name" readonly value="<%=omodeName%>">
		</tr>	
		<tr> 
      <td class="blue">
        	新彩铃代码
      </td>
      <td>
				<input name="Color_Mode" type="text" class="InputGrey" id="Color_Mode"  value="<%=oColorMode%>" readonly>
			</td>
			<td class="blue">
			新彩铃名称
			</td>
            <td>
				<input name="Color_Name" type="text" class="InputGrey" id="Color_Name"  value="<%=oColorName%>" readonly>
			</td>             
		</tr>
		<tr>	
            <td class="blue">
            	业务开通日期
            </td>
            <td>
            	<input type="text" name="Begin_Time" id="Begin_Time" value="<%=oBeginTime%>" readonly class="InputGrey">
			</td>            
            <td class="blue">
            	业务到期日期
            </td>
            <td>
				<input name="End_Time" type="text" class="InputGrey" id="End_Time" value="<%=oEndTime%>" readonly>
			</td>
		</tr>
		<tr>
        	<td colspan=4>
        		<input name="op" type="hidden" class="button" id="op" maxlength=30 v_must=1 v_minlength=1 v_maxlength=30 >
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
</div>
<div name="licl" id="licl">	
			<input type="hidden" name="opCode" value="7966">
			<input type="hidden" name="iOpCode" value="7966">
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
			<input type="hidden" name="ip" 	value="<%=omodeCode%>">		

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
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"彩铃续签冲正">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">			
			<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">			
			<input type="hidden" name="i20" value="<%=hand_fee%>">	
			<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">
				
			<input type="hidden" name="beforeOpCode" value="7965">	
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">		
			
			<input type="hidden" name="return_page" value="/npage/bill/f7960_login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">	
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
</div>			
			<%@ include file="/npage/include/footer.jsp" %>        	
</form>
</body>
</html>
