<%
  /*
   * 功能: 来电信息
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
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*,java.util.*"%>
<%!
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
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
    System.out.println("start_date:~~~~~~~~~~~~~~~~~~~~"+request.getParameter("start_date"));
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
    String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
    String sqlMulKfCfm="";
    //zengzq
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq=""; 
    int start=0;
    int end=0;
    String op_code="K171";
    String[][] queryList = new String[][] {};
    String headName=request.getParameter("headName");
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    String contact_id = request.getParameter("contact_id");
    String region_code = request.getParameter("region_code");	
    String accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no");
    String listen_flag = request.getParameter("listen_flag");
    String accept_phone = request.getParameter("accept_phone");
    String mail_address = request.getParameter("mail_address");
    String contact_address = request.getParameter("contact_address");
    String grade_code = request.getParameter("grade");
    String contact_phone = request.getParameter("contact_phone");
    String caller_phone = request.getParameter("caller_phone"); //主叫号码
    String statisfy_code = request.getParameter("statisfy_code");
    String cust_name = request.getParameter("cust_name");
    String fax_no = request.getParameter("fax_no");
    String accept_long_begin = request.getParameter("accept_long_begin");
    String accept_long_end = request.getParameter("accept_long_end");
    String callee_phone = request.getParameter("callee_phone");
    String skill_quence = request.getParameter("skill_quence");
    String staffHangup = request.getParameter("staffHangup");
    String acceptid = request.getParameter("accid");
    String staffcity = request.getParameter("staffcity");    
    String VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
    HashMap hashMap =new HashMap();
    if(start_date!=null){
    hashMap.put("tablename",start_date.substring(0, 6));
    }
		hashMap.put("begin_date",start_date); 
    hashMap.put("end_date",end_date); 
    hashMap.put("accept_long_begin",accept_long_begin); 
    hashMap.put("accept_long_end",accept_long_end); 
    hashMap.put("other_passwd_flag",VERTIFY_PASSWD_FLAG_ISNOT_NULL); 
    hashMap.put("contact_id",contact_id);     
    hashMap.put("region_code",region_code);     
    hashMap.put("accept_login_no",accept_login_no);   
    hashMap.put("accept_phone",accept_phone);   
    hashMap.put("mail_address",mail_address); 
    hashMap.put("contact_address",contact_address); 
    hashMap.put("grade_code",grade_code); 
    hashMap.put("contact_phone",contact_phone); 
    hashMap.put("caller_phone",caller_phone); 
    hashMap.put("statisfy_code",statisfy_code); 
    hashMap.put("cust_name",cust_name); 
    hashMap.put("fax_no",fax_no); 
    hashMap.put("callee_phone",callee_phone); 
    hashMap.put("skill_quence",skill_quence); 
    hashMap.put("staffHangup",staffHangup); 
    hashMap.put("acceptid",acceptid); 
    hashMap.put("staffcity",staffcity); 
    hashMap.put("listen_flag",listen_flag);
    hashMap.put("op_code",op_code);
    hashMap.put("sqlstr",sql);
    hashMap.put("boss_login_no",loginNo);
    
    int rowCount =0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage;               // 需要从当前上一页面传过来
    String sqlTemp ="";
    String sqlStr ="";

    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增
	  
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

   //第一次载入页面，获取上次选中记录
   if("cur".equalsIgnoreCase(pageFlag)||"all".equalsIgnoreCase(pageFlag)){
   		  List iDataList3 =(List)KFEjbClient.queryForList("dcallexpstatus",hashMap);  
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
      // sqlTemp =strCountSql+sqlFilter;
		   rowCount=((Integer)KFEjbClient.queryForObject("dcallcallcount",hashMap)).intValue();               
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
      //  String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
       
       start = (curPage - 1) * pageSize + 1;
		   end = curPage * pageSize;
		   if (end > rowCount){
			     end = rowCount;
		    }
		  hashMap.put("start",String.valueOf(start)); 
      hashMap.put("end",String.valueOf(end)); 
		  List iDataList =(List)KFEjbClient.queryForList("dcallcallexpcur",hashMap);                              
		  queryList = getArrayFromListMap(iDataList ,1,23); 	
      System.out.println("===queryList.length=="+queryList.length);
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

		  List iDataList1 =(List)KFEjbClient.queryForList("dcallcallexpall",hashMap);                              
		  queryList = getArrayFromListMap(iDataList1 ,0,22); 	

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
			//保存用户选择的列  
			if("all".equalsIgnoreCase(expFlag)||"cur".equalsIgnoreCase(expFlag)){
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K171'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K171',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>来电信息导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="CONTACT_ID" value="流水号" onclick="judgeCheckAll('area[]')" />流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="decode(ACCEPTID,'0','人工','1','自动','2','来人','3','来函','4','传真','5','EMail','6','Web','7','呼出','8','三方通话' ,'9','内部呼叫' ,'10','呼出反馈','11','其它','12','短信','13','未受理')" value="受理方式" onclick="judgeCheckAll('area[]')"/>受理方式<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="replace(translate(cust_name,'^',' '),'','')" value="客户姓名" />客户姓名<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心')" value="客户地市" onclick="judgeCheckAll('area[]')"/>客户地市<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="ACCEPT_PHONE" value="受理号码" onclick="judgeCheckAll('area[]')"/>受理号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="CALLER_PHONE" value="主叫号码" onclick="judgeCheckAll('area[]')"/>主叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="CALLEE_PHONE" value="被叫号码" onclick="judgeCheckAll('area[]')"/>被叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss')" value="受理时间" onclick="judgeCheckAll('area[]')"/>受理时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LONG" value="受理时长" onclick="judgeCheckAll('area[]')"/>受理时长<br>
<!-- modified by liujied 20090922 -->
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="ACCEPT_LOGIN_NO" value="受理工号" onclick="judgeCheckAll('area[]')"/>受理工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="decode(STAFFHANGUP,'0','用户','1','话务员','2','密码验证失败自动释放')" value="挂机方" onclick="judgeCheckAll('area[]')"/>挂机方<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="decode(QC_FLAG,'Y','已质检','N','未质检','','未质检',NULL,'未质检')" value="是否质检" onclick="judgeCheckAll('area[]')" />是否质检<br>
<input name="area[]" type="checkbox" id="area[]" seq="12" sql="decode(STATISFY_CODE,'1','满意',NULL,'未处理','2','一般','3','不满意','9','满意度用户挂机','4','满意度按其他键')" value="客户满意度" onclick="judgeCheckAll('area[]')" />客户满意度<br>
<input name="area[]" type="checkbox" id="area[]" seq="13" sql="decode(LANG_CODE,'1','普通话','2','英语')" value="服务语种" onclick="judgeCheckAll('area[]')"/>服务语种<br>
<input name="area[]" type="checkbox" id="area[]" seq="14" sql="CALLCAUSEDESCS" value="来电原因" />来电原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="15" sql="decode(LISTEN_FLAG,'Y','是','','否',NULL,'否','N','否')" value="录音听取标志" onclick="judgeCheckAll('area[]')"/>录音听取标志<br>
<input name="area[]" type="checkbox" id="area[]" seq="16" sql="decode(USE_FLAG,'Y','是','N','否')" value="是否使用放音" onclick="judgeCheckAll('area[]')"/>是否使用放音<br>
<input name="area[]" type="checkbox" id="area[]" seq="17" sql="QC_LOGIN_NO" value="质检员工号" onclick="judgeCheckAll('area[]')"/>质检员工号<br>
<!--zengzq modify decode中的内容和查询页面保持一致 start-->
<input name="area[]" type="checkbox" id="area[]" seq="18" sql="decode(VERTIFY_PASSWD_FLAG,'Y','是','N','否','YY','是(正确)','YN','是(失败)','','否',NULL,'否')" value="是否密码验证" onclick="judgeCheckAll('area[]')"/>是否密码验证<br>
<input name="area[]" type="checkbox" id="area[]" seq="19" sql="decode(OTHER_PASSWD_FLAG,'Y','是','N','否','YY','是(正确)','YN','是(失败)','','否',NULL,'否')" value="是否他机验证" onclick="judgeCheckAll('area[]')"/>是否他机验证<br>
<!--zengzq modify decode中的内容和查询页面保持一致 end-->
<input name="area[]" type="checkbox" id="area[]" seq="20" sql="BAK" value="备注" onclick="judgeCheckAll('area[]')"/>备注<br>
<input name="area[]" type="checkbox" id="area[]" seq="21" sql="TRANSFER_BAK" value="转接备注" />转接备注<br>
<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="headName" value="">
<input type="hidden" name="sql" value="">

<!--zengzq-->
<input type="hidden" name="stautsflag" value="stautsflag">
<input type="hidden" name="seq" value="">
<!--donglei20091120 替换绑定变量 start-->
<input name="start_date"        type="hidden" value="">         
<input name="end_date"          type="hidden" value="">   
<input name="contact_id"        type="hidden" value="">
<input name="region_code"	      type="hidden" value="">
<input name="accept_login_no"   type="hidden" value="">
<input name="listen_flag"       type="hidden" value="">
<input name="accept_phone"      type="hidden" value="">
<input name="mail_address"      type="hidden" value="">
<input name="contact_address"   type="hidden" value="">
<input name="grade_code"        type="hidden" value="">
<input name="contact_phone"     type="hidden" value="">
<input name="caller_phone"      type="hidden" value="">
<input name="statisfy_code"     type="hidden" value="">
<input name="cust_name"         type="hidden" value="">
<input name="fax_no"            type="hidden" value="">
<input name="accept_long_begin" type="hidden" value="">   
<input name="accept_long_end"   type="hidden" value="">   
<input name="callee_phone"      type="hidden" value="">
<input name="skill_quence"      type="hidden" value="">
<input name="staffHangup"       type="hidden" value="">
<input name="acceptid"          type="hidden" value="">
<input name="staffcity"         type="hidden" value="">
<input name="VERTIFY_PASSWD_FLAG_ISNOT_NULL"         type="hidden" value="">

<!--donglei20091120 替换绑定变量 end-->
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
	
	var formobj = window.opener.parent.queryFrame.document.sitechform;
	var startdate = formobj.start_date.value;
	
	if(startdate > '<%=dateStr %>'){
		
		similarMSNPop("导出的结束时间不能超过当前时间");
		return;
	}
	
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	
	//zengzq
	var seq=getCheckboxSeq(); 
	var stautsflag="<%=stautsflag%>";
	
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	//替换绑定变量 start
window.sitechform.start_date.value        =	opener.sitechform.start_date.value;                 
window.sitechform.end_date.value          =	opener.sitechform.end_date.value;             
window.sitechform.contact_id.value        =	opener.sitechform.contact_id.value;     
window.sitechform.region_code.value	      =	opener.sitechform.region_code.value;	   
window.sitechform.accept_login_no.value   =	opener.sitechform.accept_login_no.value;
window.sitechform.listen_flag.value       =	opener.sitechform.listen_flag.value;  
window.sitechform.accept_phone.value      =	opener.sitechform.accept_phone.value;   
window.sitechform.mail_address.value      =	opener.sitechform.mail_address.value;   
window.sitechform.contact_address.value   =	opener.sitechform.contact_address.value;
window.sitechform.grade_code.value        =	opener.sitechform.grade_code.value;     
window.sitechform.contact_phone.value     =	opener.sitechform.contact_phone.value;  
window.sitechform.caller_phone.value      =	opener.sitechform.caller_phone.value;   
window.sitechform.statisfy_code.value     =	opener.sitechform.statisfy_code.value;  
window.sitechform.cust_name.value         =	opener.sitechform.cust_name.value;     
window.sitechform.fax_no.value            =	opener.sitechform.fax_no.value;        
window.sitechform.accept_long_begin.value =	opener.sitechform.accept_long_begin.value;    
window.sitechform.accept_long_end.value   =	opener.sitechform.accept_long_end.value;      
window.sitechform.callee_phone.value      =	opener.sitechform.callee_phone.value;  
window.sitechform.skill_quence.value      =	opener.sitechform.skill_quence.value;  
window.sitechform.staffHangup.value       =	opener.sitechform.staffHangup.value;   
window.sitechform.acceptid.value          =	opener.sitechform.acceptid.value;      
window.sitechform.staffcity.value         =	opener.sitechform.staffcity.value;

window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value         =	opener.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value;

//替换绑定变量 end
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
 	 window.sitechform.action="k171_expSelect.jsp?exp="+str;
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


/*******************************************/
//信息框层叠 by libin 2009-05-15
var msn_popmenu = null;
var msn_count = 0;

function similarMSNPop_local(msgContent){
    msn_count++;
	var imgClose=msn_popmenu.oPopup.document.createElement("img");
	imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	imgClose.style.cursor="pointer";
	imgClose.onmouseover=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_on.gif";
	}
	imgClose.onmouseout=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	}
	imgClose.onclick=function()
	{
		//hiddenList(overDiv,120);
	}
	imgClose.setAttribute("id","msgImg");
	var titleDiv=msn_popmenu.oPopup.document.createElement("div");
	titleDiv.setAttribute("id","msgTitle");
	var titleDivTxt=msn_popmenu.oPopup.document.createTextNode("弹出框");
	var contentDiv=msn_popmenu.oPopup.document.createElement("div");
	contentDiv.setAttribute("id","msgContent");
	contentDiv.innerHTML=msgContent;
	var overDiv = msn_popmenu.oPopup.document.createElement("div");
	overDiv.setAttribute("id","msg");
	overDiv.style.display="none";
	overDiv.style.overflow="hidden";
	
	overDiv.onclick=function(){
		hiddenList(overDiv,120);
	}
	
	titleDiv.appendChild(imgClose);
	titleDiv.appendChild(titleDivTxt);
	overDiv.appendChild(titleDiv);
	overDiv.appendChild(contentDiv);
	
	var bodyHtml=msn_popmenu.oPopup.document.getElementsByTagName("body");
	bodyHtml[0].appendChild(overDiv);
	
	showList(overDiv,120); 
	if(msn_popmenu.oPopup.document.getElementById("overDiv")) return false;
	
	
	var hidett = setTimeout(function(){hiddenList(overDiv,120)},10000);
	overDiv.setAttribute("hidett",hidett);
	
}

function showList(objectId,mH)
{
	var h =0;
	var maxHeight = mH;
	var anim = function()
	{ 
		h += 5;
		if(h > maxHeight)
		{ 
			objectId.style.height = mH+"px";  
			if(tt){window.clearInterval(tt);}  
		} 
		else
		{ 	
			objectId.style.height = h + "px";
			objectId.style.display="block";

		}
	} 
	var tt = window.setInterval(anim,15);  
} 

function hiddenList(objectId,mH)
{ 
	var h =mH; 
	var anim = function()
	{ 
		h -= 5;
		if(h <= 0)
		{ 
			objectId.style.display="none";
			if(tt){window.clearInterval(tt);
			if(objectId.getAttribute("hidett")!=null)
			{
				window.clearInterval(objectId.getAttribute("hidett"));
				}
			if(h>=-5){
			msn_count--;
			if(msn_count<0)
			   msn_count = 0;
			if(msn_count==0){
				msn_popmenu.stopthis();
				msn_popmenu.hide();
			}
			}
			}
			objectId.parentNode.removeChild(objectId);
		} 
		else
		{ 
			objectId.style.height = h + "px";
		} 
	} 
	var tt = window.setInterval(anim,15); 
} 
	
function similarMSNPop(msgContent){
    if(msn_popmenu == null){
    	var MSG1 = new CLASS_MSN_MESSAGE(180, 120, "");
		msn_popmenu = MSG1;
		MSG1.show();
    }else{
    	msn_popmenu.reshow();
    	}	
	similarMSNPop_local(msgContent);	
}

function CLASS_MSN_MESSAGE(width, height, title) {
	this.title = title;
	this.width = width ? width : 180;
	this.height = height ? height : 120;
	this.timeout = 500;
	this.speed = 150;
	this.step = 5;
	this.right = screen.width - 1;
	this.bottom = screen.height;
	this.left = this.right - this.width;
	this.top = this.bottom - this.height;
	this.timer = 0;
	this.pause = false;
	this.close = false;
	this.autoHide = true;

	this.clickClose = false;
}

CLASS_MSN_MESSAGE.prototype.hide = function () {
	this.oPopup.hide();
};

CLASS_MSN_MESSAGE.prototype.onunload = function () {
	return true;
};

CLASS_MSN_MESSAGE.prototype.show = function () {	
    this.oPopup = window.createPopup();
	this.Pop = this.oPopup;
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var str = '';
	var me = this.Pop;
	this.oPopup.document.createStyleSheet().addImport('<%= request.getContextPath() %>/nresources/default/css/layer_ob.css');
	this.oPopup.document.body.innerHTML = str;
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;
};

/*  
*    消息停止方法  
*/
CLASS_MSN_MESSAGE.prototype.stopthis = function () {	
  
	 window.clearInterval(this.timer);
	 this.close = true;	
};
/*  
*    消息显示方法  
*/
CLASS_MSN_MESSAGE.prototype.reshow = function () {	
  if(this.close==false){
  		return;
  	}
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var me = this.Pop;
	
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;	
};
 </script>
