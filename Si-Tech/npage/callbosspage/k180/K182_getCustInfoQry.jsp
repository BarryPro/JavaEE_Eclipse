<%
  /*
   * 功能: 通过客户姓名模糊查找用户信息
　 * 版本: 1.0
　 * 日期: 2008/12/24
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode="";
    String opName="用户信息";
	  String loginNo = (String)session.getAttribute("workNo");  
    String orgCode = (String)session.getAttribute("orgCode");
    if(orgCode==null){
      orgCode="0101";
    }
    String regionCode=orgCode.substring(0,2);
    String cust_name   = request.getParameter("cust_name");         //开始时间
    
    String[][] dataRows = new String[][]{};
    String action = request.getParameter("myaction");
    
    if("doLoad".equals(action)){

%>	
					<wtc:service name="sPubSelect" outnum="7">
						<wtc:param value="<%=cust_name%>"/>
					  <wtc:param value="<%=regionCode%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
 <%}%>
<html>
<head>
<title>受理业务</title>
<script language=javascript>

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(){
	if( document.sitechform.cust_name.value == ""){
    	  showTip(document.sitechform.cust_name,"客户姓名不能为空！");
        sitechform.cust_name.focus();
  }else {
     hiddenTip(document.sitechform.cust_name);
     doSubmit();
	}
}

//提交
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="K182_getCustInfoQry.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">查询条件</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
       <td align="center"> 客户姓名  </td>
	     <td width="90%">
			  <input name="cust_name" type="text" value="<%=(cust_name==null)?"":cust_name%>" onkeyup="hiddenTip(this);">    
        <font color="orange">*</font>
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()"> &nbsp;&nbsp;
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">

      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
          <tr >
            <th align="center" class="blue" width="15%" > 服务号码</th>
            <th align="center" class="blue" width="20%" > 用户姓名</th>
            <th align="center" class="blue" width="15%" > 用户地址</th>
            <th align="center" class="blue" width="12%" > 身份证号</th>
            <th align="center" class="blue" width="20%" > 邮编    </th>
            <th align="center" class="blue" width="18%" > 用户状态</th>
          <th align="center" class="blue" width="18%"   >入网时间 </th>
          </tr> 
         <% for ( int i = 0; i < dataRows.length; i++ ) {             
           String tdClass="";
           if((i+1)%2==1){
             tdClass="grey";
            } 
           %>
       <tr>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      </tr>
      <% } %>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

