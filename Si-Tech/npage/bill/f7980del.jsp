<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划变更
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%              
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  	/****得系统流水****/
	String printAccept="";		
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
  	printAccept = sLoginAccept; 
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
<title>亲情号码删除</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  onload=function()
  {		
  }
  
  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //***
  function printfrmCfm(){
  	getAfterPrompt();
  	if(document.all.kin_nos.value.length==0)
  	{
  		rdShowConfirmDialog('请选择至少一条要删除的亲情号码！');
  	}
	else
	{
	  	//alert(document.all.friend_no.value+"|"+document.all.fam_prod_id.value+"|"+document.all.pay_fee.value);
	  	setOpNote();//为备注赋值
	  	document.frm.action="f7979_Cfm.jsp";
	 	 var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	    if(typeof(ret)!="undefined")
	    {
	      if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
	        {
		      frmCfm();
	        }
		  }
		  if(ret=="continueSub")
		  {
	        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	        {
		      frmCfm();
	        }
		  }
	    }
	    else
	    {
	       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	       {
		     frmCfm();
	       }
	    }
	}    	
	return true;
  }

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept=<%=printAccept%>;                            // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=opCode%>";                                  //操作代码
		var phoneNo=document.frm.phoneNo.value;                 //客户电话
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
		
		cust_info+="手机号码："+"<%=iPhoneNo%>"+"|";
		cust_info+="客户姓名："+"<%=bp_name%>"+"|";
		
		
		opr_info+="用户品牌："+document.all.oSmName.value+"  "+"办理业务：神州行助老爱心卡亲情号码删除"+"|";
		opr_info+="操作流水："+"<%=printAccept%>"+"|";		
		
		opr_info+="删除的亲情号码为："+document.frm.kin_nos.value+"|";
		
		opr_info+="生效时间： "+"当日"+"|";
		note_info1+="备注："+"|";
		note_info1+="每月删除亲情号码的数量只能是4次，即每月最多可删除4个亲情号码；"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
  } 
 function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "操作员：<%=loginNo%>完成了亲情号码删除操作"; 
	}
	return true;
}

/**复选框全部选中**/
function doSelectAllNodes(){
	document.all.confirm.disabled=false;
	var regionChecks = document.getElementsByName("regionCheck");
	for(var i=0;i<regionChecks.length;i++){
		regionChecks[i].checked=true;
	}
	doChange();	
}

/**取消复选框全部选中**/
function doCancelChooseAll(){
	document.all.confirm.disabled=true;
	var regionChecks = document.getElementsByName("regionCheck");
	for(var i=0;i<regionChecks.length;i++){
		regionChecks[i].checked=false;
	}
	doChange();				
}
function doChange()
{				
	document.all.confirm.disabled=false;
	var regionChecks = document.getElementsByName("regionCheck");
	var impCodeStr = "";
	var regionLength=0;
	for(var i=0;i<regionChecks.length;i++){		
		if(regionChecks[i].checked){
		var impValue = regionChecks[i].value;
			var impArr = impValue.split("|");
			if(regionLength==0){
				impCodeStr = impArr[0];			
			}else{
				impCodeStr += (","+impArr[0]);									
			}
			regionLength++;
		}						
	}	
	document.all.kin_nos.value=impCodeStr;
	if(document.all.kin_nos.value.length==0)
	{
		document.all.confirm.disabled=true;
	}	
}

//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>

      <table cellspacing="0">
          <tr>
			<td align="center" width="15%" class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td> 
			<td align="center" width="15%" class="blue">机主姓名</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>                    
			</td>           
		</tr>
		<tr> 
			<td align="center" width="15%" class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td align="center" width="15%" class="blue">资费名称</td>
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
			<td align="center" width="15%" class="blue">
				主资费代码
			</td>
            <td>
				<input name="Mode_Code" type="text" class="InputGrey" id="Mode_Code" readonly value="<%=oModeCode%>">
			</td>  
			<td align="center" width="15%" class="blue">
				主资费名称
			</td>
			<td>
				<input name="Mode_Name" type="text" class="InputGrey" id="Mode_Name" readonly value="<%=omodename%>">
		</tr>	
		<tr> 
     	 <td align="center" width="15%" class="blue">
       		 亲情号资费代码
      	</td>
      		<td>
				<input name="kin_mode" type="text" class="InputGrey" id="kin_mode"  value="<%=oColorMode%>" readonly>
			</td>
			<td align="center" width="15%" class="blue">
			亲情号资费名称
			</td>
            <td>
				<input name="kin_name" type="text" class="InputGrey" id="kin_name"  value="<%=oColorName%>" readonly>
			</td>             
		</tr>
		<tr>	
            <td align="center" width="15%" class="blue">
            	业务开通日期
            </td>
            <td>
            	<input type="text" name="Begin_Time" id="Begin_Time" value="<%=oBeginTime%>" readonly class="InputGrey">
			</td>            
            <td align="center" width="15%" class="blue">
            	业务到期日期
            </td>
            <td>
				<input name="End_Time" type="text" class="InputGrey" id="End_Time" value="<%=oEndTime%>" readonly>
			</td>
		</tr>	
		</table>
	</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">亲情号码信息</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY> 
          	<tr> 
          	<td align="center" width="15%" class="blue">已有亲情号码</td>
          	<td width="85%" align=left class="InputGrey">	
			<% 
			 for(int j=0;j<KinNos.length;j++){        	
			%>			
				<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=KinNos[j][0]%>" onclick="doChange()">&nbsp;
				<%=KinNos[j][0]%>&nbsp;&nbsp;										
			<%	
			 	if(j > 4)
			 	{
			 		%> <br> <%
			 	}
			 }
			%>
		</td>
			</tr>
		</table>
	
		<TABLE cellSpacing="0">
          <tr>
			<td colspan=4>
				<input type="hidden" name="kin_nos" id="kin_nos">
			</td>
			</tr>	
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
            	 &nbsp; 
            	 <input type="button" name="allchoose"  class="b_foot" value="全部选择" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       		<input type="button" name="cancelAll" class="b_foot" value="取消全选" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;	
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="printfrmCfm(this)" disabled>
                 &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 				
				</div>
			</td>
          </tr>
       </table>
 <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--客户地址-->
 <input name="cardId_no" type="hidden" id="cardId_no" value="<%=cardId_no%>"> <!--证件号码-->
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
   <input type="hidden" name="stream" value="<%=printAccept%>"><!--打印流水-->
   <input name="Next_Mode" type="hidden" id="Next_Mode" value="<%=oNextMode%>" ><!--到期后资费-->
  <input type="hidden" name="phoneNo" value="<%=iPhoneNo%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
   <input type="hidden" name="regionCode" value="<%=regionCode%>">
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" > 
  <input type="hidden" name="return_page" value="/npage/bill/f7977Login.jsp?activePhone=<%=iPhoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



