<%
  /*
   * 功能: 转存录音
　 * 版本: 1.0
　 * 日期: 2009/01/08
　 * 作者: zengzq 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq=""; 
    
    String headName=request.getParameter("headName");
    String[][] dataRows = new String[][]{};
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
    
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增
    
		String strCountSql="select to_char(count(*)) count  from dcallcall";
	  String strOrderSql=" order by BEGIN_DATE desc ";
	  
	  String statusSql="select t.field_id from DCALLEXPSTATUS t where t.boss_login_no='"+loginNo+"'and  t.op_code='K1716'";
	  
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="来电信息";
	  int intMaxRow=5000+1;
	  if(headName!=null){
	  if(!"".equalsIgnoreCase(headName)){
	   head =headName.split(",");
	   strHead =new String[head.length];
	  for (int i = 0; i < head.length; i++) {
	    strHead[i]=head[i];
      }
    }
	  }        
	  
	  sqlStr+="select "+sql+" from dcallcall"+sqlFilter;
%>	
		
<%
   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
%>
         <wtc:service name="s151Select" outnum="1">
					<wtc:param value="<%=statusSql%>"/>
					</wtc:service>
				<wtc:row id="row" length="1">
<%
					strseq=row[0];
					if(!"".equalsIgnoreCase(strseq)){
					stautsflag="Y";
					}
%> 
					</wtc:row>	
<%
	}
%>
	
<%
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
      sqlTemp =strCountSql+sqlFilter;
%>	             
			<wtc:service name="s151Select" outnum="1">
				<wtc:param value="<%=sqlTemp%>"/>
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
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>		           
        <wtc:service name="s151Select" outnum="23">
					<wtc:param value="<%=querySql%>"/>
					</wtc:service>
				<wtc:array id="queryList"  start="1" length="22"   scope="end"/>
<%
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
%>		           
      <wtc:service name="s151Select" outnum="22">
				<wtc:param value="<%=sqlStr%>"/>
				</wtc:service>
			<wtc:array id="queryList"  start="0" length="22"   scope="end"/>
<%
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");
				
			}
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K1716'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K1716',:v2,sysdate)&&"+loginNo+"^"+seq;
			List sqlList=new ArrayList();
			String[] sqlArr = new String[]{};
			if("Y".equalsIgnoreCase(stautsflag)){
					sqlList.add(deleteStatus);
			}
      sqlList.add(insertStatus);
      sqlArr = (String[])sqlList.toArray(new String[0]);
			String outnum = String.valueOf(sqlArr.length + 1);   
			//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";   
%>
			<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
			<wtc:array id="retRows"  scope="end"/>	
<%
   }   
%>

<html>
<head>
<title>转存录音导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title">导出列表</div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="CONTACT_ID" value="流水号" onclick="judgeCheckAll('area[]')" />流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="CUST_NAME" value="客户姓名" />客户姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql1="decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心')" value="客户地市" onclick="judgeCheckAll('area[]')"/>客户地市<br> 
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="ACCEPT_PHONE" value="受理号码" onclick="judgeCheckAll('area[]')"/>受理号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="CALLER_PHONE" value="主叫号码" onclick="judgeCheckAll('area[]')"/>主叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="CALLEE_PHONE" value="被叫号码" onclick="judgeCheckAll('area[]')"/>被叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss')" value="受理时间" onclick="judgeCheckAll('area[]')"/>受理时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="ACCEPT_LONG" value="受理时长" onclick="judgeCheckAll('area[]')"/>受理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LOGIN_NO" value="受理工号" onclick="judgeCheckAll('area[]')"/>受理工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(STAFFHANGUP,'0','用户','1','话务员','2','密码验证失败自动释放')" value="挂机方" onclick="judgeCheckAll('area[]')"/>挂机方<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(QC_FLAG,'Y','已质检','N','未质检','','未质检',NULL,'未质检')" value="是否质检" onclick="judgeCheckAll('area[]')" />是否质检<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="decode(STATISFY_CODE,'0','满意','1','未处理','2','一般','3','不满意','4','满意度调查挂机')" value="客户满意度" onclick="judgeCheckAll('area[]')" />客户满意度<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="CALLCAUSEDESCS" value="来电原因" />来电原因<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">

<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">

<input type="button" name="expbutton" value="导出" class="b_text" onclick="s_exp('area[]')"/>
<input type="button" name="expclose" value="关闭" class="b_text" onclick="window.close();"/>
</div>
</p>
</div>
</form>
</body>
</html>
<script language="javascript" type="text/javascript"> 
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
 
function s_all(x){
		var tmpCheck = document.getElementById("checkAll");
		var inps = document.getElementsByName(x);
		if(tmpCheck.checked==true){
				for(var i=0;i<inps.length;i++){
						inps[i].checked = true;
				}
		}
		if(tmpCheck.checked==false){
				for(var i=0;i<inps.length;i++){
						inps[i].checked = false;
				}
		}
}
 
//若全选后去掉某个选择项,则全选不勾中 zengzq add 
function judgeCheckAll(x){
		var tmpCheck = document.getElementById("checkAll");
		var inps = document.getElementsByName(x);
		var count = 0;
		
		for(var i=0;i<inps.length;i++){
				if(inps[i].checked == false){
						tmpCheck.checked = false;
						count++ ;
				}
		}
		if(count==0){
				tmpCheck.checked = true;
		}
}
 
//判断一个字符串是否数组中出现
function isStr(str,strArr){
		if(strArr!=null&&strArr!=''){
				for(var j=0;j<strArr.length;j++){
				 		if(str==strArr[j]){
				 				return true;
				 		}
				}
		}
		return false;
}
//保存用户上回设置状态
function setStauts(){
		var inps = document.forms['sitechform'].elements['area[]'];
		var arrid ="<%=strseq%>";
		var temarr=new Array();
		var count = 0;
		if(arrid!=''){
				temarr=arrid.split(",");
				for(var i=0;i<inps.length;i++){
				   	if(isStr(inps[i].seq,temarr)){
						   	inps[i].checked=true;
						   	count++;
				   	}
				}
				//如果上次全选,则此次将"全选/取消"勾选 zengzq add  
				if(inps.length==count){
						document.getElementById('checkAll').checked = true;
				} else{
						document.getElementById('checkAll').checked = false;
				}
		}
}
 setStauts();
 
function s_exp(x){
		var head=getCheckboxValue();
		var sql=getCheckboxSql();
		var seq=getCheckboxSeq();
		var stautsflag="<%=stautsflag%>";
		var temSql='';
		var expFlag="<%=pageFlag%>";
		
		window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
		window.sitechform.page.value = opener.document.sitechform.page.value;
	  window.sitechform.headName.value = head;
	  window.sitechform.sql.value = sql;
	  window.sitechform.seq.value = seq;
	  window.sitechform.stautsflag.value = stautsflag;
  
    if(head==''){
   			return;
   	}
   	temSql="select "+sql+ "from dcallcall"+ window.sitechform.sqlFilter.value;
   	submitExp(expFlag);
 }
 
 function submitExp(str){
	 	 window.sitechform.action="k1716_expSelect.jsp?exp="+str;
	 	 window.sitechform.method='post';
	   window.sitechform.submit(); 
 	}
function getCheckboxValue(){
		var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') { 
				return (checkbox.checked)?checkbox.value:''; 
		}
		
		if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }
		
		var val = [];
		var len = checkbox.length;
		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].value;
				}
		}
		
		return (val.length)?val:'';
}
function getCheckboxSql(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') { 
				return (checkbox.checked)?checkbox.value:''; 
		}
		
		if (checkbox[0].tagName.toLowerCase() != 'input' || 
			checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }
	
		var val = [];
		var len = checkbox.length;
		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].sql;
				}
		}
		
		return (val.length)?val:'';
}

function getCheckboxSeq(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') {
				return (checkbox.checked)?checkbox.value:''; 
		}
		
		if (checkbox[0].tagName.toLowerCase() != 'input' || 
			checkbox[0].type.toLowerCase() != 'checkbox')
		{ return ''; }
	
		var val = [];
		var len = checkbox.length;
		for(i=0; i<len; i++){
				if (checkbox[i].checked){
						val[val.length] = checkbox[i].seq;
				}
		}
		
		return (val.length)?val:'';
}
</script>
