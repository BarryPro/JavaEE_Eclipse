<%
  /*
   * 功能: 多人质检结果明细
　 * 版本: 1.0
　 * 日期: 2008/10/20
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* "%>

<%
    String opCode="k212";
    String opName="质检查询-多人质检结果详细信息";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 

    String contact_id   = request.getParameter("contact_id");
    String[][] detailRecList = new String[][]{};
    String[][] detailItemList = new String[][]{};
    String isPwdVer = "N";
    String sqlStr="";
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
		
    if (contact_id!=null) {
    sqlStr = "select "                                             
            +"t1.recordernum,   " //被检流水号
            +"t1.staffno,       " //被检工号
            +"t3.object_name,   " //被检对象
            +"t4.name,          " //考评内容
            +"t1.score,         " //总得分
            +"t1.contentlevelid," //等级
            +"t1.evterno,       " //质检工号
            +"t1.kind,          " //考评方式
            +"t1.checktype,     " //考评类别
            +"t1.starttime,     " //质检开始时间
            +"t1.endtime,       " //质检结束时间
            +"t1.dealduration,  " //处理时长
            +"t1.lisduration,   " //放音监听时长
            +"t1.arrduration,   " //整理时长
            +"t1.evtduration,   " //质检总时长
            +"t1.flag,          " //质检结果
            +"t1.contentinsum,  " //内容概要
            +"t1.handleinfo,    " //处理情况
            +"t1.improveadvice, " //改进建议
            +"t1.trainadvice    " //培训建议
            +"from dqcmulinfo t1,dqcobject t3,dqccheckcontect t4 where t1.serialnum= '"+contact_id+"'";  
		String strJoinSql=" and t1.objectid=t3.object_id(+) "                                                    
                     +" and t1.contentid=t4.contect_id(+) ";
    sqlStr +=strJoinSql;    
    System.out.println("==========sqlStr=========="+sqlStr);
%>	         
					<wtc:service name="s151Select" outnum="20">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
    		detailRecList = queryList;
    	System.out.println("==========detailRecList.length========"+detailRecList.length);
    	sqlStr = "select "
        +"t2.item_name"//考评项目
        +"t2.formula"  //公式
        +"t1.weight"   //权重
        +"t1.score"    //得分
        +"t1.orgvalue" //原始值
        +"from dqcmulinfodetail t1,dqccheckitem t2 where t1.serialnum="+contact_id;
        
      strJoinSql=" and t1.itemid=t2.item_id ";
      sqlStr += strJoinSql;

%>	         
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
				detailItemList = queryList;
    	System.out.println("detailItemList============length=="+detailItemList.length);
    	System.out.println("sqlStr=====2=======value=="+sqlStr);
}             
%>	         


<html>
<head>
<title>质检结果详细信息</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInput(url){
   if( document.sitechform.contact_id.value == ""){
    	  showTip(document.sitechform.contact_id,"流水号不能为空！请重新选择后输入");
        sitechform.contact_id.focus();
    }   
    else {
    	
    hiddenTip(document.sitechform.contact_id);
    doSubmit(url);
    }
}
function doSubmit(url){
    window.sitechform.action=url;
    window.sitechform.method='post';
    window.sitechform.submit();
}

//关闭窗口
function closeWin(){
  window.close();	
}


</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
		<div class="title" id="footer">	 
 		流水号&nbsp;<input name="contact_id" type="text"  id="contact_id" value="<%=contact_id%>" >
   <input name="tableName" type="hidden" value="<%=tableName%>">
</div>

<br>
	<div id="Operation_Table">
		<div class="title">基本信息</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <td > 被检流水号 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][0].length()!=0)? detailRecList[0][0]:"&nbsp;"%></td>
	     <td > 被检工号 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][1].length()!=0)? detailRecList[0][1]:"&nbsp; "%></td>
	     <td > 被检对象 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][2].length()!=0)? detailRecList[0][2]:" &nbsp;"%></td>
	     <td > 考评内容 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][3].length()!=0)? detailRecList[0][3]:" &nbsp;"%></td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > 得分 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][4].length()!=0)? detailRecList[0][4]:" &nbsp;"%></td>
	     <td > 等级 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][5].length()!=0)? detailRecList[0][5]:" &nbsp;"%></td>
	     <td > 质检工号 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][6].length()!=0)? detailRecList[0][6]:" &nbsp;"%></td>
	     <td > 考评方式 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][7].length()!=0)? detailRecList[0][7]:" &nbsp;"%></td>   
	    </tr>
	    
	  <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > 考评类别 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][8].length()!=0)? detailRecList[0][8]:" &nbsp;"%></td>
	     <td > 质检开始时间 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][9].length()!=0)? detailRecList[0][9]:" &nbsp;"%></td> 
	     <td>质检结束时间 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][10].length()!=0)? detailRecList[0][10]:" &nbsp;"%></td>
	     <td > 质检时长 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][11].length()!=0)? detailRecList[0][11]:" &nbsp;"%></td>   
	    </tr>
	    
	   <!-- THE FOURTH LINE OF THE CONTENT -->
	   <tr >
	     <td > 放音监听时长 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][12].length()!=0)? detailRecList[0][12]:" &nbsp;"%></td>
	     <td > 整理时长 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][13].length()!=0)? detailRecList[0][13]:" &nbsp;"%>
	     </td> 
	     <td >总质检时长 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][14].length()!=0)? detailRecList[0][14]:" &nbsp;"%>
	     </td>
	     <td > 质检结果 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][15].length()!=0)? detailRecList[0][15]:" &nbsp;"%>
	     </td>   
	    </tr>
		</table> 

</div>
		<div id="Operation_Table">
		<div class="title">内容概要</div>	   
		<table cellspacing="0">
			 <tr >
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][16].length()!=0)? detailRecList[0][16]:" &nbsp;"%></td>
	    </tr>
	  </table>
	</div>
	
	<div id="Operation_Table">
  	<div class="title">处理情况</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][17].length()!=0)? detailRecList[0][17]:" &nbsp;"%></td>
    </tr>
  </table>
 </div>
	
  <div id="Operation_Table">
  	<div class="title">改进建议</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][18].length()!=0)? detailRecList[0][18]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">培训建议</div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][19].length()!=0)? detailRecList[0][19]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">项目考评信息</div>	  
      <table  cellSpacing="0" >
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
          <tr >
            <th align="center" class="blue" width="25%" > 考评项目 </th>
            <th align="center" class="blue" width="30%" > 公式 </th>
            <th align="center" class="blue" width="15%" > 权重 </th>
            <th align="center" class="blue" width="15%" > 得分 </th>
            <th align="center" class="blue" width="15%" > 原始值 </th>
          </tr>

          <% for ( int i = 0; i < detailRecList.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][0].length()!=0)?detailItemList[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][1].length()!=0)?detailItemList[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][2].length()!=0)?detailItemList[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][3].length()!=0)?detailItemList[i][3]:"&nbsp;"%></td>
    </tr>
      <% } %>
  </table>
</div>

<div id="Operation_Table">
  	<div class="title">密码验证信息</div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				<%=isPwdVer.equals("Y")? "验证" : "无需验证"%>
			</td>
    </tr>
  </table>
</div>
<br>
<div id="Operation_Table" >
   <input name="search" type="button"  id="search" value="返回" onClick="javascript:window.close()"> &nbsp;&nbsp;
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

