<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-29
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
    String opName="换卡冲正";
    String opCode = "1221";
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String work_Pwd = (String)session.getAttribute("password");
    boolean workNoFlag=false;
        //if(workNoFromSession.substring(0,1).equals("k"))
    workNoFlag=true;
    
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
    favStr[i]=temfavStr[i][0].trim();
    boolean hfrf=false;
    for(int j=0;j<favStr.length;j++)
    System.out.println("======= favStr ======="+favStr[j]+"==============");
        //ArrayList initArr = new ArrayList();
        //ArrayList groupArr = new ArrayList();
    
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
    
    String dirtPage=request.getParameter("dirtPage"); 
%>
<%
    request.setCharacterEncoding("GBK");
    
    HashMap hm=new HashMap();
    hm.put("1","没有客户ID！");
    hm.put("3","密码错误！");
    hm.put("4","手续费不确定，您不能进行任何操作！");
    
    hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
    hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
    hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
    hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
    hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
    hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=org_Code.substring(0,2)%>"  id="seq"/>
<script language=javascript>
<!--

  //core.loadUnit("debug");
  //core.loadUnit("rpccore");
 
  onload=function()
  {
   	//core.rpc.onreceive = doProcess;
    	self.status="";

<%
	if(ReqPageName.equals("s1220Main"))
	{
	  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
	  {        
%>   	 
	    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
<%
	  }
	  else if(retMsg.equals("100"))
	  {
%>
    	rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费<%=WtcUtil.repNull(request.getParameter("oweFee"))%>元，不能办理业务！');	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
<%
	  }
	}
%>


  }






//--------3---------验证按钮专用函数-------------
 
 function chkPass(){

    /*document.s1220.submit.disabled = true;
    if(!for0_9(document.s1220.loginAccept)){
    return false;
    }*/
    if(((document.all.phoneno.value).trim()).length<1)
    {
        rdShowMessageDialog("请输入手机号码！");
        return;
    }
    if(document.s1220.loginAccept.value.length == 0){
        rdShowMessageDialog("请输入流水号！");
        return;
    }
    if(document.s1220.billDate.value.length == 0)
    {
        rdShowMessageDialog("请输入日期！");
        return;
    }
    
    var myPacket = new AJAXPacket("QryCus_Info.jsp","正在提交，请稍候......");
    
    myPacket.data.add("work_No",document.s1220.work_No.value);   
    myPacket.data.add("org_Code",document.s1220.org_Code.value); 
    myPacket.data.add("work_Pwd",document.s1220.work_Pwd.value);
    myPacket.data.add("op_code",document.s1220.op_code.value); 
    myPacket.data.add("phoneNo",document.s1220.phoneno.value);    
    myPacket.data.add("billDate",document.s1220.billDate.value);           
    myPacket.data.add("loginAccept",document.s1220.loginAccept.value);       
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}
 
 
 //--------4---------doProcess函数----------------
 
 
  function doProcess(packet)
  {
  	
  	
    var vRetPage=packet.data.findValueByName("rpcpage");
   
    if(vRetPage == "QryCus_Info"){

        var retCode = packet.data.findValueByName("retCode");
        var retMsg = packet.data.findValueByName("retMsg");
        var userId = packet.data.findValueByName("userId");
        var custName = packet.data.findValueByName("custName");
        var passWord = packet.data.findValueByName("passWord");
        var asIdtape = packet.data.findValueByName("asIdtape");
        var asIdname = packet.data.findValueByName("asIdname");
        var asIdiccid = packet.data.findValueByName("asIdiccid");
        var smTape = packet.data.findValueByName("smTape");
        var smName = packet.data.findValueByName("smName");
        var runCode = packet.data.findValueByName("runCode");
        var runName = packet.data.findValueByName("runName");
        var cardName = packet.data.findValueByName("cardName");
        var blocName = packet.data.findValueByName("blocName");
        var base_No = packet.data.findValueByName("base_No");
        var base_Name = packet.data.findValueByName("base_Name");
        var base_Date = packet.data.findValueByName("base_Date");
        var oldFee = packet.data.findValueByName("oldFee");
		var backFlag = packet.data.findValueByName("backFlag");
		var test = packet.data.findValueByName("test");
		var test1 = packet.data.findValueByName("test1");
		var test2 = packet.data.findValueByName("test2");
		var test3 = packet.data.findValueByName("test3");
		var VloginAccept = packet.data.findValueByName("VloginAccept");
		var oldsim = packet.data.findValueByName("oldsim");
		var newsim = packet.data.findValueByName("newsim");
	if(retCode == "000000"){
	    if(backFlag != "0")
		{
			rdShowMessageDialog("原始交易已经冲正!");
			return;
		}
		document.s1220.userId.value = userId;	
		document.s1220.custName.value = custName;
		document.s1220.passWord.value = passWord;
		document.s1220.asIdtape.value = asIdtape;
		document.s1220.asIdname.value = asIdname;	
		document.s1220.asIdiccid.value = asIdiccid;
		document.s1220.smTape.value = smTape;
		document.s1220.smName.value = smName;
		document.s1220.runCode.value = runCode;	
		document.s1220.runName.value = runName;
		document.s1220.cardName.value = cardName;
		document.s1220.blocName.value = blocName;
		document.s1220.base_No.value = base_No;	
		document.s1220.base_Name.value = base_Name;
		document.s1220.base_Date.value = base_Date;
		document.s1220.oldFee.value = oldFee;
		document.s1220.test.value = test;
		document.s1220.test1.value = test1;
		document.s1220.test2.value = test2;
		document.s1220.test3.value = test3;
		document.s1220.VloginAccept.value = VloginAccept;
		document.s1220.oldsim.value = oldsim;
		document.s1220.newsim.value = newsim;
		document.all.confirm.disabled=false;
		
	}else
	{
		rdShowMessageDialog("错误:"+ retCode + "->" + retMsg,0);
		return;
	}    
    }
    
    
    
    
    
  }

 

//-------2---------验证及提交函数-----------------



function go_check_simType10073(){
	    var packet = new AJAXPacket("/npage/s1170/ajax_check_simType10073.jsp","请稍后...");
        	packet.data.add("phoneNo","<%=activePhone%>");//手机号
        	packet.data.add("opCode","<%=opCode%>");//
    core.ajax.sendPacket(packet,do_check_simType10073);
    packet =null;
}
function do_check_simType10073(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
    }else{//操作成功
	    var result_flag = packet.data.findValueByName("result_flag");	
	    if(result_flag=="1"){
	    	rdShowMessageDialog("请去“m405城市通开卡代收费界面”退公交费");
	    }
    }
}

 function printCommit(){
 	
 	
/*
  	关于申请“ 移动城市通”产品新增专款、账目项及代收代付结算的函 hejwa add 2016年9月20日20:17:07
  	
  	如果SIM卡类型是‘10073--NFC城市通卡’，
		并且用户没有城市通卡可选资费(包括预约生效，预约失效)，则界面增加提示，
		提示信息为：“请去‘****城市通开卡代收费界面’退公交费”。***是操作代码。
  	*/
  	go_check_simType10073(); 	
 	
    getAfterPrompt();
	//校验newsim oldsim
    if(!checkElement(document.all.phoneno)) return false;	
   //打印工单并提交表单
   document.all.remark.value="换卡由"+ document.all.newsim.value +"换为"+document.all.oldsim.value;
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
      
    // if(typeof(ret)!="undefined")
    //{
     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {
            
	      s1220.submit();
        }
	  if(ret=="remark")
	  {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
	      s1220.submit();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     s1220.submit();
       }
    }	
    return true;
  }
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
    var h=198;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=seq%>";
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=activePhone%>";
    /* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;
  
  }

  function printInfo(printType)
  {
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    
    var retInfo = "";
    //retInfo+='<%=loginName%>'+"|";
    //retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; 
    cust_info+="客户姓名："+document.all.custName.value+"|";
    cust_info+="手机号码："+document.all.phoneno.value+"|";  
    cust_info+="证件号码："+document.all.asIdiccid.value+"|";
    
    opr_info+="业务类型："+'<%=opName%>'+"|";
    opr_info+="变更流水"+document.all.VloginAccept.value+"|";
    
    note_info1+="备注："+document.all.remark.value+"|";
    note_info2+=document.all.t_op_remark.value+"|";
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;	
  }
//-->



 
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<body>

<form action="f1221BackCfm.jsp" method="POST" name="s1220"  onKeyUp="chgFocus(s1220)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">业务办理</div>
</div>
    <input type="hidden"  name="work_No" id="work_No" size="16" value="<%=work_no%>" >
    <input type="hidden" name="org_Code" id="org_Code" value="<%=org_Code%>">
    <input type="hidden"  name="work_Pwd" id="work_Pwd" size="16" value="<%=work_Pwd%>" >
    <input type="hidden" name="op_code" id="op_code" size="16" value="<%=opCode%>" >
    <input type="hidden"  name="userId" id="userId" size="16">
    <!--input type="test"  name="custName" id="custName" size="16"-->
    <input type="hidden"  name="passWord" id="passWord" size="16" value="">
    <input type="hidden"  name="asIdtape" id="Asidtape" size="16" value="" >
    <!--input type="hidden"  name="asIdname" id="asIdname" size="16" value="" -->
    <!--input type="hidden"  name="asIdiccid" id="asIdiccid" size="16" value="" -->
    <input type="hidden"  name="smTape" id="smTape" size="16" value="" >
    <!--input type="hidden"  name="smName" id="smName" size="16" value="" -->
    <input type="hidden"  name="runCode" id="runCode" size="16" value="" >
    <!--input type="hidden"  name="runName" id="runName" size="16" value="" -->
    <!--input type="hidden"  name="cardName" id="cardName" size="16" value="" -->
    <input type="hidden"  name="blocName" id="blocName" size="16" value="" >
    <!--input type="hidden"  name="base_No" id="base_No" size="16" value="" -->
    <input type="hidden"  name="base_Name" id="base_Name" size="16" value="" >
    <!--input type="hidden"  name="base_Date" id="base_Date" size="16" value="" -->
    <!--input type="hidden"  name="oldFee" id="oldFee" size="16" value="" -->
    <input type="hidden" name="test" size="16" value="" >
    <input type="hidden" name="test1" size="16" value="" >
    <input type="hidden" name="test2" size="16" value="" >
    <input type="hidden" name="test3" size="16" value="" >
    <input type="hidden"  name="VloginAccept" size="16" value="" >
    <input type="hidden"  name="oldsim" size="16" value="" >
    <input type="hidden"  name="newsim" size="16" value="" >
    <input type="hidden"  name="login_Accept"  value="<%=seq%>" >
    <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">


<table cellspacing="0">

    <tr> 
        <td class=blue nowrap>用户号码</td>
        <td nowrap> 
            <input class=InputGrey readOnly type="text" size="16" name="phoneno" id="phoneno" value="<%=activePhone%>" maxlength=11  index="6"> 
        </td>
        <td class=blue>流水号</td>
        <td>
            <input type="text" size="16" v_type="loginAccept" v_must=1 name="loginAccept" id="loginAccept" index="3">
        </td>
        <td class=blue>日期</td>
        <td>
            <input type="text" size="16" v_type="billDate" v_must=1 name="billDate" id="billDate" maxlength=8 index="3">
            <input class="b_text" type="button"  value="查询" onClick="chkPass()">
        </td>
    </tr>
    
    
    <tr> 
        <td nowrap class="blue">用户姓名</td>
        <td nowrap colspan="5">
            <input class="InputGrey"  type="text" size="16" name="custName" id="custName"  index="6" readonly >
        </td>
        
    </tr>
    <tr> 
        <td nowrap class=blue>证件类型</td>
        <td nowrap> 
            <input class="InputGrey"  type="text" size="16" name="asIdname" id="asIdname"  index="8" readonly>
        </td>
        <td nowrap class=blue>证件号码</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="asIdiccid" id="asIdiccid" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>运行状态</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="runName" id="runName" size="16" readonly tabindex="0">
        </td>
        <td nowrap class=blue>大客户标志</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text" name="cardName" id="cardName" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">操作工号</td>
        <td nowrap>  
            <input class="InputGrey" type="text"  name="base_No" id="base_No" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">操作时间</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="base_Date" id="base_Date" size="16" readonly tabindex="0">
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">费用合计</td>
        <td nowrap> 
            <input class="InputGrey" type="text"  name="oldFee" id="oldFee" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">客户品牌</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="smName" id="smName" size="16" readonly tabindex="0">
        </td>
    </tr>
    
    <tr> 
        <td class="blue">备注</td>
        <td colspan="5"> 
            <input type="text" class="InputGrey" name="remark" id="remark" size="60" readonly maxlength=30>
        </td>
    </tr>
    <tr style="display:none"> 
        <td class="blue">用户备注</td>
        <td colspan="5"> 
            <input type="text" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  index="28" maxlength=60> 
        </td>
    </tr>
  </table>
  <jsp:include page="/npage/public/hwReadCustCard.jsp">
		<jsp:param name="hwAccept" value="<%=seq%>"  />
		<jsp:param name="showBody" value="01"  />
	</jsp:include>
  <table>
    <tr id="footer"> 
        <td colspan="6"> 
            <input class="b_foot" type="button" name="confirm" value="打印&确认"  onClick="printCommit()" index="26" disabled >
            <input class="b_foot" type=reset name=back value="清除" onClick="document.all.confirm.disabled=true;" >
            <input class="b_foot" type="button" name="b_back" value="关闭"  onClick="removeCurrentTab()" index="28">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 

</html>
