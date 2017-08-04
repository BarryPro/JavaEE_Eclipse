<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 营业员操作查询1507
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>

<%
	String opCode="1507";
	String opName="营业员操作查询";
	String workNo = (String)session.getAttribute("workNo");
	String queryType=request.getParameter("queryType");
	String queryTypeBak = queryType;
	String begin_phoneNo=request.getParameter("begin_phoneNo");
	String end_phoneNo=request.getParameter("end_phoneNo");
	String begin_loginNo=request.getParameter("begin_loginNo");
	String end_loginNo=request.getParameter("end_loginNo");
	String begin_time=request.getParameter("begin_time");
	String end_time=request.getParameter("end_time");
	String work_no=request.getParameter("work_no");
	String function_code=request.getParameter("function_code");
	String regionCode = (String)session.getAttribute("regCode");
	/*zhaoxin 20090806*/
	String iPhoneNo = (String)request.getParameter("activePhone");
	String iLoginAccept = "0";
  String iChnSource = "01";

 	/* ningtn */
	String begin_broadNo=request.getParameter("begin_broadNo");
	String end_broadNo=request.getParameter("end_broadNo");
	String tempStr = begin_broadNo + "|" + end_broadNo;
	/* ningtn end */
	if("broadNo".equals(queryType)){
		begin_phoneNo = begin_broadNo;
		end_phoneNo   = end_broadNo;
%>
	<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="1"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="0"/>
		<wtc:param  value="01"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=workNo%>"/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value="<%= tempStr %>"/>
  </wtc:service>
  <wtc:array id="list" scope="end"/>
<%
			if("000000".equals(errCode)){
				if(list != null && list.length > 0){
				System.out.println("=== list[0][0] ===" + list[0][0]);
					tempStr = list[0][0];
					StringTokenizer resToken = null;
					resToken = new StringTokenizer(tempStr, "|"); 
					begin_phoneNo = (String)resToken.nextElement();
					if(resToken.hasMoreElements()){
						end_phoneNo = (String)resToken.nextElement();
					}
					queryType = "phoneNo";
				}
			}
	}
	System.out.println(queryType + "|" + begin_phoneNo + "|" + end_phoneNo);
//	ArrayList arlist = new ArrayList();
//		s1520view viewBean = new s1520view();//实例化viewBean
		System.out.println("["+queryType+begin_phoneNo+end_phoneNo+begin_loginNo+end_loginNo+begin_time+end_time+work_no+function_code+"]");
//		arlist = viewBean.s1507Qry(queryType,begin_phoneNo,end_phoneNo,begin_loginNo,end_loginNo,begin_time,end_time,work_no,function_code,regionCode);
%>
	<wtc:service name="s1507Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
	  <wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=begin_phoneNo%>"/>
		<wtc:param value="<%=end_phoneNo%>"/>
		<wtc:param value="<%=begin_loginNo%>"/>
		<wtc:param value="<%=end_loginNo%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value="<%=function_code%>"/>
		<wtc:param value="<%=regionCode%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>

	<wtc:service name="bs_s1507Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCodeb" retmsg="retMsgb">
	  <wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=begin_phoneNo%>"/>
		<wtc:param value="<%=end_phoneNo%>"/>
		<wtc:param value="<%=begin_loginNo%>"/>
		<wtc:param value="<%=end_loginNo%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value="<%=function_code%>"/>
		<wtc:param value="<%=regionCode%>"/>
	</wtc:service>
	<wtc:array id="resultb" scope="end"/>
<%

//	String [][] result = new String[][]{};
//	result = (String[][])arlist.get(0);
	String return_code =retCode;
	String return_message =retMsg;
	int    flag_crm = 0;
	int    flag_boss = 0;
%>
<%
	if (!return_code.equals("000000")&&return_code.equals("150700"))
	{
		flag_crm = 1;
	}

	if (!retCodeb.equals("000000")&&retCodeb.equals("150700"))
	{
		flag_boss = 1;
	}
	if(return_code.equals("150700")&&retCodeb.equals("150700")){
%>
	<script language="JavaScript">
		rdShowMessageDialog("查询结果为空",0);
		window.location="f1507_1.jsp?begin_phoneNo=<%=begin_phoneNo%>&end_phoneNo=<%=end_phoneNo%>&begin_loginNo=<%=begin_loginNo%>&end_loginNo=<%=end_loginNo%>&begin_time=<%=begin_time%>&end_time=<%=end_time%>&queryType=<%=queryType%>";
	</script>
<%
	}
	else if( flag_crm!=0 && flag_boss !=0){
%>
	<script language="JavaScript">
		rdShowMessageDialog("查询失败!请联系管理员！",0);
		window.location="f1507_1.jsp?begin_phoneNo=<%=begin_phoneNo%>&end_phoneNo=<%=end_phoneNo%>&begin_loginNo=<%=begin_loginNo%>&end_loginNo=<%=end_loginNo%>&begin_time=<%=begin_time%>&end_time=<%=end_time%>&queryType=<%=queryType%>";
	</script>
<%
	}else if((result.length+resultb.length)>=3000){
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>记录数超过3000条，请缩小范围查询,显示的是前面3000条!");
</script>
<%
	}

%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>营业员操作查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">营业员操作查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
		<th nowrap>操作名称</th>
		<th nowrap>操作时间</th>
		<th nowrap>操作对象</th>
		<th nowrap>金额总计</th>
		<th nowrap>工号</th>
		<th nowrap>操作流水</th>
		<th nowrap>操作备注</th>
	</tr>
<%	      for(int y=0;y<result.length;y++)
	      {
			String tdClass = ((y%2)==1)?"Grey":"";
%>
	        <tr>
<%    	        for(int j=2;j<result[0].length;j++)
	        {
%>
	              <td height="25" class="<%=tdClass%>" nowrap>&nbsp;<%= result[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>
<%	      for(int y=0;y<resultb.length;y++)
	      {
			String tdClass = ((y%2)==1)?"Grey":"";
%>
	        <tr>
<%    	        for(int j=2;j<resultb[0].length;j++)
	        {
%>
	              <td height="25" class="<%=tdClass%>" style="color: red;" nowrap>&nbsp;<%= resultb[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>
	<tr>
		<td align="center" id="footer" colspan="7">
			<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back
						onClick="window.location='f1507_1.jsp?begin_phoneNo=<%=begin_phoneNo%>&end_phoneNo=<%=end_phoneNo%>&begin_loginNo=<%=begin_loginNo%>&end_loginNo=<%=end_loginNo%>&begin_time=<%=begin_time%>&end_time=<%=end_time%>&queryType=<%=queryTypeBak%>'"
						type="button" value="返回">
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
}
</script>
