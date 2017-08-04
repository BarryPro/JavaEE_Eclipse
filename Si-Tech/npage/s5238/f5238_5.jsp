<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workName = (String)session.getAttribute("workName");          	//工号姓名
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");								
	String end_time = request.getParameter("end_time");	

	String errCode="";
    String errMsg="";
    String paramsIn[] = new String[6];
    paramsIn[0] = workNo;				//工号
    paramsIn[1] = nopass;				//密码
    paramsIn[2] = "5238";				//OP_CODE
    paramsIn[3] = login_accept;			//操作流水
	paramsIn[4] = mode_code;			// 
	paramsIn[5] = region_code;			// 

    	  
	//acceptList = impl.callFXService("s5238_accValid",paramsIn,"2");
	%>
	
	    <wtc:service name="s5238_accValid" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
	
	<%
	errCode=code;   
	System.out.println("-------------errCode----------------"+errCode);
	errMsg=msg;
	if(!errCode.equals("000000"))
    {

%>
    	    <script language='javascript'>
    	    	rdShowMessageDialog("错误信息<%=errCode%>" + "【" + "<%=errMsg%>" + "】" ,0);
		        history.go(-1);
    	    </script>
<%		}
%>
<%
  //查找资费描述信息
  String[][] result1 = new String[][]{};
  String sqlStr1 = "select note from tMidBillModeCode where login_accept="+login_accept;
 // retArray1 = impl.sPubSelect("1", sqlStr1);
  %>
  
  		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
  
  <%
  result1 = result_t;
  String vModeNote = result1[0][0];

%>
<html>
<head>
<base target="_self">
<title>个人产品配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
onload=function() 
{
	 self.status="";
	 queryRelationFlag();
}	

//查询各个配置规则的状态
function queryRelationFlag()
{
	var myPacket = new AJAXPacket("f5238_rpc_queryRelationFlag.jsp","正在提交，请稍候......");
	myPacket.data.add("login_accept","<%=login_accept%>");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

//-----RPC返回------
function doProcess(packet) 
{
	self.status="";
	var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	
	var change_flag=packet.data.findValueByName("change_flag");
	var depend_flag=packet.data.findValueByName("depend_flag");
	var limit_flag=packet.data.findValueByName("limit_flag");

	if(parseInt(errCode)!=0)
	{
		rdShowMessageDialog("错误代码"+errCode+",错误信息"+errMsg,0);
		return false;
	}
	else
	{
		if(change_flag=="Y")
		{
			document.form1.change_flag.value="已配置";
			document.form1.change_flag.style.color="black";
		}
		else
		{
			document.form1.change_flag.value="未配置";
			document.form1.change_flag.style.color="red";
		}
		if(depend_flag=="Y")
		{
			document.form1.depend_flag.value="已配置";
			document.form1.depend_flag.style.color="black";
		}
		else
		{
			document.form1.depend_flag.value="未配置";
			document.form1.depend_flag.style.color="red";
		}
		if(limit_flag=="Y")
		{
			document.form1.limit_flag.value="已配置";
			document.form1.limit_flag.style.color="black";
		}
		else
		{
			document.form1.limit_flag.value="未配置";
			document.form1.limit_flag.style.color="red";
		}
	}
}

//配置产品变更规则
function deployChange()
{
	document.form1.changeButton.disabled=true;
	var url = "f5238_deployChange.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}
 
//配置产品依赖规则
function deployDepend()
{
	document.form1.dependButton.disabled=true;
	var url = "f5238_deployDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

//配置产品互斥规则
function deployLimit()
{
	document.form1.limitButton.disabled=true;
	var url = "f5238_deployLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}


function frmCfm()
{
	
		document.form1.action="f5238_6.jsp"; 
		document.form1.submit();
	
}

function submitAdd(){
 
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认提交本次资费配置信息吗？')==1)
        {
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('确认要提交资费配置信息吗？')==1)
        {
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交资费配置信息吗？')==1)
       {
	     frmCfm();
       }
    }	
	return true;
  }
/*********************************************************
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=login_accept%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);  
     return ret;    
  }

  function printInfo(printType)
  {
	   	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";

	  opr_info+="资费代码："+"<%=mode_code%>"+"|";
	  opr_info+="资费名称：" +"<%=mode_name%>"+"|";
	  opr_info+="业务品牌："+"<%=sm_code%>"+"|";
	  opr_info+="开始时间："+"<%=begin_time%>"+"|";
	  opr_info+="结束时间："+"<%=end_time%>"+"|";
	  opr_info+="配置流水："+"<%=login_accept%>"+"|";
	  note_info1+="优惠描述："+"<%=vModeNote%>"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	  return retInfo;
  }
********************************************************************/
function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrintNew.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;    
  }

  function printInfo(printType)
  {
	  var retInfo = "";
	  var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间

      retInfo+='<%=workNo%>   <%=workName%>'+"|";
	  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";

	  retInfo+="资费代码："+"<%=mode_code%>"+"|";
	  retInfo+="资费名称：" +"<%=mode_name%>"+"|";
	  retInfo+="业务品牌："+"<%=sm_code%>"+"|";
	  retInfo+="开始时间："+"<%=begin_time%>"+"|";
	  retInfo+="结束时间："+"<%=end_time%>"+"|";
	  retInfo+="配置流水："+"<%=login_accept%>"+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+="优惠描述："+"<%=vModeNote%>"+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";
	  retInfo+=" "+"|";

	  return retInfo;
  }
function submitback()
{
	document.form1.action="f5238_3.jsp"; 
	document.form1.submit();
}
</script>
</head>

<body>
 
	  <form name="form1"  method="post">
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">个人产品配置-产品关系配置</div>
	</div>
	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="sm_code" value="<%=sm_code%>">
	  	<input type="hidden" name="begin_time" value="<%=begin_time%>">
	  	<input type="hidden" name="end_time" value="<%=end_time%>">
	  	<input type="hidden" name="page_flag" value="1" color="red">
	  	<TR >
	  		<TD >
	  		  	<TABLE  id="mainOne" cellspacing="0" >
	            <TBODY>
	  	        	<TR >
	  					<TD width="23%" valign="top">
	  						<table id="mainTwo" cellspacing="0" border="0">
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;<b>产品配置步骤</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;1.配置产品代码</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;2.配置产品明细</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;3.资费规则配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;4.开关机配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">5.产品关系配置</font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;6.完成</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%" valign="top">
	  						<table   id="mainThree cellspacing="0" >
	  							<tr  height="22">
	  								<TD width="30%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  								<TD width="70%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;产品代码	</TD>
	  								<TD>
	  									<%=mode_code%>
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;状态&nbsp;&nbsp;<input type="text" name="change_flag" value="未配置"   size="8" ></TD>
	  								<TD>
	  									 <input name="changeButton" type="button"   class="b_text"  value="配置产品变更规则" disabled onClick="deployChange();">
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;状态&nbsp;&nbsp;<input type="text" name="depend_flag" value="未配置"  size="8"></TD>
	  								<TD>
	  									 <input name="dependButton" type="button"   class="b_text"  value="配置产品依赖规则" disabled onClick="deployDepend();">
	  								</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;状态&nbsp;&nbsp;<input type="text" name="limit_flag" value="未配置"  size="8"></TD>
	  								<TD>
	  									 <input name="limitButton" type="button"  class="b_text"  value="配置产品互斥规则" disabled onClick="deployLimit();">
	  								</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  	        	</TR> 
	            </TBODY>
	          	</TABLE>
	          	<TABLE cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button" class="b_foot" value="上一步" onClick="submitback()">
	          	 	    &nbsp;
	          	 	    <input name="nextButton" type="button"   class="b_foot" value="下一步" onClick="submitAdd()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
</body>
</html>

