<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.04
 模块: 动感地带地盘护照申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	//==============================获取营业员信息

    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");
 	String opCode  =request.getParameter("busyType");
	String opName = "";
	String readType ="";
	String sqlInpoint = "";
	String inpointTemp = "";
	
	if(opCode.equals("2285")){
		opName="动感地带地盘护照申请";
	}else{
		opName="动感地带地盘护照申请冲正";
		readType="readonly";
	}

    
	//=======================获得操作流水
	String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	printAccept = seq;
	String exeDate="";
	exeDate = getExeDate("1","3530");
	
    String [] inParas = new String[3];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	
	//String[] ret = impl.callService("s2285Qry",inParas,"14");
%>
	<wtc:service name="s2285Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="17">			
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>	
	</wtc:service>	
	<wtc:array id="ret"  scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	
	if (ret.length>0 && retCode.equals("000000"))
	{ 
		String custName = ret[0][2];
		String custAddress = ret[0][3];
		String icType = ret[0][4];
		String icIccid = ret[0][5];
		String smCode = ret[0][6];
		String gradeName = ret[0][7];
		String currentPoint = ret[0][8];
		String inTime = ret[0][9];
		String expTime = ret[0][10];
		String cardNo = ret[0][11];
		String vCuststatus= ret[0][12];
		String phoneNo1= ret[0][13];
		/* ningtn 哈尔滨城市通需求 */
		String cityCardNo = ret[0][16];
	/*	
		System.out.println("custName="+custName);
		System.out.println("custAddress="+custAddress);
		System.out.println("icType="+icType);
		System.out.println("icIccid="+icIccid);
		System.out.println("smCode="+smCode);
		System.out.println("belongCode="+belongCode);
		System.out.println("runCode="+runCode);
		System.out.println("vipGrade="+vipGrade);
		System.out.println("currentPoint="+currentPoint);
		System.out.println("inTime="+inTime);
		System.out.println("expTime="+expTime);
		System.out.println("cardNo="+cardNo);
*/
%>

<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>黑龙江BOSS-动感地带护照</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY onLoad="init()">
<FORM action="s2285Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">

              <table cellspacing="0">
                <tr> 
                  <td class="blue">操作类型</td>
                  <td colspan="3"> 
                    <input type="text" class="InputGrey" readonly name="opName" value="<%=opName%>" style="color:orange" size="30">
                  </td>
				</tr>
                <tr> 
                  <td class="blue">客户姓名</td>
                  <td> 
                    <input type="text" class="InputGrey" readonly name="custName" value="<%=custName%>">
                  </td>
                  <td class="blue">手机号码</td>
                  <td> 
                    <input type="text" name="phoneNo"  readonly class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td class="blue">客户地址</td>
                  <td width="39%"> 
                    <input type="text" class="InputGrey" readonly name="custAddress" value="<%=custAddress%>" size='40'>
                  </td>
                 <td class="blue">业务品牌</td>
                  <td> 
                    <input type="text"  class="InputGrey" readonly name="smCode" value="<%=smCode%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td class="blue">证件类型</td>
                  <td> 
                    <input type="text" name="icType"  readonly class="InputGrey" value="<%=icType%>">
                  </td>  
				  <td class="blue">证件号码</td>
                   <td> 
                    <input type="text" class="InputGrey" readonly name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                 <tr> 
                  <td class="blue">动感地带级别</td>
                  <td> 
                    <input type="text"  class="InputGrey" readonly name="gradeName" value="<%=gradeName%>">
                  </td>
                  <td class="blue">当前积分</td>
                 <td> 
                    <input type="text" class="InputGrey" readonly name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr> 
					<td class="blue">运行状态</td>
                  <td colspan="3"> 
					<input type="text"  class="InputGrey" readonly name="vCuststatus" value="<%=vCuststatus%>">  
					</td>
				  </tr>
				<tr> 
                  <td class="blue">护照卡号</td>
                  <td colspan="3"> 
                    <input type="text" name="cardNo" id="cardNo" value="<%=readType%>" 
                    	maxlength='9' <%=readType%> v_type="0_9" v_minlength="9" onblur="checkElement(this)">
                    <font color="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">入会时间</td>
                  <td> 
                    <input type="text"  name="inTime" value="" <%=readType%>>
                  </td>
                  <td class="blue">会员有效期至</td>
                  <td> 
                    <input type="text" name="expTime"  value="" <%=readType%>>
                  </td>
                </tr>
                <tr id="dnCityRow" style="display:none;">
                	<td class="blue">动感城市通卡</td>
                	<td colspan="3">
                		<input type="text" name="dnCityCardNo" id="dnCityCardNo"
                		 <%=readType%> maxlength="12" v_type="0_9" v_minlength="12" onblur="checkElement(this)"/>
                		<font color="orange">*</font>
                	</td>
                </tr>
				<tr> 
                  <td class="blue">备注</td>
                  <td colspan="3"> 
                  <input type="text"  class="InputGrey"  name="opNote" value="" size='60' readOnly>
				  </td>
                </tr>
				<tr> 
            	<td colspan='4'>
				<div align="center" id="footer"> 
	     		<input type="button" name="print" class="b_foot" value="确认&打印" onClick="doprint()"   >
                <input type="button" name="return1" class="b_foot" value="返回" onClick="history.go(-1)">
                <input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
        </tr>
			</table>
		  <%@ include file="/npage/include/footer.jsp" %>   

</FORM>
<script language="JavaScript">
<!--
function init()
{
	
	if("<%=opCode%>"=="2285"){
	
		document.frm.inTime.value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
		document.frm.expTime.value='<%=exeDate%>';	
	}else {
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		/* ningtn 哈尔滨市城市通需求 */
		var cityCardNo = "<%=cityCardNo%>";
		$("#dnCityCardNo").val(cityCardNo);
	}
	//哈尔滨市城市通需求 ningtn
	var reg = "<%=regionCode%>";
	if(reg != "01"){
		$("#dnCityRow").hide();
	}else{
		$("#dnCityRow").show();
	}
}

function doprint()
{
	getAfterPrompt();
	if(document.frm.opCode.value=="2285"){
		if(document.frm.cardNo.value==""){
			
			rdShowMessageDialog("请输入卡号!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if(document.frm.cardNo.value.length !=9){
			rdShowMessageDialog("请输入卡号!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		var cardNoObj = $("#cardNo");
		if(!checkElement(cardNoObj[0])){
			showTip(cardNoObj[0],"必须为9位数字");
			return false;
		}
		if(cardNoObj.val().trim() == "null" || cardNoObj.val().trim().length == 0){
			showTip(cardNoObj[0],"必须输入");
			return false;
		}
		//哈尔滨市城市通需求 ningtn
		var reg = "<%=regionCode%>";
		if(reg == "01" && "<%=opCode%>"=="2285"){
			var dnCityNoObj = $("#dnCityCardNo");
			if(!checkElement(dnCityNoObj[0])){
				showTip(dnCityNoObj[0],"必须为12位数字");
				return false;
			}
			if(dnCityNoObj.val().trim() == "null" || dnCityNoObj.val().trim().length == 0){
				showTip(dnCityNoObj[0],"必须输入");
				return false;
			}
		}
	}

	

	document.all.print.disabled=true;	

	//打印工单并提交表单
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
	document.all.print.disabled=false;
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
	var sysAccept="<%=printAccept%>";                          // 流水号
	var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
	var mode_code=null;                                        //资费代码
	var fav_code=null;                                         //特服代码
	var area_code=null;                                        //小区代码
	var opCode="<%=opCode%>";                                  //操作代码
	var phoneNo=document.frm.phoneNo.value;                    //客户电话
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
  }

 function printInfo()
  {
	if(document.frm.opNote.value==""){
		document.frm.opNote.value="操作员"+"<%=workname%>"+"对用户"+document.frm.custName.value+"进行动感地带护照"+" <%=opName%>"
	}
	var cust_info="";
	var opr_info=""; 
	var note_info1=""; 
	var note_info2=""; 
	var note_info3=""; 
	var note_info4=""; 
	var retInfo = ""; 
	
	cust_info+="手机号码："+document.frm.phoneNo.value+"|";
	cust_info+="客户姓名："+document.frm.custName.value+"|";
	cust_info+="客户地址："+document.frm.custAddress.value+"|";
	cust_info+="证件号码："+document.frm.icIccid.value+"|";
	
	opr_info+="用户品牌："+document.frm.smCode.value + "|";
	opr_info+="办理业务：动感地带护照" +"<%=opName%>"+"|";
	opr_info+="动感地带级别："+"<%=gradeName%>";
	if(document.frm.opCode.value=="2285"){
		opr_info+="注册日期："+document.frm.inTime.value+"|";
		opr_info+="有效期至："+document.frm.expTime.value+"|";
	}else{
		opr_info+="办理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	}
	opr_info+="护照号码："+document.frm.cardNo.value+"|";
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	retInfo+=""+"|";
	  
	return retInfo;
  }
  function frmCfm(){
	document.frm.action="s2285Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		history.go(-1);
	 </script>
<% } %>



