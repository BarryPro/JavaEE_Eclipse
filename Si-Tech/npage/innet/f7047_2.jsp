<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
String opCode = "7047";
String opName="SIM卡重个人化";
    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);

  String simNo = request.getParameter("sim_no");
  String cardNo= request.getParameter("card_no");
  String passwordFromSer="";
  String[] paraAray1 = new String[3];  
  paraAray1[0] = simNo;		/* 手机号码   */ 
  paraAray1[1] = opCode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */

  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }

  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="";
  String phone_no="",imsi_no="",phoneNo="",vIdNo="";
 %>
		<wtc:service name="s7047Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		</wtc:service>
		<wtc:array id="s7160QryArr" scope="end"/>
<%
	  int errCode = retCode1==""?999999:Integer.parseInt(retCode1);
	  String errMsg = retMsg1;

  	if(errCode != 0){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
	  	 	history.go(-1);
	  	//-->
	  </script>
  <%
  		return;
  	}
  	
  	if(s7160QryArr!=null&&s7160QryArr.length>0){
				bp_name = s7160QryArr[0][2];//机主姓名
				bp_add = s7160QryArr[0][3];//客户地址
				cardId_type = s7160QryArr[0][4];//证件类型
				cardId_no = s7160QryArr[0][5];//证件号码
				sm_code = s7160QryArr[0][6];//业务品牌
				region_name = s7160QryArr[0][7];//归属地
				phoneNo = s7160QryArr[0][8];//当前状态
				imsi_no = s7160QryArr[0][9];//ＶＩＰ级别
				vIdNo = s7160QryArr[0][10];
				
  	}else{
 	%>
				<script language="JavaScript">
					<!--
			  		rdShowMessageDialog("s7160Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg);
			  	 	parent.removeTab("<%=opCode%>");
			  	//-->
			  </script>
<%    		
  	}

			String printAccept="";
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%printAccept = sLoginAccept;%>

<html>
<head>
	<base target="_self">
<title>"<%=opName%>"</title>
<script language="JavaScript">

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

 
 
 

  //***
  function frmCfm(){
	 	frm.submit();
		return true;
  }
 //***IMEI 号码校验
 function formatmsg()
 {
 	//alert("ssssssssss");
 	/*var str=window.showModalDialog(("trans.html","http://ip:port/testPage.jsp","newwin","dialogHeight: 200px; dialogWidth: 150px; dialogTop: 458px; dialogLeft: 166px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: Yes;");*/
 	// var path = "pubService_lcm.jsp";
   /* 
	  * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
	  */
		path ="http://10.110.0.100:33000/rewritecard/index.jsp"
    path = path + "?OPID=" + "<%=loginNo%>";
   
    //var retInfo = window.showModalDialog(path,"","dialogWidth:50;dialogHeight:40;");
    var retInfo = window.showModalDialog("Trans.html",path,"","dialogWidth:50;dialogHeight:40;"); 
    //alert(retInfo);
    //var RESULT="";
    if(typeof(retInfo) == "undefined")     
    {	
    	rdShowMessageDialog("重个人化出错!");
    	return false;   
    }
    var chPos;
    chPos = retInfo.indexOf("&");
    if(chPos < 0)
    {	
    	rdShowMessageDialog("重个人化出错!");
    	return false ;	}
    //alert( retInfo.substring(0,chPos));
    retInfo=retInfo+"&";
    var retVal=new Array();   
    for(i=0;i<4;i++)
    {   	   
    	
    	var chPos = retInfo.indexOf("&");
        valueStr = retInfo.substring(0,chPos);
        var chPos1 = valueStr.indexOf("=");
        valueStr1 = valueStr.substring(chPos1+1);
        retInfo = retInfo.substring(chPos+1);
        retVal[i]=valueStr1;
        //alert(valueStr);
        //alert(retVal[i]);
    } 
    if(retVal[0]=="0")
    {
    	printCommit();
    }
    else{
    	rdShowMessageDialog("重个人化失败,错误代码:"+retVal[0]);
    }
   
 }
 function printCommit()
 { 
  getAfterPrompt();//add by qidp
  
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
     // if(rdShowMessageDialog('确认要提交信息吗？')==1)
     // {
	    frmCfm();
      //}
	}
  }else{
    // if(rdShowMessageDialog('确认要提交信息吗？')==1)
     //{
	   frmCfm();
    // }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
	var pType="subprint";   
	var billType="1";  
	var sysAccept = document.all.login_accept.value;   
   var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;    
}

function printInfo(printType)
{
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	cust_info+= "手机号码：    "+document.all.phone_no.value+"|";
	cust_info+= "客户姓名：    "+document.all.cust_name.value+"|";
	cust_info+= "证件号码：    "+document.all.cardId_no.value+"|";
	cust_info+= "客户地址：    "+document.all.cust_addr.value+"|";
	



	opr_info+="办理业务："+"<%=opName%>"+"|";
    opr_info+="业务流水："+document.all.login_accept.value+"|";
	  
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
   return retInfo;	
}
//-->
</script>


</head>

<body>
		<form name="frm" method="post" action="f7047Cfm.jsp" onKeyUp="chgFocus(frm)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">操作类型：<%=opName%> </div>
			</div>

			<table cellspacing="0">
				
			    <tr>
			        <td class="blue" width="15%">客户姓名</td>
			        <td width="35%">
			            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name">
			        </td>
			        <td class="blue" width="15%">客户地址</td>
			        <td width="35%">
			            <input name="cust_addr" size="60" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">证件类型</td>
			        <td>
			            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20">
			        </td>
			        <td class="blue">证件号码</td>
			        <td>
			            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">业务品牌</td>
			        <td>
			            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code">
			
			        </td>
			        <td class="blue">手机号码</td>
			        <td>
			            <input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phone_no">
			
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">SIM卡号</td>
			        <td>
			            <input name="sim_no" value="<%=simNo%>" type="text" class="InputGrey" v_must=1 readonly id="sim_no" maxlength="20">
			
			        </td>
			        <td class="blue">IMSI号</td>
			        <td>
			            <input name="imsi_no" value="<%=imsi_no%>" type="text" class="InputGrey" v_must=1 readonly id="imsi_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">空卡序号</td>
			        <td>
			            <input name="card_no" value="<%=cardNo%>" type="text" class="InputGrey" v_must=1 readonly id="card_no">
			        </td>
			        <td class="blue">用户ID</td>
			        <td>
			            <input name="id_no" value="<%=vIdNo%>" type="text" class="InputGrey" v_must=1 readonly id="id_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">备注</td>
			        <td colspan="3">
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="<%=opName%>" readonly >
			        </td>
			    </tr>
			    <tr>
			        <td colspan="4" id="footer">
			        	<input class="b_foot" name="format" type="button" index="2" value="重个人化" onClick="formatmsg()">
			            <!--<input class="b_foot" name="confirm" type="button" index="2" value="确认&打印" onClick="printCommit()" disabled >-->
			            <input class="b_foot" name="reset" type="reset" value="清除">
			            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			        </td>
			    </tr>
			</table>		
       <%@ include file="/npage/include/footer.jsp" %>
		<input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opcode" value="<%=opCode%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="op_name" value="<%=opName%>">
	</form>
</body>
</html>
