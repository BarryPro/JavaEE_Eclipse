        

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=GB2312" %>

<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	//==============================获取营业员信息
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	  String regionCode = (String)session.getAttribute("regCode");
	

	
	String phoneNo = request.getParameter("phoneNo");
 	String opCode  =request.getParameter("busyType");
 	String clubType  =request.getParameter("clubType");
	String opName = "";
	String readType ="";
	String sqlInpoint = "";
	String[][] InpointStrTemp = new String[][]{};
	String inpointTemp = "";
	
	if(opCode.equals("3530")){
		opName="入会";
		if(clubType.equals("01"))
			sqlInpoint = "select favour_point from smarkfavcode where favour_code='CL01' and sm_code='gn' and region_code='"+regionCode+"'";
		else if(clubType.equals("02"))
			sqlInpoint = "select favour_point from smarkfavcode where favour_code='YM01' and sm_code='gn' and region_code='"+regionCode+"'";
			
		System.out.println("  sqlInpoint="+sqlInpoint);
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlInpoint%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>
<%		
		//InpointArrTemp = coTemp.spubqry32("1",sqlInpoint);
		InpointStrTemp = result_t3;
		inpointTemp = InpointStrTemp[0][0];
		readType ="";
	}else if(opCode.equals("3538")){
		opName="换卡";
		readType="readonly";
	}else if(opCode.equals("3531")){
		opName="退会";
		readType="readonly";
	}else{
		opName="入会冲正";
		readType="readonly";
	}

    
	//=======================获得操作流水
	String printAccept="";
	printAccept = getMaxAccept();
	String exeDate="";
    exeDate = getExeDate("1","3530");
	
    String [] inParas = new String[4];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = clubType;
	//String[] ret = impl.callService("s3530Qry",inParas,"14");
%>

    <wtc:service name="s3530Qry" outnum="16" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%	
	String retCode= code1;
	String retMsg = msg1;
	
	if (result_t1 != null && code1.equals("000000"))
	{ 
		String custName = result_t1[0][2];
		String custAddress = result_t1[0][3];
		String icType = result_t1[0][4];
		String icIccid = result_t1[0][5];
		String smCode = result_t1[0][6];
		String belongCode = result_t1[0][7];
		String runCode = result_t1[0][8];
		String vipGrade = result_t1[0][9];
		String currentPoint = result_t1[0][10];
		String inTime = result_t1[0][11];
		String expTime = result_t1[0][12];
		String cardNo = result_t1[0][13];
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

<title>黑龙江BOSS-VIP俱乐部</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onLoad="init()">
<FORM action="s3530Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">会籍管理</div>
	</div>

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">


              <table  cellspacing="0">
                <tr> 
                  <td class="blue">操作类型</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="opName"  value="<%=opName%>">
                  </td>
                  <td >&nbsp;</td>
                  <td> &nbsp;
				  </td>
				  <tr id="newcardNo" style="display:none">
				  <td  class="blue">新卡号</td>
                  <td> 
					<input type="text"   name="oldcardNo"  value="">
					 <font class="orange">*</font>
                  </td>
				  <td >&nbsp;</td>
                  <td>&nbsp;</td>
				</tr>
				<tr id="oldloginAccept1" style="display:none">
				 <td  class="blue">操作流水</td>
                  <td> 
					<input type="text"   name="oldloginAccept"  value="">
					 <font class="orange">*</font>
                  </td>
				  <td ></td>
                  <td></td> 
				</tr>
                <tr> 
                  <td class="blue">客户姓名</td>
                  <td> 
                    <input type="text"  readonly   Class="InputGrey" name="custName" value="<%=custName%>">
                  </td>
                  <td class="blue">手机号码 </td>
                  <td> 
                    <input type="text" name="phoneNo"  readonly  Class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td class="blue">客户地址</td>
                  <td> 
                    <input type="text"  readonly  size="38" Class="InputGrey" name="custAddress" value="<%=custAddress%>">
                  </td>
                 <td class="blue">业务品牌</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="smCode" value="<%=smCode%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td class="blue">证件类型 </td>
                  <td> 
                    <input type="text" name="icType"  readonly   Class="InputGrey"  value="<%=icType%>">
                  </td>  
				  <td class="blue">证件号码</td>
                   <td> 
                    <input type="text"  readonly   Class="InputGrey" name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                <tr id="phoneId"> 
                  <td class="blue">归属地市</td>
                  <td> 
                    <input type="text" readonly   Class="InputGrey"  name="belongCode" value="<%=belongCode%>" >
                  </td>
                  <td class="blue">运行状态</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="runCode" value="<%=runCode%>">
                  </td>
                </tr>
                 <tr   nowrap> 
                  <td class="blue">VIP级别</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="vipGrade" value="<%=vipGrade%>">
                  </td>
                  <td class="blue">当前积分</td>
                  <td> 
                    <input type="text"  readonly   Class="InputGrey" name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr   nowrap> 
                  <td class="blue">入会时间</td>
                  <td> 
                    <input type="text"    name="inTime" value="" <%=readType%>>
                  </td>
                  <td class="blue">会员有效期至</td>
                  <td> 
                    <input type="text"   name="expTime"  value="" <%=readType%>>
                  </td>
				  </tr>
				<tr   nowrap> 
                  <td class="blue">会员卡号</td>
                   <td colspan="3" width="86%"> 
                    <input type="text"    name="cardNo" value=""  maxlength="8" <%=readType%>>
                    <input type="hidden"    name="clubType" value="<%=clubType%>">
                  </td>     
				  </tr>

                <tr nowrap> 
                  <td class="blue">备注</td>
                  <td colspan="3" width="86%"> 
                    <input type="text"  name="opNote" value=""  size="80"  readonly   Class="InputGrey">
				  </td>
                </tr>
				<tr> 
            <td noWrap colspan="6" id="footer">
				<div align="center"> 
	     		<input type="button" name="print"  value="确认&打印" onClick="doprint()"  class="b_foot_long" >
                      &nbsp;
                <input type="button" name="return1"  value="返回" onClick="history.go(-1);" class="b_foot">
                      &nbsp; 
                <input type="button" name="close1"  value="关闭" onClick="removeCurrentTab()" class="b_foot">
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
	if("<%=opCode%>"=="3530"){
		document.frm.inTime.value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
		document.frm.expTime.value='<%=exeDate%>';
		document.frm.oldloginAccept.style.display="none";
		document.frm.oldcardNo.style.display="none";
		
	}else if("<%=opCode%>"=="3531"){
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
	}else if("<%=opCode%>"=="3537"){
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		document.all.oldloginAccept1.style.display="block";
		document.all.newcardNo.style.display="none";
	}else{
		//alert("dddddddddd");
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		document.all.newcardNo.style.display = "block";
		
		document.all.oldloginAccept1.style.display = "none" ;
	
	}

}

function doprint()
{
	getAfterPrompt();
	if(document.frm.opCode.value=="3530"){
		if(document.frm.cardNo.value==""){
			
			rdShowMessageDialog("请输入卡号!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if(document.frm.cardNo.value.length !=8){
			rdShowMessageDialog("请输入卡号!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if("<%=inpointTemp%>" -document.frm.currentPoint.value>0){
			rdShowMessageDialog("用户积分不足!");
	 	    return false;
		
		}
	}else if(document.frm.opCode.value=="3531"){
		
	}else if(document.frm.opCode.value=="3537"){
		if(document.frm.oldloginAccept.value==""){
			rdShowMessageDialog("请输入操作流水!");
	 	    document.frm.oldloginAccept.focus();
	 	    return false;
		}
	}else{
		if(document.frm.oldcardNo.value==""){
			rdShowMessageDialog("请输入新卡号!");
	 	    document.frm.oldcardNo.focus();
	 	    return false;
		}
		if(document.frm.oldcardNo.value.length !=8){
			rdShowMessageDialog("请输入新卡号!");
	 	    document.frm.oldcardNo.focus();
	 	    return false;
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
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
	 //alert(printStr);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=printAccept%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = "<%=phoneNo%>";                            //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){ 	
	  	document.frm.opNote.value="操作员"+"<%=workname%>"+"对用户"+document.frm.custName.value+"进行VIP俱乐部"+" <%=opName%>"
	  }
	    	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		

	  var retInfo = "";
      cust_info+="客户姓名：" +document.frm.custName.value+"|";
      cust_info+="手机号码："+document.frm.phoneNo.value+"|";
      cust_info+="客户地址："+document.frm.custAddress.value+"|";
      cust_info+="证件号码："+document.frm.icIccid.value+"|";
      opr_info+="用户品牌： "+document.frm.smCode.value + "|";
      opr_info+="VIP级别："+document.frm.vipGrade.value+"|";
	  opr_info+="办理业务VIP俱乐部： " +"<%=opName%>"+"|";
	  opr_info+="入会日期："+document.frm.inTime.value+"|";
	  if(document.frm.opCode.value=="3530"){
      opr_info+="有效期至："+document.frm.expTime.value+"|";
	  opr_info+="扣减积分："+"<%=inpointTemp%>"+"|";
      opr_info+="俱乐部卡号："+document.frm.cardNo.value+"|";
	  }else if(document.frm.opCode.value=="3531"){
	  opr_info+="退会日期："+'<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  }else if(document.frm.opCode.value=="3538"){
      opr_info+="原俱乐部卡号："+document.frm.cardNo.value+"|";
      opr_info+="新俱乐部卡号："+document.frm.oldcardNo.value+"|";
	  }else{
	  opr_info+="入会冲正日期："+'<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  }
	  opr_info+="操作流水： "+"<%=printAccept%>" +"|";
	  if(document.frm.opCode.value=="3530"){
	  note_info1+="备注：1、VIP俱乐部会员资格是建立在全球通VIP俱乐部会员（即全球通钻石卡、金卡、银卡客户）资格基础之上的，每年须接受一次新的资格审查并续交年费，方可延续会员资格。"+"|";
	  note_info1+="2、会员若降级为银卡以下客户或停止使用中国移动网络，则其俱乐部会员资格自动失效，俱乐部年费不退还。"+"|";
	  }
	  
		  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;
  }
  function frmCfm(){
	document.frm.action="s3530Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码'<%=retCode%>'，错误信息'<%=retMsg%>'。",0);
		window.location.href="s3530.jsp?ph_no=<%=phoneNo%>";
	 </script>
<% } %>

