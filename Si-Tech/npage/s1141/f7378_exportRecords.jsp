<%
  /*
   * 关于对BOSS系统增加短信白名单用户管理权限的申请
   * 日期: 2014-02-19
   * 作者: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
  <meta http-equiv="Cache-Control" content="no-store"/>
  <meta http-equiv="Pragma" content="no-cache"/>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = "7378";
  String opName = "自有业务宣传名单管理";
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
  String currentPage = WtcUtil.repNull(request.getParameter("currentPage"));
  currentPage = currentPage.equals("") ? "1": currentPage;
  String listtype   = WtcUtil.repNull(request.getParameter("listtype"));
  String switchFlag = WtcUtil.repNull(request.getParameter("switchFlag"));
  String op_type    = WtcUtil.repNull(request.getParameter("op_type"));
  String category   = WtcUtil.repNull(request.getParameter("category"));
  String beginTime  = WtcUtil.repNull(request.getParameter("beginTime"));
  String endTime    = WtcUtil.repNull(request.getParameter("endTime"));

%>            

  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<%
  String []inParas = new String[23];
  inParas[0] = accept;
  inParas[1] = "01";
  inParas[2] = opCode;
  inParas[3] = workNo;
  inParas[4] = password;
  inParas[5] = "";
  inParas[6] = "";
  inParas[7]  = listtype;
  inParas[8]  = switchFlag;
  inParas[9]  = op_type;
  inParas[10] = category;
  inParas[11] = beginTime;
  inParas[12] = endTime;
  inParas[13] = currentPage;
%>
	
  <wtc:service name="s7378QryBat" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
		<wtc:param value="<%=inParas[10]%>"/>
		<wtc:param value="<%=inParas[11]%>"/>
		<wtc:param value="<%=inParas[12]%>"/>
		<wtc:param value="<%=inParas[13]%>"/>
	</wtc:service>
	<wtc:array id="totalResultNumber" start="0" length="1" scope="end"/>
	<wtc:array id="result" start="1" length="3" scope="end"/>
	
<title><%=opName%></title>
<script language="javascript" type="text/javascript" 
  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language="javascript">
  var oXL = null;
  //创建AX对象excel
  var oWB = null;
  //获取workbook对象
  var oSheet = null;
  var rowIndex = 0;
  
  /** zhouby jquery for export
  */
  function ExportToExcel(targetTable, flag) { 
      //取得表格行数
      $('#'+targetTable+' tr').each(function(i, e){
          var cols = $('td, th', this);
          cols.each(function(j, e){
              var value = $.trim($(this).text().replace(/\n/g, ''));
              if (value == ""){
                  value = $(this).find('input').val();
              }
              
              if (flag && (j + 1) == cols.length){
                  return true;
              }
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  
  function exportTables(tableIds, flag){
    try{   
        rowIndex = 0;
        oXL = new ActiveXObject("Excel.Application");
        oWB = oXL.Workbooks.Add();
        oSheet = oWB.ActiveSheet;
        
        if (tableIds.length <= 0){
            return;
        }
        
        for (var i = 0; i < tableIds.length; i++){
            ExportToExcel(tableIds[i], flag);
        }
        //设置excel可见属性
        oXL.Visible = true;
    }catch(e){
          if((!+'\v1')){ //ie浏览器  
             alert("无法启动Excel，请确保电脑中已经安装了Excel!\n\n如果已经安装了Excel，" + 
                 "请调整IE的安全级别。\n\n具体操作：\n\n"+"工具 → Internet选项 → 安全 → 自定义级别 → ActiveX 控件和插件 → 对未标记为可安全执行脚本的ActiveX 控件初始化并执行脚本 → 启用 → 确定"); 
          }else{ 
              alert("请使用IE浏览器进行“导入到EXCEL”操作！");  //方便设置安全等级，限制为ie浏览器  
          } 
      }
  }
  
<%
  if ("000000".equals(retCode)){
%>
      var totalResultNumber = "<%=totalResultNumber[0][0]%>";
<%
  }
%>
  
  var currentPageNumber = "<%=currentPage%>", pageSize = 1000;
  
  function hasNextPage(){
      return (totalResultNumber - currentPageNumber * pageSize) > 0;
  }
  
  function hasPreviousPage(){
      return currentPageNumber > 1;
  }

  function getPagingToolBar(){
      var data = {listtype : "<%=listtype%>",
                  switchFlag : "<%=switchFlag%>",
                  op_type : "<%=op_type%>",
                  category : "<%=category%>",
                  beginTime : "<%=beginTime%>",
                  endTime : "<%=endTime%>"};
    
      var actionName = 'f7378_exportRecords.jsp?' + $.param(data);
    
      var totalPages = Math.ceil(totalResultNumber / pageSize);
      var temp="";
      if(actionName.indexOf("?")==-1){
          temp="?";
      }
      else {
          temp="&";
      }
      var str = "<tr><td colspan='3'>";
      str += "<p align='center'>";
      if(!hasPreviousPage())
          str+="<span id='firstPage'>首页</span> <span id='prevPage'>上一页</span>&nbsp;";
      else
      {
          str+="<a id='first' href='"+actionName+temp+"currentPage=1'>首页</a>&nbsp;";
          str+="<a id='prev' href='"+actionName+temp+"currentPage="+(currentPageNumber-1)+"'>上一页</a>&nbsp;";
      }
      if(!hasNextPage())
          str+="下一页 尾页&nbsp;";
      else
      {
          str+="<a id='next' href='"+actionName+temp+"currentPage="+(currentPageNumber+1)+"'>下一页</a>&nbsp;";
          str+="<a id='last' href='"+actionName+temp+"currentPage="+totalPages+"'>尾页</a>&nbsp;";
      }
      str+="&nbsp;共<b>"+totalResultNumber+"</b>条记录&nbsp;";
      str+="</p>";
      str+="</td></tr>";
      
      $('#target').append(str);
  }
  
  $(function(){
      getPagingToolBar();
      
      $('#submitBtn').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          exportTables(['targetTable']);
      });
  });
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">		
<div id="Main">
 <DIV id="Operation_Table"> 
  
  <div class="title">
		<div id="title_zi">查询结果</div>
	</div>
  
  <table id="targetTable" cellspacing="0" >          
 		<tr> 
      <th>序号</th>
      <th>手机号码</th>
      <th>归属区县名称</th>
    </tr>
    
    <tbody id="target">
<%
    if ("000000".equals(retCode)){
      int length = result.length;
      if (length > 0){
          for (int i = 0; i < length; i++){
          
%>
              <tr>
                <td><%=result[i][0]%></td>  
                <td><%=result[i][1]%></td>  
                <td><%=result[i][2]%></td>  
              </tr>
<%
          }
      }
    }else {
%>
      <script language="javascript">
        rdShowMessageDialog("调用服务失败！" + retCode + retMsg");
      </script>
<%
    }
%>
    </tbody>
	</table>
	
  <table cellspacing="0" >
   	<tr>
      <td id="footer">              
    	  <input type=button name="submitBtn" id="submitBtn" class="b_foot" value="导出">
      </td>
  	</tr>
  </table>
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>