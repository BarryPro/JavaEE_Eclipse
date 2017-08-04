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
  
  String  retFlag="",retMsg="";  
  String  bp_name="",sm_code="",rate_code="",sm_name="",bigCust_flag="",bigCust_name="";
  String  rate_name="",next_rate_code="",next_rate_name="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  imain_stream="",next_main_stream="",group_type_code="",group_type_name="";
  String  card_no="",print_note="",hand_fee="",favorcode="";
  String  oSaleName="",oSaleCode="",oModeCode="";
  String  omodename="",oColorMode="",oColorName="",oNextMode="";
  String  oBeginTime="",oEndTime="",oPayMoney="";
 
  
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
	System.out.println("opCode === "+ iOpCode);
	
  //retList = co.callFXService("s7978Init", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s7978Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="39">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>	
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="36"  scope="end"/>
	<wtc:array id="result0"  start="36" length="1" scope="end"/>
<%
  String errCode = retCode1;
  String errMsg = retMsg1;
	String[][] KinNos= new String[][]{};
	//co.printRetValue();
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s7978Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
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
	 
	    oModeCode = tempArr[0][25];//主资费代码
	 
	    omodename = tempArr[0][26];//主资费名称
	 
	    oColorMode = tempArr[0][29];//亲情资费代码
	  
	    oColorName = tempArr[0][30];//亲情资费名词
	 
	    oPayMoney = tempArr[0][31];//
	
	    oBeginTime = tempArr[0][32];//开通时间
	 
	    oEndTime = tempArr[0][33];//结束时间
	    
		oNextMode = tempArr[0][35]; //取消后资费代码
	 		  
	 	KinNos = result0;  //亲情号码
	 } 
	else{%>
	 <script language="JavaScript">
	<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  		//window.location="f7960_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  	 history.go(-1);
  	//-->
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
 }
  
  //--------2---------验证按钮专用函数-------------
 

  function frmCfm()
  {
  		//document.all.i16.value=document.all.Mode_Code.value;
  		if(document.frm.opNote.value=="")
     	document.frm.opNote.value="用户取消了神州行助老爱心卡业务";
  		 //getAfterPrompt();
        if(!checkElement(document.all.phoneNo)) return;
        document.frm.iAddStr.value=document.all.Next_Mode.value+"|"+document.frm.Mode_Code.value+"|"+document.frm.kin_mode.value+"|"+""+"|"+document.all.opNote.value+"|"+""+"|";
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
			<div id="title_zi">用户信息</div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	

	<table cellspacing="0">
		<tr>
			<td width="15%" class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td> 
			<td width="15%" class="blue">机主姓名</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>                    
			</td>           
		</tr>
		<tr> 
			<td width="15%" class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td width="15%" class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>            
		</tr>
	</table>
</div>
		
<div id="Operation_Table"> 
	<div class="title">
	<div id="title_zi">业务明细</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY> 
		<tr>	
			<td width="15%" class="blue">
				主资费代码
			</td>
            <td>
				<input name="Mode_Code" type="text" class="InputGrey" id="Mode_Code" readonly value="<%=oModeCode%>">
			</td>  
			<td width="15%" class="blue">
				主资费名称
			</td>
			<td>
				<input name="Mode_Name" type="text" class="InputGrey" id="Mode_Name" readonly value="<%=omodename%>">
		</tr>	
		<tr> 
     	 <td width="15%" class="blue">
       		 亲情号资费代码
      	</td>
      		<td>
				<input name="kin_mode" type="text" class="InputGrey" id="kin_mode"  value="<%=oColorMode%>" readonly>
			</td>
			<td width="15%" class="blue">
			亲情号资费名称
			</td>
            <td>
				<input name="kin_name" type="text" class="InputGrey" id="kin_name"  value="<%=oColorName%>" readonly>
			</td>             
		</tr>
		<tr>	
            <td width="15%" class="blue">
            	业务开通日期
            </td>
            <td>
            	<input type="text" name="Begin_Time" id="Begin_Time" value="<%=oBeginTime%>" readonly class="InputGrey">
			</td>            
            <td width="15%" class="blue">
            	业务到期日期
            </td>
            <td>
				<input name="End_Time" type="text" class="InputGrey" id="End_Time" value="<%=oEndTime%>" readonly>
			</td>
		</tr>	
		<tr>
			<td width="15%" class="blue">
				取消后资费代码
			</td>
			<td colspan=3>
				<input name="Next_Mode" type="text" class="InputGrey" id="Next_Mode"  value="<%=oNextMode%>" readonly>    
        		<input name="opNote" type="hidden" class="button" id="opNote" maxlength=30>
			</td>
        </tr>
          	<tr>
          	<td align=left width="15%" class="blue">
				 已有亲情号码
			</td>
			<TD colspan=3 align=left class="InputGrey">
			<% 
			 for(int j=0;j<KinNos.length;j++){         	
			%>	
			<%=KinNos[j][0]%>&nbsp;&nbsp; 
			<%
			 }
			%>
			</TD>	
		</tr>
		<tr> 
			<td colspan="4" id="footer"> 
				<div align="center"> 
                &nbsp; 
				<input name="commit" id="commit" type="button" class="b_foot"  value="确认" onClick="frmCfm();" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 
				</div>
			</td>
		</tr>
	</table>
</div>
<div name="licl" id="licl">			
			<input type="hidden" name="opCode" value="7978">
			<input type="hidden" name="iOpCode" value="7978">
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
			<input type="hidden" name="ip" 	value="<%=oNextMode%>">		

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
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>：用户取消了神州行助老爱心卡业务">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">			
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">			
			<input type="hidden" name="i20" value="<%=hand_fee%>">	
			<input type="hidden" name="beforeOpCode" value="7960">	
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">		
			
			<input type="hidden" name="return_page" value="/npage/bill/f7977Login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">	
				
</div>				
			<%@ include file="/npage/include/footer.jsp" %>        	
</form>
</body>
</html>
