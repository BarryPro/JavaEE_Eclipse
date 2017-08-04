<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 新区县操作统计报表2148
   * 版本: 1.0
   * 日期: 200/01/04
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>
 

<%
	String opCode="zg16";
	String opName="总对总银行移动话费统计表";
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");
    String sqlStr="";
	//String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String[] inParas2 = new String[1];
	//inParas2[0] = "select agt_capture,agt_capture||'->'||agt_name from agt_capture@link_bank order by agt_capture";
//	inParas2[0] = "select agt_capture,agt_capture||'->'||agt_name from agt_capture@link_bank where agt_capture='60' order by agt_capture";
	inParas2[0] = "select login_no,login_no||'->'||login_name from dloginmsg where login_no in ('zdzspd','zdzccb') order by login_no";
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=inParas2[0]%>"/>
	 
	</wtc:service>
	<wtc:array id="result" scope="end" />

		<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>发票进销存报表</TITLE>
</HEAD>
<body>
 
 

 	
<script src="invoice_boss.js" type="text/javascript"></script>		

<SCRIPT language="JavaScript">

function dosubmit() {
   var bankcode = document.form1.bbank_list.options[document.form1.bbank_list.selectedIndex].value;
   var bdateyear = document.form1.begin_time.value;
   var edateyear = document.form1.end_time.value;
   var workno = "<%=work_no%>";
   document.form1.hParams1.value= "prc_zg17_rpt('"+bankcode+"','"+bdateyear+"','"+edateyear+"','"+workno+"' ";
 
   form1.submit(); 
   
}

function doProcess(packet)
{
	var retResult   = packet.data.findValueByName("retResult");
	var ret_count   = packet.data.findValueByName("ret_count");
	//alert("retResult is "+retResult+" and ret_count is "+ret_count);
	var date_bf =packet.data.findValueByName("date_bf"); 
	var date_now =packet.data.findValueByName("date_now"); 
	var date_input =document.all.end_time.value;
	//alert("test date_input is "+date_input+" and date_now is "+date_now+" and date_bf is "+date_bf);
	

	var year_bf =  date_bf.substr(0,4);
    var year_now =  date_now.substr(0,4); 
	var month_bf = date_bf.substr(4,2);
	var month_now = date_now.substr(4,2);
	var year_in =  date_input.substr(0,4); 
	var month_in = date_input.substr(4,2);
	
	var len_bf=(year_bf-year_in)*12+(month_bf-month_in)+1;
	var len_now=(year_now-year_in)*12+(month_now-month_in)+1;
	//alert("len_bf is "+len_bf+" and len_now is "+len_now);
	/*
	if(len_now<=1 || len_bf>6)
	{
		rdShowMessageDialog("仅可查询当月之前近六个月的记录!");
		return false;
	}*/
	if(date_input<date_bf || date_input>=date_now)
	{
		//rdShowMessageDialog("仅可查询当月之前近六个月的记录!");
		//return false;
	}
	else
	{
		//alert(date_input+" and date_bf is"+date_bf);
		if(retResult=="N")
		{
			rdShowMessageDialog("查询结果异常!");
			return false;
		}
		else
		{
			if(ret_count=="0")
			{
				 rdShowMessageDialog("请输入正确的集团产品ID,仅多媒体桌面电话产品可查询!");
				 document.all.jtcpid.value = "";
				 document.all.jtcpid.focus();
				 return false;
			}
			else
			{
				var ym = document.all.end_time.value;
				var jtcpid= document.all.jtcpid.value;
				select_boss(document.form1);
				document.form1.submit();
			}
		}
	}
	
	
}
</SCRIPT> 

<FORM method=post name="form1" action="../rpt/print_rpt_boss.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择操作报表</div>
	</div>

<table cellSpacing="0">
			

 
	 
	<tr > 
            <td>银行名称:</td>
            <td colspan=3> 
                <select size="1" name="bbank_list">
				   <%for(int i=0; i<result.length; i++) {%>
				       <option class=button value="<%=result[i][0]%>"><%=result[i][1]%></option>
				   <%}%>				   
				</select>
            </td>
             
          </tr> 
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
	 
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(dosubmit())" type=button value=确认>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=清除>
		&nbsp; <input class="b_foot" name=back onClick="window.location.href='zg16_1.jsp'" type=button value=返回>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
      <input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
	  <input type="hidden" name="g_name" id="group_id" value="">
  
  <%@ include file="/npage/public/pubSearchText.jsp" %>
	<%@ include file="/npage/include/footer.jsp" %> 
</FORM>
</BODY></HTML>
		<%
	 
	 
%>

 
