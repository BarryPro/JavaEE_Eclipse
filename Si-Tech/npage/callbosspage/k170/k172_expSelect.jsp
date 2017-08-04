<%
  /*
   * 功能: 来电原因
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
	    typeCheckBox.append(getInnerHtml(call_cause_desc_temp)+"，");
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
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
    String expFlag = request.getParameter("exp");
    String pageFlag = request.getParameter("flag");
	   //判断是导出全部还是导入当前页
    String sqlFilter = request.getParameter("sqlFilter");
    String sql=request.getParameter("sql");
    String loginNo = (String)session.getAttribute("workNo"); 
    String seq=request.getParameter("seq");// 保存用户选择状态新增
    String strseq=""; 
    String headName=request.getParameter("headName");
    String callCauseId=request.getParameter("callCauseId"); 
    //20091120 新增 
    int start=0;
    int end=0;  
    String op_code="K172";
    String[][] queryList = new String[][] {};
    String start_date = request.getParameter("start_date"); //开始时间
	  String VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	  String end_date = request.getParameter("end_date"); //结束时间
	  String contact_id = request.getParameter("contact_id"); //流水号  
	  String region_code = request.getParameter("region_code"); //客户地市
	  String accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no"); //受理工号
	  String acceptid = request.getParameter("acceptid");
	  String accept_phone = request.getParameter("accept_phone"); //受理号码
	  String caller_phone = request.getParameter("caller_phone"); //主叫号码
	  String call_cause_id = request.getParameter("call_cause_id");
	  String accept_long_begin = request.getParameter("accept_long_begin"); //通话时长
	  String accept_long_end = request.getParameter("accept_long_end");
	  String sm_code = request.getParameter("sm_code"); //客户品牌
	  String staffcity = request.getParameter("staffcity"); //员工地市
	  String statisfy_code = request.getParameter("statisfy_code"); //客户满意度
	  String cause_id_is_null = request.getParameter("cause_id_is_null"); //来电原因为空
	  String nowday="";
	  HashMap pMap=new HashMap();
	  if(start_date!=null){
	  nowday = start_date.substring(0, 6);
	  }
		pMap.put("nowday", nowday);
		pMap.put("start_date", start_date);
		pMap.put("end_date", end_date);
		pMap.put("accept_long_begin", accept_long_begin);
		pMap.put("accept_long_end",accept_long_end);
		pMap.put("accept_login_no", accept_login_no);
		pMap.put("caller_phone", caller_phone);
		pMap.put("acceptid", acceptid);
		pMap.put("sm_code", sm_code);
		pMap.put("staffcity", staffcity);
		pMap.put("region_code", region_code);
		pMap.put("call_cause_id", call_cause_id);
		pMap.put("statisfy_code", statisfy_code);
		pMap.put("cause_id_is_null", cause_id_is_null);
		pMap.put("VERTIFY_PASSWD_FLAG_ISNOT_NULL", VERTIFY_PASSWD_FLAG_ISNOT_NULL);
		pMap.put("contact_id", contact_id);
		pMap.put("accept_phone", accept_phone);
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
    String stautsflag=request.getParameter("stautsflag");  // 保存用户选择状态新增	  
	  String[] strHead =null;
	  String head[]=null;
	  String excelName="来电原因";
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
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_callcause_strCountSql",pMap)).intValue();
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
    
        List queryList1 =(List)KFEjbClient.queryForList("query_callcause_exp_cur",pMap);     
        queryList = getArrayFromListMap(queryList1 ,1,21);   
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
 
		  List iDataList2 =(List)KFEjbClient.queryForList("query_callcause_exp_all",pMap);                              
		  queryList = getArrayFromListMap(iDataList2 ,0,14); 	
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
			String deleteStatus="delete from DCALLEXPSTATUS t where t.boss_login_no=:v1 and t.op_code='K172'&&"+loginNo;
			String insertStatus="insert into DCALLEXPSTATUS t(t.boss_login_no,t.op_code,t.field_id,t.create_time) values(:v1,'K172',:v2,sysdate)&&"+loginNo+"^"+seq;
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
<title>来电原因导出</title>

</head>
<body >
<form name="sitechform" method="post" action="">
<div id="Operation_Table" >
<div class="title"><div id="title_zi">导出列表</div></div>
<div id="title_zi"><input type="checkbox" id="checkAll" name="checkbox" value="checkbox" onclick="s_all('area[]')"/>全选/取消<br>
<input name="area[]" type="checkbox" id="area[]" seq="0" sql="contact_id" value="流水号" onclick="judgeCheckAll('area[]')"/>流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="1" sql="to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss')" value="受理时间" onclick="judgeCheckAll('area[]')"/>受理时间<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="CALLCAUSEDESCS" value="来电原因" onclick="judgeCheckAll('area[]')"/>来电原因<br>
<input name="area[]" type="checkbox" id="area[]" seq="2" sql="CALLER_PHONE" value="主叫号码" onclick="judgeCheckAll('area[]')"/>主叫号码<br>
<input name="area[]" type="checkbox" id="area[]" seq="3" sql="replace(translate(cust_name,'^',' '),'','')" value="客户名称" onclick="judgeCheckAll('area[]')"/>客户名称<br> 
<input name="area[]" type="checkbox" id="area[]" seq="4" sql="decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心')" value="客户地市" onclick="judgeCheckAll('area[]')"/>客户地市<br>
<input name="area[]" type="checkbox" id="area[]" seq="5" sql="decode(STATISFY_CODE,'1','满意',NULL,'未处理','2','一般','3','不满意','9','满意度用户挂机','4','满意度按其他键')" value="客户满意度" onclick="judgeCheckAll('area[]')"/>客户满意度<br>
<input name="area[]" type="checkbox" id="area[]" seq="6" sql="ACCEPT_PHONE" value="受理号码" onclick="judgeCheckAll('area[]')"/>受理号码<br>
<!-- modified by liujied 20090922 -->                             
<input name="area[]" type="checkbox" id="area[]" seq="7" sql="ACCEPT_LOGIN_NO" value="受理工号" onclick="judgeCheckAll('area[]')"/>受理工号<br>
<input name="area[]" type="checkbox" id="area[]" seq="8" sql="ACCEPT_LONG" value="通话时长" onclick="judgeCheckAll('area[]')"/>通话时长<br>
<input name="area[]" type="checkbox" id="area[]" seq="9" sql="decode(ACCEPTID,'0','人工','1','自动','2','来人','3','来函','4','传真','5','EMail','6','Web','7','呼出','8','三方通话' ,'9','内部呼叫' ,'10','呼出反馈','11','其它','12','短信')" value="受理方式" onclick="judgeCheckAll('area[]')"/>受理方式<br>
<input name="area[]" type="checkbox" id="area[]" seq="10" sql="CALL_ACCEPT_ID" value="外呼流水号" onclick="judgeCheckAll('area[]')"/>外呼流水号<br>
<input name="area[]" type="checkbox" id="area[]" seq="11" sql="BAK" value="备注" onclick="judgeCheckAll('area[]')"/>备注<br>

<input name="start_date"                       type="hidden" value="">
<input name="end_date"                         type="hidden" value="">
<input name="contact_id"                       type="hidden" value="">
<input name="region_code"                      type="hidden" value="">
<input name="accept_login_no"                  type="hidden" value="">    
<input name="acceptid"                         type="hidden" value="">
<input name="accept_phone"                     type="hidden" value="">
<input name="caller_phone"                     type="hidden" value="">
<input name="call_cause_id"                    type="hidden" value="">
<input name="accept_long_begin"                type="hidden" value="">
<input name="accept_long_end"                  type="hidden" value="">
<input name="sm_code"                          type="hidden" value="">
<input name="showCauseName"                    type="hidden" value="">
<input name="staffcity"                        type="hidden" value="">
<input name="statisfy_code"                    type="hidden" value="">
<input name="cause_id_is_null"                 type="hidden" value="">

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
  //如果上次全选,则此次将"全选/取消"勾选  
  	if(inps.length==count){
  			document.getElementById('checkAll').checked = true;
  	} else{
  			document.getElementById('checkAll').checked = false;
  	}
  	
 }
 }
 setStauts();
 
function s_exp(x){
	
	var formobj = window.opener.parent.queryFrame2.document.sitechform;
	var startdate = formobj.start_date.value;
	
	if(startdate > '<%=dateStr %>'){
		
		similarMSNPop("导出的结束时间不能超过当前时间");
		return;
	}
	var head=getCheckboxValue();
	var sql=getCheckboxSql();
	var seq=getCheckboxSeq();
	var stautsflag="<%=stautsflag%>";
	var temSql='';
	var expFlag="<%=pageFlag%>";
	window.sitechform.sqlFilter.value = opener.document.sitechform.sqlWhere.value;
	
  window.sitechform.start_date.value                        = opener.sitechform.start_date.value;                    
  //window.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value    = opener.sitechform.VERTIFY_PASSWD_FLAG_ISNOT_NULL.value;
  window.sitechform.end_date.value                          = opener.sitechform.end_date.value;                      
  window.sitechform.contact_id.value                        = opener.sitechform.contact_id.value;                    
  window.sitechform.region_code.value                       = opener.sitechform.region_code.value;                   
  window.sitechform.accept_login_no.value                   = opener.sitechform.accept_login_no.value;               
  window.sitechform.acceptid.value                          = opener.sitechform.acceptid.value;                      
  window.sitechform.accept_phone.value                      = opener.sitechform.accept_phone.value;                  
  window.sitechform.caller_phone.value                      = opener.sitechform.caller_phone.value;                  
  window.sitechform.call_cause_id.value                     = opener.sitechform.call_cause_id.value;             
  window.sitechform.accept_long_begin.value                 = opener.sitechform.accept_long_begin.value;             
  window.sitechform.accept_long_end.value                   = opener.sitechform.accept_long_end.value;               
  window.sitechform.sm_code.value                           = opener.sitechform.sm_code.value;                       
  window.sitechform.showCauseName.value                     = opener.sitechform.showCauseName.value;                 
  window.sitechform.staffcity.value                         = opener.sitechform.staffcity.value;                     
  window.sitechform.statisfy_code.value                     = opener.sitechform.statisfy_code.value;                                       
  window.sitechform.cause_id_is_null.value                  = opener.sitechform.cause_id_is_null.value; 
	
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
 	 window.sitechform.action="k172_expSelect.jsp?exp="+str;
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
