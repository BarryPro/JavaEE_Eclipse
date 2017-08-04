<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>

<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	
	String phone_no  = request.getParameter("phone_no");	
	String work_nos  = request.getParameter("work_nos");
	String starttimes=request.getParameter("starttime");
	String banlitype=request.getParameter("banlitype");
	String endtimes=request.getParameter("endtime");
	String opCode=request.getParameter("opCode");
	String work_no = (String)session.getAttribute("workNo");
	String beizhus=work_no+"进行自有业务办理操作日志查询";
	
	String bus_realPath = request.getRealPath("npage/properties")
     +"/zyoptype.properties";

	
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = work_nos;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = beizhus;
	inputParsm[8] = starttimes;
	inputParsm[9] = endtimes;
	inputParsm[10] = banlitype;
	
		int nowPage = 1;
		int allPage = 0;
				
%>
     	
  	<wtc:service name="sM217Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>

	</wtc:service>
        <wtc:array id="result2" scope="end" />
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 

	        <th>操作时间</th>
	        <th>手机号码</th>
	        <th>业务类别</th>
	        <th>操作类型</th>
	        <th>操作人姓名</th>
	        <th>操作工号</th>
	        <th>操作详细信息</th>



	      </tr>
	    <script language="javascript">
	      	<%
	   if(retCode.equals("000000")) {
	    if(result2.length>0) {				
		  %>		
		  var zifuchuans="";
		  		<%
		  String tbClass="";
				for(int y=0;y<result2.length;y++){
					if(y%2==0){
						tbClass="Grey";
					}else{
						tbClass="";
					}
					System.out.println(result2[y][0]);
					System.out.println(result2[y][1]);
					System.out.println(result2[y][2]);
					System.out.println(result2[y][3]);
					System.out.println(result2[y][4]);
					System.out.println(result2[y][5]);
					System.out.println(result2[y][6]);
			  		%>
			   var jiemianyuansus='';     
		     //var jsondata='[{"key":"用户手机号码","value":"13904512358"},{"key":"被屏蔽业务","value":"全选,短信,彩信"},{"key":"操作员","value":"aaaaxp"},{"key":"操作时间","value":"2014-12-31 15:48:15"}]';
		      var jsondata='<%=result2[y][6]%>';
					var json=eval(jsondata);  
					$.each(json,function(i,n){ 
						if(json[i].value=="451") {
								json[i].value="黑龙江";
							}
					jiemianyuansus=jiemianyuansus+''+json[i].key+':'+json[i].value+'，';				
					});
					
					jiemianyuansus=jiemianyuansus.substring(0,(jiemianyuansus.length-1));
					jiemianyuansus=jiemianyuansus+'。';
			  	zifuchuans = zifuchuans+'<tr align="center" id="row_<%=y%>"><td class="<%=tbClass%>"><%=result2[y][5]%></td><td class="<%=tbClass%>"><%=result2[y][0]%></td><td class="<%=tbClass%>"><%=readValue(result2[y][1],"ywlb","optype",bus_realPath)%></td><td class="<%=tbClass%>"><%=readValue(result2[y][1],result2[y][2],"optype",bus_realPath)%></td><td class="<%=tbClass%>"><%=result2[y][4]%></td><td class="<%=tbClass%>"><%=result2[y][3]%></td><td class="<%=tbClass%>">'+jiemianyuansus+'</td></tr>';
				<%
				}
				allPage = (result2.length - 1) / 10 + 1 ;
				
			%>
			
		$("#ssss1").append(zifuchuans);
		
			<%
			}
			}
		%>
	      	</script>
		<%
		if(retCode.equals("000000")) {
		if(result2.length>0) {

		%>


				<tbody id="ssss1">

				</tbody>
        <div align="center">
				<table align="center">
				<tr>
					<td align="center">
						总记录数：<font name="totalPertain" id="totalPertain"><%=result2.length%></font>&nbsp;&nbsp;
						总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
						当前页：<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
						每页行数：10
						<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('+1');">[下一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
						跳转到
						<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
							<%
							for (int i = 1; i <= allPage; i ++) {
							%>
								<option value="<%=i%>">第<%=i%>页</option>
							<%
							}
							%>
						</select>
						页
					</td>
				</tr>
				</table>
			</div>
			<input type="hidden" id="nowPage" />
			<input type="hidden" id="allPage" value="<%= allPage %>" />   

		<%
		    
		  }else {
		%>
<tr height='25' align='center' ><td colspan='7'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='7'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		if (goPage == "-1") {
			setPage(parseInt($("#nowPage").val()) - 1);
			return;
		} else if (goPage.length == 2 && "+1" == goPage) {
			setPage(parseInt($("#nowPage").val()) + 1);
			return;
		}else{ 
			goPage = parseInt(goPage);
			if(goPage < 1){
				return false;
			}else if(goPage > $("#allPage").val()){
				return false;
			}else{
				pageNo = parseInt(goPage);
				//所有行隐藏
				$("[id^='row_']").hide();
				//显示行
				var startRow = (pageNo - 1) * 10;
				var endRow = pageNo * 10 - 1;
				for(var i = startRow; i <= endRow; i++ ){
					var pageStr = "#row_" + i;
					$(pageStr).show();
				}
				$("#nowPage").val(pageNo);
				$("#currentPage").text(pageNo);
			}
		}
	}
	
	
</script>
