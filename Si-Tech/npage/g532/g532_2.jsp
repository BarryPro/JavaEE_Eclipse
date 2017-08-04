<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "g532";//15114579440
    String opName = "回收专款查询";
	String phoneno=request.getParameter("phoneno");
	String regionCode = (String)session.getAttribute("regCode");	  


	String result[][] = new String[][]{};
	
	String[] inParas0 = new String[2];//新平台g794的sql：

	//inParas0[0]="select distinct b.act_name,c.means_name from dbmarketadm.mk_actrecordfeeext_info a,dbmarketadm.mk_act_info b,dbmarketadm.mk_means_info c ,dbmarketadm.mk_actrecord_info d where a.order_no = d.serial_no and a.act_id = b.act_id and a.means_id = c.means_id and d.preorder_flag='0' and a.fee_type='1' and b.act_class not in ('16','18','19') and d.phone_no=:phone_no and a.fee_code=:s_pay_type and a.in_time > to_date(:begin_dt,'yyyy/mm/dd hh24:mi:ss') ";
	inParas0[0]="select distinct b.act_name,c.means_name from dbmarketadm.mk_act_info b,dbmarketadm.mk_means_info c ,dbmarketadm.mk_actrecord_info d  where b.act_id = d.act_id and d.means_id = c.means_id and d.preorder_flag='0'  and b.act_class not in ('16','18','19') and d.phone_no=:phone_no and a.in_time > to_date(:begin_dt,'yyyy/mm/dd hh24:mi:ss') ";

	String[] inParas1 = new String[2]; //旧平台e177的sql：
	//inParas1[0]="select distinct c.act_name,d.means_name from dbmktadm.mk_paytypecon_info a ,dbmktadm.mk_actrecord_info b ,dbmktadm.mk_act_info c ,dbmktadm.mk_means_info d where a.order_id = b.order_id and b.act_id= c.act_id and b.means_id = d.means_id and b.phone_No=:phone_no and a.pay_type=:s_pay_type and b.oper_time > to_date(:begin_dt,'yyyy/mm/dd hh24:mi:ss')  and b.preorder_flag='0'";
	inParas1[0]="select distinct c.act_name,d.means_name from dbmktadm.mk_actrecord_info b ,dbmktadm.mk_act_info c ,dbmktadm.mk_means_info d  where b.act_id= c.act_id and b.means_id = d.means_id and b.phone_No=:phone_no and b.oper_time > to_date(:begin_dt,'yyyy/mm/dd hh24:mi:ss')  and b.preorder_flag='0'";
	String s_acc_name="";
	String s_sacle_name="";

	String[] inParas2 = new String[2];
	inParas2[0]="select function_name from sfunccode where function_code=:func_code";
%>
   
	 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>自助终端查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果(提示：此页面只提供查询立即和预约办理两种方式专款回收信息)</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
                  <th>回收专款名称</th>
				  <th>回收专款类型 </th>
				  <th>回收专款金额</th>
                  <th>专款办理时间</th> 
				  <th>专款办理工号</th>
				  <th>专款办理操作代码</th>
				  <th>专款开始时间</th>
				  <th>专款结束时间</th>
				  
				  <th>营销活动名称</th> 
				  <th>营销档位名称</th> 
				</tr>
 
 <wtc:service name="sPayOweQry" outnum="8" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>" retmsg="msg1" retcode="code1" >
			<wtc:param value="<%=phoneno%>" />
		 	
 </wtc:service>
 <wtc:array id="sVerifyTypeArr" scope="end"/>
	<%
		result = sVerifyTypeArr;
		String retCode1 =code1;
		String retMsg =msg1;
		  if(retCode1=="000000" ||retCode1.equals("000000"))
		  {
			  %>
				
				<%
					for(int i =0;i<result.length;i++)
					{
						//result[i][4]="1141";
						//result[i][4]="e177";
						//xl add 根据opcode判断quyl的sql begin
						  if(result[i][4]=="g794" ||result[i][4].equals("g794"))
						  {
							  inParas0[1]="phone_no="+phoneno+",begin_dt="+result[i][2];
							  //inParas0[1]="phone_no=13904518896"+",begin_dt=20121201";
							  %>
							  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
								 <wtc:param value="<%=inParas0[0]%>"/>
								 <wtc:param value="<%=inParas0[1]%>"/>	
							  </wtc:service>
							  <wtc:array id="ret_val" scope="end" />
							  <%
								if(ret_val.length>0)
							    {
								    s_acc_name=ret_val[0][0];
									s_sacle_name=ret_val[0][1];
							    }
						  }
						  else if(result[i][4]=="e177" ||result[i][4].equals("e177"))
						  {
							  inParas1[1]="phone_no="+phoneno+",begin_dt="+result[i][2];
							  //inParas1[1]="phone_no=13904510912"+",begin_dt=20121201";
							  %>
							  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
								 <wtc:param value="<%=inParas1[0]%>"/>
								 <wtc:param value="<%=inParas1[1]%>"/>	
							  </wtc:service>
							  <wtc:array id="ret_val2" scope="end" />
							  <%
								if(ret_val2.length>0)
							    {
								    s_acc_name=ret_val2[0][0];
									s_sacle_name=ret_val2[0][1];
							    }  
						  }
						  else
						  {
							  inParas2[1]="func_code="+result[i][4];
							  %>
								<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode7" retmsg="retMsg7" outnum="1">
								  <wtc:param value="<%=inParas2[0]%>"/>
								  <wtc:param value="<%=inParas2[1]%>"/>	
								</wtc:service>
								<wtc:array id="ret_val3" scope="end" />
							  <%
								  s_acc_name=ret_val3[0][0];
								  s_sacle_name="";
						  }	
						//xl add 根据opcode判断quyl的sql end
						%>
						
						
						<tr>
							<td>
								<%=result[i][7]%>
							</td>
							<td>
								<%=result[i][0]%>
							</td>
							
							<td>
								<%=result[i][1]%>
							</td>
							<td>
								<%=result[i][2]%>
							</td>
							<td>
								<%=result[i][3]%>
							</td>
							<td>
								<%=result[i][4]%>
							</td>
							<td>
								<%=result[i][5]%>
							</td>
							<td>
								<%=result[i][6]%>
							</td>
							
							<td>
								<%=s_acc_name%> 
							</td>
							<td>
								<%=s_sacle_name%><br>
							</td>
							</tr>
						<%
					}
				%>
					
				
			  <%	
		  }
		  else{
	%>
			<script language="javascript">
				rdShowMessageDialog("查询失败!错误原因："+"<%=retMsg%>"+";错误代码："+"<%=retCode1%>");
				window.location.href="g532_1.jsp";
			</script>
			<%
	}	
	
			
	 
		 

%>

         
          <tr id="footer"> 
      	    <td colspan="10">
    	      <input class="b_foot" name=back onClick="window.location = 'g532_1.jsp' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭> 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

