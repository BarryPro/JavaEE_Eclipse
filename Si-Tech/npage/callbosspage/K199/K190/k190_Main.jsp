<%
   /*
   * 功能: K190 客服一级报表录入信息表
　 * 版本: 1.0.0
　 * 日期: 2009/9/8
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

  
 
  	
	String opCode = "K190";
	String opName = "客服一级报表录入信息表";
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));

	String sqlStr = " select SERIALNO,to_char(datetime,'YYYY-MM-DD HH24:MI:SS') AS datetime,CENTER10086,CALLAG10086, CALLPE10086,CALLEN10086,CALLER10086,CALLPER10086,CENTER12580, CALLOUTAG10086,CALLEROUT10086,OUTAG10086,AG12580,AGER12580,OUTAGER10086,ENER10086,OUTMAIN, OTHERAG1008612580,WAVEBD,    	OUTTOTAL,    OTHERER1008612580,MALFUNCTION,AGENTAVGNUM,CALLTIME from difagfirst where 1=1  "  ;
 
	String strCountSql = "select to_char(count(*)) count  from difagfirst a where 1=1";
	
	String edBeginTimeSql = " ";
 


	
	String start_date = request.getParameter("start_date"); //结束时间
	 
	


	String[][] dataRows = new String[][] {};
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

		if ("doLoad".equals(action)) {
		sqlStr += sqlFilter;
		String sqlTemp = strCountSql + sqlFilter;
		 
		HashMap hashMap =new HashMap();
		String _start_date = start_date;
		if(start_date!=null&&start_date.length()>8){
			_start_date = start_date.substring(0,8);
		}
		hashMap.put("start_date",_start_date); 

    rowCount=((Integer)KFEjbClient.queryForObject("k190Mainselect_CountSql",hashMap)).intValue(); 

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
		List iDataList3 =(List)KFEjbClient.queryForList("k190Mainselect",hashMap);                              
	  dataRows = getArrayFromListMap(iDataList3 ,1,26);    

 
   }
%>


<html>
	<head>
		<%@ include file="k190_query.jsp" %>
	</head>
	<body onLoad="">
		<div id="Operation_Table">
			<input type="button" class="b_foot" value = "增加" onClick="openWinMid('k190_addsceTrans.jsp','新增结点',600,1000);" >
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
    <td noWrap="nowrap" >全省10086客户服务中心数量</td>
    <td noWrap="nowrap" >10086呼入总座席数</td>
    <td noWrap="nowrap" >10086呼入专家坐席数</td>
    <td noWrap="nowrap" >10086外语座席数</td>
    <td noWrap="nowrap" >10086呼入话务员数</td>
    <td noWrap="nowrap" >10086呼入专席话务员数</td>
    <td noWrap="nowrap" >12580客户服务中心数量</td>
    <td noWrap="nowrap" >10086呼出座席数</td>
    <td noWrap="nowrap" >10086呼出话务员数</td>
    <td noWrap="nowrap" >10086承接的外包项目的坐席数</td>
    <td noWrap="nowrap" >12580座席数量</td>
    <td noWrap="nowrap" >12580话务员数量</td>
    <td noWrap="nowrap" >10086承接的外包项目的话务员数</td>
    <td noWrap="nowrap" >10086外语话务员数</td>
    <td noWrap="nowrap" >主动流失率</td>
    <td noWrap="nowrap" >外包公司承接10086/12580业务的坐席数</td>
    <td noWrap="nowrap" >话务拨动系数</td>
    <td noWrap="nowrap" >总体流失率</td>
    <td noWrap="nowrap" >外包公司承接10086/12580业务的话务员数</td>
    <td noWrap="nowrap" >系统故障次数</td>
    <td noWrap="nowrap" >人均每小时电话处理量</td>
    <td noWrap="nowrap" >工时合理率</td>
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
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][4].length() != 0) ? dataRows[i][4]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][5].length() != 0) ? dataRows[i][5]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][6].length() != 0) ? dataRows[i][6]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][7].length() != 0) ? dataRows[i][7]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][8].length() != 0) ? dataRows[i][8]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][9].length() != 0) ? dataRows[i][9]
						: "&nbsp;"%>
					</td>
 
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][10].length() != 0) ? dataRows[i][10]
						: "&nbsp;"%>
					</td>
						<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][11].length() != 0) ? dataRows[i][11]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][12].length() != 0) ? dataRows[i][12]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][13].length() != 0) ? dataRows[i][13]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][14].length() != 0) ? dataRows[i][14]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][15].length() != 0) ? dataRows[i][15]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][16].length() != 0) ? dataRows[i][16]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][17].length() != 0) ? dataRows[i][17]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][18].length() != 0) ? dataRows[i][18]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][19].length() != 0) ? dataRows[i][19]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][20].length() != 0) ? dataRows[i][20]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][21].length() != 0) ? dataRows[i][21]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][22].length() != 0) ? dataRows[i][22]
						: "&nbsp;"%>
					</td>
				 <td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][23].length() != 0) ? dataRows[i][23]
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
