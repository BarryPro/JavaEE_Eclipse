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
      String opCode = "zg03";
	  String opName = "网厅空中充值审批";
	  String s_region_code=request.getParameter("s_region_code");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  System.out.println("AAAAAAAAAAAAAAAAAAAaaa s_region_code is "+s_region_code);
	  //分页
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 20;
	   
	  //开始 结束 
	  String s_dis_code= request.getParameter("s_dis_code");	
	  
	  String region_name =  request.getParameter("region_name");
	  String dis_name    =  request.getParameter("dis_name");

	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[5];
 
	  inParas2[0]=workno;
	  inParas2[1]=s_region_code;
	  inParas2[2]=s_dis_code;
	  inParas2[3]= "" + iPageNumber;
	  inParas2[4]="" + iPageSize;
	  
 
%>
<wtc:service name="szg03Qry1" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="6">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="2" scope="end"/>
<wtc:array id="mainInfo2"  start="4" length="2" scope="end"/>
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
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / 20 + 1 ;//页数的 这里也要改
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body onload="inits()">


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
								 
									<th>地市</th>
									<th>区县</th>
								 
									<th>代理商手机号码</th>
									<th>代理商账号</th>
									 
									<th  >操作 
										<input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">全选 &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="check_not_id" onclick="doCancelChooseAll()">取消全选 
									</th>
							<%
								for(int i=0;i<result1.length;i++)
								{
									%>
										<tr>
											 
											<td><%=region_name%></td>
											<td><%=dis_name%></td>
											 
											<td><%=result1[i][0]%></td>
											<td><%=result1[i][1]%></td> 
											<input type="hidden" id="phone_nos<%=i%>" value="<%=result1[i][0]%>" >
											<input type="hidden" id="contract_nos<%=i%>" value="<%=result1[i][1]%>" >
											<td>
											<input type="checkbox" id=checkbox<%=i%> name="regionCheck">
											</td>
										</tr>
									<%
								}
							%>

						 
						
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot"  onClick="deletes_more()" type=button value=录入>	
						 
							  <input class="b_foot" name=back onClick="window.location = 'zg03_1.jsp' " type=button value=返回>
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
								每页行数：20 
								 
								&nbsp;&nbsp;跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=mainInfo2[0][0]%>');">
										<%
										 
										for (int i = 1; i <= allPage; i ++){
											
											if(iPageNumber==i){
												//System.out.println("aaaaaaaaaaaaaaaaaaaa "+i);
												%>
												<option value="<%=i%>" selected >
													第<%=i%>页
												</option>	
												<%
											}else{
												
												%>
													<option value="<%=i%>">第<%=i%>页</option>
												<%
												}
										%>
										
									
									<%}%>
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
					window.location.href="zg03_1.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	
	function inits()
	{
		//alert("1");
		document.getElementById("toPage").disabled=false;
		//alert("2");
	}

	 
	
	function deletes_more()
	{
		var idArrays=[];
		var conArrays=[];
		var len = "";
		len=document.all.regionCheck.length;
		var check_flag=0;
		if(len==undefined)
		{
			//id_nos
			var id_no=document.getElementById("phone_nos"+i).value;
			idArrays.push(id_no);
			//alert("什么情况 "+idArrays);
			check_flag=1;
		}
		else
		{
			for (i = 0; i < len; i++)
			{
				if (document.all.regionCheck[i].checked == true) 
				{
					var phone_no=document.getElementById("phone_nos"+i).value;
					idArrays.push(phone_no);
					 
					var contract_no=document.getElementById("contract_nos"+i).value;
					conArrays.push(contract_no);
					check_flag=1;
				}
			}
		}
		if(check_flag==1)
		{
			//alert("phone_no is "+idArrays+" and conArrays is "+conArrays);
			var url="zg03_3.jsp?phone_arrays="+idArrays+"&conArrays="+conArrays;
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
		document.getElementById("toPage").disabled=true;
		window.location.href="zg03_2.jsp?pageNumber="+page+"&s_region_code="+"<%=s_region_code%>"+"&s_dis_code="+"<%=s_dis_code%>"+"&region_name="+"<%=region_name%>"+"&dis_name="+"<%=dis_name%>"; 
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
 


