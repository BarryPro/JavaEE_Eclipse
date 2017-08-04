<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
<%
	String opCode ="g098"; //"d223";
	String opName = "拆包信息查询";//"退费统计";
 
	String beginYm = request.getParameter("beginYm");	
	String endYm = request.getParameter("endYm");	
	String regionCode= (String)session.getAttribute("regCode"); 
	String tfhm = request.getParameter("tfhm");
	//String custPass = request.getParameter("password");
	//custPass = Encrypt.encrypt(custPass);


	//xl add 月初第一天查询wcailing表 其他时间调服务 测试号码 13796139124
	String date_now = request.getParameter("date_now");
	//date_now = "20130401";
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA　date_now is "+date_now);
	String date_yc="";
	String date_yc_wcaimingimei="";
	String id_No="";
	String[] inParas2 = new String[1];
	inParas2[0]="select to_char(trunc(add_months(last_day(sysdate), -1) + 1), 'yyyymmdd'),to_char(ADD_MONTHS(sysdate,-1), 'yyyyMM') from dual ";
	%>
		<wtc:service name="TlsPubSelBoss"  outnum="2" >
			<wtc:param value="<%=inParas2[0]%>"/>
		</wtc:service>
		<wtc:array id="sid_date" scope="end" />
	<%
	date_yc=sid_date[0][0];
	date_yc_wcaimingimei=sid_date[0][1];
	if(date_now==date_yc ||date_now.equals(date_yc))
	{
		%>
			<script language="javascript">
				//alert("月初第一天查询");
			</script>
			<%
	 
				
				String inParas2_id[] = new String[2];
				inParas2_id[0]="select to_char(id_no) from dcustmsg where phone_No=:phoneNos";
				inParas2_id[1]="phoneNos="+tfhm;
				System.out.println("AAAAAAAAAAAAAAAAAA inParas2【0】 is "+inParas2[0]+" and ");
				%>
				<wtc:service name="TlsPubSelBoss" retcode="sid_code" retmsg="s_id_ret" outnum="1">
				<wtc:param value="<%=inParas2_id[0]%>"/> 
				<wtc:param value="<%=inParas2_id[1]%>"/>
			 
			</wtc:service>
			<wtc:array id="ret_id" scope="end" />
			<%
				if(ret_id==null||ret_id.length==0)
				{
					%>
						<script language="javascript">
							rdShowMessageDialog("查询用户基本情况失败,错误代码："+"<%=sid_code%>");
							window.location='g098_1.jsp';
						</script>
					<%
				}
				else
				{
			%>
				<%
				id_No=ret_id[0][0];
				String inParas_dy[] = new String[2];
			 
				inParas_dy[0] =" select a.phone_no,a.statis_month, b.function_name,nvl(a.chg_note,'拆包') from wcailingimeidata a,sfunccode b where id_no=:id_No and statis_month=:endYm  and flag='1' and a.op_code=b.function_code union select phone_no,year_month,'二码合一',nvl(chg_note,'拆包') from WG3Backchange where id_no=:id_no2 and year_month=:end_ym2 and back_flag='1'";
				inParas_dy[1] ="id_No="+id_No+",endYm="+date_yc_wcaimingimei+",id_no2="+id_No+",end_ym2="+date_yc_wcaimingimei;
				 
				String[] inParas2_new_dy = new String[2];
				inParas2_new_dy[0]="select to_char(a.op_time,'YYYYMMDD hh24:mi:ss') ,a.imei_no ,d.brand_name ,c.res_name from Wmachsndopr a, dchnresmobinfo b,dbchnterm.schnrescode c,schnresbrand d where trim(a.imei_no) = b.imei_no and b.res_code = c.res_code and d.brand_code = c.brand_code and a.id_no = :s_id_no and a.op_code in('1141','7981','e505','7955','8027','d069') and a.op_time > add_months(sysdate,-6) order by a.op_time desc";
				inParas2_new_dy[1]="s_id_no="+id_No;

				String s_opTime_dy="";
				String s_imei_no_dy="";
				String s_brand_name_dy="";
				String s_res_name_dy="";

			%> 
			<wtc:service name="TlsPubSelCrm"  outnum="4" >
					<wtc:param value="<%=inParas2_new_dy[0]%>"/>
					<wtc:param value="<%=inParas2_new_dy[1]%>"/>
				</wtc:service>
				<wtc:array id="scrm_arr_dy" scope="end" />
			<%
				if(scrm_arr_dy!=null&&scrm_arr_dy.length>0)
				{
					s_opTime_dy=scrm_arr_dy[0][0];
					s_imei_no_dy=scrm_arr_dy[0][1];
					s_brand_name_dy=scrm_arr_dy[0][2];
					s_res_name_dy=scrm_arr_dy[0][3];
				}
				else
				{
					%>
						<script language="javascript">
							//rdShowMessageDialog("用户未办理该营销案，请重新选择！");
							//history.go(-1);;
						</script>
					<%
				}
			%>



			<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="4">
				<wtc:param value="<%=inParas_dy[0]%>"/> 
				<wtc:param value="<%=inParas_dy[1]%>"/>
			 
			</wtc:service>
			<wtc:array id="ret_val" scope="end" />
			<%
			 
			if(ret_val==null||ret_val.length==0)
			{
			%> 
			<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">拆包返费情况查询</div>
				</div>
				<table cellspacing="0" id="tabList">
				<tr>
					<td>查询无结果</td>
				</tr>
				<tr>
			<td align="center" id="footer" colspan="8">
						 
					&nbsp; <input class="b_foot" name=back onClick="window.location='g098_1.jsp'" type="button" value="返回">
					&nbsp;  
					</td>
				</tr>
					</table>
				<% 
			}
			else
			{
				%><HEAD><TITLE>查询结果</TITLE>
			</HEAD>

			<body>
			 
			<FORM method=post name="frm1507_2">
				<%@ include file="/npage/include/header.jsp" %>
			<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">营销案办理情况</div>
			</div>

		<table cellspacing="0" id="queryMsgTab">
				<tr>
					<th>办理时间</th>
					<th>IMEI码</th>
					<th>品牌</th>
					<th>机型</th>
				</tr>
				<tr>
					<td><%=s_opTime_dy%></td>
					<td><%=s_imei_no_dy%></td>
					<td><%=s_brand_name_dy%></td>
					<td><%=s_res_name_dy%></td>
				</tr>
			</table>
				<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">拆包返费情况查询</div>
				</div>
				<table cellspacing="0" id="tabList">
				<tr>
					<th nowrap>手机号码</th>
					<th nowrap>统计年月</th>
					<th nowrap>业务名称</th>
					<th nowrap>备注</th>
				 
				<tr>
				<%
					  for(int y=0;y<ret_val.length;y++)
					  { 
				%>
						<tr>
				<%    	    for(int j=0;j<ret_val[0].length;j++)
							{
				%>
							  <td height="25" nowrap>&nbsp;<%= ret_val[y][j]%></td>
				<%	        }
				%>			 
						</tr>
				<%	   }
				%>
					<td align="center" id="footer" colspan="8">
						 
					&nbsp; <input class="b_foot" name=back onClick="window.location='g098_1.jsp'" type="button" value="返回">
					&nbsp;  
					</td>
				</tr>
			</table>
				<%@ include file="/npage/include/footer.jsp" %>
			</form>
			</body>
			</html><%
			}
					}
			%>	 
 
 	
 


		<%
	}
	else
	{
		%>
			<script language="javascript">
				//alert("非月初调服务查询");
			</script>
		<%

		//xl begin
		// xl add for crm侧查询 begin
			String s_op_code="";
			String[] inParas0 = new String[2];
			inParas0[0]="select to_char(id_no) from dcustmsg where phone_no=:phone_no ";
			inParas0[1]="phone_no="+tfhm;
			String s_idNo="";
			%>
				<wtc:service name="TlsPubSelBoss"  outnum="1" >
					<wtc:param value="<%=inParas0[0]%>"/>
					<wtc:param value="<%=inParas0[1]%>"/>
				</wtc:service>
				<wtc:array id="sid_arr" scope="end" />
			<%
				if(sid_arr!=null&&sid_arr.length>0)
				{
					s_idNo=sid_arr[0][0];
				}
				else
				{
					%>
						<script language="javascript">
							alert("查询id_no报错");
							history.go(-1);
						</script>
					<%
				}
			String[] inParas2_new = new String[2];
			inParas2_new[0]="select to_char(a.op_time,'YYYYMMDD hh24:mi:ss') ,a.imei_no ,d.brand_name ,c.res_name from Wmachsndopr a, dchnresmobinfo b,dbchnterm.schnrescode c,schnresbrand d where trim(a.imei_no) = b.imei_no and b.res_code = c.res_code and d.brand_code = c.brand_code and a.id_no = :s_id_no and a.op_code in('1141','7981','e505','7955','8027','d069') and a.op_time > add_months(sysdate,-6) order by a.op_time desc";
			inParas2_new[1]="s_id_no="+s_idNo;

			String s_opTime="";
			String s_imei_no="";
			String s_brand_name="";
			String s_res_name="";
		 %>
		 
				<wtc:service name="TlsPubSelCrm"  outnum="4" >
					<wtc:param value="<%=inParas2_new[0]%>"/>
					<wtc:param value="<%=inParas2_new[1]%>"/>
				</wtc:service>
				<wtc:array id="scrm_arr" scope="end" />
			<%
				if(scrm_arr!=null&&scrm_arr.length>0)
				{
					s_opTime=scrm_arr[0][0];
					s_imei_no=scrm_arr[0][1];
					s_brand_name=scrm_arr[0][2];
					s_res_name=scrm_arr[0][3];
				}
				else
				{
					%>
						<script language="javascript">
							//rdShowMessageDialog("用户未办理该营销案，请重新选择！");
							//history.go(-1);;
						</script>
					<%
				}
			%>

			<wtc:service name="sGetIMeiMsg" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sid_code" retmsg="s_id_ret" outnum="10">
			<wtc:param value="<%=tfhm%>"/> 
			<wtc:param value="<%=beginYm%>"/>
			<wtc:param value="<%=endYm%>"/> 
			
		 
		</wtc:service>
		<wtc:array id="result" scope="end" start="0" length="2"/> 
		<wtc:array id="result2" scope="end" start="2" length="1"/>
		<wtc:array id="result3" scope="end" start="3" length="1"/>
		<wtc:array id="result4" scope="end" start="4" length="1"/>
		<wtc:array id="result5" scope="end" start="5" length="1"/>
		<wtc:array id="result6" scope="end" start="6" length="1"/>
		<wtc:array id="result7" scope="end" start="7" length="1"/>
		<wtc:array id="result8" scope="end" start="8" length="1"/>
		<wtc:array id="result9" scope="end" start="9" length="1"/>
		<%
			
		 
		 
		if((!sid_code.equals("0"))&& (!sid_code.equals("000000")))
		{
			%>
						<script language="javascript">
							rdShowMessageDialog("查询失败！错误代码"+"<%=sid_code%>"+",错误原因:"+"<%=s_id_ret%>");
							history.go(-1);;
						</script>
					<%
		}
		else
		{
			%><HEAD><TITLE>查询结果</TITLE>
		</HEAD>

		<body>
		<!--
		<DIV><img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()"></DIV>
		-->
		<FORM method=post name="frm1507_2">
			<%@ include file="/npage/include/header.jsp" %>
			<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">营销案办理情况</div>
			</div>

		<table cellspacing="0" id="queryMsgTab">
				<tr>
					<th>办理时间</th>
					<th>IMEI码</th>
					<th>品牌</th>
					<th>机型</th>
				</tr>
				<tr>
					<td><%=s_opTime%></td>
					<td><%=s_imei_no%></td>
					<td><%=s_brand_name%></td>
					<td><%=s_res_name%></td>
				</tr>
			</table>
			<div class="title">
				<div id="title_zi">拆包刷码情况</div>
			</div>
			<table cellspacing="0" id="tabList">
			<tr>
				<th nowrap>手机号码</th>
				<th nowrap>统计年月</th>
				<th nowrap>拆包\刷码</th>
				<th nowrap>业务名称</th>
				<th nowrap>拆包前IMEI</th>
				<th nowrap>拆包后IMEI</th>
				<th nowrap>刷码前号码</th>
				<th nowrap>刷码后号码</th>
				<th nowrap>拆包\刷码时间</th>
			 
			<tr>
			<%
				for(int i=0;i<result2.length;i++)
				{
					%>
						<tr>
							<td><%=tfhm%></td>
							<td><%=result2[i][0]%></td>
							<td><%=result3[i][0]%></td>
							<td><%=result4[i][0]%></td>
							<td><%=result5[i][0]%></td>
							<td><%=result6[i][0]%></td>
							<td><%=result7[i][0]%></td>
							<td><%=result8[i][0]%></td>
							<td><%=result9[i][0]%></td>
						</tr>
					<%
				}
				   
			%>
				<td align="center" id="footer" colspan="9">
					 
				&nbsp; <input class="b_foot" name=back onClick="window.location='g098_1.jsp?activePhone=<%=tfhm%>'" type="button" value="返回">
				&nbsp;  
				</td>
			</tr>
		</table>
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
		</body>
		</html><%
		}
		//add end
	}
	
	
%>	 
 
 	
 

