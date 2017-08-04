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
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%!
//导出来电原因去掉数据库中的html代码
	StringBuffer typeCheckBox = new StringBuffer();
	public  String removeHtmlCode(String call_cause_desc){
		if(call_cause_desc==null||call_cause_desc==""){return "";}
	    int tempBegin = call_cause_desc.indexOf("<span", 0);
	    if(tempBegin<0){
	    	tempBegin = call_cause_desc.indexOf("<SPAN", 0);
	    }
	    int tempend = call_cause_desc.indexOf("</span>", tempBegin);
	    if(tempend<0){
	    	tempend = call_cause_desc.indexOf("</SPAN>", tempBegin);
	    }
	    if(tempend<0){return typeCheckBox.toString();}
	    String call_cause_desc_temp = call_cause_desc.substring(0,tempend);
	    typeCheckBox.append(getInnerHtml(call_cause_desc_temp)+",");
	    call_cause_desc=call_cause_desc.substring(tempend+7,call_cause_desc.length());
	    //call_cause_desc_temp=call_cause_desc.substring(0,tempend);
	    removeHtmlCode(call_cause_desc).toString();
	    return typeCheckBox.toString();
		}
		
	public String getInnerHtml(String call_cause_desc_temp){
	    int tempBegin = call_cause_desc_temp.indexOf(">", 0);
	    int tempend = call_cause_desc_temp.indexOf("<", tempBegin+2);
	    if(tempend<0){return "";}
		return call_cause_desc_temp.substring(tempBegin+1,tempend);
	}
%>
<%
//jiangbing 20091118 批量服务替换
    String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
    String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
    String sqlMulKfCfm="";
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    
    //zengzq
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq=""; 
    
    String headName=request.getParameter("headName");
    String[][] queryList = new String[][] {};
    String start_date        =  request.getParameter("start_date");            //开始时间
    String end_date          =  request.getParameter("end_date");              //结束时间
    String contact_id        =  request.getParameter("contact_id");        //流水号
    String region_code       =  request.getParameter("region_code");       //客户地市
    String accept_login_no   =  request.getParameter("accept_login_no");   //受理工号
    String accept_phone      =  request.getParameter("accept_phone");      //受理号码
    String mail_address      =  request.getParameter("mail_address");      //电子邮件
    String contact_address   =  request.getParameter("contact_address");   //联系地址
    String grade_code        =  request.getParameter("grade_code");        //客户级别
    String contact_phone     =  request.getParameter("contact_phone");     //联系电话
    String caller_phone      =  request.getParameter("caller_phone");      //主叫号码  
    String statisfy_code     =  request.getParameter("statisfy_code");     //客户满意度
    String cust_name         =  request.getParameter("cust_name");        //客户姓名
    String fax_no            =  request.getParameter("fax_no");           //传真号码
    String accept_long_begin =  request.getParameter("accept_long_begin");     //受理时长(开始)
    String accept_long_end   =  request.getParameter("accept_long_end");       //受理时长(结束)
    String callee_phone      =  request.getParameter("callee_phone");     //被叫号码  
    String skill_quence      =  request.getParameter("skill_quence");     //列队级别
    String staffHangup       =  request.getParameter("staffHangup");      //挂机方
    String acceptid          =  request.getParameter("acceptid");         //受理方式 
    String oper_code         =  request.getParameter("staffcity");        //员工地市
    String kf_login_no       =  request.getParameter("kf_login_no");      //转存工号
    String ipAddr            =  request.getParameter("bak2");          //转存IP 
    String tablename = "";
    String op_code="K17D";
    int start=0;
    int end=0;  
    HashMap pMap=new HashMap();
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("contact_id", contact_id);
		pMap.put("region_code", region_code);
		pMap.put("accept_login_no", accept_login_no);
		pMap.put("accept_phone", accept_phone);
		pMap.put("mail_address", mail_address);
		pMap.put("contact_address", contact_address);
		pMap.put("grade_code", grade_code);
		pMap.put("contact_phone", contact_phone);
		pMap.put("caller_phone", caller_phone);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("cust_name", cust_name);
		pMap.put("fax_no", fax_no);
		pMap.put("accept_long_begin", accept_long_begin);
		pMap.put("accept_long_end", accept_long_end);
		pMap.put("callee_phone", callee_phone);
		pMap.put("skill_quence", skill_quence);
		pMap.put("staffHangup", staffHangup);
		pMap.put("acceptid", acceptid);
		pMap.put("oper_code", oper_code);
		pMap.put("kf_login_no", kf_login_no);
		pMap.put("ipAddr", ipAddr);  
		if(start_date!=null){
		tablename = start_date.substring(0, 6); 
		}
		pMap.put("tablename", tablename); 
		pMap.put("op_code",op_code);
    pMap.put("sqlstr",sql);
    pMap.put("boss_login_no",loginNo);
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";
    
    //zengzq
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增  
	  String[] strHead =null;
	  String head[]=null;
          //String excelName="来电信息";
	  String excelName="转存录音查询";
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
		//zengzq
   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
   		  List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",pMap);  
   		  if(iDataList3.size()!=0){                            
		    queryList = getArrayFromListMap(iDataList3 ,0,1); 	
				strseq=queryList[0][0];
				}
				if(!"".equalsIgnoreCase(strseq)){
					stautsflag="Y";
					}
		}
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K17D_strCountSql",pMap)).intValue();
        System.out.println("rowCount___________________________"+rowCount);
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
        
        start = (curPage - 1) * pageSize + 1;
				end = curPage * pageSize;
				pMap.put("start", ""+start);
				pMap.put("end", ""+end);		    
		    List iDataList2 =(List)KFEjbClient.queryForList("query_K17D_expcur",pMap);     
		    queryList = getArrayFromListMap(iDataList2 ,1,16);  
		    System.out.println("queryList___________________________cur"+queryList.length);
             for(int i=0;i<queryList.length;i++){
              for(int j=0;j<queryList[i].length;j++){
              if(queryList[i][j]!=null){
                  if(queryList[i][j].startsWith("<SPAN") ||queryList[i][j].startsWith("<span")){
                    queryList[i][j]=removeHtmlCode(queryList[i][j]);
                  } 
                }
               }
	           typeCheckBox=typeCheckBox.delete(0, typeCheckBox.capacity());
             }
				XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
        out.print("<script language='javascript'>window.close();</script>");
   }
   if("all".equalsIgnoreCase(expFlag)){
      List iDataList5 =(List)KFEjbClient.queryForList("query_K17D_expall",pMap);                              
		  queryList = getArrayFromListMap(iDataList5 ,0,13); 	
		  System.out.println("queryList_________________________________-"+queryList.length);
             for(int i=0;i<queryList.length;i++){
              for(int j=0;j<queryList[i].length;j++){
              if(queryList[i][j]!=null){
                  if(queryList[i][j].startsWith("<SPAN") ||queryList[i][j].startsWith("<span")){
                    queryList[i][j]=removeHtmlCode(queryList[i][j]);
                  } 
                }
               }
            typeCheckBox=typeCheckBox.delete(0, typeCheckBox.capacity());
             }
        XLSExport.toExcel(strHead,queryList,intMaxRow,excelName,response);
				out.print("<script language='javascript'>window.close();</script>");
				
			//zengzq
			}
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K17D'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K17D',:v2,sysdate)&&"+loginNo+"^"+seq;
			List sqlList=new ArrayList();
			String[] sqlArr = new String[]{};
			if("Y".equalsIgnoreCase(stautsflag)){
			sqlList.add(deleteStatus);
			}
					     sqlList.add(insertStatus);
					     sqlArr = (String[])sqlList.toArray(new String[0]);
			String outnum = String.valueOf(sqlArr.length + 1);      
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
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="t1.CONTACT_ID" value="流水号" onclick="judgeCheckAll('area[]')" />流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="CUST_NAME" value="客户姓名" onclick="judgeCheckAll('area[]')" />客户姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心') region_code" value="客户地市" onclick="judgeCheckAll('area[]')"/>客户地市<br> 
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="ACCEPT_PHONE" value="受理号码" onclick="judgeCheckAll('area[]')"/>受理号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="CALLER_PHONE" value="主叫号码" onclick="judgeCheckAll('area[]')"/>主叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="CALLEE_PHONE" value="被叫号码" onclick="judgeCheckAll('area[]')"/>被叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss') BEGIN_DATE" value="受理时间" onclick="judgeCheckAll('area[]')"/>受理时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="to_char(ACCEPT_LONG)" value="受理时长" onclick="judgeCheckAll('area[]')"/>受理时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LOGIN_NO" value="受理工号" onclick="judgeCheckAll('area[]')"/>受理工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(STAFFHANGUP,'0','用户','1','话务员','2','密码验证失败自动释放') STAFFHANGUP" value="挂机方" onclick="judgeCheckAll('area[]')"/>挂机方<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(QC_FLAG,'Y','已质检','N','未质检','','未质检',NULL,'未质检') QC_FLAG" value="是否质检" onclick="judgeCheckAll('area[]')" />是否质检<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="decode(STATISFY_CODE,'0','满意','1','未处理','2','一般','3','不满意','4','满意度调查挂机') STATISFY_CODE" value="客户满意度" onclick="judgeCheckAll('area[]')" />客户满意度<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="CALLCAUSEDESCS" value="来电原因" onclick="judgeCheckAll('area[]')" />来电原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="t2.login_no" value="转存工号" onclick="judgeCheckAll('area[]')" />转存工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="t2.bak2" value="转存IP" onclick="judgeCheckAll('area[]')" />转存IP<br>

<input name="start_date"                type="hidden" value="">               
<input name="end_date"                  type="hidden" value="">
<input name="contact_id"         type="hidden" value="">
<input name="region_code"           type="hidden" value="">
<input name="accept_login_no"       type="hidden" value="">
<input name="accept_phone"          type="hidden" value="">
<input name="mail_address"          type="hidden" value="">
<input name="contact_address"       type="hidden" value="">
<input name="grade_code"            type="hidden" value="">
<input name="contact_phone"         type="hidden" value="">
<input name="caller_phone"          type="hidden" value="">
<input name="statisfy_code"         type="hidden" value="">
<input name="cust_name"            type="hidden" value="">
<input name="fax_no"               type="hidden" value="">
<input name="accept_long_begin"         type="hidden" value="">
<input name="accept_long_end"           type="hidden" value="">
<input name="callee_phone"         type="hidden" value="">
<input name="skill_quence"         type="hidden" value="">
<input name="staffHangup"          type="hidden" value="">
<input name="acceptid"             type="hidden" value="">
<input name="staffcity"            type="hidden" value="">
<input name="kf_login_no"          type="hidden" value="">
<input name="bak2"              type="hidden" value="">


<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">

<!--zengzq-->
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
 
 
 //zengzq
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
  //zengzq add 
  var count = 0;
  if(arrid!=''){
  	temarr=arrid.split(",");
  	for(var i=0;i<inps.length;i++){
	   	if(isStr(inps[i].seq,temarr)){
	   	inps[i].checked=true;
	   	//zengzq add 
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
	
	//zengzq
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	
	document.all("start_date").value           = opener.document.all("start_date").value;       
  document.all("end_date").value             = opener.document.all("end_date").value;         
  document.all("contact_id").value    = opener.document.all("0_=_t1.contact_id").value;  
  document.all("region_code").value      = opener.document.all("1_=_region_code").value;    
  document.all("accept_login_no").value  = opener.document.all("2_=_accept_login_no").value;
  document.all("accept_phone").value     = opener.document.all("3_=_accept_phone").value;   
  document.all("mail_address").value     = opener.document.all("4_=_mail_address").value;   
  document.all("contact_address").value  = opener.document.all("5_=_contact_address").value;
  document.all("grade_code").value       = opener.document.all("6_=_grade_code").value;     
  document.all("contact_phone").value    = opener.document.all("7_=_contact_phone").value;  
  document.all("caller_phone").value     = opener.document.all("8_=_caller_phone").value;   
  document.all("statisfy_code").value    = opener.document.all("9_=_statisfy_code").value;  
  document.all("cust_name").value       = opener.document.all("10_=_cust_name").value;     
  document.all("fax_no").value          = opener.document.all("11_=_fax_no").value;        
  document.all("accept_long_begin").value    = opener.document.all("accept_long_begin").value;  
  document.all("accept_long_end").value      = opener.document.all("accept_long_end").value;    
  document.all("callee_phone").value    = opener.document.all("12_=_callee_phone").value;  
  document.all("skill_quence").value    = opener.document.all("14_=_skill_quence").value;  
  document.all("staffHangup").value     = opener.document.all("15_=_staffHangup").value;   
  document.all("acceptid").value        = opener.document.all("16_=_acceptid").value;      
  document.all("staffcity").value       = opener.document.all("17_=_staffcity").value;     
  document.all("kf_login_no").value     = opener.document.all("18_=_t2.kf_login_no").value;   
  document.all("bak2").value         = opener.document.all("19_=_t2.bak2").value;       
	window.sitechform.page.value = opener.document.sitechform.page.value;
  window.sitechform.headName.value = head;
  window.sitechform.sql.value = sql;
  
  //zengzq
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
function getCheckboxValue()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].value;
		}
	}
	
	return (val.length)?val:'';
}
function getCheckboxSql()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].sql;
		}
	}
	
	return (val.length)?val:'';
}


//zengzq
function getCheckboxSeq()
{
   var checkbox=document.forms['sitechform'].elements['area[]'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].seq;
		}
	}
	
	return (val.length)?val:'';
}

 </script>
