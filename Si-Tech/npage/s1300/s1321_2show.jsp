<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String workno = (String)session.getAttribute("workNo");				//操作工号
	String regionCode = (String)session.getAttribute("regCode");		//地市
	String phoneNo = "";
	// xl add for 发票号码 begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workno;
	%>
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
<%
	result_check = retList;
	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag=result_check[0][1];
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	// xl add for 发票号码 end
	String i_contract_no = request.getParameter("contract_no");
  	String i_year_month = request.getParameter("year_month");//收据的年月
	String i_year_month_end = request.getParameter("year_month_end");	
	String i_begin_ym = request.getParameter("begin_ym");//发票的年月
	String i_begin_ym_end = request.getParameter("begin_ym_end");
	/*liyan 20080514 加入限制条件：
	1、不可打当月发票，即开始时间、结束时间为当月也不可以，提示：请出帐后再兑换发票
	2、限制收据、发票开始月份同结束月份时间跨度最大为三个月
	3、如果有用户选择的三个月内，存在欠费的情况，会提示那个月欠费，并不允许对换
	4、如果有用户选择的三个月内，所有的交费都对换过发票，则提示已经兑换过发票，
	5、其它情况显示错误代码
	*/
	if (i_year_month_end.equals(dateStr) || i_begin_ym_end.equals(dateStr)  )
	{
	%>
	     <script language="JavaScript">
	        rdShowMessageDialog("请出帐后再兑换发票! "); 
	        window.location="s1321_2.jsp";
        </script>
	<%
	}
else{
		String year_month_num = "";
		String begin_ym_num = "";
	  String[] inParas2 = new String[]{""};
	  //取收据开始月份同收据结束月份时间跨度
	  inParas2[0]="select to_char(Months_Between(to_date(?,'yyyymm'),to_date(?,'yyyymm')) + 1)   from dual ";
		System.out.println("收据="+inParas2[0]);
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=inParas2[0]%></wtc:sql>
	  <wtc:param value="<%=i_year_month_end%>"/>
	  	<wtc:param value="<%=i_year_month%>"/>
	</wtc:pubselect>
	<wtc:array id="ret_val" scope="end" />
<%	
		if(ret_val.length==1)
		{
		    year_month_num = ret_val[0][0];
		}
		//取发票开始月份同发票结束月份时间跨度
		inParas2[0]="select to_char(Months_Between(to_date(?,'yyyymm'),to_date(?,'yyyymm')) + 1)   from dual ";
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=inParas2[0]%></wtc:sql>
	<wtc:param value="<%=i_begin_ym_end%>"/>
	  	<wtc:param value="<%=i_begin_ym%>"/>
	</wtc:pubselect>
	<wtc:array id="ret_val" scope="end" />
<%	
		if(ret_val.length==1)
		{
		    begin_ym_num = ret_val[0][0];
		}			
	
  if (Integer.parseInt(year_month_num)>30 || Integer.parseInt(begin_ym_num)>30  )
	{
	  %>
        <script language="JavaScript">
	        rdShowMessageDialog("收据、发票开始月份同结束月份时间跨度最大为三0个月，请重新输入! "); 
	        window.location="s1321_2.jsp";
        </script>
      <%
	}
else
  {		
	String[] inParas = new String[6];
	inParas[0] = i_contract_no;
	inParas[1] = i_year_month;
	inParas[2] = i_year_month_end;
	inParas[3] = i_begin_ym;
	inParas[4] = i_begin_ym_end;
	inParas[5] = workno;
	
	  if (i_year_month.equals(dateStr)||i_begin_ym.equals(dateStr)){
%>
        <script language="JavaScript">
	        rdShowMessageDialog("请出帐后再兑换发票! "); 
	        window.location="s1321_2.jsp";
        </script>
<%  }
else
  {
//	  SPubCallSvrImpl impl = new SPubCallSvrImpl(); 
	  int [] lens ={1,6,7,1,1};
// 	CallRemoteResultValue value = viewBean.callService("2",i_contract_no,"s1322Init","16",lens,inParas);
// 	ArrayList retList  = value.getList();
%>
	<wtc:service name="s1322Init" routerKey="region" routerValue="<%=regionCode%>" outnum="18" retcode="retCode3" retmsg="retMsg3">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="6" scope="end"/>
	<wtc:array id="result2" start="7" length="7" scope="end"/>
	<wtc:array id="result3" start="14" length="1" scope="end"/>
	<wtc:array id="result4" start="15" length="1" scope="end"/>
	<wtc:array id="result5" start="16" length="2" scope="end"/>
<%
	//1-6查的 dcustowetotal
	//7-14查的 wpay wpay的出参里增加 通过tpcall_crm展示出来的 已打印的金额
	//再增加循环的 展示查询临时表后查出来的值
	String return_code = retCode;
	String return_msg = retMsg3;
	String return_msg3 =retMsg3;
	return_code = result0[0][0];	
	
	double yingsou = 0.00;
	double d_pay=0.0;//d冲销的钱
	double wpay_yikaiju=0.0;//wpay已经开发票的钱
	if (retCode3.equals("000000")  && result0.length >0) 
	{
		  return_code = result0[0][0];	    
	}
	if (retCode3.equals("000000")  && result4.length >0) 
	{
		  return_msg = result4[0][0];	
	}
  if (return_code.equals("000000")) {
	  
	   for (int i = 0; i < result1.length; i++) 
	   { 
	       yingsou += Double.parseDouble(result1[i][5]);	       
	   }		    
	   //xl add 营改增
	   
	  // wpay_yikaiju=Double.parseDouble(result5[0][0]);//已开具
	  // d_pay=Double.parseDouble(result5[0][1]);//本次开具
	}
	
 if (!return_code.equals("000000")&&!return_code.equals("0") ) 
 {
    %>
		<script language="JavaScript">
			//alert("test "+"<%=return_code%>"+" return_msg is "+"<%=return_msg%>"+" return_msg3 is "+"<%=return_msg3%>");
        </script>
	<%
	if (return_code.equals("133078"))
    {
    %>
        <script language="JavaScript">
        rdShowMessageDialog("<%=return_msg%>"); 
        //rdShowMessageDialog("该收据已经兑换过发票! "); 
        window.location="s1321_2.jsp";
        </script>
    <%
    }
    else if (return_code.equals("133060"))
    {
    %>
        <script language="JavaScript">
        rdShowMessageDialog("<%=return_msg%>"); 
        window.location="s1321_2.jsp";
        </script>
   <%      
    }
    else
    {
      %>
        <script language="JavaScript">
        rdShowMessageDialog("收据兑换月消费发票错误!'<%=return_msg3%>'。",0);
    // rdShowMessageDialog("<%=return_code%>"); 
        window.location="s1321_2.jsp";
        </script>
   <%    
    }
  }  
  else 
  { %>
  
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-兑换发票</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doPrintSubmit() {
	getAfterPrompt();
	if(div1.innerText<0) {
	   rdShowMessageDialog("选择的缴费合计小于实收费用，请重新选择!");
	   return false;
	}
	
	var unchangeCheckBoxs = document.getElementsByName("unchange");
	var xx = 0;
	for(var ii = 0;ii<unchangeCheckBoxs.length;ii++){
		if(unchangeCheckBoxs[ii].checked){
			xx++;
		}
	}
	
	if(xx==0){
		rdShowMessageDialog("请选择一项",0);	
		return false;
	} 
	else 
	{ 
		/*
		if(rdShowConfirmDialog("当前发票号码是"+"<%=check_seq%>"+",是否打印发票?")==1)
		{
			document.all.check_seq.value="<%=check_seq%>";
			document.all.s_flag.value="<%=s_flag%>";
			document.form.submit();
		}
		else
		{
			return false;
		}
		*/
		document.form.submit();
    }
 }

function test(){
 
	var k = <%=result2.length%>;
	var sum = 0;
    var accept = "";
    var contract = "";
    var year = "";

	if (k == 1) {
	   if(document.form.unchange.checked){
		  var s = document.form.unchange.value;	
		  sum += parseFloat(s.split(",")[5]);
		  accept += s.split(",")[3];
		  contract += s.split(",")[2];
          year += s.split(",")[6];  		
	   }
	} else {
	   for(var i=0;i < k;i++){
		  if(document.form.unchange[i].checked){
			 var s = document.form.unchange[i].value;	
			 sum += parseFloat(s.split(",")[5]);
			 accept += s.split(",")[3]+"|";
			 contract += s.split(",")[2]+"|";
             year += s.split(",")[6]+"|";  		
		  }
	   }
	}
  
	div1.innerText = Math.round((parseFloat(sum)-parseFloat(document.form.yingsou.value))*100)/100;
	
	document.form.accept.value=accept;
	document.form.contract.value=contract;
  document.form.paymoney.value=sum;
  document.form.year.value=year;
	//alert("div1.innerText is "+div1.innerText+" and paymoney is "+sum+" and year is "+year+" document.form.accept.value is "+document.form.accept.value);
}  
//-->
</SCRIPT>
</HEAD>
<BODY>
<FORM action="s1321_2print.jsp" method=post name="form">
	 <%@ include file="/npage/include/header.jsp" %>
  <INPUT TYPE="hidden" name="yingsou" value="<%=yingsou%>">
   <INPUT TYPE="hidden" name="accept">
  <INPUT TYPE="hidden" name="contract" value="">
  <INPUT TYPE="hidden" name="year" value="">
  <INPUT TYPE="hidden" name="paymoney" value="">
  <INPUT TYPE="hidden" name="work_no" value="<%= workno%>">
  <INPUT TYPE="hidden" name="contract_no" value="<%=i_contract_no%>">
  <INPUT TYPE="hidden" name="year_month" value="<%=i_year_month%>">
  <INPUT TYPE="hidden" name="year_month_end" value="<%=i_year_month_end%>">
  <INPUT TYPE="hidden" name="begin_ym" value="<%=i_begin_ym%>">
  <INPUT TYPE="hidden" name="begin_ym_end" value="<%=i_begin_ym_end%>">

<input type="hidden" name="check_seq">
<input type="hidden" name="s_flag">
<input type="hidden" name="d_pay" value="<%=d_pay%>"> 
<input type="hidden" name="wpay_yikaiju" value="<%=wpay_yikaiju%>">
	<div class="title">
		<div id="title_zi">兑换发票
	</div>
</div>

<table cellspacing="0" align="center" >
	<tr> 
		<td colspan="3" class="blue">兑换类型</td>
		<td colspan="5" class="blue">收据兑换等额发票</td>
	</tr>
	<tr>
		<th>选择</th>
		<th>用户名称</th>
		<th>手机号码</th>
		<th>帐户号码</th>
		<th>缴费流水</th>
		<th>付费类型</th>
		<th>缴费金额</th>
		<th>收据时间</th>
	</tr>
	<input type="text" name="phoneNo" value="<%=result2[0][1]%>">
	
		<% for(int i=0;i<result2.length;i++)
	  {
	  		String tdClass = ((i%2)==1)?"Grey":"";
		%>
			<tr> 
			  <td class="<%=tdClass%>"><input type="checkbox" name="unchange"  value="<%=result2[i][0].trim()%>,<%=result2[i][1].trim()%>,<%=result2[i][2].trim()%>,<%=result2[i][3].trim()%>,<%=result2[i][4].trim()%>,<%=result2[i][5].trim()%>,<%=result2[i][6].trim()%>"   onclick="test()"></td>
			  <td class="<%=tdClass%>"><%=result2[i][0]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][1]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][2]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][3]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][4]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][5]%></td>
			  <td class="<%=tdClass%>"><%=result2[i][6]%></td>
			</tr>
    <%}%>
</table>
		
 <table cellspacing="0">
	<tr> 
		<th><b>月消费年月</b></th>
		<th><b>应收</b></th>
		<th><b>优惠</b></th>
		<th><b>滞纳金</b></th>
		<th><b>补收月租</b></th>
		<th><b>实收</b></th>
	</tr>
	  <% 
        for (int i = 0; i < result1.length; i++) {	
        	String tdClass = ((i%2)==1)?"Grey":"";			             
	  %>
   <tr> 
      <td  nowrap class="<%=tdClass%>"><%=result1[i][0]%></td>
				<td  nowrap class="<%=tdClass%>"><%=result1[i][1]%></td>
				<td  nowrap class="<%=tdClass%>"><%=result1[i][2]%></td>
				<td  nowrap class="<%=tdClass%>"><%=result1[i][3]%></td>
				<td  nowrap class="<%=tdClass%>"><%=result1[i][4]%></td>
				<td  nowrap class="<%=tdClass%>"><%=result1[i][5]%></td>
   </tr>
	  <% } %>
                   
	<tr> 
		<td  nowrap>发票余额</td>
		<td  nowrap>&nbsp;<div id="div1"></div></td>
		<td  nowrap>&nbsp;</td>
		<td  nowrap>&nbsp;</td>
		<td nowrap>&nbsp;</td>
		<td nowrap>&nbsp;</td>
	</tr>
	
    <tr>
    	<td id="footer" colspan="6">
	        <input class="b_foot" type="button" value=打印 onclick="doPrintSubmit()">
			&nbsp;
	        <input class="b_foot" type="button" value=返回 onclick="history.go(-1)">
        </td>
    </tr>
     
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% }}}} %>
