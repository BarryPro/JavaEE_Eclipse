<%
  /*
   * 功能: 服务评价报告导出
　 版本: 1.0
　 * 日期: 2009/01/09
　 * 作者: zengzq 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*,java.io.*,java.net.*,java.util.*"%>
<%
		String myParamspub="";  /*midify by yinzx 20091113 公共查询服务替换*/
 		String org_code = (String)session.getAttribute("orgCode");
 		String regionCode = org_code.substring(0,2);
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
    String objectid = request.getParameter("objectid");
    String report_type = request.getParameter("report_type");
    if(report_type==null||report_type.equals(""))
        report_type = "";
    String loginNo = (String)session.getAttribute("workNo");
		String start_date     =  request.getParameter("start_date");
		String end_date       =  request.getParameter("end_date");
		String staffno        =  request.getParameter("staffno");
		String group_flag 		=  request.getParameter("group_flag");
		String objectTypeName 		=  request.getParameter("objectTypeName");
%>
<%
		String thSqlStr = "select t1.name,t1.object_id,t1.contect_id from dqccheckcontect t1,dqcobject t2 where trim(t1.object_id)=:objectid and t1.object_id=t2.object_id and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
		myParamspub= "objectid="+objectid.trim() ;
%>		           
   <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=thSqlStr%>"/>
	<wtc:param value="<%=myParamspub%>"/>
	</wtc:service>
		<wtc:array id="thName" start="0" length="3"  scope="end"/>
	
<%
	   //判断是导出全部还是导入当前页
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String sql=request.getParameter("sql");
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
	  String statusSql="select t.field_id from DCALLEXPSTATUS t where t.boss_login_no=:loginNo and  t.op_code='K204'";
	  String myParams2= "loginNo="+loginNo ;
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="服务评价报告";
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
	 
%>	
<%
   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
%>
			 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	     <wtc:param value="<%=statusSql%>"/>
	     <wtc:param value="<%=myParams2%>"/>
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
   if("all".equalsIgnoreCase(expFlag)){
    HashMap hashMap =new HashMap();
   	hashMap.put("start_date",start_date); 
    hashMap.put("end_date",end_date); 
    hashMap.put("loginNo",loginNo); 
    hashMap.put("objectid",objectid); 
    hashMap.put("group_flag",group_flag); 
    hashMap.put("selectSql",sql);
    hashMap.put("hasMoreCondition","Y"); 
    List iDataList3 =(List)KFEjbClient.queryForList("k204reportselectAll2",hashMap);                              
	  String[][] queryList = getArrayFromListMap(iDataList3 ,0,4);   

	if(report_type.equals(""))
      XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
  else{
        //导出txt文本
        out.clear();
        OutputStream o=response.getOutputStream();
   			byte b[]=new byte[500];
    		response.setContentType("application/octet-stream");
   			response.setHeader("content-disposition","attachment; filename="+URLEncoder.encode(excelName,"UTF-8")+".txt");
   			for(int i=0;i<strHead.length;i++){
   			  if(strHead[i]!=null)
   			  {
   			      if(i!=0){
   			      		o.write("\t".getBytes());
   			      }
   						o.write((strHead[i]).getBytes());
   				}
   			}
            o.write("\r\n".getBytes());
            for(int i=0;i<queryList.length;i++){
                for(int j=0;j<queryList[i].length;j++){
                    if(queryList[i][j]!=null){
                         if(j!=0){
   			      		           o.write("\t".getBytes());
   			                 }
   					             o.write((queryList[i][j]).getBytes());
   					        }
   				      }
   				    if(i<queryList.length-1)
            	o.write("\r\n".getBytes());
            }
            o.flush();
            out.clear();
            out = pageContext.pushBody();
            return;
        }
				out.print("<script language='javascript'>window.close();</script>");		
		}
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K204'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K204',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>服务评价报告导出</title>
 <%
 HashMap hashMap =new HashMap();
 hashMap.put("start_date",start_date); 
 hashMap.put("end_date",end_date); 
 hashMap.put("loginNo",loginNo); 
 hashMap.put("objectid",objectid); 
 hashMap.put("group_flag",group_flag); 
 hashMap.put("hasMoreCondition","Y"); 
 List iDataList4 =(List)KFEjbClient.queryForList("k204reportselectAll",hashMap);                              
 String[][] tmpqueryList = getArrayFromListMap(iDataList4 ,0,4);   
 %>

</head>
<body>
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="01" sql="staffno" value="工号" onclick="judgeCheckAll('area[]')"/>工号<br>
<% 
 if(thName!=null){
	 for(int j=0;j<thName.length;j++){
	 		String tmpSql ="''";
	 		if(tmpqueryList!=null){
		 		for ( int i = 0; i < tmpqueryList.length; i++ ) {
					
						if((tmpqueryList[i][2].trim()).equals(thName[j][1].trim())&&(tmpqueryList[i][3].trim()).equals(thName[j][2].trim())){
								tmpSql = 	"100-sum(100-score) score"+i;				
						}				
				}
			}
%>
					<input name="area[]" type="checkbox" id="area[]" seq="<%=j%>" sql="<%=tmpSql%>" value="<%=thName[j][0]%>" onclick="judgeCheckAll('area[]')"/><%=thName[j][0]%><br>
<%
	}
}
%>
<input name="area[]" type="checkbox" id="area[]" seq="02" sql="100-sum(100-score) score_" value="综合得分" onclick="judgeCheckAll('area[]')"/>综合得分<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">
<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">
<input type="button" name="expbutton" value="导出EXCEL" class="b_text" onclick="s_exp('area[]')"/>
<!--input type="button" name="expbutton" value="导出TXT" class="b_text" onclick="s_exp_txt('area[]')"/-->
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
		  	}else{
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
	  temSql="select "+sql+ "from dqcinfo t1 "+ window.sitechform.sqlFilter.value;
	  submitExp(expFlag);
 }
function s_exp_txt(x){
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
	  temSql="select "+sql+ "from dqcinfo t1 "+ window.sitechform.sqlFilter.value;
	  submitExp_txt(expFlag);
}
function submitExp(str){
 	 window.sitechform.action="k204_expSelect.jsp?exp="+str+"&objectid="+"<%=objectid%>"
 	 + "&staffno=" + "<%=staffno%>"
 	 + "&start_date=" + "<%=start_date%>";
   + "&end_date=" + "<%=end_date%>";
   + "&objectTypeName=" + "<%=objectTypeName%>";
   + "&group_flag=" + "<%=group_flag%>";
 	 window.sitechform.method='post';
   window.sitechform.submit(); 
}

function submitExp_txt(str){
 	 window.sitechform.action="k204_expSelect.jsp?exp="+str+"&objectid="+'<%=objectid%>'+"&report_type=txt";
 	 window.sitechform.method='post';
   window.sitechform.submit(); 
}

function getCheckboxValue(){
	  var checkbox=document.forms['sitechform'].elements['area[]'];
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox'){
			 return (checkbox.checked)?checkbox.value:'';
		}
		if (checkbox[0].tagName.toLowerCase() != 'input' ||checkbox[0].type.toLowerCase() != 'checkbox'){
				 return ''; 
		}

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
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox'){
			 return (checkbox.checked)?checkbox.value:'';
		}
		
		if (checkbox[0].tagName.toLowerCase() != 'input' ||checkbox[0].type.toLowerCase() != 'checkbox'){
				return ''; 
		}
	
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
		if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox'){
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