<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 工号关系绑定配置-查询界面
　 * 版本: 1.0
　 * 日期: 2009/06/06
　 * 作者: donglei 
　 * 版权: sitech
   * update yinzx 090715  客服调试 1.sPubSelect 服务崭时替换为s151Select 正式后替换回来
   *                               2.修改原逻辑错误 start=1；改为start=0            
   *  														 3.增加'k%' 判断
   * update yinzx 090825 表dloginmsgrelation 放到boss库中
 　*/
 %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>

<%

    String opCode="K096";
    String opName="工号关系绑定配置";
	  String loginNo = (String)session.getAttribute("workNo");
	      /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	     
  	String sqlStr = "SELECT T.LOGIN_NO,T1.KF_LOGIN_NO,T.LOGIN_NAME,T1.CREATE_LOGIN_NO,to_char(T1.CREATE_DATE,'yyyy-Mm-dd hh24:mi:ss'),T1.UPDATE_LOGIN_NO,to_char(T1.UPDATE_DATE,'yyyy-Mm-dd hh24:mi:ss'),decode(T1.VALID_FLAG,'Y','正常','N','失效',NULL,'未绑定'),T1.VALID_FLAG ";
  	       sqlStr+= "FROM DLOGINMSG T,DLOGINMSGRELATION T1 ";
  	       sqlStr+= "WHERE T.LOGIN_NO=T1.BOSS_LOGIN_NO(+) and substr(t.login_no,1,1)='8'";
		String strCountSql="select to_char(count(*)) FROM DLOGINMSG T,DLOGINMSGRELATION T1 WHERE T.LOGIN_NO=T1.BOSS_LOGIN_NO(+)  and substr(t.login_no,1,1)='8'";
    String strOrderSql=" order by t1.CREATE_DATE desc ";

    String boss_login_no =  request.getParameter("boss_login_no");       //开始时间
    String kf_login_no   =  request.getParameter("kf_login_no");         //结束时间
    String login_name  =  request.getParameter("login_name");    //ip地址
    String login_status   =  request.getParameter("login_status");     //工号
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // Transfered pages
    String sqlTemp="";
    String action = request.getParameter("myaction");
		String sqlFilter = request.getParameter("sqlFilter");
	  //查询条件
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	  	if(boss_login_no!=null&&!("").equals(boss_login_no)){
      	sqlFilter+="and T.login_no like '%'||:boss_login_no||'%' ";
      	myParams+="boss_login_no="+boss_login_no.trim();
    	}
    	if(kf_login_no!=null&&!("").equals(kf_login_no)){
      	sqlFilter+="and T1.kf_login_no like '%'||:kf_login_no||'%'";
      	myParams+=",kf_login_no="+kf_login_no.trim();
    	}
    	if(login_name!=null&&!("").equals(login_name)){
      	sqlFilter+="and T.login_name like '%'||:vlogin_name||'%'";
      	myParams+=",vlogin_name="+login_name.trim();
    	}
    	//状态判断
    	if(login_status!=null&&!("").equals(login_status)){
      	if("Y".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG ='Y'"; 
      	}
      	if("N".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG ='N'"; 
      	}
      	if("S".equals(login_status)){
      	sqlFilter+=" and T1.VALID_FLAG is null"; 
      	}
    	}
    }
%>	
			
<%	if ("doLoad".equals(action)) {
				sqlStr+=sqlFilter+strOrderSql;
        sqlTemp = strCountSql+sqlFilter;
        
        System.out.println("---------sqlTemp------------"+sqlTemp);
    	  %>	             
					<wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service> 
					<wtc:array id="rowsC4"  scope="end"/>	
					<%             
	      if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1; 
        }                
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }                
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        
        System.out.println("-----------curPage---------------|"+curPage);
        System.out.println("-----------pageSize--------------|"+pageSize);
        System.out.println("-----------rowCount--------------|"+rowCount);
        
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        System.out.println("-------querySql----------"+querySql);
        System.out.println("-------myParams----------"+myParams);
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="0" length="9"   scope="end"/>
				<%
				dataRows = queryList;
				
				
    }
    
%>

<html>
<head>
<title>工号关系绑定配置</title>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
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
function submitInputCheck(){
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    submitMe();
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="loginNoRelationCfg.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

//跳转到指定页面
function jumpToPage(operateCode){
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage1").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
}
//=========================================================================
// LOAD PAGES.
//=========================================================================
function doLoad(operateCode){
	 
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
    keepValue();
    submitMe(); 
    }
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
	  	e[i].value="";
  }
 }
      window.location="loginNoRelationCfg.jsp";
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.boss_login_no.value="<%=boss_login_no%>";
	window.sitechform.kf_login_no.value="<%=kf_login_no%>";
	window.sitechform.login_name.value="<%=login_name%>";
	window.sitechform.login_status.value="<%=login_status%>";
	window.sitechform.oper.value="<%=request.getParameter("oper")%>";
}

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

		 
//去左空格;
function ltrim(s){
  return s.replace( /^\s*/, "");
}
//去右空格;
function rtrim(s){
return s.replace( /\s*$/, "");
}
//去左右空格;
function trim(s){
return rtrim(ltrim(s));
}
//新增关系 
function addRelation(boss_login_no){
  openWinMid('addLoginNoRelation.jsp?boss_login_no='+boss_login_no,'新增工号绑定关系',200,300); 
}
//修改关系 
function modifyRelation(boss_login_no,kf_login_no,flag){
   openWinMid('modifyLoginNoRelation.jsp?boss_login_no='+boss_login_no+'&kf_login_no='+kf_login_no+'&flag='+flag,'修改工号绑定关系',200,300); 
}
//删除关系 
function delRelation(boss_login_no){
	var packet = new AJAXPacket("loginNoRelation_rpc.jsp","...");
	packet.data.add("retType","delRelation");
	packet.data.add("boss_login_no",boss_login_no);
	core.ajax.sendPacket(packet,doProcessDelRelation,true);
	packet=null;
}

/**
  *返回处理函数
  */
function doProcessDelRelation(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	if (retType == 'delRelation' && retCode == "000000") {
		rdShowMessageDialog("绑定关系删除成功！");		
	  document.sitechform.search.click();
	} else {
		rdShowMessageDialog("绑定关系删除失败！");
	}
	
}


function EnterKey(){ 

  if(event.keyCode==13)   
  {   
  document.sitechform.search.focus();
  document.sitechform.search.click();
  
  }   
  }   


function historyGo(){
	
	location = "f8002.jsp";	
}
</script>
</head>


<body >
<form id="sitechform" name="sitechform">
<div id="Main">
		 
   <DIV id="Operation_Table"> 

		<div class="title"><div id="title_zi">工号关系绑定配置</div></div>
		<table cellspacing="0" onkeydown="EnterKey();">
    <!-- THE FIRST LINE OF THE CONTENT -->
     <tr >
      <td > BOSS工号 </td>
      <td >
				<input  id="boss_login_no" name="boss_login_no" type="text" maxlength="6"   value="<%=(boss_login_no==null)?"":boss_login_no%>"  >
        
      </td>
      <td > 平台工号 </td>
      <td >
				<input id="kf_login_no" name="kf_login_no" type="text" maxlength="6"   value="<%=(kf_login_no==null)?"":kf_login_no%>" >

      </td>
    </tr>
    <tr>
		  <td > 工号姓名 </td>
      <td >
			  <input name ="login_name" type="text" id="login_name"  value="<%=(login_name==null)?"":login_name%>">
      </td> 
      <td >状态 </td>
      <td >
			  <select id="login_status" name="login_status" size="1" onchange="this.value=login_status.options[this.selectedIndex].value;oper.value=login_status.options[this.selectedIndex].value;">
			 	<%if(login_status==null || ("").equals(login_status)|| request.getParameter("oper")==null || ("").equals(request.getParameter("oper"))){%>
			 	<option value="" selected>--全部--</option>
			 	<option value="Y" >--正常--</option>
        <option value="N" >--失效--</option>
        <option value="S" >--未绑定--</option>
			 	<%}else{
			 	 if(("Y").equals(request.getParameter("oper"))){
			 	  %>
			 	<option value="Y" selected>--正常--</option>
        <option value="N" >--失效--</option>
        <option value="S" >--未绑定--</option>
        <option value=""  >--全部--</option>
			 	<%}else if(("N").equals(request.getParameter("oper"))){%>
			 	<option value="Y" >--正常--</option>
        <option value="N" selected>--失效--</option>
        <option value="S" >--未绑定--</option>
        <option value=""  >--全部--</option>
        <%}else if(("S").equals(request.getParameter("oper"))){%>
			 	<option value="Y" >--正常--</option>
        <option value="N" >--失效--</option>
        <option value="S" selected>--未绑定--</option>
        <option value=""  >--全部--</option>
			 	<%}}%>
      	 </select>
			  <input name="oper" type="hidden" value="<%=request.getParameter("oper")%>">
      </td> 
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="center" id="footer" >
      	<input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
        <input name="clear" type="button"  id="clear" value="重设" onClick="clearValue();return false;">              
        <input name="retbut" type="button"  id="retbut" value="返回"  class="b_foot" onClick="historyGo();return false;">              
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <a>快速选择</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>快速跳转</a> 
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr > 
            <th align="center" class="Blue" width="10%" >BOSS工号</th>
            <th align="center" class="Blue" width="10%" >平台工号</th>
            <th align="center" class="blue" width="10%" >工号姓名</th>
            <th align="center" class="blue" width="10%" >创建工号</th>
            <th align="center" class="blue" width="10%" >创建时间</th>
            <th align="center" class="blue" width="10%" >修改工号</th>
            <th align="center" class="blue" width="10%" >修改时间</th>
            <th align="center" class="blue" width="10%" >状态</th>
            <th align="center" class="blue" width="10%" >操作</th>
         </tr>                                                          
          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="one";
           %>
          <%if((i+1)%2==1){ 
          			tdClass="two";
          %>
          <tr  >
			<%}else{%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td> 
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%if(dataRows[i][1]==null||("").equals(dataRows[i][1])){%><a href="#" onclick="addRelation('<%=dataRows[i][0]%>');return false;">绑定</a>
        <%}else{%>
        <a href="#" onclick="modifyRelation('<%=dataRows[i][0]%>','<%=dataRows[i][1]%>','<%=dataRows[i][8]%>');return false;">修改</a>
        <a href="#" onclick="delRelation('<%=dataRows[i][0]%>');return false;">删除</a>
        <%}%></td>     
    </tr>
      <% } %> 
  </table>
  
  <table  cellspacing="0"> 
    <tr >
      <td class="blue"  align="right">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <a>快速选择</a>
        <select onchange="jumpToPage(this.value)">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <a>快速跳转</a> 
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>


	<%if(sqlFilter==null){%>
		<script language=javascript>
			submitInputCheck();
		</script>
	<%}%>

</html>


