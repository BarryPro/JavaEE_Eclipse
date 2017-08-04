<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/05/22
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>   
<%@ page import="com.sitech.boss.util.page.*"%>		           
<%


 	String opCode = request.getParameter("opCode");
 	String opName = "数据清理任务审批";
 	String regionCode = (String)session.getAttribute("regionCode");
 	
	String owner_name = request.getParameter("owner_name");
	String table_name = request.getParameter("table_name");
	String creator = request.getParameter("creator");
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time"); 	
	
	int iPageNumber = 1;
  int iPageSize = 10;
  int iStartPos = (iPageNumber-1)*iPageSize;
  int iEndPos = iPageNumber*iPageSize;
    
    	
  String sql = "select TASK_ID,OWNER_NAME,TABLE_NAME,CREATOR,CREATE_TIME,TASK_START_TIME,TASK_END_TIME,TASK_STATUS,CLEAN_TYPE from dTableCleanTask where TASK_STATUS='0'";
	if (owner_name != null)
	{
		if (owner_name.trim().length() > 0) {
		    sql = sql + " and  OWNER_NAME= '" + owner_name + "'";
		}
	}
	if (table_name != null)
	{
		if (table_name.trim().length() > 0) {
		    sql = sql + " and  TABLE_NAME= '" + table_name + "'";
		}
	}	 
	if (creator != null)
	{
		if (creator.trim().length() > 0) {
		    sql = sql + " and  CREATOR= '" + creator + "'";
		}
	}		 
	if (begin_time != null)
	{
		if (begin_time.trim().length() > 0) {
		    sql = sql + " and  TASK_START_TIME= to_date('" + begin_time + "','YYYYMMDDHH24MISS')";
		}
	}	
	if (end_time != null)
	{
		if (end_time.trim().length() > 0) {
		    sql = sql + " and  TASK_END_TIME= to_date('" + end_time + "','YYYYMMDDHH24MISS')";
		}
	}			  
	System.out.println("1111111111sql="+sql);
	String sqlStr0  = "SELECT count(*) from (" + sql + ")"; 
	String sqlStr1 = "select * from (select row_.*,rownum id from (" + sql + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 
	System.out.println("1111111111sql="+sqlStr1);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="18"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="result"  scope="end"/>
<%
int totalNum = allNumArr.length>0?Integer.parseInt(allNumArr[0][0]):0;
%>        
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>                 
		<title><%=opName%></title>   
		<script>
				function getTask(obj){
					document.all.taskId.value=obj.value;
				}
				function doCfm(){
					if(document.all.taskId.value==""){
						rdShowMessageDialog("请选择一个任务");
						return false;
					}
					if(document.all.taskStatus.value=="0"){
						rdShowMessageDialog("请选择审批状态");
						return false;
					}
					var myPacket=new AJAXPacket("f9652_Cfm.jsp","正在获取数据，请稍候......");
					myPacket.data.add("taskId",document.all.taskId.value);
					myPacket.data.add("taskStatus",document.all.taskStatus.value);
					myPacket.data.add("taskNote",document.all.taskNote.value);
					core.ajax.sendPacket(myPacket);
					myPacket=null;  					
				}
				function doProcess(packet){
					var retCode=packet.data.findValueByName("retCode");
					var retMsg=packet.data.findValueByName("retMsg");
					rdShowMessageDialog(retCode+":"+retMsg);
					window.location.reload();
				}
				
		</script>
	</head>
	<body>
		<form name="form1" action="f9652_Cfm.jsp">
		<%@ include file="/npage/include/header.jsp" %>

			<div class="title">
				<div id="title_zi">数据清理任务审批</div>
			</div>		
			<table cellspacing="0" >
				<tr > 
					<th>&nbsp;</th>
					<th>属主</th>
					<th>表名</th>
					<th>创建人</th>
					<th>创建时间</th>
					<!--th>任务开始时间</th>
					<th>任务结束时间</th-->	
					<th>任务清理策略</th>		
					<th>任务状态</th>																					
				</tr>			
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i = 0 ; result != null && i < result.length ; i++){
				tbclass = (i%2==0)?"Grey":"";
	%>						
				<tr > 
					<td nowrap class="<%=tbclass%>"> 
						<input type="radio" name="task_id" value="<%=result[i][0]%>" onclick="getTask(this);"/>
					</td>
					<td nowrap class="<%=tbclass%>"> 
						<%=result[i][1]%> &nbsp;
					</td>	
					<td nowrap class="<%=tbclass%>"> 
						<%=result[i][2]%> &nbsp;
					<td nowrap class="<%=tbclass%>"> 
						<%=result[i][3]%> &nbsp;
					</td>
					<td nowrap class="<%=tbclass%>"> 
						<%=result[i][4]%> &nbsp;
					</td>	
					<td nowrap class="<%=tbclass%>"> 
					<%
							if(result[i][8].equals("0")){
								result[i][8] = "整表迁移";
							}else if(result[i][8].equals("1")){
								result[i][8] = "SQL迁移";
							}else if(result[i][8].equals("2")){
								result[i][8] = "自定义应用迁移";
							}else if(result[i][8].equals("3")){
								result[i][8] = "分区表迁移";
							}
					%>
					<%=result[i][8]%>
					</td>					
					<td nowrap class="<%=tbclass%>"> 
						待审批
					</td>			
				</tr>	
<%}}%>	
		<tr align="right">
			<td colspan="20" style="background:#E6E6E6">
			  <div style="position:relative;font-size:12px;">
						<%	
						   int iQuantity = totalNum;
						   Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						   PageView view = new PageView(request,out,pg); 
						   view.setVisible(true,true,0,0);       
						%>
						&nbsp;&nbsp;&nbsp;&nbsp;	
				</div>	
			</td>	
		</tr>
	</table>	
	</br>
	<table cellspacing="0">
		<tr>
			<td>任务编号</td>
			<td><input type="text" readonly class="InputGrey" value="" name="taskId" size="100"></td>
		</tr>
		<tr>
			<td>审批状态</td>
			<td>
				<select name="taskStatus">
					<option value="1">任务就绪</option>
					<option value="8">任务撤销</option>
				</select>
			</td>
		</tr>		
		<tr>
			<td>审批意见</td>
			<td>
				<input type="text"  value="" name="taskNote" size="100">
			</td>
		</tr>			
	</table>
	<table cellspacing="0">
				<tr  id="footer">
					<td colspan="9">
						<input class="b_foot" name=back onClick="doCfm();" style="cursor:hand" type=button value="确认"/>
						<input class="b_foot" name=back onClick="history.go(-1)" style="cursor:hand" type=button value="返回"/>
						<input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="关闭"/>
					</td>
				</tr>
			</table>

		<%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" value="<%=opName%>"/>
		</form>
	</body>
</html>
