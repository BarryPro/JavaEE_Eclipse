<%
	/********************
	 version v2.0
	开发商: si-tech
	*
	*update:zhanghonga@2008-08-12 页面改造,修改样式
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
  String opName = "综合信息查询之用户帐单";
  
	String org_code = (String)session.getAttribute("orgCode");
	String busy_name="";
	String TGroupFlag="";
	String TBigFlag = "";
	String BigFlag = "0";
	String rowNum = "16";
	
	String phoneNo = request.getParameter("phoneNo");
	String count = request.getParameter("count");
	String busy_type = request.getParameter("busy_type");
	String idNo = request.getParameter("idNo");
	String op_code = "1500";
	// xl add 密码校验
	String pwdcheck = request.getParameter("pwdcheck"); 
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA pwdcheck is "+pwdcheck);
	if(busy_type.equals("1"))
	{
		busy_name="用户帐单";
	}else{
		busy_name="帐户帐单";
	}
		/**
		try
		{	s1500moreWrapper wrapper = new s1500moreWrapper();//实例化wrapper
			arlist = wrapper.wrapper_s1500UConQry(phoneNo,count,busy_type,org_code,op_code,"5"); 
			//System.out.println(" call ebj 55555555555555555555555");
		}
		catch(Exception e)
		{
			//System.out.println("调用EJB发生失败！");
		}
	**/
%>
	<wtc:service name="s1500UConQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=count%>"/>
	<wtc:param value="<%=busy_type%>"/>
	<wtc:param value="<%=org_code%>"/>
	<wtc:param value="5"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="10" scope="end"/>
	<wtc:array id="result2" start="10" length="11" scope="end"/>
<%
	int iretCode = 0;
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码<%=retCode1%><br>服务信息<%=retMsg1%>!");
	</script>
<%
		return;
	}
	
	if((result==null||result.length==0)&&(result2==null||result2.length==0)){
%>
	<script language="javascript">
		rdShowMessageDialog("用户账单信息不存在!");
		history.go(-1);
	</script>
<%
		return;	
	}

	String return_code =result[0][0];
	String return_msg = "";   
	String countName  = "";   
	String userType   = "";   
	String currentFee = "";		
	String predelFee  = "0";            
	String phoneNum   = "";   
	String prepayFee  = "";   
	String contract   = "";   
	String sTotalFee = "0";

	double sum_delayfee=0.00;
	double sum_owefee=0.00;
	int flag=0;

	//System.out.println("return_code "+return_code);
	//System.out.println("return_msg "+return_msg);
	if (Integer.parseInt(return_code)==0)
	{
		return_msg = result[0][1];   
		countName  = result[0][2];   
		userType   = result[0][3];   
		currentFee = result[0][5];	
		predelFee  = "0";            
		phoneNum   = result[0][6];   
		prepayFee  = result[0][4];   
		contract   = result[0][8];  
		if ( userType.equals("999") )
		{
			BigFlag = "1";
		}
		else 
		{
			if (userType.substring(0,2).equals("01") )
			{
				TBigFlag = "钻石卡客户";
			}
			else if (userType.substring(0,2).equals("02") )
			{
				TBigFlag = "金卡客户";
			}
			else if (userType.substring(0,2).equals("03") )
			{
				TBigFlag = "银卡客户";
			}
			else if (userType.substring(0,2).equals("04") )
			{
				TBigFlag = "贵宾卡客户";
			}
			else if (userType.substring(0,2).equals("05") )
			{
				TBigFlag = "大客户";
			}
			else
			{
				TBigFlag = "普通客户";
			}
			if ( userType.substring(2,3).equals("0"))
			{
				TGroupFlag = "非集团客户";
			}
			else if (userType.substring(2,3).equals("1"))
			{
				TGroupFlag = "集团普通客户";
			}
			else if (userType.substring(2,3).equals("2"))
			{
				TGroupFlag = "集团中高价值客户";
			}
			else if (userType.substring(2,3).equals("3"))
			{
				TGroupFlag = "集团中的大客户";
			}

		} 


		for (int i=0; i< result2.length;i++)
		{
			sum_owefee = sum_owefee + Double.parseDouble(result2[i][5]);
			sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][6]);
		}
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAA");
		//double dTotalFee = sum_delayfee+sum_owefee+Double.parseDouble(predelFee)+Double.parseDouble(currentFee);
		double dTotalFee = 0.00;
		//System.out.println("BBBBBBBBBBBBBBBBBBBBBBB");
		String tmp1=Double.toString(dTotalFee*100+0.5);		
		if (tmp1.indexOf(".")!=-1){
		String tmp2 = tmp1.substring(0,tmp1.indexOf("."));
			double tmp3 = Double.parseDouble(tmp2);
			sTotalFee=Double.toString(tmp3/100);		
		}
%>
<script language="JavaScript">
	 var GroupFee = new Array(11);
	   GroupFee[0] = new Array();
	   GroupFee[1] = new Array();
	   GroupFee[2] = new Array();
	   GroupFee[3] = new Array();
	   GroupFee[4] = new Array();
	   GroupFee[5] = new Array();
	   GroupFee[6] = new Array();
	   GroupFee[7] = new Array();
	   GroupFee[8] = new Array();
	   GroupFee[9] = new Array();
	   GroupFee[10] = new Array();   
<%
	 for(int x = 0; x< result2.length; x++){
%>
	     GroupFee[0][<%= x %>] = "<%= result2[x][0] %> ";
		 GroupFee[1][<%= x %>] = "<%= result2[x][1] %> ";
		 GroupFee[2][<%= x %>] = "<%= result2[x][2] %> ";
		 GroupFee[3][<%= x %>] = "<%= result2[x][3] %> ";
		 GroupFee[4][<%= x %>] = "<%= result2[x][4] %> ";
		 GroupFee[5][<%= x %>] = "<%= result2[x][5] %> ";
		 GroupFee[6][<%= x %>] = "<%= result2[x][6] %> ";
		 GroupFee[7][<%= x %>] = "<%= result2[x][7] %> ";
		 GroupFee[8][<%= x %>] = "<%= result2[x][8] %> ";
		 GroupFee[9][<%= x %>] = "<%= result2[x][9] %> ";
		 GroupFee[10][<%= x %>] = "<%= result2[x][10] %> ";		 
<%
	}
%> 
 
</script>
<%
	}else if (return_code.equals("150011")){
		  flag = 1;
	}else{
			flag = 2;
	}
%>

<HTML><HEAD>

<script language="JavaScript">

 function showSelWindow()
 {
		var userGroup = new Array(<%=result2.length%>);
			userGroup[0] = new Array(2);
			userGroup[1] = new Array(2);
		<%for(int x = 0; x< result2.length; x++)
		{%>
			userGroup[<%= x %>][0]= "<%=result2[x][0]%>";
			userGroup[<%= x %>][1]= "<%=result2[x][1]%>";
		<%}%>

		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
		var str=window.showModalDialog('getUserCount.jsp?userGroup='+userGroup,"",prop);

		if( typeof(str) != "undefined" ){
			if ( str == "0" ){
				history.go(-1);
			}
			else{

			}
		}
 }
 function init(){
		//以下域的缺省值是规范中的要求
		<% if ( flag == 2 ){%>
			rdShowMessageDialog("未查询到用户账单相关数据!<br>服务代码 :<%=return_code%>");
			history.go(-1);
		<%}%>
		<% if ( flag == 1 ){
		%>
			showSelWindow();
		<%}%>

	}
</script> 
 
<title>黑龙江移动通信</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<BODY onLoad="init();">
<FORM method="post" name="form">
		<input type="hidden" name="Op_Code"  value=<%=op_code%>>
		<input type="hidden" name="busy_type"  value=<%=busy_type%>>
		<input type="hidden" name="sumdelayFee"  value=<%=sum_delayfee%>>
		<input type="hidden" name="unitCode" value="<%=org_code%>">
		<input type="hidden" name="sumFee"  value=<%=sTotalFee%>>
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户账单</div>
		</div>
       <table cellspacing="0">
         <tr>
           <td class="blue">帐单类型</td>
           <td>
             <input type="text" class="InputGrey" readonly name="TbusyName" size="16" maxlength="12"  value=<%=busy_name%>>
           </td>
           <td class="blue">号码数量</td>
           <td>
             <input type="text"  class="InputGrey" readonly name="PhoneNum" size="36" maxlength="12" value=<%=phoneNum%>>
           </td>
         </tr>
         <tr> 
           <td class="blue">帐户号码</td>
           <td> 
             <input type="text" class="InputGrey" readonly name="count" size="16" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" value=<%=contract%>>
           </td>
           <td class="blue">帐户名称 </td>
           <td>
		   <%
			 //pwdcheck="N";
			 if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value=<%=countName%>>
				 <%
			 }
			 else if(pwdcheck=="N" ||pwdcheck.equals("N"))
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value=<%=countName.substring(0,1)%>XX>
				 <%
			 }
			 else
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value="密码状态未确认，帐户名称不展示">
				 <%
			 }
		   %>
             
           </td>
         </tr>
         <tr id="bat_id"> 
           <td class="blue">预存款</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="prepayFee" size="16" maxlength="12" value=<%=prepayFee%>>
           </td>
           <td class="blue">补收月租</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="predelFee" size="12" maxlength="10" value=<%=predelFee%>>
           </td>
         </tr>
         <tr id="phoneId"> 
           <td class="blue">手机号码</td>
           <td colspan="3"> 
             <input type="text" readonly class="InputGrey" name="phoneNo" size="16" maxlength="11" value=<%=phoneNo%> >
           </td>
        </tr>
       </table>
		  
		  </div>
		  
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">账单明细</div>
			</div>
		  
       <table style="cursor:hand" cellspacing="0">
         <tr align="center"> 
             <th>&nbsp;</th>
	           <th>手机号码</th>
	           <th>帐单年月</th>            
	           <th>帐单状态</th>
	           <th>开始时间</th>
	           <th>结束时间</th>                        
	           <th>欠费金额</th>
	           <th>滞纳金</th>
	           <th>应收金额</th>
	           <th>优惠金额</th>
	           <th>预存划拨</th>
	           <th>新交款</th>
         </tr>
		 <%
		 		String tbClass="";
			  for (int i=0;i<result2.length;i++){
			  	if(i%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
		%>
					<tr align="center">
		<%
		  		if ( busy_type.equals("2") ){
		%>
					 
					   <td> 
			         <input type="checkbox" name="checkbox" value=<%=result2[i][0]%> checked onclick="">
			       </td>
    <%
            }else{
    %>
	           <td>&nbsp;</td>
    <%
     				}
    %>
           <a href="f1500ConFee.jsp?idNo=<%=idNo.trim()%>&yearMonth=<%=result2[i][1]%>&phoneNo=<%=phoneNo%>&contractNo=<%=count%>&billBegin=<%=result2[i][3]%>&billEnd=<%=result2[i][4]%>&statusName=<%=result2[i][2]%>" target="_blank">
	           <td class="<%=tbClass%>"><%=result2[i][0]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][1]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][2]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][3]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][4]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][5]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][6]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][7]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][8]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][9]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][10]%></td>    
           </a>
         </tr>
		<%
		 	}
		%>
       </table>
        
       <TABLE cellSpacing="0">
         <TR> 
           <td noWrap colspan="6" id="footer"> 
             <div align="center"> 
               <input type="button" name="return" class="b_foot" value="返回" onClick="window.history.go(-1)">
               <input type="button" name="return" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
            </td>
         </TR>
       </TABLE>
        
       <%@ include file="/npage/include/footer.jsp" %>
</FORM>
 
</body>
</html>
