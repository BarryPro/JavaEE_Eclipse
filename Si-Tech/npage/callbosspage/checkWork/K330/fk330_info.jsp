<%
  /*
   * 功能: 接触信息查询
   * 版本: 3.0
   * 日期: 2008/06/25
   * 作者: zhanghonga
   * 版权: si-tech
   http://10.204.127.5:7001/npage/PersonChange/s9119/f9119_info.jsp?sflag=1&queryPhoneNo=13903510001&queryCustId=123
  */
%>
		<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%
		  /*midify by guozw 20091114 公共查询服务替换*/
		 String myParams="";
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode = org_code.substring(0,2);

			String sflag = request.getParameter("queryType");									/*查询方式*/
			//String sOpLoginNo = (String)session.getAttribute("workNo");			  /*查询者工号*/
			String queryPhoneNo = request.getParameter("queryPhoneNo");				 /*查询者手机号*/
			String queryCustId = request.getParameter("queryCustId");				 /*查询者订单表示*/
			String sql4dwomsg="";
			
			if("0".equals(sflag)){
					   sql4dwomsg = " SELECT   srv_no, to_char(wo_no), wo_name, begin_time, end_time, status_name ";
							sql4dwomsg+=" FROM dwomsg a, swotype b, swostatus c ";
							sql4dwomsg+=" WHERE wo_no = to_number(:queryCustId)";
							sql4dwomsg+=" AND a.wo_code = b.wo_code AND a.wo_status = c.wo_status ORDER BY begin_time";
							myParams = "queryPhoneNo="+queryPhoneNo ;
			}
		else if("1".equals(sflag)){
						 sql4dwomsg = " SELECT   srv_no, to_char(wo_no), wo_name, begin_time, end_time, status_name ";
							sql4dwomsg+=" FROM dwomsg a, swotype b, swostatus c ";
							sql4dwomsg+=" WHERE srv_no := queryPhoneNo";
							sql4dwomsg+=" AND a.wo_code = b.wo_code AND a.wo_status = c.wo_status ORDER BY begin_time";	
							myParams = "queryPhoneNo="+queryPhoneNo ;
			}			
		%>
		
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=sql4dwomsg%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="infoResult"  scope="end"/>	
	<%
		if(!retCode.equals("000000")){
	%>
		<script language="javascript">
			rdShowMessageDialog("服务代码:<%=retCode%>&服务信息:<%=retMsg%>.");
			parent.document.getElementById("sQryCnttOnlyTable").style.display="none";
		</script>
	<%
			return;
		}
	%>

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

        var time = new Date();
        var url  = '<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_out_plan_qc_form_t.jsp?time='+time+'&id='+str;
        var winParam = 'dialogWidth=800px;dialogHeight=360px';
        window.showModalDialog(url, window, winParam);
}




		</script>		
	</head>
	<body>
		<div id="Operation_Table"> 
		<table cellspacing="0">
			<tr align="center">
				<th>手机号码</th>
				<th>订单标识</th>
				<th>订单名称</th>
				<th>开始时间</th>
				<th>结束时间</th>	
				<th>订单状态</th>	
			</tr>	
		<%
			String tdclass="";
			String phoneNo="";
		if(infoResult.length>0){
			for(int i=0;i<infoResult.length;i++){
				if(i%2==0){
					tdclass="";
				}else{
					tdclass="Grey";	
				}
		%>

			<tr align="center">
				<td class="<%=tdclass%>" nowrap><a href='#' onclick="testaa('<%=infoResult[i][0]%>');"/><%=infoResult[i][0]%></a></td>
				<td class="<%=tdclass%>" nowrap><%=infoResult[i][1]%>&nbsp;</td>
				<td class="<%=tdclass%>" nowrap><%=infoResult[i][2]%>&nbsp;</td>
				<td class="<%=tdclass%>" nowrap><%=infoResult[i][3]%>&nbsp;</td>
				<td class="<%=tdclass%>" nowrap><%=infoResult[i][4]%>&nbsp;</td>
				<td class="<%=tdclass%>" nowrap><%=infoResult[i][5]%>&nbsp;</td>
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
