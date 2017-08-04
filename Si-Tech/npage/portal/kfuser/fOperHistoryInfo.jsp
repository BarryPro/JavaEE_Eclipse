<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
　 * 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
   * 修改日期 2009-05-32     修改人  libina     修改目的  修正无内容TD显示异常的问题
 　*/
%>
<%
  String phoneNo  = (String)session.getAttribute("activePhone");
  Calendar cr = Calendar.getInstance();
  int yy = Integer.parseInt("" + cr.get(cr.YEAR)) - 2;
  String year = "" + yy;
  String year1 = "" + cr.get(cr.YEAR);
  String crm = cr.get(cr.MONTH) < 10 ? "0" + (cr.get(cr.MONTH)+1) : "" + (cr.get(cr.MONTH)+1);
  String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
  String begindate = year+crm+crd + " 00:00:00";
  String enddate = year1+crm+crd + " 23:59:59"; 
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
  String login_no = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_HisQuery"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="15">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=begindate%>"/>
	<wtc:param value="<%=enddate%>"/>
</wtc:service>
<HTML>
<HEAD>
<title>历史信息查询结果</title>

<!------------------------------------
   -对页面表格进行排序需要使用的js脚本	
-------------------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery.tablesorter.js"></script>

<script language="javascript">
    /***********************************
	 *add by zhanghonga@20090314
	 *解决用户要求:面板上“历史信息查询”，点击“变更时间”可进行排序.最差方法按照变更时间进行倒排序.
	 *(以下代码删除之后,对原页面无任何影响)
	 ***********************************/
	$(document).ready(function() 
    	{ 
    		/***********************************
    		  *tablesorter()的参数可以为空,如果为空,页面初始化的时候显示默认的排序效果;
    		  *sortList:[[3,1]]表示从表格按照第四列降序排列.其中第一个参数"3"表示下标从0开始的第四列,第二个参数:0升序,1降序
    		  *如果需要页面初始化的时候同时按照几列排列,使用sortList:[[0,0],[1,0]]这样的形式
    		************************************/
        	$("#myTable").tablesorter({
        		sortList:[[3,1]]	
        	});
        	
        	/***********************************
        	 *在所有的th上附加样式,使得鼠标移上去后,变成别的形状,例如"手"形的形状
        	 ***********************************/
        	$("th").css({cursor:"hand"}); 
    	} 
	); 


    /***********************************
	 *add by zhanghonga@20090314
	 *解决用户要求:增加按照时间段（月）查询，对第一步查询出的内容做二次筛选
	 *(以下代码删除之后,对原页面无任何影响)
	 ***********************************/	
	function doSubmitQuery(){
		var beginQueryDate = $("#beginQueryDate").val();	
		var endQueryDate = $("#endQueryDate").val();
		var myTable = $("#myTable")[0];
		
		if(!forDate($("#beginQueryDate")[0])){
			return false;
		}
		
		if(!forDate($("#endQueryDate")[0])){
			return false;
		}
		
		if(beginQueryDate>endQueryDate){
			rdShowMessageDialog("开始时间不能大于结束时间",0);
			return false;
		}
		
		$("td[@impDate]").each(
			function(i){
				if(this.impDate.substring(0,6)<beginQueryDate||this.impDate.substring(0,6)>endQueryDate){
					myTable.rows[i+1].style.display = "none";		
				}else{
					myTable.rows[i+1].style.display = "block";
				}
			}
		);
	}
	
	
    /***********************************
	 *add by zhanghonga@20090314
	 *解决用户要求:增加按照时间段（月）查询，对第一步查询出的内容做二次筛选
	 *显示一次查询出的所有内容
	 ***********************************/	
	function doShowAllQuery(){
		$("td[@impDate]").each(
			function(i){
				$("#myTable")[0].rows[i+1].style.display = "block";
			}
		);		
	}
</script>
</head>
<body>
<form action="#" method="post" name="form1" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>历史信息查询结果</B></div>
				<DIV id="Operation_Table">
        			<div class="title">历史信息</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
							<thead> 
						      <tr> 
						    	 <th>服务号码</th>
						         <th>变更内容</th>
						         <th>工号</th>
						         <th>变更时间</th>
						         <th>操作流水</th>
						         <th>手续费</th>
						         <th>变更备注</th>
						         <th>现金付款</th> 
						         <th>机器费</th>
						         <th>选号费</th> 
						         <th>入网费</th>
						         <th>操作码</th> 
						         <th>归属代码</th> 
						         <th>SIM卡费</th> 
						      </tr>
						     </thead> 
							<tbody>
							<wtc:iter id="rows" start="1" length="14" indexId="i" >
							<tr>
							<td align="center" title="<%=rows[0]%>"><%=rows[0]%></td>
							<td align="center" title="<%=rows[1]%>"><%="".equals(rows[1])?"&nbsp;":rows[1]%></td>
							<td align="center" title="<%=rows[2]%>"><%=rows[2]%></td>
							<td align="center" title="<%=rows[3]%>" impDate="<%=rows[3]%>"><%=rows[3]%></td>
							<td align="center" title="<%=rows[4]%>"><%=rows[4]%></td>
							<td align="center" title="<%=rows[5]%>"><%=rows[5]%></td>
							<td align="center" title="<%=rows[6]%>"><%=rows[6]%></td>
							<td align="center" title="<%=rows[7]%>"><%=rows[7]%></td>
							<td align="center" title="<%=rows[8]%>"><%=rows[8]%></td>
							<td align="center" title="<%=rows[9]%>"><%=rows[9]%></td>
							<td align="center" title="<%=rows[10]%>"><%=rows[10]%></td>
							<td align="center" title="<%=rows[11]%>"><%=rows[11]%></td>
							<td align="center" title="<%=rows[12]%>"><%=rows[12]%></td>
							<td align="center" title="<%=rows[13]%>"><%=rows[13]%></td>
							</tr>
							</wtc:iter>
							</tbody> 
							</table>
						</div>
<%
	  System.out.println("报表记录开始@libina@20090519");
	  System.out.println("服务调用结果："+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("0".equals(retCode)){
	     successFlag = 0;
	  }
%>
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01001',"+successFlag+",'01001','0','历史信息查询')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("报表记录结束@libina@20090519");
%>    
						<div id="Operation_Table"> 
							<div class="title">请输入年月</div>
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td class="blue" width="10%">开始年月</td>
									<td width="20%">
										<input type="text" name="beginQueryDate" id="beginQueryDate" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;&nbsp;
									</td>
									<td class="blue" width="10%">结束年月</td>
									<td>
										<input type="text" name="endQueryDate" id="endQueryDate" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;&nbsp;
										<input type="button" onclick="doSubmitQuery()" value="查询" class="b_text">&nbsp;
										<input type="button" onclick="doShowAllQuery()" value="显示全部内容" class="b_text">
									</td>
								</tr>
							</table> 	
						</div>            
					</DIV>
		  </td>
          <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
        </tr>
        <tr>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
          <td valign="bottom"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
            <tr>
              <td height="1"></td>
            </tr>
          </table></td>
          <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
        </tr>
  </table>
</DIV>

			</FORM>
		</body>
</html>
