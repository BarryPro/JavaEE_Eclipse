
<%
  /*
   * 功能: 接触信息查询
   * 版本: 3.0
   * 日期: 2008/06/25
   * 作者: zhanghonga
   * 版权: si-tech
  */
%>
		<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%
		    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
			String acceptNo = request.getParameter("accept_no");				/*服务请求标识*/
			String queryCustId = request.getParameter("queryCustId");			/*客户标识*/
			String sBeginTimeIn = request.getParameter("queryBeginTime");			/*开始时间*/
			String sEndTimeIn = request.getParameter("queryEndTime");			/* 结束时间 */
			String sqlStr = "select a.accept_no, a.phone_no, to_char(a.accept_time, 'yyyy-mm-dd hh24:mi:ss'), to_char(a.accomplish_time, 'yyyy-mm-dd hh24:mi:ss'), "
					+ " a.status_name, a.class_name, a.case_content "
					+ " from case_rec_info a "
					+ " where a.accomplish_time between to_date( :sBeginTimeIn  , 'yyyymmdd hh24:mi:ss') and to_date(:sEndTimeIn ,'yyyymmdd hh24:mi:ss')";
			
		  	myParams="sBeginTimeIn="+sBeginTimeIn+",sEndTimeIn="+sEndTimeIn;
		  	
			if (acceptNo != null && !"".equals(acceptNo)) {
				sqlStr = sqlStr + " and a.accept_no = :vacceptNo";
				myParams+=",vacceptNo="+ acceptNo;
			}
			if (queryCustId != null && !"".equals(queryCustId)) {
				sqlStr = sqlStr + " and a.phone_no = :queryCustId ";
				myParams+=",queryCustId="+ queryCustId;
			}
 
		%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="7" >
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="retList"  scope="end"/>
 
<html>
	<head>
		<title></title>	
		<script language="javascript">
			function doQuery(){
				parent.document.getElementById("sQryCnttOnlyTable").style.display="none";
				parent.document.getElementById("sQryCnttInfoDiv").style.display="block";
				parent.document.getElementById("sQryCnttInfoTable").style.display="block";

			}

                      function  testaa(str){
	/*
	window.open('K230_add_qc_item.jsp?current_node_id=' + current_node_id + '&object_id=' + object_id + '&content_id=' + content_id + '&father_node_id=' + father_node_id,
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	var time     = new Date();
	var url      = '<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_out_plan_qc_form_t.jsp?time='+time+'&id='+str;
	var winParam = 'dialogWidth=800px;dialogHeight=360px';
	window.showModalDialog(url, window, winParam);
}




		</script>		
	</head>
	<body>
		<div id="Operation_Table"> 
		<table cellspacing="0">
			<tr align="center">
				<th>服务请求标识</th>
				<th>客户标识</th>
				<th>受理时间</th>
				<th>完成时间</th>
				<th>服务请求状态</th>	
				<th>服务请求类型</th>	
				<th>服务请求内容</th>		
			</tr>	
		<%
			String tdclass="";
			String phoneNo="";
		if(retList != null && retList.length>0){
			
			for (int i = 0; i < retList.length; i++) {
		%>
			<tr align="center">
				<td class="<%=tdclass%>" ><a href='#' onclick="testaa('<%=retList[i][0]%>');"/><%=retList[i][0]%></a> &nbsp;</td>
				<td class="<%=tdclass%>" ><%=retList[i][1]%>&nbsp;</td>
				<td class="<%=tdclass%>" ><%=retList[i][2]%>&nbsp;</td>
				<td class="<%=tdclass%>" ><%=retList[i][3]%>&nbsp;</td>
				<td class="<%=tdclass%>"><%=retList[i][4]%>&nbsp;</td>
				<td class="<%=tdclass%>"><%=retList[i][5]%>&nbsp;</td>
				<td class="<%=tdclass%>" ><%=retList[i][6]%>&nbsp;</td>
			</tr>
		<%
			}
		}else{
			out.println("<tr><td colspan='9' width='100%' align='center' line-height='200px'><font class='orange'>无相关记录!</font></td></tr>");	
		}
		%>
		</table>
		</div>
	</body>	
</html>
