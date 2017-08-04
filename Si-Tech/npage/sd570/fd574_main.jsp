<%
/********************
 version v2.0
 开发商: si-tech
 模块: 取消欢乐家庭
 create by wanglma 20110429
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  String opCode = request.getParameter("opCode");
  String opName = "取消欢乐家庭";
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String passWord = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String phoneNo = request.getParameter("activePhone"); /* 家长号码*/
  String[][] famArr = new String[][]{};
  String fuNo = "";
  String tdNo = "";
  /* 流水 */
  String printAccept="";
  printAccept = getMaxAccept();
  String   custName ="",  custAddr="",mainFeeId="", opMainFeeId="", idCardType="",  idCardNo="", custType="",  smName ="",  localName="",  mainFee="",  combo ="", opMainFee="", opFeeType="";
  /* ningtn 欢乐家庭 */
  String isBuyTd = "0";
%>
    <wtc:service name="sd574Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="14">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>	
			<wtc:param value="<%=opCode%>"/>		
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=passWord%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="取消欢乐家庭"/>		
			</wtc:service>
    <wtc:array id="resultArr" scope="end" start="0" length="13" />
    <wtc:array id="resultArr2" scope="end" start="13" length="1" />
<%
   
   if(resultArr.length > 0){
      custName = resultArr[0][7]; //名称
      custAddr = resultArr[0][8]; //地址
      idCardType = resultArr[0][9];//证件类型
      idCardNo = resultArr[0][10]; //证件号码
      smName = resultArr[0][5];  //卡品牌
      /* 无用，删除
      custType = resultArr[0][13]; //客户类型
      */
      localName = resultArr[0][11];//归属地
      mainFeeId = resultArr[0][1]; //成员当前主资费ID
      mainFee = resultArr[0][2];//成员当前主资费
      combo = resultArr[0][12]; //套餐类型
   }
   System.out.println("========ningtn======= :" + resultArr2.length);
   if(resultArr2.length > 0){
   		//是否购买了TD固话，isBuyTd 1购买，0没购买
   		for(int isBuyIter = 0; isBuyIter < resultArr2.length; isBuyIter++){
   		System.out.println("========ningtn======= :" + resultArr2[isBuyIter][0]);
   			if("1".equals(resultArr2[isBuyIter][0])){
   				isBuyTd = "1";
   			}
   		}
   }
   
   for(int i=0;i<resultArr.length;i++){
     if("TD号码".equals(resultArr[i][6])){
        tdNo = resultArr[i][0] ;
     }else if("副卡号码".equals(resultArr[i][6])){
       	fuNo = resultArr[i][0] ;
     }
   }
   if(!"000000".equals(retCode)){
      %>
        <script language="javascript">
        	rdShowMessageDialog("操作失败！errCode: <%=retCode%>   errMsg: <%=retMsg%>",0);
        	window.location="fd570.jsp?opCode=d574&activePhone=<%=phoneNo%>&opName=<%=opName%>";
        </script>
      <%
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>退出欢乐家庭</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">

<!--
  //定义应用全局的变量

  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }

 function printCommitOne(subButton){
 	/* ningtn 欢乐家庭 增加校验 */
 	if("<%=isBuyTd%>" == "1"){
	 	if(!checkElement(document.frm.phonePrice)){
			return false;
		}
	}else{
		$("#phonePrice").val("0");
	}

 	getAfterPrompt();
	//controlButt(subButton);//延时控制按钮的可用性
	subButton.disabled = true;
 	document.frm.action = "fd574_cfm.jsp";
	//打印工单并提交表单
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
	{
		frmCfm();
	}else{
		subButton.disabled = false;
	}
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=printAccept%>";                            // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=opCode%>";                                  //操作代码
		var phoneNo="<%=phoneNo%>";                 //客户电话

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		var count=0;
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容

		cust_info+="手机号码："+$("#phoneNo").val()+"|";
		cust_info+="客户姓名："+$("#custName").val()+"|";

		
		opr_info+="业务类型: 办理退订欢乐家庭业务|";
		opr_info+="欢乐家庭主卡移动电话号码："+$("#phoneNo").val()+"|";
		opr_info+="欢乐家庭主卡客户名称："+$("#custName").val()+"|";
		opr_info+="欢乐家庭手机副卡号码：<%=fuNo%>|";
		opr_info+="欢乐家庭TD固话号码：<%=tdNo%>|";
		opr_info+="<%=phoneNo%>号码办理解散家庭，自次月起将不再享受欢乐家庭优惠套餐。|";
		opr_info+="移动手机号码退订欢乐家庭业务后，将按照神州行畅听卡资费标准收取。|";
		opr_info+="TD固话号码退订欢乐家庭业务后将按照新资费标准收取：0月租、0元来电显示，5元彩铃必|";
		opr_info+="选，10元底线（含市话和国内长途点对点短信。）小区内市话首三分钟0.2元,超过后0.1元/分钟，拨打国内长途0.25元/分钟(不含港澳台 )，本地被叫免费。小区外主叫0.25元/分钟，被叫免国内长途0.6元/分钟(不含港澳台)，其他按现行标准资费收取。|";
 		note_info1+="您办理的退订欢乐家庭套餐当月办理次月生效。自下月起，将结束家庭内统一缴费并统一付费业务，同时不再享受家庭内通话免费资费、所有号码将按照新资费标准收取。预存专款未到期则不再按月返还，视为客户主动放弃。|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

//-->
//事中提示

$(document).ready(function(){
	var phoneTrObj = $("#phonePriceTr");
	var isBuyTdVal = "<%=isBuyTd%>";
	if(isBuyTdVal == "1"){
		phoneTrObj.show();
	}else{
		phoneTrObj.hide();
	}
});

</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

     <table>
	<tr>
		<td class="blue" width="20%">
			客户号码
		</td>
		<td width="30%">
			<input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			客户名称
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=custName%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			客户地址
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=custAddr%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			证件类型
		</td>
		<td width="30%">
			<input name="idCardType" id="idCardType" type="text" class="InputGrey" value="<%=idCardType%>" readonly>
		</td>
		<td class="blue" width="20%">
			证件号码
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=idCardNo%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			品牌名称
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=smName%>" readonly>
		</td>
		<td class="blue" width="20%">
			号码归属地
		</td>
		<td width="30%">
			<input type="text" name="localName" id="localName" size="40" value="<%=localName%>" v_must="1" class="InputGrey" readonly>
		</td>	
	</tr>
	<tr>
		<td class="blue" width="20%">
			当前主资费
		</td>
		<td width="30%">
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="40" value="<%=mainFee%>" readonly>
		</td>
		<td class="blue">
			办理套餐类型
		</td>
		<td>
			<input name="combo" id="combo" type="text" class="InputGrey" size="40" value="欢乐家庭<%=combo%>套餐" readonly>
		</td>
	</tr>
	<tr id="phonePriceTr">
		<td class="blue">补手机款</td>
		<td colspan="3">
			<input name="phonePrice" id="phonePrice" type="text" size="40" value="" v_type="money" v_must="1" />
		</td>
	</tr>
	
</table>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">业务明细</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY>
		  <tr>
			<tr>
		      <th align=center>手机号码</th>
		      <th align=center>号码类型</th>
			  <th align=center>套餐类型</th>
			  <th align=center>生效时间</th>
			  <th align=center>失效时间</th>
			</tr>
			<%
			 for(int j=1;j<resultArr.length;j++){
			%>
		    <tr>
			  <TD align=center class="Grey"><%=resultArr[j][0]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][6]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][1]%>--<%=resultArr[j][2]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][3]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][4]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	<table>
		  <tr>
            <td colspan="4" id="footer"> <div align="center">
                &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="printCommitOne(this)" >
                &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;
				</div>
			</td>
          </tr>
      </table>
      

    <input type="hidden" name="opCode" value="<%=opCode%>"  />
    <input type="hidden" name="phoneNo" value="<%=phoneNo%>"  />
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
