<%
/*************************************
* 功  能: g381·虚拟V网用户查询结果
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: shengzd @ 2010-03-22
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("phoneNo");
    String groupNo = request.getParameter("groupNo");
    String pageNum = request.getParameter("pageNum");//跳转的页数
    String rowNum = request.getParameter("rowNum");//每页显示的数量
    String pageCount = "";//总页数
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	String groupName = "";
	String groupNo_new = "";
	
	String oprType = (String)request.getParameter("oprType");
	
	System.out.println(" zhoubyi groupNo " + groupNo);
	System.out.println(" zhoubyi " + oprType);
	
	/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		String[][] allNumStr = new String[][]{};
		String num = "0";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<wtc:service name="sg381Qry"  routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
		<wtc:param value="<%=Integer.toString(iPageNumber)%>"/>
		<wtc:param value="<%=Integer.toString(iPageSize)%>"/>	
		<wtc:param value="<%=oprType%>"/>	
	</wtc:service>
	<wtc:array id="qryArr" start="0" length="9" scope="end"/>
	<wtc:array id="qryArr2" start="9" length="1" scope="end"/>
	

<%

	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		num = qryArr2[0][0];
	}
%>		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
  $(function() {
  		$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');	
  		if(<%=qryFlag%>) {
			showTable();
			$('#pageNum').val('<%=pageNum%>');
			$('#rowNum').val('<%=rowNum%>');
		}else {
			 clearTable();
			 rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
		}
		//隐藏父页面的遮罩
		window.parent.hideBox();
  });
  
  function showTable() {
  	$('#groupTable').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
  }
  function clearTable() {
  		$('#groupTable').empty();
  		$('#groupTable').css('display','none');
  }
</script>

<body>
<form name="frm2" action="" method="post" >
		<input type="hidden" value="" id="pageNum" />
		<input type="hidden" value="" id="rowNum" />
		
		<div id="groupTable">
			<div id="Operation_Table" style="padding:0px">
					<table id="tabList2" cellspacing="0"  vColorTr="set">
							<tr>	
								<th>集团号</th>			
								<th>集团名称</th>
								<th>用户手机号码</th>			
								<th>用户名称</th>
								<th>当月资费</th>			
								<th>下月资费</th>
								<th>成员账号</th>
								<th>运行状态</th>
								<th>加入集团时间</th>
							</tr>
							<%
								if(qryFlag) {
									for(int i=0;i<qryArr.length;i++) {
										out.println("<tr><td>" + qryArr[i][0] + "</td>" +
											        "<td>" + qryArr[i][1] + "</td>" +
											        "<td>" + qryArr[i][2] + "</td>" +
											        "<td>" + qryArr[i][3] + "</td>" +
											        "<td>" + qryArr[i][4] + "</td>" +
											        "<td>" + qryArr[i][5] + "</td>" +
											        "<td>" + qryArr[i][6] + "</td>" +
											        "<td>" + qryArr[i][7] + "</td>" +
											        "<td>" + qryArr[i][8] + "</td>" +
											        "</tr>"
											    );
									}
								}
							%>
							<tr>	
								<td colspan="9">
									<div id="page0" style="position:relative;font-size:12px;">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				           		<%	
									    //实现分页
									    if(num!=null && !"0".equals(num)){
										    int iQuantity = Integer.parseInt(num.trim());
										    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
											  PageView view = new PageView(request,out,pg); 
										   	view.setVisible(true,true,0,0);    
									   	}
								%>
									</div>
								</td>
							</tr>
											    <tr id='footer'>

				        <td colspan='9'>
<!--

				           <input type="button" name="toexcel" class="b_foot" value="导出" onclick='window.open("fg381_toexcel.jsp?opCode=<%=opCode%>&phoneNo=<%=phoneNo%>&groupNo=<%=groupNo%>&pageNum=<%=pageNum%>&rowNum=<%=rowNum%>&iPageNumber=<%=iPageNumber%>&iPageSize=<%=num%>")' />
				           -->
				        </td>

				    </tr>

					</table>
			</div>
		</div>
</form>
</body>
</html>