   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "3479";
  String opName = "新帐单打印";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %> 
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>
<link rel="stylesheet" href="reset.css" media="all" />
<link rel="stylesheet" href="bills1.css" media="all" />
<link rel="stylesheet" href="print-reset.css" media="print" />
<%
//String workNo = (String)session.getAttribute("workNo");
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

System.out.println("---------------------------s1351Cfm.jsp---------------------------");
DecimalFormat df = new DecimalFormat("#0.00");
String sm_code = new String();
 
String phoneNo = request.getParameter("phoneNo");
System.out.println("11111111phoneNo="+phoneNo);
String contract_no = "";//request.getParameter("contract_no");
System.out.println("222222222contract_no="+contract_no);
String contract_no_sign = contract_no;
String beginDate= request.getParameter("beginDate");

//xl add begin
String[] inParas = new String[2];
String date_minus="";
inParas[0]="select to_char(months_between(to_date(to_char(sysdate,'yyyymm'),'yyyymm'),to_date( :begin_dt,'yyyymm'))) from dual";
inParas[1]="begin_dt="+beginDate;
String time_sql="select to_char(months_between(to_date(to_char(sysdate,'yyyymm'),'yyyymm'),to_date('"+beginDate+"','yyyymm')) )from dual";
%>
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=time_sql%></wtc:sql>
	 
	</wtc:pubselect>
	<wtc:array id="result41" scope="end" />
<%

if(result41!=null){
			if (result41.length>0) {
			   date_minus = result41[0][0];
System.out.println("BBBBBBBBBBBBBBBBBBBBBBB "+time_sql+" and is "+inParas[1]+" and is "+result41+" and is "+result41[0][0]);
			   if(Integer.parseInt(date_minus)>=6)
			   {
			System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+time_sql+" and is "+inParas[1]+" and is "+result41+" and is "+result41[0][0]);
				%>
				<script>		
					rdShowMessageDialog('超出5个月的查询范围',0);
			 
				</script>
			   <%
			   }
			   else
			   {
				   System.out.println("3333333333 beginDate="+beginDate);
String custPasswd = WtcUtil.repNull(request.getParameter("password"));//用户帐户密码
System.out.println("---------------------------custPasswd---------------------------"+custPasswd);
System.out.println("wxy="+custPasswd);
String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String ny = dateStr.substring(0,4);
String nm = dateStr.substring(4,6);
String nd = dateStr.substring(6,8);
Calendar cd = Calendar.getInstance();
Calendar cr = Calendar.getInstance();
cr.setTime(new Date());
String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
String zy = beginDate.substring(0,4);
String zm = beginDate.substring(4,6);
cd.clear();
cd.set(cd.YEAR,Integer.parseInt(zy));
cd.set(cd.MONTH,Integer.parseInt(zm)-1);
String zdf = cd.getActualMinimum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMinimum(cd.DAY_OF_MONTH) : "" + cd.getActualMinimum(cd.DAY_OF_MONTH);
String zdl = cd.getActualMaximum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMaximum(cd.DAY_OF_MONTH) : "" + cd.getActualMaximum(cd.DAY_OF_MONTH);
String errCode="";
String sql="";
String errMsg="";
String rtnPage = "/npage/login/s1300UnbillDetail.jsp";
String password="";
int row_count = 51;
int num=0;
int i = 0;
int j = 0;
int k=0;

String errCode2="";
String errMsg2="";
String[] args=new String[4];
args[0]=phoneNo;
	args[1]=beginDate;
	args[2]=contract_no;
	args[3]=workno;

  System.out.println("sql="+sql);
	String[][] agentCodeStr =new String[1][1]; 
	//System.out.println((String[][])co2.spubqry32("1",sql).get(0));
	%>
	
	
	
	<%
	
		
/*xl add for 新版账单
String[] args=new String[4];
args[0]=phoneNo;
args[1]=contract_no;
args[2]=beginDate;
args[3]=workno; 
*/
String[] args1=new String[4];
args1[0]=phoneNo;
args1[1]=contract_no;
args1[2]=beginDate;
args1[3]=workno; 
int flag = 0;
%>
<wtc:service name="se610boss" outnum="15" retmsg="r_msg2" retcode="rcode2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args1[0]%>" />
			<wtc:param value="<%=args1[1]%>" />	
			<wtc:param value="<%=args1[2]%>" /> 	
			<wtc:param value="<%=args1[3]%>" /> 
		</wtc:service>

	<wtc:array id="r_return_code1" scope="end" start="0"  length="1" />	
	<wtc:array id="fee_code" scope="end" start="1"  length="1" />	 
	<wtc:array id="fee_id_3" scope="end" start="2"  length="1" />
	<wtc:array id="fee_money1" scope="end" start="3"  length="1" />
	<wtc:array id="fee_favor" scope="end" start="4"  length="1" />
	<wtc:array id="fee_act" scope="end" start="5"  length="1" />
	<wtc:array id="fee_flag" scope="end" start="6"  length="1" />
	<wtc:array id="row_num" scope="end" start="7"  length="1" />
	<wtc:array id="fee_total" scope="end" start="8"  length="1" />
	<wtc:array id="fee_total_fav" scope="end" start="9"  length="1" />
	<wtc:array id="fee_total_act" scope="end" start="10"  length="1" />	
	<wtc:array id="sCustName" scope="end" start="11"  length="1" />	
	<wtc:array id="sSmName" scope="end" start="12"  length="1" />	
	<wtc:array id="lContractNo" scope="end" start="13"  length="1" />	
	<wtc:array id="sNote_ex" scope="end" start="14"  length="1" />	
 
	<%
 
	errCode2=rcode2;
	errMsg2=r_msg2;

	if(!errCode2.equals("000000")&&(!errCode2.equals("348904")))
	{  
		flag=1;
%>
		<script>		
			rdShowMessageDialog('11 ：<%=errCode2%>:<%=errMsg2%>',0);
			//document.location.replace('<%=rtnPage%>');
			history.go(-1);
		</script>
<%
    }
	else if(errCode2.equals("348904"))
	{
		//alert("123");
	}
	else
	{
		flag=0;
		int rownum0=fee_code.length; //总行数 ？
	    int f = fee_flag.length;
	  
		
			 
	 
%>
 
 
<link rel="stylesheet" href="reset.css" media="all" />
<link rel="stylesheet" href="bills1.css" media="all" />
<link rel="stylesheet" href="print-reset.css" media="print" />
<%
	if (flag==0){
%>
  <table width="98%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
      <tr>
        <th width="100"> 客户号码</th>
        <td width="200"><%=phoneNo%></td>

		<th width="100" align="left"> 客户姓名 </th>
        <td width="200"><%=sCustName[0][0]%> </td>
      </tr>
      <tr>
        <th width="100"> 品牌 </th>
        <td width="200"><%=sSmName[0][0]%> </td>

		<th width="100" align="left"> 账户号码 </th>
        <td width="200"><%=lContractNo[0][0]%> </td>
      </tr>	
	  <tr>
        <th width="100"> 计费周期 </th>
        <td colspan=3><%=zy%>年 <%=zm%>月 <%=zdf%>日 至<%=zy%>年 <%=zm%>月 <%=zdl%>日</td>
         
      </tr>
	  
</table>

	   
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
    
      <tr>
         <td colspan=1>一级账目项</td><td colspan=1>二级账目项</td><td colspan=2>三级账目项</td> <td rowspan=2>应收费用</td><td rowspan=2>优惠费用</td><td rowspan=2>实收费用</td>
	  </tr>
	  <tr>
		 <td>名称</td> <td>名称</td> <td>名称</td><td>代码</td>  
	  </tr>
	 <%
			for(int i0 =0;i0<rownum0;i0++)
			{
				 
				if((fee_flag[i0][0]=="1")||fee_flag[i0][0].equals("1"))
                {
					
					%>
					<tr>
						<td rowspan="<%=Integer.parseInt(row_num[i0][0])%>"><%=fee_code[i0][0]%>    </td>
						<%
							
							if((fee_flag[i0+1][0]=="2")||fee_flag[i0+1][0].equals("2"))
					        {
								 
								%>
									<td rowspan="<%=Integer.parseInt(row_num[i0+1][0])%>"><%=fee_code[i0+1][0]%>    </td>
								<%  
					        } 
						%>
						<%
							if((fee_flag[i0+2][0]=="3")||fee_flag[i0+2][0].equals("3"))
					        {
								 
								%>
									<td  >  <%=fee_code[i0+2][0]%> </td>
							 <td  >  <%=fee_id_3[i0+2][0]%></td>
							 <td >  <%=fee_money1[i0+2][0]%></td>
							 <td >  <%=fee_favor[i0+2][0]%></td>
							 <td  >  <%=fee_act[i0+2][0]%></td>
								<%  
					        }
							//i0=i0+Integer.parseInt(row_num[i0][0]);//i0=0+3	  3 6+2
							
						%>
					</tr>
					<%  i0=i0+2;continue;
				}  
				if((fee_flag[i0][0]=="2")||fee_flag[i0][0].equals("2"))
                {
					 
					%>
					<tr>
						<td rowspan="<%=Integer.parseInt(row_num[i0][0])%>"><%=fee_code[i0][0]%>    </td>
						<%
							if((fee_flag[i0+1][0]=="3")||fee_flag[i0+1][0].equals("3"))
					        {
								%>
									<td  >  <%=fee_code[i0+1][0]%> </td>
							 <td >  <%=fee_id_3[i0+1][0]%></td>
							 <td >  <%=fee_money1[i0+1][0]%></td>
							 <td  >  <%=fee_favor[i0+1][0]%></td>
							 <td  >  <%=fee_act[i0+1][0]%></td>
								<% 
					        } //i0=i0+Integer.parseInt(row_num[i0][0])+1; //i0=3+1
						%>
						
					</tr>
					<%  i0=i0+1;continue;
				} 
				if((fee_flag[i0][0]=="3")||fee_flag[i0][0].equals("3"))
                {
					 %>
					<tr>
						<td  >  <%=fee_code[i0][0]%> </td>
							 <td  >  <%=fee_id_3[i0][0]%></td>
							 <td  >  <%=fee_money1[i0][0]%></td>
							 <td  >  <%=fee_favor[i0][0]%></td>
							 <td  >  <%=fee_act[i0][0]%></td>
					</tr>
					<% //i0=i0+Integer.parseInt(row_num[i0][0]); 
					continue; 
				}
				%>
				
				<tr>
					<%
						if((fee_flag[i0][0]=="4")||fee_flag[i0][0].equals("4"))
						{
								 	%><td colspan="3">小计</td> <td> <%=fee_money1[i0][0]%> </td>
									  <td><%=fee_favor[i0][0]%></td>
									   <td> <%=fee_act[i0][0]%></td>
									<%
									
						}
						
					%>
				</tr>
				<%
						//i0=i0+Integer.parseInt(row_num[i0][0])-1;  //i0=0+3	-1
						 
						continue;			
			}
	 %>
      
						 
	  <tr>
		 <td colspan=4><div align="center">合计</div></td><td><%=fee_total[0][0]%></td><td><%=fee_total_fav[0][0]%></td><td><%=fee_total_act[0][0]%></td>
	  </tr>
	
		<tr>
			<td> <div align="center">温馨提示</div></td>
			<td colspan=6 > <%=sNote_ex[0][0]%> </td>
		</tr>
	  
	 <!--end 参数取值--> 
 
       
			 
	 
      
    </table>
 
 
	 

 
 
<%}
}%>
	 
	
	
	
	
    <wtc:service name="s3479" outnum="26" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args[0]%>" />
			<wtc:param value="<%=args[1]%>" />	
			<wtc:param value="<%=args[2]%>" />
			<wtc:param value="<%=args[3]%>" />		
	</wtc:service>

	<wtc:array id="r_return_code" scope="end" start="0"  length="1" />	
	<wtc:array id="r_cust_name" scope="end" start="1"  length="1" />	 
	<wtc:array id="r_post_name" scope="end" start="2"  length="2" />
	<wtc:array id="r_cust_addr" scope="end" start="4"  length="1" />
	<wtc:array id="r_fee_sum" scope="end" start="5"  length="1" />
	<wtc:array id="r_fee_item" scope="end" start="6"  length="1" />
	<wtc:array id="r_fee_money" scope="end" start="7"  length="1" />
	<wtc:array id="r_fee_level" scope="end" start="8"  length="1" />
	<wtc:array id="r_pay_other" scope="end" start="9"  length="1" />
	<wtc:array id="r_other_pay" scope="end" start="10"  length="1" />
	<wtc:array id="r_account_item" scope="end" start="11"  length="1" />
	<wtc:array id="r_account_money" scope="end" start="12"  length="1" />
	<wtc:array id="r_account_sum" scope="end" start="13"  length="1" />
	<wtc:array id="r_score_item" scope="end" start="14"  length="1" />
	<wtc:array id="r_score_value" scope="end" start="15"  length="1" />
	<wtc:array id="r_remain_score" scope="end" start="16"  length="1" />
	<wtc:array id="r_clean_score" scope="end" start="17"  length="1" />
	<wtc:array id="r_service" scope="end" start="18"  length="1" />
	<wtc:array id="r_service_code" scope="end" start="19"  length="1" />
	<wtc:array id="r_busi_name" scope="end" start="20"  length="1" />
	<wtc:array id="r_replace_fee" scope="end" start="21"  length="1" />
	<wtc:array id="r_replace_sum" scope="end" start="22"  length="1" />
	<wtc:array id="r_sm_name" scope="end" start="23"  length="1" />
	<wtc:array id="r_return_msg" scope="end" start="24"  length="1" />
		
	<%
 
	errCode=code2;
	errMsg=msg2;
	System.out.println("--------------errCode-------------s1351.jsp----------------"+errCode);
	System.out.println("errCode="+errCode+"  errMsg="+errMsg);
	System.out.println("errCode="+r_return_code[0][0]+"  errMsg="+r_return_msg[0][0]);
	if(!errCode.equals("000000") &&!errCode.equals("347904"))
	{  
%>
		<script>		
			alert("111 查询失败,错误代码："+"<%=r_return_code[0][0]%>"+"，错误信息："+"<%=r_return_msg[0][0]%>");
		</script>
<%
  }
  else if(errCode.equals("347904"))
  {
  }
  else
  {
	   //仿照积分 做一个
	   int max_row_fee = 0;
	   if(r_fee_item.length > r_fee_money.length)
		{
			max_row_fee = r_fee_item.length;
		}
		else
		{
			max_row_fee = r_fee_money.length;
		}
	    
		String[][] emo_list=new String[max_row_fee][3]; //费用项目 这个值emo_list 有三个参数 其中第一个是代表css样式 以便突出显示
		System.out.println("\n222222222222222222222 max_row_fee ="+max_row_fee+" r_fee_item.length is "+r_fee_item.length+" r_fee_money.length is "+r_fee_money.length+" and r_fee_level.length is "+r_fee_level.length);
		 
		for(i=0;i<max_row_fee;i++)
		{
	  	if(j>=max_row_fee)
	   			break;
	    if(num>=r_fee_item.length)
	    {
	    	 
	 	     break;
	 	   }
	  		emo_list[i][0] = r_fee_item[num][0]; //费用项
	  		emo_list[i][1] = r_fee_money[num][0];//金额
	  		emo_list[i][2] = r_fee_level[num][0];//显示的层次
	  		num++;
	  	j++;
  	}
  	
	

		int max_row = 0;
		if(r_account_item.length > r_score_item.length)
		{
			max_row = r_account_item.length;
		}
		else
		{
			max_row = r_score_item.length;
		}

		String[][] emo_conlist = new String[max_row][2];
		String[][] emo_marklist = new String[max_row][2];
		for(i=0;i<max_row;i++)
		{
			if(i >= r_account_item.length)
					break;
			emo_conlist[i][0] = r_account_item[i][0];
			emo_conlist[i][1] = r_account_money[i][0];
		}
		if(phoneNo.equals("")||phoneNo==null){}
		else
		{
			for(i=0;i<max_row;i++)
			{
				if(i >= r_score_item.length)
						break;
				emo_marklist[i][0] = r_score_item[i][0];
				emo_marklist[i][1] = r_score_value[i][0];	
			}
		}
%>

<HTML>
<HEAD>
<TITLE>话费明细查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>

	<body>
	 <DIV id="Operation_Table">      	
		<div class="title">
			 
		</div>
 
		<td valign=top>
		<table >
		<tr><td>
		 <table >
		    <th colspan="2" align = "center" height=34>账户信息</th>
			<tr>
				<td>账户项目</td>
				<td>账户项目金额</td>
			</tr>
			<%
	for(i=0;i<max_row;i++)
	{
%>
 		<tr >
  		 
  		<td  ><%=emo_conlist[i][0]==null?"":emo_conlist[i][0]%></td>
  		<td ><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><%=emo_conlist[i][1]==null?"":emo_conlist[i][1]%></td>
  		
 		</tr>
<%
	 }
%>
	<td >账户资金合计</td>
 			 
  		<td class=xl145><span
  				style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
      System.out.println("月末帐户余额＝"+r_account_sum[0][0]);
    
%>  		
			</span><%=df.format(Float.parseFloat(r_account_sum.length < 1?"0":r_account_sum[0][0]))%><span
  				style='mso-spacerun:yes'>&nbsp;</span></font></td>
		 </table>
		</td>
		<td>&nbsp;</td>
		<td valign=top>
		 <table>
		    <th colspan="2" align = "center" height=34>积分信息</th>
			<tr>
				<td>积分项目</td>
				<td>积分值</td>
			</tr>
			<%
	for(i=0;i<max_row;i++)
	{
%>
 		<tr >
  		 
  		<td  ><%=emo_marklist[i][0]==null?"":emo_marklist[i][0]%></td>
  		<td ><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><%=emo_marklist[i][1]==null?"":emo_marklist[i][1]%></td>
  		
 		</tr>
<%
	 }
%>

<%
      if((phoneNo==null)||("".equals(phoneNo))||(r_score_item.length<1))
      {
%>
      	
  		
<%
      }
      else
      {
%>  
 			 <td >本月剩余积分</td>
  		 <td ><%=r_remain_score.length < 1?"0":r_remain_score[0][0]%></td>  
<%
      }
%>  
		 </table>
		 </td></tr>
		 <tr><td colspan = "5"></td> </tr>
		 <tr><td colspan = "5">
			<table>
		    <th align = "center" colspan = "5" >代收信息费明细</th>
			<tr>
				<td>服务商</td>
				<td>服务代码</td>
				<td>订购业务名称</td>
				<td>代收费费用</td>
			</tr>
			<%
				for(i=0;i<r_service.length;i++)
 		{		
%>
 		<tr >
  		 
  		<td  ><%=(r_service[i][0].length()<=16?r_service[i][0]:r_service[i][0].substring(0,16))%></td>
 			 <td ><span style='mso-spacerun:yes'>&nbsp;</span><%=r_service_code[i][0]%></td>
  		<td ><%=(r_busi_name[i][0].length()<=18?r_busi_name[i][0]:r_busi_name[i][0].substring(0,18))%></td>
  		<td  ><%=df.format(Float.parseFloat(r_replace_fee[i][0]))%></td>
  		 
  	</tr>
<%	
 		 }
 
				
			%>
<tr >
  	<td><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;
  		</span>代收费信息合计:</td>
  		<td>　</td>
  		<td >　</td>
  	
  		<td  x:num="20"><%=df.format(Float.parseFloat(r_replace_sum.length < 1?"0":r_replace_sum[0][0]))%> 元</td>
  	          		
 		</tr>
		 </table>
		 </td></tr>
    </table>
		</td>
	 </tr>

 </table>
	</DIV>  	
</body>
</html>
<%   
     
    }
			   }	
			   
			}
		}
//xl add end






    
  
 
 
%>
