<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
 

<%
 String opCode = "g578";
  String opName = "物联网个人账单查询"; 
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

System.out.println("---------------------------s1351Cfm.jsp---------------------------");
DecimalFormat df = new DecimalFormat("#0.00");
String sm_code = new String();
String printway=request.getParameter("printway");//打印方式
String phoneNo = request.getParameter("phoneNo");
String phone_new="";
//xl add 转换 10648的不转
//147的可能也不转
if(phoneNo.substring(0,4)=="1064" ||phoneNo.substring(0,4).equals("1064"))
//if((phoneNo.substring(0,5)=="10648" ||phoneNo.substring(0,5).equals("10648")) ||(phoneNo.substring(0,3)=="147" ||phoneNo.substring(0,3).equals("147")))
{
 
	String[] inparas=new String[2];
	inparas[0]="select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno = :p_no ";
	inparas[1]="p_no="+phoneNo;
	%>
		<wtc:service name="TlsPubSelBoss"  outnum="1" >
			<wtc:param value="<%=inparas[0]%>"/>
			<wtc:param value="<%=inparas[1]%>"/>
		</wtc:service>
		<wtc:array id="sm_name_arr" scope="end" />

	<%
	if(sm_name_arr!=null&&sm_name_arr.length>0)
	{
		phone_new=sm_name_arr[0][0];
	}
}
else
{
	phone_new=phoneNo;
}
//xl add 判断品牌 begin
String s_sm_code="";
String s_run_code="";
String[] inparas_pp=new String[2];
inparas_pp[0]="select sm_code ,substr(run_code,2,1) from dcustmsg where phone_no=:s_no";
inparas_pp[1]="s_no="+phone_new;
%>
<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inparas_pp[0]%>"/>
	<wtc:param value="<%=inparas_pp[1]%>"/>
</wtc:service>
<wtc:array id="sm_name_code" scope="end" />
<%
	if(sm_name_code.length>0)
	{
		s_sm_code=sm_name_code[0][0];
		s_run_code=sm_name_code[0][1];
	}
	if(s_sm_code=="PB" ||s_sm_code.equals("PB"))
	{
		
		System.out.println("phoneNo="+phoneNo);
		String contract_no = request.getParameter("contract_no");
		System.out.println("contract_no="+contract_no);
		String contract_no_sign = contract_no;
		String beginDate= request.getParameter("beginDate");
		/*
		String custPasswd = WtcUtil.repNull(request.getParameter("password"));//用户帐户密码
		System.out.println("---------------------------custPasswd---------------------------"+custPasswd);
		System.out.println("wxy="+custPasswd);*/
			String custPass = request.getParameter("password");
			System.out.println("AAAAAAAAAAAAAAAAAAAAAAAaa custPass is "+custPass);
			custPass = Encrypt.encrypt(custPass);
			System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbb custPass is "+custPass);  
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
		String rtnPage = "/npage/g578/g578_1.jsp";
		String password="";
		int row_count = 51;
		int num=0;
		 
		 
		//System.out.println("phoneNo="+phoneNo);
		 
		 
		String[] args=new String[4];
		args[0]=phone_new;
		args[1]=contract_no;
		args[2]=beginDate;
		args[3]=workno; 

		 

			int flag = 0;  //查询结果标签 0：正确 1：出错
		%>
		 <wtc:service name="se610boss" outnum="15" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
					<wtc:param value="<%=args[0]%>" />
					<wtc:param value="<%=args[1]%>" />	
					<wtc:param value="<%=args[2]%>" /> 	
					<wtc:param value="<%=args[3]%>" /> 
					<wtc:param value="<%=custPass%>" />
				</wtc:service>

			<wtc:array id="r_return_code" scope="end" start="0"  length="1" />	
			<wtc:array id="fee_code" scope="end" start="1"  length="1" />	 
			<wtc:array id="fee_id_3" scope="end" start="2"  length="1" />
			<wtc:array id="fee_money" scope="end" start="3"  length="1" />
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
		 
			errCode=code2;
			errMsg=msg2;
			/*System.out.println("--------------errCode-------------s1351.jsp----------------"+errCode);
			System.out.println("errCode="+errCode+"  errMsg="+errMsg);
			System.out.println("errCode="+r_return_code[0][0]+"  errMsg="+r_return_msg[0][0]);
			*/
			if(!errCode.equals("000000"))
			{  
				flag=1;
		%>
				<script>		
					rdShowMessageDialog('<%=errCode%>:<%=errMsg%>',0);
					document.location.replace('<%=rtnPage%>');
				</script>
		<%
			} 
			else
			{
				flag=0;
				int rownum0=fee_code.length; //总行数 ？
				int f = fee_flag.length;
				for(int i =0;i<rownum0;i++)
				{
					%>
					<script language="javascript">
						 
						//alert("test 总行数 is "+"<%=rownum0%>" ); 
						//alert("test fee_flag is "+"<%=fee_flag[i][0]%>" ); 
						  
					</script>
					<%
				}
				
					 
			 
		%>
		<HTML>
		<HEAD>
		<script language="javascript">
			function inits(runcode)
			{
			  // alert("123 "+runcode);
			   if(runcode=="s")
			   {
				   rdShowMessageDialog("用户当前状态不允许办理账单查询业务!");
				   history.go(-1);
			   }	
		    }
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<TITLE><%=opName%></TITLE>
		<link rel="stylesheet" href="../e610/reset.css" media="all" />
		<link rel="stylesheet" href="../e610/bills1.css" media="all" />
		<link rel="stylesheet" href="../e610/print-reset.css" media="print" />
		<%
			if (flag==0){
		%>
		 
		</HEAD>
		<BODY onload="inits('<%=s_run_code%>')" class="email" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
		<!-------------------                  新账单内容开始                    -------------------------->

		<div class="container">
		 
		 <div align="center"><h2><b>中国移动通信客户账单</b></h2></div> 
		 
			<table width="96%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
			  <tr>
				<th width="100">客户号码</th>
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

			   
		   <table width="94%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
			
			  <tr>
				 <td colspan=1>一级账目项</td><td colspan=1>二级账目项</td><td colspan=2>三级账目项</td> <td rowspan=2>应收费用</td><td rowspan=2>优惠费用</td><td rowspan=2>实收费用</td>
			  </tr>
			  <tr>
				 <td>名称</td> <td>名称</td> <td>名称</td><td>代码</td>  
			  </tr>
			 <%
					for(int i =0;i<rownum0;i++)
					{
						 
						if((fee_flag[i][0]=="1")||fee_flag[i][0].equals("1"))
						{
							
							%>
							<tr>
								<td rowspan="<%=Integer.parseInt(row_num[i][0])%>"><%=fee_code[i][0]%><%=i%>    </td>
								<%
									
									if((fee_flag[i+1][0]=="2")||fee_flag[i+1][0].equals("2"))
									{
										 
										%>
											<td rowspan="<%=Integer.parseInt(row_num[i+1][0])%>"><%=fee_code[i+1][0]%>    </td>
										<%  
									} 
								%>
								<%
									if((fee_flag[i+2][0]=="3")||fee_flag[i+2][0].equals("3"))
									{
										 
										%>
											<td  >  <%=fee_code[i+2][0]%> </td>
									 <td  >  <%=fee_id_3[i+2][0]%></td>
									 <td >  <%=fee_money[i+2][0]%></td>
									 <td >  <%=fee_favor[i+2][0]%></td>
									 <td  >  <%=fee_act[i+2][0]%></td>
										<%  
									}
									//i=i+Integer.parseInt(row_num[i][0]);//i=0+3	  3 6+2
									
								%>
							</tr>
							<%  i=i+2;continue;
						}  
						if((fee_flag[i][0]=="2")||fee_flag[i][0].equals("2"))
						{
							 
							%>
							<tr>
								<td rowspan="<%=Integer.parseInt(row_num[i][0])%>"><%=fee_code[i][0]%>    </td>
								<%
									if((fee_flag[i+1][0]=="3")||fee_flag[i+1][0].equals("3"))
									{
										%>
											<td  >  <%=fee_code[i+1][0]%> </td>
									 <td >  <%=fee_id_3[i+1][0]%></td>
									 <td >  <%=fee_money[i+1][0]%></td>
									 <td  >  <%=fee_favor[i+1][0]%></td>
									 <td  >  <%=fee_act[i+1][0]%></td>
										<% 
									} //i=i+Integer.parseInt(row_num[i][0])+1; //i=3+1
								%>
								
							</tr>
							<%  i=i+1;continue;
						} 
						if((fee_flag[i][0]=="3")||fee_flag[i][0].equals("3"))
						{
							 %>
							<tr>
								<td  >  <%=fee_code[i][0]%> </td>
									 <td  >  <%=fee_id_3[i][0]%></td>
									 <td  >  <%=fee_money[i][0]%></td>
									 <td  >  <%=fee_favor[i][0]%></td>
									 <td  >  <%=fee_act[i][0]%></td>
							</tr>
							<% //i=i+Integer.parseInt(row_num[i][0]); 
							continue; 
						}
						%>
						
						<tr>
							<%
								if((fee_flag[i][0]=="4")||fee_flag[i][0].equals("4"))
								{
											%><td colspan="3">小计</td> <td> <%=fee_money[i][0]%> </td>
											  <td><%=fee_favor[i][0]%></td>
											   <td> <%=fee_act[i][0]%></td>
											<%
											
								}
								
							%>
						</tr>
						<%
								//i=i+Integer.parseInt(row_num[i][0])-1;  //i=0+3	-1
								 
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
		 
			
			
		  
		 
			
		 
			
		<div align="center">
			<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" width="0" height="0" id="wb" name="wb"></OBJECT> 
			<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
			<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
		  codebase="smsx.cab#Version=6,3,436,14">
			</object>
		 
			<input type="button" name="print"  class="b_foot" value="打印" onclick="javascript:window.print();">
			<!--
			<input type="button" value="打印设置" class="b_foot" title="打印设置" onClick="document.all.wb.ExecWB(8,1)"/>
			<input type="button" value="打印预览" class="b_foot" title="打印预览" onClick="PageSetup_Null();document.all.wb.ExecWB(7,1)"/>
			 -->
			 &nbsp;&nbsp;&nbsp;&nbsp;
			 <input type="button"  class="b_foot"value="返回" title="返回" onClick="window.location='g578_1.jsp?opCode=g578&opName=物联网个人账单查询&crmActiveOpCode=g578'" />
			 &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button"  class="b_foot"value="关闭" title="关闭" onClick="window.close()" />
		</div>
		</div>

		 

		<!-------------------                  新账单内容结束                    -------------------------->

		</BODY>
		</HTML>
		<%}
		}
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("非物联网号码不允许办理!");
				history.go(-1);
			</script>
		<%
	}
//end of 品牌

 
 

%>
