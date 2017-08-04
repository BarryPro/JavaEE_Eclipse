<%
  /*
   * 功能: 短信日志导出excel
　 * 版本: 1.0.0
　 * 日期: 2009/02/21
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,javax.servlet.http.HttpServletRequest,com.sitech.boss.util.excel.*"%>

<html>
<head>
<%
	
	 String[] chks = (String[])request.getParameterValues("chk");
	  //导出当前显示数据
   String[] strHead_name = new String[10];
	      strHead_name[0] = "序号";
	      strHead_name[1] = "接触流水号";
	      strHead_name[2] = "工号";
	      strHead_name[3] = "目的地址";
	      strHead_name[4] = "源地址";
	      strHead_name[5] = "短信状态";
	      strHead_name[6] = "短信内容";
	      strHead_name[7] = "发送时间";
	      strHead_name[8] = "受理时间";
	      strHead_name[9] = "主叫号码";
	 String phSql = "";
	 String sql1 = "select ";
	 String timeSql = "";
	 String begintime = request.getParameter("begintime")==null?"":request.getParameter("begintime");
	 String endtime = request.getParameter("endtime")==null?"":request.getParameter("endtime");
	 
	 if(begintime != null && begintime.length() > 0){
		
		
	 		timeSql = " and to_char(t.INSERT_TIME,'yyyy-MM-dd HH24:MI') >= '"+begintime+"'";
		}
		if(endtime != null && endtime.length() > 0){
			
			timeSql += " and to_char(t.INSERT_TIME,'yyyy-MM-dd HH24:MI') <= '"+endtime+" 23:59:59'";
		}
	 
	 String caller_phone = "";
	 String user_phone = "";
	 String send_login_no = "";
	 String curPage = request.getParameter("curPage")==null?"":request.getParameter("curPage");
	 String pageSize = request.getParameter("pageSize")==null?"":request.getParameter("pageSize");
	 String rowCount = request.getParameter("rowCount")==null?"":request.getParameter("rowCount");
	 String expFlag = request.getParameter("typ")==null?"":request.getParameter("typ");
	 
	 if(request.getParameter("caller_phone") != null && request.getParameter("caller_phone").length() > 0){
	 	caller_phone = request.getParameter("caller_phone");
	 	phSql += " and t.caller_phone like '%"+caller_phone+"%'";
	 }
	 if(request.getParameter("user_phone") != null && request.getParameter("user_phone").length() > 0){
	 	user_phone = request.getParameter("user_phone");
	 	phSql += " and t.user_phone like '%"+user_phone+"%'";
	 }
	 if(request.getParameter("send_login_no") != null && request.getParameter("send_login_no").length() > 0){
	 	send_login_no = request.getParameter("send_login_no");
	 	phSql += " and t.send_login_no like '%"+send_login_no+"%'";
	 }
   int intMaxRow = 5000+1;
	 String excelName="短信日志";
	 
   if("cur".equalsIgnoreCase(expFlag)){
   		
   		String[] strHead = new String[chks.length+1];
   		strHead[0] = "序号";
   		for(int i = 0; i < chks.length; i++){
   			if(i==0){
   				strHead[i+1] = strHead_name[Integer.parseInt(chks[0].split(";,")[0])];
   				sql1 += chks[0].split(";,")[1];
   			}else{
   				strHead[i+1] = strHead_name[Integer.parseInt(chks[i].split(";")[0])];
   				sql1 += chks[i].split(";")[1];
   			}   			
   			
   		}
   		sql1 += " from SMS_PUSH_REC_LOG_12580 t where 1=1 " + phSql + timeSql+" order by t.insert_time desc,t.user_phone";
   		
   		String querySql = PageFilterSQL.getOraQuerySQL(sql1,curPage,pageSize,rowCount);
   		
   		
			
%>		           
        <wtc:service name="s151Select" outnum="21">
					<wtc:param value="<%=querySql %>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="21"   scope="end"/>
<%
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
   		String[] strHead = new String[chks.length];
   		for(int i = 0; i < chks.length; i++){
   			if(i==0){
   				strHead[0] = strHead_name[Integer.parseInt(chks[0].split(";,")[0])];
   				sql1 += chks[0].split(";,")[1];
   			}else{
   				strHead[i] = strHead_name[Integer.parseInt(chks[i].split(";")[0])];
   				sql1 += chks[i].split(";")[1];
   			} 
   		}
   		sql1 += " from SMS_PUSH_REC_LOG_12580 t where 1=1" + phSql + timeSql+" order by t.insert_time desc,t.user_phone";
   		
   		String countsqlStr = "select count(*) from SMS_PUSH_REC_LOG_12580 t where 1=1 " + phSql + timeSql;//因为每次导出2000判断导出次数 
%>
 				<wtc:service name="s151Select" outnum="2">
					<wtc:param value="<%=countsqlStr %>"/>
				</wtc:service>
				<wtc:array id="queryList"  start="0" length="2"   scope="end"/>
<%
			String sumStr = queryList[0][0];
			if(Integer.parseInt(sumStr) < 2000){
%>
			<wtc:service name="s151Select" outnum="21">
			<wtc:param value="<%=sql1 %>"/>
			</wtc:service>
			<wtc:array id="dqueryList"  start="0" length="21"   scope="end"/>
<%				
				XLSExport.toExcel(strHead,dqueryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");
			}else if(Integer.parseInt(sumStr) <= 50000){
				  String[][] dataRows = new String[Integer.parseInt(sumStr)][];
					int s = 0;
					int n = 0;					
					if(Integer.parseInt(sumStr)%1999 == 0){
						n = Integer.parseInt(sumStr)/1999;
					}else{
						n = Integer.parseInt(sumStr)/1999+1;
					}
					
					for(int a = 0; a < n; a++){
					
					String sqlStrSum = "SELECT * FROM (SELECT ROWNUM rnm, aa.* FROM ("+sql1+") aa WHERE ROWNUM <= "+((a+1)*1999)+") WHERE rnm >= "+(a*1999+1);

%>
			<wtc:service name="s151Select" outnum="23">
			<wtc:param value="<%=sqlStrSum%>"/>
			</wtc:service>
			<wtc:array id="queryList"  start="1" length="22"   scope="end"/>
<%
						if(a==0){
						  
							System.arraycopy(queryList,0,dataRows,0,queryList.length);
						}else{
							
							System.arraycopy(queryList,0,dataRows,a*1999,queryList.length);
						}
					}
					XLSExport.toExcel(strHead,dataRows,intMaxRow,excelName,response);
					out.print("<script language='javascript'>window.close();</script>");
			}else if(Integer.parseInt(sumStr) > 50000){
					out.println("<font color='red'>一次最多可导出5万条数据</font>");
			}
		}

%>
<title></title>

<script>
	function jsExcel(tp){
		var chks = document.sitechform.chk;
		var flag = false;
		for(var i = 0; i < chks.length; i++){
			if(chks[i].checked){
				flag = true;
			}
		}
		if(flag){
			document.sitechform.action="k507_sel_cloumn.jsp?typ="+tp;
			document.sitechform.submit();
		}else{
			rdShowMessageDialog("请选择要导出的字段");
		}
		
	}
</script>
</head>

<body>
<div id="Operation_Table">
<form name="sitechform" id="sitechform" method="post">
	
<input type="hidden" name="begintime" value="<%=begintime==null?"":begintime %>" />
<input type="hidden" name="endtime" value="<%=endtime==null?"":endtime %>" />

<input type="hidden" name="caller_phone" value="<%=caller_phone==null?"":caller_phone %>" />
<input type="hidden" name="user_phone" value="<%=user_phone==null?"":user_phone %>" />
<input type="hidden" name="send_login_no" value="<%=send_login_no==null?"":send_login_no %>" />
<input type="hidden" name="curPage" value="<%=curPage==null?"":curPage %>" />
<input type="hidden" name="pageSize" value="<%=pageSize==null?"":pageSize %>" />
<input type="hidden" name="rowCount" value="<%=rowCount==null?"":rowCount %>" />

<table width="200" border="1">
	
  <tr align="center" cellspacing="0">
    <td><input name="chk" type="checkbox" value="1;,contact_id"></td>
    <td>&nbsp;流水号</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="2;,t.send_login_no"></td>
    <td>&nbsp;工号</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="3;,t.user_phone"></td>
    <td>&nbsp;目的地址</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="9;,t.caller_phone"></td>
    <td>&nbsp;主叫号码</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="4;,t.long_serv_no"></td>
    <td>&nbsp;源地址</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="5;,decode(t.Success_FLAG,'Y','成功','N','失败')"></td>
    <td>&nbsp;短信状态</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="6;,t.SEND_CONTENT"></td>
    <td>&nbsp;短信内容</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="7;,to_char(t.VALID_TIME, 'yyyy-MM-dd hh24:mi:ss')"></td>
    <td>&nbsp;发送时间</td>
  </tr>
  <tr align="center">
    <td><input name="chk" type="checkbox" value="8;,to_char(t.INSERT_TIME, 'yyyy-MM-dd hh24:mi:ss')"></td>
    <td>&nbsp;受理时间</td>
  </tr>
  <tr align="center">
    <td colspan="2"><input type="button" value="导出当前页" class="b_foot" onClick="jsExcel('cur')">&nbsp;<input type="button" class="b_foot" value="导出全部" onClick="jsExcel('all');">&nbsp;<input type="button" class="b_foot" value="取消" onClick="window.close();"></td>
  </tr>
</table>

</form>
</div>
</body>
</html>
