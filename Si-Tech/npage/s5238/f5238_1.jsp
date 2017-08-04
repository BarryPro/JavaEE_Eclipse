<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
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
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	Logger logger = Logger.getLogger("f5238.jsp");
  String[][] result = new String[][]{};
  
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");

	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
	String errCode="";
    String errMsg="";
    
    String region_code="";
    String region_name="";
    String sm_code    ="";
    String sm_name    ="";
    String mode_code  ="";
    String mode_name  ="";
    String mode_flag  ="";
    String begin_time ="";
    String end_time   ="";
    String note       ="";
    String mode_use   ="";
    String use_name   ="";
	String year_flag ="";
	String next_mode = "";
	String next_mode_name="";
	String mode_type="";
	String mode_type_name="";
	String power_right="";
      
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");
	String op_code = request.getParameter("op_code")==null?"":request.getParameter("op_code");
	if(op_code.equals(""))  op_code="5238";
	
	if(login_accept == null)
	{
		
		//获取系统流水
 	//sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
 	%>
 	
 	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
 	
 	<%
		login_accept=sysAcceptl;
		
	}
	else
	{
		ArrayList acceptList = new ArrayList();
    	String paramsIn[] = new String[4];
    	paramsIn[0] = workNo;				//工号
    	paramsIn[1] = nopass;				//密码
    	paramsIn[2] = "5238";				//OP_CODE
    	paramsIn[3] = login_accept;			//操作流水

    	  
	 //	acceptList = impl.callFXService("s5238_1Int",paramsIn,"18");
%>

    <wtc:service name="s5238_1Int" outnum="18" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />	
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%	 	
		errCode=code;   
		errMsg=msg;
		
		if(!errCode.equals("000000"))
    	{
%>  	
    	    <script language='javascript'>
    	    	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		        history.go(-1);
    	    </script>
<%		}
		else
		{
			if(result_t1.length>0){
			region_code =result_t1[0][0].trim();
			region_name =result_t1[0][1].trim();
			sm_code     =result_t1[0][2].trim();
			sm_name     =result_t1[0][3].trim();
			mode_code   =result_t1[0][4].trim();
			mode_name   =result_t1[0][5].trim();
			mode_flag   =result_t1[0][6].trim();
			begin_time  =result_t1[0][7].trim();
			end_time    =result_t1[0][8].trim();
			note        =result_t1[0][9].trim();
			mode_use    =result_t1[0][10].trim();
	   		use_name  =result_t1[0][11].trim();
			year_flag   =result_t1[0][12].trim();
			next_mode   =result_t1[0][13].trim();
			next_mode_name  =result_t1[0][14].trim();
			mode_type       =result_t1[0][15].trim();
			mode_type_name  =result_t1[0][16].trim();
			power_right     =result_t1[0][17].trim();
			}
	    }
	}
%>

<html>
<head>
<base target="_self">
<title>个人产品配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
onload=function()
{
	self.status="";

    <%if(year_flag.equals("0")){%>
      document.all.yearInfoButt.style.display="";
	  document.all.yearInfoButt.value="包年信息已配置";
	<%}%>
	<%if(!(end_time.equals("20500101")) && next_mode.length()>7){%>
      document.all.nextModeTr.style.display="";
	<%}%>
}

//处理rpc返回结果
	function doProcess(packet) {
		self.status="";
		var qryType=packet.data.findValueByName("rpcType");
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		if(parseInt(errCode)!=0){
			rdShowMessageDialog("错误信息"+errMsg + "<br>错误代码"+errCode, 0);
			return false;
		}
		
		if(qryType=="getProCode")
		{
				var proCode = packet.data.findValueByName("proCode");
				document.form1.mode_code.value=StrAdd(1,proCode,1);
				document.form1.getprocodebutton.disabled=true;
				return;
		}
		
	}	
function StrAdd(AddType, SrcStr, Value)
{
	//AddType 0值加1， 1:模加1
	var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	//var BaseStr ="0123456789";
	var S = "";
	var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
	var isCarry = 0;
	
	SrcLen= SrcStr.length;
	BaseLen=BaseStr.length;
	isCarry = Value % BaseLen;
	for(  CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
	{
		if (isCarry != 0)
		{
			Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
			if (Index < -1)
			{
				return "";
			}
			if (Index > BaseLen - 1)
			{
				isCarry = 1;
				S = BaseStr.charAt(Index - BaseLen) + S;
			}
			else
			{
				isCarry = 0;
				S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
				break;
			}
			if (CurPos == 0 && AddType == 0) S = BaseStr.charAt(0) + S;
		}
		else
		{
			break;
		}
		
	}
	return S;
}

//判断输入的是否为中文	
function ischinese()
{
 	var ret=false;
 	var s=document.all.mode_code.value;
 	for(var i=0;i<s.length;i++)
 	{
 	 	ret=(s.charCodeAt(i)>=10000);
 	 	if(ret==true)
 	 	{
 	 		rdShowMessageDialog("请勿在产品代码框中输入中文！");
 	 		document.all.mode_code.focus();
 	 		return;
 	 	}
 	}
}    


//选择地区代码
function queryRegionCode()
{
	window.open("f5238_queryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=600,width=400,scrollbars=yes");
}

//选择品牌代码
function querySmCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5238_querySmCode.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("请先选择地区代码！");
		document.form1.query_regioncode.focus();
	}
}

//选择资费类型代码
function queryModeType()
{
	if(!checkElement(document.form1.region_code)) return ;
	if(!checkElement(document.form1.sm_code)) return ;

    var retToField = "mode_type|mode_type_name|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value+"&smCodeCond="+document.form1.sm_code.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=550,scrollbars=yes');
}


//选择模版代码
function queryModeUse()
{
	if(document.form1.region_code.value=="")
	{
	    rdShowMessageDialog("请先选择地区代码！");
		document.form1.query_regioncode.focus();
	}
	else if(document.form1.sm_code.value=="")
	{
		rdShowMessageDialog("请先选择品牌代码！");
		document.form1.query_smcode.focus();
	}
	else
	{
		
		var mode_flag="";
	  for(var i=0;i<document.form1.mode_flag.length;i++)
	  {
		  if(document.form1.mode_flag[i].checked==true)
		  {
			  mode_flag=document.form1.mode_flag[i].value;
		  }
	  }
		var url = "f5238_queryModeUse.jsp?mode_use="+document.all.mode_use.value+"&region_code="+document.form1.region_code.value+"&sm_code="+document.form1.sm_code.value+"&mode_flag="+mode_flag+"&mode_type="+document.form1.mode_type.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
}

//选择到期资费
function queryNextMode()
{
	var url = "f5238_queryModeCode.jsp?region_code="+document.form1.region_code.value;
    var retMsg = window.open(url,'','height=600,width=500,scrollbars=yes');
}

/*--------- 提交页面转到下一页 -------------*/
function submitAdd()
{
	if(document.form1.region_code.value==""){
	rdShowMessageDialog("地区代码为必填项,请务必填写",0);
	return;
}

	if(document.form1.sm_code.value==""){
	rdShowMessageDialog("品牌代码为必填项,请务必填写",0);
	return;
}


	if(document.form1.mode_type.value==""){
	rdShowMessageDialog("产品类型为必填项,请务必填写",0);
	return;
}
		if(!check(form1)) return;
	
	if(!forDate(document.form1.begin_time)) 
	{
		document.all.begin_time.focus();
		return;
	}
	if(!forDate(document.form1.end_time)) 
	{
		document.all.end_time.focus();
		return;
	}
	if(document.all.end_time.value<document.all.begin_time.value)
	{
		rdShowMessageDialog("结束时间应晚于开始时间！");
		document.form1.end_time.focus();
		return;
	}
	if(document.all.power_right.value == ""){
		 rdShowMessageDialog("请选择受理权限！");
	   document.form1.power_right.focus();
	   return;
	}
	if(document.all.year_flag[0].checked==true && document.all.yearInfoButt.value=="包年信息未配置")
	{
	   rdShowMessageDialog("请配置包年信息！");
	   document.form1.yearInfoButt.focus();
	   return;
	}
	document.form1.action="f5238_2.jsp"; 
	document.form1.submit();	
}

//控制包年按钮的可见性
function ctrlYear(flag)
{
    if(flag==0)
    {
	    document.all.yearInfoButt.style.display="";
	}else
    {
	    document.all.yearInfoButt.style.display="none";
	}
}

//弹出窗口配置包年信息
function opYearInfo()
{
  if(!checkElement(document.all.region_code)) 
  {
    document.all.region_code.focus();
	return;
  }
  if(!checkElement(document.all.mode_code)) 
  {
    document.all.mode_code.focus();
	return;
  }
  if(!checkElement(document.all.begin_time)) 
  {
    document.all.begin_time.focus();
	return;
  }
  if(!checkElement(document.all.end_time)) 
  {
     document.all.end_time.focus();
	 return;
  }
  var url = "f5238_opYearInfo.jsp?login_accept=<%=login_accept%>"+"&mode_code="+document.all.mode_code.value+"&region_code="+document.all.region_code.value+"&begin_time="+document.all.begin_time.value+"&end_time="+document.all.end_time.value;
  escape(url);
  window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
}

function endTimeChg()
{
    var end_time=document.all.end_time.value;
	if(end_time<"20500101")
	{
	    document.all.nextModeTr.style.display="";
	}else
	{
	    document.all.nextModeTr.style.display="none";
	}
}

function getProCode()
{
	if(document.form1.region_code.value=="")
	{
		rdShowMessageDialog("请先选择地区代码！");
		document.form1.query_regioncode.focus();
		return;
	}
	if(document.form1.sm_code.value=="")
	{
		rdShowMessageDialog("请先选择品牌代码！");
		document.form1.query_smcode.focus();
		return;
	}

	if(document.form1.mode_type.value=="")
	{
		rdShowMessageDialog("请先选择产品类别！");
		document.form1.query_modetype.focus();
		return;
	}	
	
	var mode_flag="";
	for(var i=0;i<document.form1.mode_flag.length;i++)
	{
		if(document.form1.mode_flag[i].checked==true)
		{
			mode_flag=document.form1.mode_flag[i].value;
		}
	}
	  //alert(sm_code+mode_flag + mode_type);
		var myPacket = new AJAXPacket("f5238_getProCode_rpc.jsp","正在提交，请稍候......");
		myPacket.data.add("sm_code",document.form1.sm_code.value);
		myPacket.data.add("mode_flag",mode_flag);
		myPacket.data.add("mode_type",document.form1.mode_type.value);
		myPacket.data.add("region_code",document.form1.region_code.value);
		myPacket.data.add("rpcType","getProCode");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
}


</script>
 
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">个人产品配置-配置产品代码</div>
	</div>

	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="page_flag" value="0">
	  <input type="hidden" name="op_code" value="<%=op_code%>">
	  		  	<TABLE id="mainOne" cellspacing="0" >
	            <TBODY>

	  	        	<TR >
	  					<TD width="23%" valign="top">
	  						<table  id="mainTwo"  cellspacing="0" >
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;<b>产品配置步骤</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">1.配置产品代码</font></TD>
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
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;5.产品关系配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;6.完成</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%">
	  						<table   id="mainThree" cellspacing="0">
	  							<tr  height="22">
	  								<TD width="33%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  								<TD width="67%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;地区代码</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2   name=region_code value="<%=region_code%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=10    name=region_name value="<%=region_name%>" maxlength=10 readonly  Class="InputGrey" >
										<input  type="button" class="b_text" name="query_regioncode" onclick="queryRegionCode()" value="选择">
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;品牌代码</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="品牌代码"  name=sm_code value="<%=sm_code%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="品牌代码"  name=sm_name value="<%=sm_name%>" maxlength=20 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_smcode" onclick="querySmCode()" value="选择">
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;产品类型</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="资费类型"  name=mode_type value="<%=mode_type%>" maxlength=10 size="10" readonly  Class="InputGrey" >
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="资费类型"  name=mode_type_name value="<%=mode_type_name%>" maxlength=20 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_modetype" onclick="queryModeType()" value="选择">
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;产品层次</TD>
	  								<TD>
	  									<input type="radio" name="mode_flag" value="0" <%=mode_flag.equals("0")==true?"checked":""%><%=mode_flag.equals("")==true?"checked":""%>>主产品
	  									<input type="radio" name="mode_flag" value="2" <%=mode_flag.equals("2")==true?"checked":""%>>可选产品
	  									<input type="radio" name="mode_flag" value="1" <%=mode_flag.equals("1")==true?"checked":""%>>附加产品
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;产品代码</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=8 v_maxlength=8 v_name="产品代码"  name=mode_code value="<%=mode_code%>" maxlength=8 onblur="ischinese()"></input>
										<input type="button" class="b_text"  name="getprocodebutton" onClick="getProCode()" value="获取" />
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;产品名称</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="产品名称"  name=mode_name value="<%=mode_name%>" maxlength=30 ></input>
	  								  	<font class="orange">*</font>
	  								</TD>
	  							</tr>	  							
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;是否包年</TD>
	  								<TD>
	  									<input type="radio" name="year_flag" onClick="ctrlYear(0)" value="0" <%=year_flag.equals("0")==true?"checked":""%>>是
	  									<input type="radio" name="year_flag" value="1" onClick="ctrlYear(1)" <%=year_flag.equals("1")==true?"checked":""%><%=year_flag.equals("")==true?"checked":""%>>否										
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;开始时间</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="开始时间" name=begin_time v_format="yyMMdd" value="<%=begin_time.equals("")?sysdate:begin_time%>" maxlength=8 ></input>&nbsp;<font class="orange">*(YYYYMMDD)</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;结束时间</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="结束时间" name=end_time v_format="yyMMdd" value="<%=end_time.equals("")?sysdate:end_time%>" maxlength=8 onChange="endTimeChg()" ></input>&nbsp;<font class="orange">*(YYYYMMDD)</font>
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;受理权限</TD>
	  								<TD>
	  								<select name="power_right" value="<%=power_right%>" >
										<option value="" > ---- 请选择 ---- </option>
<%
        //得到输入参数
        try
        {
                String sqlStr ="select right_code, right_code||'->'||right_name from sPowerValueCode order by right_code";                     
                //retArray = callView.sPubSelect("2",sqlStr);   
      %>
      
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>
      
      <%                  
                result = result_t3;
                int recordNum = result.length;
                for(int i=0;i < recordNum;i++){
                		out.println("<option   value='" + result[i][0] + "' >" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }              
%>									
              			</select>	<font class="orange">*</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;产品描述</TD>
	  								<TD>
	  									<input type=text  v_type="" v_must=1 v_minlength=1 v_maxlength=600 v_name="产品描述" name=note size=50 value="<%=note%>" maxlength=600></input> 	<font class="orange">*</font>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;按某产品模版配置</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="配置模版代码"  name=mode_use value="<%=mode_use%>" maxlength=10 size="10" >
	  									<input type=text  name=use_name value="<%=use_name%>" maxlength=30 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_modeuse" onclick="queryModeUse()" value="选择">
	  								</TD>
	  							</tr>
								<tr  id="nextModeTr" style="display:none">
	  								<TD class="blue">&nbsp;&nbsp;指定到期资费</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="到期资费"  name=next_mode value="<%=next_mode%>" maxlength=10 size="10">
	  									<input type=text  name=next_mode_name value="<%=next_mode_name%>" maxlength=30 readonly  Class="InputGrey" >
										<input  type="button" class="b_text"  name="query_nextmode" onclick="queryNextMode()" value="选择">
	  								</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  	        	</TR> 
	  	        
	            </TBODY>
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="right" width="60%" id="footer"> 
	          	 	    <input name="nextButton" type="button" class="b_foot" value="下一步" onClick= "submitAdd()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot" value="重  置" onClick="window.location='f5238_1.jsp'" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="b_foot"  value="关  闭" onClick="removeCurrentTab()" >

						<input style="display:none" class="b_foot_long" type="button" name="yearInfoButt" value="包年信息未配置" onclick="opYearInfo();">
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
</body>
</html>

<script language="javascript">
<%if(op_code.equals("5237")){%>
   rdShowMessageDialog("请注意此界面用于地市资费配置测试！");
<%}%>

</script>
