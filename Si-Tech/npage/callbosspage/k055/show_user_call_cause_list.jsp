<%
	/*
	 * 功能: 来电原因查询
	 * 版本: 1.0
	 * 日期: 2008/10/18
	 * 作者: zhangjc 
	 * 版权: sitech
	 * modify by yinzx 20091001 去掉外呼流水字段
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
 /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String opCode = "k055";
	String opName = "用户信息";
	
	String caller_phone = request.getParameter("caller_phone");

	// 获得系统当前月份
	java.util.Date current = new java.util.Date();
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM"); 
    String curMonth=sdf.format(current);
    
    String tableName = "DCALLCALL" + curMonth;
    String accept_name = "";
     accept_name="decode(b.accept_code ,'0',	'人工'" ;    
		 accept_name+=                   ",'1',	'自动'";     
		 accept_name+=                   ",'2',	'来人'";     
		 accept_name+=                   ",'3',	'来函'";     
		 accept_name+=                   ",'4',	'传真'";     
		 accept_name+=                   ",'5',	'EMail'";    
		 accept_name+=                   ",'6',	'Web'";      
		 accept_name+=                   ",'7',	'呼出'";     
		 accept_name+=                   ",'8',	'三方通话'" ;
		 accept_name+=                   ",'9',	'内部呼叫'" ;
		 accept_name+=                   ",'10','呼出反馈'" ;
		 accept_name+=                   ",'11','其它'";     
		 accept_name+=                   ",'12','短信'";     
		 accept_name+=                   ",'13','未受理' ),";

	
	String sqlStr = "select contact_id,to_char(begin_date,'yyyymmdd hh24:mi:ss'),callcausedescs,accept_phone,caller_phone,accept_login_no,accept_long,acceptid,"+accept_name+"call_accept_id,a.accept_kf_login_no ";
	sqlStr += "from " + tableName + " a, SCALLACCEPTCODE b ";
	sqlStr += "where accept_phone =:caller_phone and a.acceptid = b.accept_code order by a.begin_date desc";
   myParams = "caller_phone="+caller_phone ;                                     
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="13">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="13" scope="end" />

<html>
	<head>
		<title>用户信息</title>
		<script type="text/javascript">
			function openCustomerDetainPage() {
				var url = "/npage/callbosspage/customerDetain/customerDetain.jsp";
				var iHeight = 500;
				var iWidth = 950;
			  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
				var features = "height=" + iHeight + ",width=" + iWidth + ",resizable=yes,"
										 + "top=" + iTop + ",left=" + iLeft;
				window.open(url, null, features);
				return;
			}
		</script>
	</head>

	<body>
		<%@ include file="/npage/include/header.jsp"%>
		<div id="Operation_Table">
			<a href="javascript:openCustomerDetainPage()">
				<span style="font-weight:bold;font-size:12px;text-decoration:underline;">
					客户挽留
				</span><br /><br />
			</a>
			<table cellSpacing="0">
				<tr>
					<th align="center" class="blue" width="8%">
						序号
					</th>
					<th align="center" class="blue" width="8%">
						受理时间
					</th>
					<th align="center" class="blue" width="8%">
						来电原因
					</th>
					<th align="center" class="blue" width="8%">
						受理号码
					</th>
					<th align="center" class="blue" width="8%">
						主叫号码
					</th>
					<th align="center" class="blue" width="8%">
						受理工号
					</th>
					<th align="center" class="blue" width="8%">
						BOSS号码
					</th>
					<th align="center" class="blue" width="8%">
						受理时长
					</th>
					<th align="center" class="blue" width="8%">
						受理方式
					</th>
					<th align="center" class="blue" width="8%">
						流水号
					</th>
					 
				</tr>

				<%
					for (int i = 0; i < queryList.length; i++) {
						String tdClass = "";
						
						if ((i + 1) % 2 == 1) {
							tdClass = "grey";
						}
				%>
				<tr>
					<td align="center" class="<%=tdClass%>"><%=i+1%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][1]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][2]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][3]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][4]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][10]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][5]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][6]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][8]%>&nbsp;</td>
					<td align="center" class="<%=tdClass%>"><%=queryList[i][0]%>&nbsp;</td>
	 
				</tr>
				<%
					}
				%>
			</table>
		</div>

		<%@ include file="/npage/include/footer.jsp"%>
	</body>
</html>