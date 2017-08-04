<%
   /*
   * 功能: K199 客服中心运营指标体系
　 * 版本: 1.0.0
　 * 日期: 2009/9/9
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ page import="java.util.*"%>

<%

  
	String[][] dataRows = null;
  	
	String opCode = "K199";
	String opName = "客服中心运营指标体系";
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));

	String sqlStr = "  select SERIALNO || ',' || to_char(datetime, 'YYYY-MM-DD HH24:MI:SS') || ',' || c1 || ',' || c2 || ',' || c3 || ',' || c4 || ',' || c5 || ',' || c6 || ',' || c7 || ',' || c8 || ',' || c9 || ',' || c10 || ',' || c11 || ',' || c12 || ',' || c13 || ',' || c14 || ',' || c15 || ',' || c16 || ',' || c17 || ',' || c18 || ',' || c19 || ',' || c20 || ',' || c21 || ',' || c22 || ',' || c23 || ',' || c24 || ',' || c25 || ',' || c26 || ',' || c27 || ',' || c28 || ',' || c29 || ',' || c30 || ',' || c31 || ',' || c32 || ',' || c33 || ',' || c34 || ',' || c35 || ',' || c36 || ',' || c37 || ',' || c38 || ',' || c39 || ',' || c40 || ',' || c41 || ',' || c42 || ',' || c43 || ',' || c44 || ',' || c45 || ',' || c46 || ',' || c47 || ',' || c48 || ',' || c49 || ',' || c50 || ',' || c51 || ',' || c52 || ',' || c53 || ',' || c54 || ',' || c55 || ',' || c56 || ',' || c57 || ',' || c58 || ',' || c59 || ',' || c60 || ',' || c61 || ',' || c62 || ',' || c63 || ',' || c64 || ',' || c65 || ',' || c66 || ',' || c67 || ',' || c68 || ',' || c69 || ',' || c70 || ',' || c71 || ',' || c72 || ',' || c73 || ',' || c74 || ',' || c75 || ',' || c76 || ',' || c77 || ',' || c78 || ',' || c79 || ',' || c80 || ',' || c81 || ',' || c82 from difoperational  where 1=1  "  ;
 
	String strCountSql = "select to_char(count(*)) count  from difoperational a where 1=1";
	
	String edBeginTimeSql = " ";
 
  java.text.DecimalFormat dataFormat = new java.text.DecimalFormat("#.########");


	
	String start_date = request.getParameter("start_date"); //结束时间
	 
	


	
	String[] xx= new String[]{};
	int rowCount = 0;
	int pageSize = 20; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String action = "doLoad";
	String sqlOrderby=" order by  datetime desc";
	 

	 
	String sqlFilter = request.getParameter("sqlFilter");

	//查询条件
	if (sqlFilter == null || sqlFilter.trim().length() == 0)
	 {
		if (start_date != null && !start_date.trim().equals("")) 
		{
			edBeginTimeSql = " and  '"+start_date+"'  like to_char(datetime,'yyyymm') || '%'  ";
		}
		
		 sqlFilter= edBeginTimeSql;
	}

     sqlFilter+= sqlOrderby;
%>

<%
		if ("doLoad".equals(action)) {
		sqlStr += sqlFilter;
		String sqlTemp = strCountSql + sqlFilter;
		 
		HashMap hashMap =new HashMap();
		String _start_date = start_date;
		if(start_date!=null&&start_date.length()>8){
			_start_date = start_date.substring(0,8);
		}
		hashMap.put("start_date",_start_date); 

    rowCount=((Integer)KFEjbClient.queryForObject("k199Mainselect_CountSql",hashMap)).intValue(); 
    
		strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		int start = (curPage - 1) * pageSize + 1;
	  int end = curPage * pageSize;
	  hashMap.put("start", ""+start);
	  hashMap.put("end", ""+end);
	

    List iDataList3 =(List)KFEjbClient.queryForList("k199Mainselect",hashMap);                              
	  String[][] queryList = getArrayFromListMap(iDataList3 ,0,2); 
	  dataRows = new String[queryList.length][];	 
    for(int i=0;i<queryList.length;i++)
    
   {       
              xx=queryList[i][1].split(",");
              dataRows[i]  =xx ;       
   }
   }
   
    
    
   
%>


<html>
	<head>
		<%@ include file="k199_query.jsp" %>
	</head>
	<body onLoad="">
		<div id="Operation_Table">
			<input type="button" class="b_foot" value = "增加" onClick="openWinMid('k199_addsceTrans.jsp','新增结点',600,1000);" >
      <input type="button" class="b_foot" value = "修改" onClick="modifysceTrans();">
      <input type="button" class="b_foot" value = "删除" onClick="delsceTrans();">
       
     
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" style="width:720px">
						
						
					</td>
				</tr>
			</table>
			<table cellSpacing="0">
				<input type="hidden" name="chkBoxNum" value="<%=dataRows.length%>">
				<tr>
				  <th width="2%" >选择</th>
		     <td noWrap="nowrap" >序号</td>
    <td width="120" noWrap="nowrap" >提交日期</td>
    <td noWrap="nowrap" >员工满意度</td>
    <td noWrap="nowrap" >总体流失率</td>
    <td noWrap="nowrap" >主动流失率</td>
    <td noWrap="nowrap" >人员招聘及时率</td>
    <td noWrap="nowrap" >到岗及时率</td>
    <td noWrap="nowrap" >新员工转正率（上岗率）</td>
    <td noWrap="nowrap" >培训满意率</td>
    <td noWrap="nowrap" >培训按时完成率</td>
    <td noWrap="nowrap" >培训出勤率</td>
    <td noWrap="nowrap" >培训合格率</td>
    <td noWrap="nowrap" >客户满意度</td>
    <td noWrap="nowrap" >挂机满意率</td>
    <td noWrap="nowrap" >拨测综合得分</td>
    <td noWrap="nowrap" >人工服务差错率</td>
    <td noWrap="nowrap" >一次解决率</td>
    <td noWrap="nowrap" >质检差错率</td>
    <td noWrap="nowrap" >辅导及时率</td>
    <td noWrap="nowrap" >辅导满意率</td>
    <td noWrap="nowrap" >服务投诉率</td>
    <td noWrap="nowrap" >运营总成本</td>
    <td noWrap="nowrap" >运营总收入</td>
    <td noWrap="nowrap" >服务营销总收入</td>
    <td noWrap="nowrap" >人均服务营销收入</td>
    <td noWrap="nowrap" >营销总收入</td>
    <td noWrap="nowrap" >人均营销收入</td>
    <td noWrap="nowrap" >座席外包总收入</td>
    <td noWrap="nowrap" >座席外包平均每客户收入</td>
    <td noWrap="nowrap" >平均单呼成本</td>
    <td noWrap="nowrap" >平均人工服务成本</td>
    <td noWrap="nowrap" >平均每客户服务成本</td>
    <td noWrap="nowrap" >外呼营销收入额</td>
    <td noWrap="nowrap" >投诉工单合格率</td>
    <td noWrap="nowrap" >投诉处理及时率</td>
    <td noWrap="nowrap" >投诉派单错误率</td>
    <td noWrap="nowrap" >投诉电话率</td>
    <td noWrap="nowrap" >重复投诉率</td>
    <td noWrap="nowrap" >升级投诉率</td>
    <td noWrap="nowrap" >投诉处理满意率</td>
    <td noWrap="nowrap" >服务水平（15秒整体接通率）</td>
    <td noWrap="nowrap" >人工服务放弃率</td>
    <td noWrap="nowrap" >队列放置率</td>
    <td noWrap="nowrap" >平均排队时间</td>
    <td noWrap="nowrap" >接通排队时间</td>
    <td noWrap="nowrap" >放弃排队时间</td>
    <td noWrap="nowrap" >人工请求量</td>
    <td noWrap="nowrap" >人工接通量</td>
    <td noWrap="nowrap" >排队呼入率（人工接通率）</td>
    <td noWrap="nowrap" >VIP20秒接通率</td>
    <td noWrap="nowrap" >全球通20秒接通率</td>
    <td noWrap="nowrap" >神州行30秒接通率</td>
    <td noWrap="nowrap" >动感地带30秒接通率</td>
    <td noWrap="nowrap" >它网异地30秒接通率</td>
    <td noWrap="nowrap" >平均延迟时间</td>
    <td noWrap="nowrap" >平均处理时长</td>
    <td noWrap="nowrap" >平均交谈时长（通话均长）</td>
    <td noWrap="nowrap" >平均持线时长</td>
    <td noWrap="nowrap" >平均事后处理时长</td>
    <td noWrap="nowrap" >人均每小时电话处理量</td>
    <td noWrap="nowrap" >在线利用率</td>
    <td noWrap="nowrap" >工时利用率</td>
    <td noWrap="nowrap" >出勤率</td>
    <td noWrap="nowrap" >人工服务占比</td>
    <td noWrap="nowrap" >话务波动系数</td>
    <td noWrap="nowrap" >人工服务预测准确率</td>
    <td noWrap="nowrap" >排班吻合率</td>
    <td noWrap="nowrap" >服务水平符合率</td>
    <td noWrap="nowrap" >每小时交接班人数</td>
    <td noWrap="nowrap" >项目外呼总量</td>
    <td noWrap="nowrap" >外呼接通量</td>
    <td noWrap="nowrap" >外呼营销成功量</td>
    <td noWrap="nowrap" >每小时外呼量</td>
    <td noWrap="nowrap" >计划拨出量</td>
    <td noWrap="nowrap" >接触成功率</td>
    <td noWrap="nowrap" >销售成功率</td>
    <td noWrap="nowrap" >质检合格率</td>
    <td noWrap="nowrap" >主动营销投诉率</td>
    <td noWrap="nowrap" >人工转自动比率</td>
    <td noWrap="nowrap" >IVR满意率</td>
    <td noWrap="nowrap" >知识库满意率</td>
    <td noWrap="nowrap" >系统接通率</td>
    <td noWrap="nowrap" >系统满负荷率</td>
    <td noWrap="nowrap" >故障率</td>
</tr>

				<%
						for (int i = 0; i < dataRows.length; i++) {
	 
						String tdClass = "one";
						if ((i + 1) % 2 == 1) {
							tdClass = "two";
						}
						
				%>
				<tr onClick="">

					<td><input type="checkbox" name="ck_2" value="<%=i%>" ></td>
					</td>

					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					
				<% for (int j = 2; j < 83; j++){ %>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][j].length() != 0) ? dataFormat.format(Double.parseDouble(dataRows[i][j]))
						: "&nbsp;"%>
					</td>
				<% }%>	
				
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][83].length() != 0) ? dataFormat.format(Double.parseDouble(dataRows[i][83]))
						: "&nbsp;"%>
						<input type ="hidden"  id="sceid" name="sceid" value=<%=dataRows[i][0]%>> 
					</td>
					
		
						
						  

					
				</tr>
				<%
				
				}
				%>
			</table>

			<table cellspacing="0">
				<tr>
					<td class="blue" align="right" width="720">
						<%
						if (pageCount != 0) {
						%>
						第
						<%=curPage%>
						页 共
						<%=pageCount%>
						页 共
						<%=rowCount%>
						条
						<%
						} else {
						%>
						<font color="orange">当前记录为空！</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">首页</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">上一页</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">下一页</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">尾页</a>
						<a>快速选择</a>
						<select onchange="jumpToPage(this.value)">
							<%
										for (int i = 1; i <= pageCount; i++) {
										out.print("<option value='" + i + "'");
										if (i == curPage) {
									out.print("selected");
										}
										out.print(">" + i + "</option>");
									}
							%>
						</select style="height:18px">
						&nbsp;&nbsp;
						<a>快速跳转</a>
						<input id="thePage" name="thePage" type="text"
							value="<%=curPage%>" style="height:18px;width:30px"
							onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
						<a href="#" onClick="jumpToPage('jumpToPage1');return false;">
							<font face=粗体>GO</font> <%
 }
 %>
						
					</td>
				</tr>
			</table>
		</div>
	</div>
	</body>
</html>
