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
	  
	  String total_1 = request.getParameter("total_1");  
	  //开始 结束 
	  	


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[5];
	  //inParas2[0]="select c.region_name,d.district_name,to_char(b.phone_no),b.run_time,to_char(floor(sysdate-b.run_time)),e.pay_name,to_char(a.prepay_fee),to_char(a.id_no) from  dcustbalance a,dcustmsg b,sregioncode c,sdiscode d,spaytype e where a.id_no=b.id_no and substr(b.belong_code,0,2) = c.region_code and c.region_code = d.region_code and substr(b.belong_code,2,2)=d.district_code and c.region_code=:s_region_code and a.pay_type = e.pay_type";
	  //inParas2[1]="s_region_code="+s_region_code;
	  inParas2[0]=s_region_code;
	  inParas2[1]=workno;
	  inParas2[2]= "" + iPageNumber;
	  inParas2[3]="" + iPageSize;
	  inParas2[4]="" + total_1;	
%>
<wtc:service name="bi092QryNew" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="9" scope="end"/>
<wtc:array id="mainInfo2"  start="11" length="2" scope="end"/>
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
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / 400 + 1 ;//页数的 这里也要改
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
									<th>操作 
								 
									</th>
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
											<input type="hidden" id="id_nos<%=i%>" value="<%=result1[i][8]%>" >
											<td>
											<input type="checkbox" id=checkbox<%=i%> name="regionCheck">
											</td>
										</tr>
									<%
								}
							%>

						 
						
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot"  onClick="deletes_more()" type=button value=强制预拆>
							  <input class="b_foot" name="del_all"  onClick="deletes_all('<%=mainInfo2[0][0]%>')" type=button value=全部强制预拆>
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
								当前页：<font name="currentPage" id="currentPage"><%=mainInfo2[0][1]%></font>&nbsp;&nbsp;
								每页行数：400
								<!--
								<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
								<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
								<a href="i092_2_qry_next.jsp?pageNumber=">[下一页]</a>&nbsp;&nbsp;
								 

								<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
								-->
								&nbsp;&nbsp;跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=mainInfo2[0][0]%>');">
									<%
									for (int i = 0; i <= allPage; i ++) {
										if(i==0)
										{
											%>
												<option value="<%=i%>">--请选择</option>
											<%
										}
										else
										{
											%>
												<option value="<%=i%>">第<%=i%>页</option>
											<%
										}
									
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
	function deletes_all(i_count)
	{
		//alert("test "+i_count);
		var	prtFlag = rdShowConfirmDialog("是否确定本次操作？由于数据过大，前台可能会提示超时报错，此时后台仍在进行删除操作。");
		if (prtFlag==1)
		{
			//alert("bizcodeArrays is "+bizcodeArrays);
			var url="i092_delete_all.jsp?s_count="+i_count+"&regionCode="+"<%=regionCode%>";
			var url_new =url;//URLencode(url);
			document.frm1508_2.action=url_new;
			document.frm1508_2.submit();  
			document.frm1508_2.del_all.disabled=true;
		}
		else
		{
			return false;
		}
	}
	
	function deletes_more()
	{
		var idArrays=[];
		var len = "";
		len=document.all.regionCheck.length;
		var check_flag=0;
		if(len==undefined)
		{
			//id_nos
			var id_no=document.getElementById("id_nos"+i).value;
			idArrays.push(id_no);
			alert("什么情况 "+idArrays);
			check_flag=1;
		}
		else
		{
			for (i = 0; i < len; i++)
			{
				if (document.all.regionCheck[i].checked == true) 
				{
					var id_no=document.getElementById("id_nos"+i).value;
					idArrays.push(id_no);
					//alert("here "+idArrays);
					check_flag=1;
				}
			}
		}
		if(check_flag==1)
		{
			var url="i092_Cfm.jsp?id_arrays="+idArrays+"&s_flag=2";
			var url_new =url;//URLencode(url);
			//alert(url_new);
			document.frm1508_2.action=url_new;
			var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
			if (prtFlag==1)
			{
				//alert("bizcodeArrays is "+bizcodeArrays);
				document.frm1508_2.submit();  
			}
			else
			{
				return false;
			}
		}
	}
	function gotos(page,total_1)
	{
		//var page_now = document.all.toPage[document.all.toPage.selectedIndex].value;
		//alert("test "+total_1);
		window.location.href="i092_2_qry_new.jsp?pageNumber="+page+"&s_region_code="+"<%=s_region_code%>"+"&total_1="+total_1;
	}
	function inits()
	{
		var page_now = document.all.toPage[document.all.toPage.selectedIndex].value;
		$("#currentPage").text(page);
	}
	//全选
	function doSelectAllNodes()
	{
		//document.all.sure.disabled=false;
		if(document.getElementById("check_all_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=true;
			}
		}
		
		 
	}
	//取消全选
	function doCancelChooseAll()
	{
		if(document.getElementById("check_not_id").checked)
		{
			var regionChecks = document.getElementsByName("regionCheck");
			for(var i=0;i<regionChecks.length;i++){
				regionChecks[i].checked=false;
			}
		}	
	}
	function getId(id_no)
	{
		alert(id_no);
	}
</script> 
 


