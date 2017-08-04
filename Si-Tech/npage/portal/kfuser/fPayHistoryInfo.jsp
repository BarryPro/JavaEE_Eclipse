<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
　 * 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
   * 修改日期 2009-05-21     修改人  libina     修改目的  修改缴费信息查询结果的接收方式
   * 修改日期 2009-05-23     修改人  libina     修改目的  修复条件查询功能
   * 修改日期 2009-06-14     修改人  libina     修改目的  增加日期选择按钮
 　*/
%>
<%
  String phoneNo  = (String)session.getAttribute("activePhone");
  
  String begindate = request.getParameter("beginQueryDate");
  String enddate   = request.getParameter("endQueryDate");
  
  if(begindate==null || enddate==null){
  //按用户要求从当前日期向前查询一个月内缴费记录
    Calendar cr = Calendar.getInstance();
    int yy = Integer.parseInt("" + cr.get(cr.YEAR));
    String s_year = cr.get(cr.MONTH) == 0 ? "" + (yy - 1) : "" + yy;
    String e_year = "" + cr.get(cr.YEAR);
    String e_month = cr.get(cr.MONTH) < 9 ? "0" + (cr.get(cr.MONTH)+1) : "" + (cr.get(cr.MONTH)+1);
    String s_month = "";
    if(cr.get(cr.MONTH) == 0){
      s_month = "12";
    }else if(cr.get(cr.MONTH) < 10){
      s_month = "0" + (cr.get(cr.MONTH));
    }else{
      s_month = "" + (cr.get(cr.MONTH));
    }
    String e_day = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
    String s_day = "";
    if(cr.get(cr.DATE) == 31 || cr.get(cr.DATE) == 30 || cr.get(cr.DATE) == 29 ){
      if(cr.get(cr.MONTH) == 2){
        s_day = "28"; 
      }else if(cr.get(cr.DATE) != 29){
        s_day = "30";
      }
    }else{
      s_day = e_day;
    }
    begindate = s_year + s_month + s_day;
    enddate   = e_year + e_month + e_day;
  } 
  System.out.println(begindate);
  System.out.println(enddate);
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*报表数据@年月表@libina@20090519*/
  String login_no = (String)session.getAttribute("workNo");
%>
<wtc:service name="sHW_HandFee"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="6">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=begindate%>"/>
	<wtc:param value="<%=enddate%>"/>
</wtc:service>
  <wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
	<wtc:array id="result5" start="5" length="1" scope="end"/>

<HTML>
<HEAD>
<title>缴费信息查询</title>
<!------------------------------------
   -对页面表格进行排序需要使用的js脚本	
-------------------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery.tablesorter.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<script language="javascript">
    /***********************************
	 *add by zhanghonga@20090315
	 *解决用户要求:点击“时间”可进行排序.按照变更时间进行倒排序.
	 *(以下代码删除之后,对原页面无任何影响)
	 ***********************************/
	$(document).ready(function() 
    	{ 
    		/***********************************
    		  *tablesorter()的参数可以为空,如果为空,页面初始化的时候显示默认的排序效果;
    		  *sortList:[[0,1]]表示从表格按照第一列降序排列.其中第一个参数"0"表示下标从0开始的第一列,第二个参数:0升序,1降序
    		  *如果需要页面初始化的时候同时按照几列排列,使用sortList:[[0,0],[1,0]]这样的形式
    		************************************/
        	$("#myTable").tablesorter({
        		sortList:[[0,1]]	
        	});
        	
        	/***********************************
        	 *在所有的th上附加样式,使得鼠标移上去后,变成别的形状,例如"手"形的形状
        	 ***********************************/
        	$("th").css({cursor:"hand"}); 
    	} 
	); 

	function doSubmitQuery(){
		if( document.sitechform.beginQueryDate.value == ""){
    	   showTip(document.sitechform.beginQueryDate,"开始时间不能为空");
    	   sitechform.beginQueryDate.focus();
    }else if(document.sitechform.endQueryDate.value == ""){
		     showTip(document.sitechform.endQueryDate,"结束时间不能为空");
    	   sitechform.endQueryDate.focus();
    }else if(document.sitechform.endQueryDate.value<=document.sitechform.beginQueryDate.value){
		     showTip(document.sitechform.endQueryDate,"结束时间必须大于开始时间");
    	   sitechform.endQueryDate.focus();
    }else
    {
         document.sitechform.action="fPayHistoryInfo.jsp";
	       document.sitechform.submit();
    }
	}
	 
</script>
</head>
<body>
<form action="#" method="post" name="sitechform" >
	<div id="Main">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
				<div id="Operation_Title"><B>缴费信息查询</B></div>
				<DIV id="Operation_Table">
			        <div class="title">缴费查询</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="myTable">
							<thead>
						      <tr align="center"> 
						    	 <th>缴费时间</th>
						         <th>缴费地点</th>
						         <th>缴费方式</th>
						         <th>缴费金额</th>
						         <th>操作工号</th>
						      </tr>
						    </thead>
<%
        System.out.println(phoneNo+"缴费信息查询结果："+retCode);
        System.out.println(phoneNo+"缴费信息查询结果个数："+result0[0][0]);
        if(Integer.parseInt(result0[0][0]) == 0){
        %>
        <tr>
        <td colspan="5" align="center" >
            没有符合条件的记录！
        </td>
        </tr>
        <%}
		  	for (int i=0;i<Integer.parseInt(result0[0][0]);i++){
			 %>
			 <tr align="center"> 
			 <% 
			    if(i%2==0){
			%>
						<td class="Grey"><%=result1[i][0]%></td>
						<td class="Grey"><%=result2[i][0]%></td>            
            <td class="Grey"><%=result3[i][0]%></td>
            <td class="Grey"><%=result4[i][0]%></td>
            <td class="Grey"><%=result5[i][0]%></td>        			    
			<%    
			  }else{
			%>
						<td><%=result1[i][0]%></td>
						<td><%=result2[i][0]%></td>             
            <td><%=result3[i][0]%></td>
            <td><%=result4[i][0]%></td>
            <td><%=result5[i][0]%></td>		
			<%  	
			  	}	  
		  %>
      </tr>
<%}
	  System.out.println("报表记录开始！");
	  System.out.println("服务调用结果："+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("000000".equals(retCode)){
	     successFlag = 0;
	  }
%>
	
	<wtc:pubselect name="sPubSelect" outnum="1">
  	<wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phoneNo+"','"+login_no+"','01004',"+successFlag+",'01004','0','缴费信息查询')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("报表记录结束!");
%> 
						</table>
   						
					</div>
					<div id="Operation_Table"> 
						<div class="title">请输入查询时间</div>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">	
						  <tr>					
							  <td align="right" width="15%"> 开始时间 </td>
                <td align="left" width="30%">
			            <input id="beginQueryDate" name ="beginQueryDate" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginQueryDate);return false;">
		              <img onclick="WdatePicker({el:$dp.$('beginQueryDate'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		              <font color="orange">*</font>
		            </td>
							  <td align="right" width="15%"> 结束时间 </td>
                <td align="left" width="30%">
			            <input id="endQueryDate" name ="endQueryDate" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endQueryDate);">
		              <img onclick="WdatePicker({el:$dp.$('endQueryDate'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		              <font color="orange">*</font>
		            </td> 	
		            <td align="center" width="10%"><input type="button" onclick="doSubmitQuery()" value="查询" class="b_text"></td>            
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
