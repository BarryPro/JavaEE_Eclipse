<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.util.page.*"%>
 
<%
      String opCode = "i092";
	  String opName = "强制预拆";
	  String s_region_code=request.getParameter("s_region_code");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  System.out.println("AAAAAAAAAAAAAAAAAAAaaa s_region_code is "+s_region_code);
	  //分页
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 400;
	  
	  //开始 结束
	  	


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[4];
	  //inParas2[0]="select c.region_name,d.district_name,to_char(b.phone_no),b.run_time,to_char(floor(sysdate-b.run_time)),e.pay_name,to_char(a.prepay_fee),to_char(a.id_no) from  dcustbalance a,dcustmsg b,sregioncode c,sdiscode d,spaytype e where a.id_no=b.id_no and substr(b.belong_code,0,2) = c.region_code and c.region_code = d.region_code and substr(b.belong_code,2,2)=d.district_code and c.region_code=:s_region_code and a.pay_type = e.pay_type";
	  //inParas2[1]="s_region_code="+s_region_code;
	  inParas2[0]=s_region_code;
	  inParas2[1]=workno;
	  inParas2[2]= "" + iPageNumber;
	  inParas2[3]="" + iPageSize;
 
%>
<wtc:service name="bi092Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="11">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="8" scope="end"/>
<wtc:array id="mainInfo2"  start="10" length="1" scope="end"/>
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		int nowPage = 1;
		int allPage = 0;
		
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCxxxxxxxxxxxxxxxxxxxxxxCCCCCCCCC 成功"+result1.length);
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / 100 + 1 ;
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>地市</th>
									<th>区县</th>
									<th>手机号码</th>
									<th>进入预拆时间</th>
									<th>在预拆状态停留时长(天)</th>
									<th>专款名称</th>
									<th>专款金额</th>
									<th>1操作</th>
							<%
								for(int i=0;i<result1.length-1;i++)
								{
									%>
										<tr>
											<td><%=result1[i][0]%></td>
											<td><%=result1[i][1]%></td>
											<td><%=result1[i][2]%></td>
											<td><%=result1[i][3]%></td>
											<td><%=result1[i][4]%></td>
											<td><%=result1[i][5]%></td>
											<td><%=result1[i][6]%></td>
											<td>
											<input type="checkbox" id=checkbox<%=i%>>
											</td>
										</tr>
									<%
								}
							%>

						 
						
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick="window.location = 'i092_2.jsp' " type=button value=返回>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
							</td>
						  </tr>
						  
					  </table>
					 
					<!--分页-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								总记录数：<font name="totalPertain" id="totalPertain"><%=mainInfo2[0][0]%></font>&nbsp;&nbsp;
								总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								当前页：<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
								每页行数：100
								<!--
								<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
								<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
								<a href="i092_2_qry_next.jsp?pageNumber=">[下一页]</a>&nbsp;&nbsp;
								 

								<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
								-->
								跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value);">
									<%
									for (int i = 1; i <= allPage; i ++) {
									%>
										<option value="<%=i%>">第<%=i%>页</option>
									<%
									}
									%>
								</select>
								页
							</td>
						</tr>
						</table>
					</div>
					<!--end 分页-->	
							
				<input type="hidden" id="nowPage" />
				<input type="hidden" id="allPage" value="<%= allPage %>" />		

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("查询结果为空！");
					window.location.href="i092_2.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	function deletes(id_no)
	{
		alert(id_no);
	}
	function gotos(page)
	{
		//alert("<%=s_region_code%>");
		window.location.href="i092_2_qry_next.jsp?pageNumber="+page+"&s_region_code="+"<%=s_region_code%>";
	}
</script> 
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		//alert(goPage);
		if (goPage == "-1") {
			setPage(parseInt($("#nowPage").val()) - 1);
			return;
		} else if (goPage.length == 2 && "+1" == goPage) {
			setPage(parseInt($("#nowPage").val()) + 1);
			return;
		}else{ 
			goPage = parseInt(goPage);
			if(goPage < 1){
				return false;
			}else if(goPage > $("#allPage").val()){
				return false;
			}else{
				pageNo = parseInt(goPage);
				//所有行隐藏
				$("[id^='row_']").hide();
				//显示行
				var startRow = (pageNo - 1) * 10;
				var endRow = pageNo * 10 - 1;
				for(var i = startRow; i <= endRow; i++ ){
					var pageStr = "#row_" + i;
					$(pageStr).show();
				}
				$("#nowPage").val(pageNo);
				$("#currentPage").text(pageNo);
			}
		}
	}
</script>


