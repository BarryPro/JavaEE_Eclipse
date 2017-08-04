<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String op_code="9129";
	String op_name = "SP订购日志查询";
	String opCode = op_code;
	String opName =op_name;
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
	//String[][] fiveInfoSession = (String[][])arrSession.get(4);
	String workpw = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	
	
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("z")||workNo.substring(0,1).equals("Z"))
		workNoFlag=true;
	

	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	int rows=0;
	String errcode="000000";
	String errmsg="";
	String[][] result0=null;
	String[][] result1=null;
	String[][] result2=null;
	String phoneNo = "" ;
	String ipAddr=request.getRemoteAddr();;
	String opNote = "";
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	String beginDate="";
	String endDate="";
	String disPlay = request.getParameter("disPlay") ;
	
	
	if("yes".equals(disPlay)){
		phoneNo=request.getParameter("phoneNo") ; 
		beginDate=request.getParameter("beginDate") ;
		endDate=request.getParameter("endDate") ;
%>
		<wtc:service name="s9129Qry" outnum="17" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=org_code%>"/>
			<wtc:param value="<%=workpw%>"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=beginDate%>"/>
			<wtc:param value="<%=endDate%>"/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=opNote%>"/>
			<wtc:param value="<%=beginPos%>"/>
			<wtc:param value="<%=MaxNum%>"/>
		</wtc:service>
		<wtc:array id="r0" start="0" length="3" scope="end" />
		<wtc:array id="r1" start="3" length="3" scope="end" />
		<wtc:array id="r2" start="6" length="11" scope="end" />
<%
		errcode=retCode;
		errmsg=retMsg;
		result0=r0;
		result1=r1;
		result2=r2;
	}
	else{
		//初始化查询日期
		GregorianCalendar   gc   =   (GregorianCalendar)   Calendar.getInstance();   
		gc.setTime(new java.util.Date());   
		gc.add(Calendar.MONTH,   -1);
		beginDate = new java.text.SimpleDateFormat("yyyyMM").format(gc.getTime());
		beginDate = beginDate+"01" ;
		endDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	}
	
	if(!errcode.equals("000000"))
	{
%>
		<script language='jscript'>
			rdShowMessageDialog('<%=errmsg%>' + '[' + '<%=errcode%>' + ']',0);
			history.go(-1);
		</script>
<%
	}else{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="javascript">
	onload=function()
	{
<%
		if(workNoFlag){
%>
			document.all.phoneNo.value=<%=userPhoneNo%>;
			document.all.phoneNo.readOnly=true;
			document.all.qryBtn.focus();
<%  	
		}
%>  
	}

	function doCheck(){
		if(!check(document.form1)){
			return false;			
		}
		if(parseInt(document.form1.beginDate.value)>parseInt(document.form1.endDate.value)){
			rdShowMessageDialog("开始时间不能大于结束时间！",0);
			document.form1.beginDate.focus();
	    	return false;
		}
		document.form1.action="f9129_1.jsp";
		document.form1.submit();
	}

</script>
</HEAD>

<body>
<FORM  method=post name="form1" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SP订购日志查询</div>
</div>
	<input type="hidden" name="disPlay"  value="yes">
	
<table cellspacing="0">
		<tr> 
			<td class="blue">手机号码</td>
			<td colspan="3">
				<input type="text" name="phoneNo" maxlength="11" value="<%=phoneNo%>" v_must="1" v_type="mobphone" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td class="blue">开始时间</td>
            <td>
            	<input name="beginDate" type="text" value="<%=beginDate%>" v_must="0" v_type="date">
            </td>
            <td class="blue">结束时间</td>
            <td>
            	<input name="endDate" type="text" value="<%=endDate%>" v_must="0" v_type="date">
            </td>
		</tr>
		<tr id="footer"> 
			<td colspan="4" align="center">
				<input type="button" name="qryBtn" class="b_foot" value="查询" onclick="doCheck()">
				&nbsp;&nbsp;
				<input type="reset" name="qryBtn" class="b_foot" value="重置" >
			</td>
		</tr>
	</table>
	</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
<table cellspacing="0">
		<tr>
			<th>序号</th>
			<th>订购或操作类型</th>
			<th>订购或操作渠道</th>
			<th>订购或操作时间</th>
			<th>交互信息内容</th>
		</tr>
	<%
		if(result2 != null){
			rows=result2.length;
		}
		if(rows<1){
	%>
		<tr><td colspan="5" align = "center"><b><font class="orange">无查询结果</font></td></tr>
	<%
		}
			
		for(int i=0;i<rows;i++){
		    String tdClass = "";            
            if (i%2==0){
                 tdClass = "Grey";
            }
	%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';this.style.cursor='hand'">
			<td class="<%=tdClass%>"><%=(iStartPos+i+1)%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][2]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][4]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][10]%>&nbsp;</td>
			<td class="<%=tdClass%>"><%=result2[i][9]%>&nbsp;</td> 
		</tr>
	<%
		}
	%>
		<tr id="footer">
			<td colspan="5" align="right">
				<%
					int iQuantity=0;
					if(result1!=null){
					    iQuantity = Integer.parseInt(result1[0][0]);
					}
				    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
					PageView view = new PageView(request,out,pg); 
				   	view.setVisible(true,true,0,1);       
				%>
			</td>
		</tr>
	</table>
	
	<%@ include file="/npage/include/footer.jsp" %>
	
	</FORM>
	</BODY>
</HTML>

<%}%>
