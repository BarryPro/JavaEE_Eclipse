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
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String SubmitFlag = (String)session.getAttribute("SubmitFlag");
	String page_flag = request.getParameter("page_flag");
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");	
	String end_time = request.getParameter("end_time");	
	String errCode="";
    String errMsg="";
	if(page_flag.equals("0"))
	{
		String adetail_codes_array = request.getParameter("detail_codes_array");
    	String adetail_types_array = request.getParameter("detail_types_array");
    	String abegin_times_array  = request.getParameter("begin_times_array");
    	String aend_times_array    = request.getParameter("end_times_array");
    	String amode_times_array   = request.getParameter("mode_times_array");
    	String atime_flags_array   = request.getParameter("time_flags_array");
    	String atime_cycles_array  = request.getParameter("time_cycles_array");
    	String atime_units_array   = request.getParameter("time_units_array");
    	String anotes_array        = request.getParameter("notes_array");
    	
    	String aapply_flags_array   = request.getParameter("apply_flags_array");
		String afav_orders_array   = request.getParameter("fav_orders_array");
    	String[] detail_codes_array = adetail_codes_array.split(",");
    	String[] detail_types_array = adetail_types_array.split(",");
    	String[] begin_times_array  = abegin_times_array.split(","); 
    	String[] end_times_array    = aend_times_array.split(",");  
    	String[] mode_times_array   = amode_times_array.split(",");  
    	String[] time_flags_array   = atime_flags_array.split(",");  
    	String[] time_cycles_array  = atime_cycles_array.split(","); 
    	String[] time_units_array   = atime_units_array.split(",");  
    	String[] notes_array        = anotes_array.split(","); 
    	String[] apply_flags_array  = aapply_flags_array.split(",");
		String[] fav_orders_array  = afav_orders_array.split(",");
    	
    	for(int i=0;i<notes_array.length;i++)
    	{
    		notes_array[i]=notes_array[i].replaceAll("##",",");
    	}
		
		//paramsIn.add(workNo);
		//paramsIn.add(nopass);
		String code_op="5238";
		//paramsIn.add(login_accept);
		//paramsIn.add(mode_code);
		//paramsIn.add(region_code);
		//paramsIn.add(detail_codes_array);
		//paramsIn.add(detail_types_array);
		//paramsIn.add(begin_times_array);
		//paramsIn.add(end_times_array);
		//paramsIn.add(mode_times_array);
		//paramsIn.add(time_flags_array);
		//paramsIn.add(time_cycles_array);
		//paramsIn.add(time_units_array);
		//paramsIn.add(notes_array);
		//paramsIn.add(apply_flags_array);
		//paramsIn.add(fav_orders_array);
		
		
		//acceptList = impl.callService("s5238_2Cfm",paramsIn,"10");
%>

    <wtc:service name="s5238_2Cfm" outnum="10" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=nopass%>" />
			<wtc:param value="<%=code_op%>" />
			<wtc:param value="<%=login_accept%>" />
			<wtc:param value="<%=mode_code%>" />
			<wtc:param value="<%=region_code%>" />		
			<wtc:params value="<%=detail_codes_array%>" />				
			<wtc:params value="<%=detail_types_array%>" />
			<wtc:params value="<%=begin_times_array%>" />		
			<wtc:params value="<%=end_times_array%>" />	
			<wtc:params value="<%=mode_times_array%>" />
			<wtc:params value="<%=time_flags_array%>" />
			<wtc:params value="<%=time_cycles_array%>" />
			<wtc:params value="<%=time_units_array%>" />							
			<wtc:params value="<%=notes_array%>" />	
			<wtc:params value="<%=apply_flags_array%>" />	
			<wtc:params value="<%=fav_orders_array%>" />				
		</wtc:service>

<%		
		errCode=code1;   
		errMsg=msg1;
		
		if(!errCode.equals("000000"))
    	{
%>  	
    	    <script language='javascript'>
    	    	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		        history.go(-1);
    	    </script>
<%		}
	}
	String[][] sOut_detail_code	= new String[][]{};
    String[][] sOut_detail_type	= new String[][]{};
    String[][] sOut_type_name   = new String[][]{}; 
    String[][] sOut_fav_order   = new String[][]{};   
    String[][] sOut_mode_time   = new String[][]{};   
    String[][] sOut_time_flag   = new String[][]{};   
    String[][] sOut_time_cycle  = new String[][]{};   
    String[][] sOut_time_unit   = new String[][]{};   
    String[][] sOut_note        = new String[][]{};   
    String[][] sOut_begin_time  = new String[][]{};   
    String[][] sOut_end_time    = new String[][]{};
    String[][] sOut_apply_flag  = new String[][]{};
	
	//获取所有的优惠信息
 	String paramsIn[] = new String[4];
    paramsIn[0] = workNo;				//工号
    paramsIn[1] = nopass;				//密码
    paramsIn[2] = "5238";				//OP_CODE
    paramsIn[3] = login_accept;			
    
	//acceptList1 = impl.callFXService("s5238_3Int",paramsIn,"12");
%>

    <wtc:service name="s5238_3Int" outnum="12" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t2" scope="end"   />

<%	
	errCode=code2;   
	errMsg=msg2;  					 
 
		
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	 
%>       
<html>
<head>
<base target="_self">
<title>个人产品配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

function opDetailCode(apply_flag,detail_type,detail_code,note,typeButtonNum)
{
	var apply_flag =apply_flag;
	var detail_type =detail_type;
	var detail_code =detail_code;
	var note =note;
	var typeButtonNum=typeButtonNum;


	var region_code="<%=region_code%>";

	if(apply_flag=='Y')
	{
		//rdShowMessageDialog("此优惠代码已经发布，不允许在修改！");
		//this.disabled=false;
		if(detail_type=='0')
	{
		var url = "f5238_showRateCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');                                     
	}                                                             
	else if(detail_type=='1'||detail_type=='9')                                     
	{                                                             
		var url = "f5238_showMonthCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='2'||detail_type=='b')
	{
		var url = "f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&totOrder=0";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='4')
	{
		var url = "f5238_showFuncFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='3')
	{
		var url = "f5238_showBillFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}else if(detail_type=='a')
	{
		var url = "f5238_showFuncBind.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
		
	}
	else
	{

		if(detail_type=='0')
		{
			var url = "f5238_opRateCode.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum;
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		else if(detail_type=='1'||detail_type=='9')
		{
			var url = "f5238_opMonthCode.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum;
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		else if(detail_type=='2'||detail_type=='b')
		{
			var url = "f5238_opTotCode.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum + "&totOrder=0";
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		else if(detail_type=='4')
		{
			var url = "f5238_opFuncFav.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum+"&sm_code=<%=sm_code%>";
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		else if(detail_type=='3')
		{
			var url = "f5238_opBillFav.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum+"&sm_code=<%=sm_code%>";
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		else if(detail_type=='a')
		{
			var url = "f5238_opFuncBind.jsp?apply_flag="+apply_flag+"&login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum="+typeButtonNum+"&sm_code=<%=sm_code%>";
			escape(url);
			window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
		}
		
	}
}

function submitAdd(SubmitFlag)
{

	//判断是否所有的资费规则都已配置
	<%
	for(int i=0;i < result_t2.length;i++)
	{	
	%>
		if(document.form1.typeButton<%=i%>.value=="没有配置")	
		{
			rdShowMessageDialog("还有没配置的资费规则！");
			document.form1.typeButton<%=i%>.focus();
			return;
		}
	<%
	}
	%>
	document.form1.page_flag.value="0";
	if(SubmitFlag == "1")
	{
		document.form1.action="f4507_5.jsp"; 
		document.form1.submit();
	}else {	
	document.form1.action="f5238_5.jsp"; 
	document.form1.submit();
	}
}

function submitback()
{
	document.form1.page_flag.value="1";
	document.form1.action="f5238_2.jsp"; 
	document.form1.submit();
}

function opHalfFav()
{
    var url = "f5238_opHalfFav.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
}

function opModeFlag()
{
    var url = "f5238_opModeFlag.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
}
</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
 
	  <form name="form1"  method="get">
	  	<%@ include file="/npage/include/header.jsp" %>                         

	<div class="title">
		<div id="title_zi">个人产品配置-资费规则配置</div>
	</div>
	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="sm_code" value="<%=sm_code%>">
	  	<input type="hidden" name="begin_time" value="<%=begin_time%>">
	  	<input type="hidden" name="end_time" value="<%=end_time%>">
	  	<input type="hidden" name="page_flag" value="">
	  		  	<TABLE  id="mainOne"   cellspacing="0"  >
	            <TBODY>
 
	  	        	<TR  >
	  					<TD width="23%" valign="top" >
	  						<table  id="mainTwo" cellspacing="0" >
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
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">3.资费规则配置</font></TD>
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
	  					<TD width="77%" valign="top">
	  						<table  id="mainThree" cellspacing="0" >
	  							<tr  height="22">
	  								<TD width="30%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  								<TD width="70%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;产品代码</TD>
	  								<TD>
	  									<%=mode_code%>
	  								</TD>
	  							</tr>
	  						</table>

	  						<table  id="mainThree" cellspacing="0">
	  							<tr  height="22">
	  								<Th width="15%">优惠代码</Th>
	  								<Th width="15%">优惠类型</Th>
	  								<Th width="15%">开始时间</Th>
	  								<Th width="15%">结束时间</Th>
	  								<Th width="25%">优惠描述</Th>
	  								<Th width="15%">状态</Th>
	  							</tr>
	  							
	  							<%  

	  								for(int i=0;i < result_t2.length;i++)
									{
	  							%>
	  									<tr  height="22">
	  										<TD><%=result_t2[i][0]%></TD>
	  										<TD><%=result_t2[i][2]%></TD>
	  										<TD><%=result_t2[i][9]%></TD>
	  										<TD><%=result_t2[i][10]%></TD>
	  										<TD><%=result_t2[i][8]%></TD>
	  										<TD><input type="button" class="b_text" name="typeButton<%=i%>" value="<%
	  											String typeButtonValue="";
	  											if(result_t2[i][11].equals("0"))
	  											{typeButtonValue="没有配置";}
	  											else if(result_t2[i][11].equals("1"))
	  											{typeButtonValue="已配置";}
	  											else if(result_t2[i][11].equals("Y"))
	  											{typeButtonValue="已生效";}
	  											%><%=typeButtonValue%>" onclick="opDetailCode('<%=result_t2[i][11]%>','<%=result_t2[i][1]%>','<%=result_t2[i][0]%>','<%=result_t2[i][8]%>','<%=i%>')"></TD>
	  									</tr>
	  							<%
	  								}
	  							%>
	  							
	  						</table>
	  					</TD>
	  	        	</TR> 
	  	        
	            </TBODY>
	          	</TABLE>
	          	<TABLE cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button"  value="上一步" class="b_foot" onClick="submitback()">
	          	 	    &nbsp;
	          	 	    <input name="nextButton" type="button"  value="下一步"  class="b_foot" onClick="submitAdd('<%=SubmitFlag%>')" >
	          	 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="opHalfFavButt" type="button"  value="底线半月收配置" class="b_foot_long"  onClick="opHalfFav()" >
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="opModeFlagButt" type="button"  value="包年小区配置"  class="b_foot_long" onClick="opModeFlag()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			<BR>
	  			<BR>		
	  		</TD>
	  	</TR>
	  	<%@ include file="/npage/include/footer.jsp" %>

	  </form>
 
</body>
</html>

