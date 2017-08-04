<%
  /*
   * 功能: 修改质检结果明细
　 * 版本: 1.0
　 * 日期: 2008/10/20
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* ,java.util.*,"%>

<%
    String opCode="k211";
    String opName="质检查询-修改质检结果详细信息";
    String tName="修改质检结果详细信息";
    
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		String regionCode = orgCode.substring(0,2);
		String myParams="";
    String contact_id   = request.getParameter("contact_id");
    String[][] detailRecList = new String[][]{};
    String[][] detailItemList = new String[][]{};
    String[][] detailItemSubListTemp = new String[][]{};
    ArrayList detailItemSubList = new ArrayList();
    String isPwdVer = "N";
    String sqlStr="";
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
		String modserialnum="";
    if (contact_id!=null) {
    /*zhengjiang 20091004 修改条件serialnum为modserialnum去掉and modflag='1'"*/
    String sqlGetModserialnum = "select to_char(max(modserialnum)) from dqcmodinfo where modserialnum=:contact_id ";
    myParams = "contact_id="+contact_id;
%>	         
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
							<wtc:param value="<%=sqlGetModserialnum%>"/>
							<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="modserialnumList" scope="end"/>	
<%  
if(modserialnumList.length>0){
  modserialnum=modserialnumList[0][0];
}
    sqlStr = "select "                                             
            +"t1.recordernum,   " //被检流水号
            +"t1.staffno,       " //被检工号
            +"t3.object_name,   " //被检对象
            +"t4.name,          " //考评内容
            +"decode(substr(to_char(trim(t1.score)),0,1),'.','0'||trim(t1.score),t1.score)," //总得分
            +"t1.contentlevelid," //等级
            +"t1.evterno,       " //质检工号
            +"decode(t1.kind,'0','自动分派','1','人工指定'),          " //考评方式
            +"decode(t1.checktype,'0','实时质检','1','事后质检'),     " //考评类别
            +"to_char(t1.starttime,'yyyyMMdd hh24:mi:ss'),     " //质检开始时间
            +"to_char(t1.endtime,'yyyyMMdd hh24:mi:ss'),       " //质检结束时间
            +"to_char(t1.dealduration),  " //处理时长
            +"to_char(t1.lisduration),   " //放音监听时长
            +"to_char(t1.arrduration),   " //整理时长
            +"to_char(t1.evtduration),   " //质检总时长
            +"decode(t1.flag,'0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃'),          " //质检结果
            +"t1.signataryid,   " //确认人
            +"to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //确认日期
            +"t1.contentinsum,  " //内容概要
            +"t1.handleinfo,    " //处理情况
            +"t1.improveadvice, " //改进建议
            +"t1.moddes,   " //修改说明
            +"t1.trainadvice,    " //培训建议
            +"t1.objectid,   " //被检对象id
            +"t1.contentid,    " //被检内容id   
            +"t1.modserialnum,    " //修改结果流水 
            +"t1.commentinfo   " //总体评价      
            +"from dqcmodinfo t1,dqcobject t3,dqccheckcontect t4 where t1.modserialnum=:contact_id ";//zhengjiang 20091004 把modserialnum改为contact_id去掉and t1.modflag='1' ";  
		String strJoinSql=" and t1.objectid=t3.object_id(+) "                                                    
                     +" and t1.contentid=t4.contect_id(+) ";
    sqlStr +=strJoinSql;
    myParams = "contact_id="+contact_id;
%>	         
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="27">
							<wtc:param value="<%=sqlStr%>"/>
							<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<%           
    		detailRecList = queryList;
    	if(detailRecList.length>0){
    	//zengzq modify 20091022  增加查询返回结果是否评分的考评项is_scored  'U'为是  'N'为否
         sqlStr="select t.item_name, t.formula, to_char(t.weight), t.item_id,t.is_scored  " +
               "from dqccheckitem t "+
               "where t.object_id = :object_id and t.contect_id = :contect_id and t.bak1='Y' ";
         myParams = "object_id="+detailRecList[0][23]+",contect_id="+detailRecList[0][24];
         String strParentSql=" and t.parent_item_id='0'  order by t.item_id"; 
         sqlStr += strParentSql;
%>	            
			   		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
			   				<wtc:param value="<%=sqlStr%>"/>
			   				<wtc:param value="<%=myParams%>"/>
			   		</wtc:service>
			   		<wtc:array id="resultList" scope="end"/>	
<%              
			   	detailItemList = resultList;
    	   sqlStr = "select "
           +"t1.item_name,"//考评项目
           +"t1.formula,"  //公式
           +"to_char(t1.weight),"   //权重
           +"decode(substr(to_char(trim(t2.score)),0,1),'.','0'||to_char(trim(t2.score)),to_char(t2.score)),"    //得分
           +"t2.orgvalue, " //原始值
           +"t1.item_id "   //考评项目id
           +"from dqccheckitem t1, dqcmodinfodetail t2 where t1.object_id='"+detailRecList[0][23]+"' and t1.contect_id='"+detailRecList[0][24]+"' and t1.bak1='Y' and t2.modserialnum= :contact_id";//zhengjiang modserialnum20091005去掉and t2.modflag='1'
          myParams = "object_id="+detailRecList[0][23]+",contect_id="+detailRecList[0][24]+",contact_id="+contact_id;
         strJoinSql=" and t1.object_id(+)=t2.objectid and t1.contect_id(+)=t2.contentid and t1.item_id=t2.itemid ";
         sqlStr+=strJoinSql;
    	   for(int i=0;i<detailItemList.length;i++){
    	     	if("N".equals(detailItemList[i][4])){
    	   			strParentSql=" and t1.parent_item_id=:parent_item_id  order by t1.item_id";
    	   			myParams = "object_id="+detailRecList[0][23]+",contect_id="+detailRecList[0][24]+",contact_id="+contact_id + ",parent_item_id="+detailItemList[i][3];
	    	   	}else{
	    	   			strParentSql=" and t1.item_id=:item_id order by t1.item_id";
	    	   			myParams = "object_id="+detailRecList[0][23]+",contect_id="+detailRecList[0][24]+",contact_id="+contact_id + ",item_id="+detailItemList[i][3];
	    	   	}
    	     %>	            
			   		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
			   				<wtc:param value="<%=sqlStr+strParentSql%>"/>
			   				<wtc:param value="<%=myParams%>"/>
			   		</wtc:service>
			   		<wtc:array id="detailItemListTemp" scope="end"/>	
          <% 
          detailItemSubListTemp=detailItemListTemp;
          detailItemSubList.add(detailItemSubListTemp);
    	   }
     } 
}            
%>	         


<html>
<head>
<title>修改质检结果详细信息</title>
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
<div class="Main">
<form id=sitechform name=sitechform>
<!--%@ include file="/npage/include/header.jsp"%-->
<%@ include file="/npage/callbosspage/checkWork/K203/check_header.jsp"%>

<div class="title" id="footer">	 
 		<div id="title_zi">流水号&nbsp;</div><input name="contact_id" type="text"  id="contact_id" value="<%=contact_id%>" readonly />
   <input name="tableName" type="hidden" value="<%=tableName%>"/>
</div>

<br>
	<div id="Operation_Table" style="width:100%;">
		<div class="title"><div id="title_zi">基本信息</div></div>
		<table cellspacing="0">
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
	    
	    <!-- THE FIFTH LINE OF THE CONTENT -->
	   <tr >
	     <td > 确认人 </td>
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][16].length()!=0)?detailRecList[0][16]:" &nbsp;"%></td>
	     <td > 确认日期 </td>
   		 <td ><%=(detailRecList.length!=0 && detailRecList[0][17].length()!=0)? detailRecList[0][17]:" &nbsp;"%></td>
	     <td colspan="4">&nbsp; </td>
	    </tr>
		</table> 
</div>
	
<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">综合评价</div></div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][26].length()!=0)? detailRecList[0][26]:" &nbsp;"%></td>
    </tr>
  </table>
</div>
	
	<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">处理情况</div></div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][19].length()!=0)? detailRecList[0][19]:" &nbsp;"%></td>
    </tr>
  </table>
 </div>
	
  <div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">改进建议</div></div>	  
	<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][20].length()!=0)? detailRecList[0][20]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

		<div id="Operation_Table" style="width:100%;">
		<div class="title"><div id="title_zi">内容概要</div></div>	   
		<table cellspacing="0">
			 <tr >
	     <td ><%=(detailRecList.length!=0 && detailRecList[0][18].length()!=0)? detailRecList[0][18]:" &nbsp;"%></td>
	    </tr>
	  </table>
	</div>

<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">修改说明</div></div>	  
		<table  cellspacing="0">
    <tr >
			<td ><%=(detailRecList.length!=0 && detailRecList[0][21].length()!=0)? detailRecList[0][21]:" &nbsp;"%></td>
    </tr>
  </table>
</div>

</div>

<div id="Operation_Table" style="width:100%;">
  	<div class="title"><div id="title_zi">项目考评信息</div></div>	  
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

          <% for ( int i = 0; i < detailItemList.length; i++ ) {             
           String[][] tempList = (String[][])detailItemSubList.get(i);  
           String tmpIsScore = (detailItemList[i][4].length()!=0)?detailItemList[i][4]:"N";
           String tmpItemScore = "0";
           if("Y".equals(tmpIsScore)){
         				if(tempList!=null && tempList.length>0){
         						tmpItemScore = (tempList[0][3].length()!=0)?tempList[0][3]:"0";
         				}
           }
                String tdClass="";
           %>
<%
          if((i+1)%2==1){
          tdClass="grey";
%>
          <tr  >
<%
					}else{
%>
	   <tr  >
<%
					}
%>
      <td align="left" class="<%=tdClass%>"  ><%=(detailItemList[i][0].length()!=0)?detailItemList[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][1].length()!=0)?detailItemList[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][2].length()!=0)?detailItemList[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=tmpItemScore%></td>
      <td align="center" class="<%=tdClass%>"  >0</td>
    </tr>
    <%
    if("N".equals(tmpIsScore)){
      for(int j=0;j<tempList.length;j++){
       %>
       <tr>
        <td align="left" class="<%=tdClass%>"  >&nbsp;&nbsp;<%=(tempList[j][0].length()!=0)?tempList[j][0]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][1].length()!=0)?tempList[j][1]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][2].length()!=0)?tempList[j][2]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][3].length()!=0)?tempList[j][3]:"&nbsp;"%></td>
        <td align="center" class="<%=tdClass%>"  ><%=(tempList[j][4].length()!=0)?tempList[j][4]:"&nbsp;"%></td>
       </tr>
       <%
      }
    }
%>
      <% } %>
  </table>
</div>
<br>
<div id="Operation_Table" style="width:100%;">
   <input name="search" type="button"  id="search" value="返回" onClick="javascript:window.close()"> &nbsp;&nbsp;
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</div>
</body>
</html>