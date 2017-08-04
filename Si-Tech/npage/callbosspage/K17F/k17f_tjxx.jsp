<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 接续统计查询
　 * 版本: 1.0
　 * 日期: 2009/12/23
　 * 作者: 
　 * 版权: sitech
   *
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.text.*"%>
<%!	
//求2个时间和转换为 00:00:00 格式
//前两个值为时间参数，最后一个为求平均值的次数若不求平均值，则传1进入
public String getTime(String tmpStr1,String tmpStr2,String times){
		String returnTime = null;
		String tmpS1[] = tmpStr1.split(":");
		String tmpS2[] = tmpStr2.split(":");
		long totalNum = (Integer.parseInt(tmpS1[0])+Integer.parseInt(tmpS2[0]))*60*60+(Integer.parseInt(tmpS1[1])+Integer.parseInt(tmpS2[1]))*60+(Integer.parseInt(tmpS1[2])+Integer.parseInt(tmpS2[2]));
		//long totalNum = Integer.parseInt(tmpS1[0])*60*60+Integer.parseInt(tmpS1[1])*60+Integer.parseInt(tmpS1[2]);
		//求平均通话时长  秒为单位
		totalNum = totalNum/Integer.parseInt(times);
		String tmpHH = String.valueOf(totalNum/3600);
		String tmpMin = String.valueOf((totalNum%3600)/60);
		String tmpSec = String.valueOf((totalNum%3600)%60);
	
		tmpHH = (Integer.parseInt(tmpHH)>9)?tmpHH:("0"+tmpHH);
		tmpMin = ":" + ((Integer.parseInt(tmpMin)>9)?tmpMin:("0"+tmpMin));
		tmpSec = ":" + ((Integer.parseInt(tmpSec)>9)?tmpSec:("0"+tmpSec));
		returnTime = tmpHH + tmpMin + tmpSec;
		return returnTime;
}
%>
<%
    String opCode="K17F";
    String opName="综合查询-接续统计查询";
	  String loginNo = (String)session.getAttribute("workNo");  
    String myParams = request.getParameter("para"); 
    String myParams1 = null; 
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
    String pageStaffNo = request.getParameter("logNo");            //工号
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	      
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String action = request.getParameter("myaction");
		String sqlFilter = request.getParameter("sqlFilter");
		/*out.println("pageStaffNo:"+pageStaffNo);
		out.println("loginNo:"+loginNo);
		*/
		//取系统当前时间，以确定去哪个dcallcall表中统计
		Date nowDate = new Date();
		String getYYmm = new SimpleDateFormat("yyyyMMdd HHmmss").format(nowDate);
		getYYmm = getYYmm.substring(0,6);
		String getQryLoginNo = null ;
		HashMap pMap=new HashMap();
		HashMap pMap1=new HashMap();
		//保存转接次数
		String tranTime = "0" ;
		//保存呼出次数
		String callOut = "0" ;
		//通话次数
		String callTimes = "0" ;
		//通话时长
		String callTime = "00:00:00" ;
		//平均时长
		String avgcallTime = "00:00:00" ;
		//示忙时长
		String busyTime = "00:00:00" ;
		//工作时长
		String workTime = "00:00:00" ;
		
    if ("doLoad".equals(action)) {
    		String getKFLoginNoSql = " select kf_login_no from dloginmsgrelation where boss_login_no=:boss_login_no ";
    		myParams = "boss_login_no="+pageStaffNo;
    		
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=getKFLoginNoSql%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="loginList"  start="0" length="1" scope="end"/>	
	<%
		if(loginList.length>0){
		//查询确定只有1条记录 保存示忙时长由示忙和强制示忙组成
				getQryLoginNo =loginList[0][0];
				//out.println("getQryLoginNo:"+getQryLoginNo);
		}
	%>	
						
 <%   		
 				myParams = "staffno="+getQryLoginNo;
 				myParams1 = "accept_login_no="+pageStaffNo;
        //根据分组统计接续表中不同操作类型的次数
        sqlStr = "select to_char(count(*)),operate_type from dagentoprinfo where to_char(operate_begin,'YYYYMMDD')=to_char(sysdate,'YYYYMMDD') and staffno=:staffno group by operate_type";

        //根据分组统计接续表中不同操作类型的时间和
        String sqlStr1 = "select to_char(trunc(sysdate)+sum(decode(operate_end,null,sysdate,'',sysdate,operate_end) - operate_begin),'hh24:mi:ss'),operate_type from dagentoprinfo where to_char(operate_begin,'YYYYMMDD')=to_char(sysdate,'YYYYMMDD') and staffno = :staffno group by operate_type";
        
        //转接次数统计
        String sqlStr2 = "select to_char(count(*)) from dcalltransfer where to_char(ACCEPT_DATE,'YYYYMMDD')=to_char(sysdate,'YYYYMMDD') and TRANSFER_LOGIN_NO=:accept_login_no" ;
       
        //呼出次数统计
        String sqlStr3 = "select to_char(count(*)) from dcallcall"+ getYYmm+ " where begin_date>TO_DATE(to_char(sysdate,'YYYYMMDD')||' 00:00:00','yyyymmdd hh24:mi:ss') and end_date<TO_DATE(to_char(sysdate,'YYYYMMDD')||' 23:59:59','yyyymmdd hh24:mi:ss') and op_code='K025' and accept_login_no=:accept_login_no " ;
        
        //通话次数
        String sqlStr4 = "select to_char(count(*)) from dcallcall"+ getYYmm+ " where begin_date>TO_DATE(to_char(sysdate,'YYYYMMDD')||' 00:00:00','yyyymmdd hh24:mi:ss') and end_date<TO_DATE(to_char(sysdate,'YYYYMMDD')||' 23:59:59','yyyymmdd hh24:mi:ss') and accept_login_no=:accept_login_no " ;
        
        //通话时长
        String sqlStr5 = "select to_char(trunc(sysdate)+sum(decode(end_date,null,sysdate,'',sysdate,end_date) - begin_date),'hh24:mi:ss') from dcallcall"+ getYYmm+ " where begin_date>TO_DATE(to_char(sysdate,'YYYYMMDD')||' 00:00:00','yyyymmdd hh24:mi:ss') and end_date<TO_DATE(to_char(sysdate,'YYYYMMDD')||' 23:59:59','yyyymmdd hh24:mi:ss') and accept_login_no=:accept_login_no " ;
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="2" scope="end"/>	
					
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:param value="<%=sqlStr1%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList1"  start="0" length="2" scope="end"/>	
						
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlStr2%>"/>
						<wtc:param value="<%=myParams1%>"/>
					</wtc:service>
					<wtc:array id="queryList2"  start="0" length="1" scope="end"/>	
					
						<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlStr3%>"/>
						<wtc:param value="<%=myParams1%>"/>
					</wtc:service>
					<wtc:array id="queryList3"  start="0" length="1" scope="end"/>	
										
						<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlStr4%>"/>
						<wtc:param value="<%=myParams1%>"/>
					</wtc:service>
					<wtc:array id="queryList4"  start="0" length="1" scope="end"/>	
						
						<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlStr5%>"/>
						<wtc:param value="<%=myParams1%>"/>
					</wtc:service>
					<wtc:array id="queryList5"  start="0" length="1" scope="end"/>	
<% 				
					dataRows=queryList;
					
					if(dataRows.length>0){
							for(int i=0;i<dataRows.length;i++){
									pMap.put(dataRows[i][1], dataRows[i][0]);
							}
					}
%>
<%
	
		if(queryList1.length>0){
			for(int j=0;j<queryList1.length;j++){
					
					pMap1.put(queryList1[j][1], queryList1[j][0]);
			}
			String tmpTimes1 = (String)(pMap1.get("3")==null?"00:00:00":pMap1.get("3"));
			String tmpTimes2 = (String)(pMap1.get("31")==null?"00:00:00":pMap1.get("31"));
			busyTime = getTime(tmpTimes1,tmpTimes2,"1");
			
			tmpTimes1 = (String)(pMap1.get("0")==null?"00:00:00":pMap1.get("0"));
			tmpTimes2 = (String)(pMap1.get("1")==null?"00:00:00":pMap1.get("1"));
			workTime = getTime(tmpTimes1,tmpTimes2,"1");	
		}	
		
		if(queryList2.length>0){
		//查询确定只有1条记录 保存示忙时长由示忙和强制示忙组成
				if(queryList2[0][0].length()>0){
						tranTime =queryList2[0][0];
				}
		}
		
		if(queryList3.length>0){
		//查询确定只有1条记录 保存呼出次数
				if(queryList3[0][0].length()>0){
						callOut =queryList3[0][0];
				}
		}
		
		if(queryList4.length>0){
		//查询确定只有1条记录 通话次数
				if(queryList4[0][0].length()>0){
						callTimes =queryList4[0][0];
				}
		}
		if(queryList5.length>0){
		//查询确定只有1条记录 通话时长
				if(queryList5[0][0].length()>0){
						callTime =queryList5[0][0];
						avgcallTime = getTime(callTime,"00:00:00",callTimes);		
				}		
		}	
%>
<%
} 
   
%>	

<html>
<head>
<style>
img{
   cursor:hand;
 }
</style>	
<title>接续统计查询</title>
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

function submitInput(){
  if(document.sitechform.logNo.value == ""){
		showTip(document.sitechform.logNo,"工号不能为空！请输入");
		sitechform.logNo.focus();
  }else {
    hiddenTip(document.sitechform.logNo);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    doSubmit();
  }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k17f_tjxx.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
	  	e[i].value="";
  }else if(e[i].type=="checkbox"){
  	e[i].checked=false;
  }
 }
     window.location="k17f_tjxx.jsp";
}

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
   window.sitechform.myaction.value="doLoad";
   keepValue();
   window.sitechform.action="k17f_tjxx.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.logNo.value="<%=pageStaffNo%>";
	window.sitechform.para.value="<%=myParams%>";
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
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table">
		<table cellspacing="0">
    <tr><td colspan='6' ><div class="title"><div id="title_zi">接续统计查询</div></div></td></tr>
     <tr >
     <td > 工号 </td>
	    <td >
	    <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name="logNo" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(pageStaffNo==null)?"":pageStaffNo%>>
			  <font color="orange">*</font>
	    </td>
	   </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer" style="width:420px">
       <!--zhengjiang 20091004 查询与重置换位置--> 
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()">
       <input name="clear" type="button"  id="clear" value="重置" onClick="clearValue()">
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
      <table  cellSpacing="0" >
        <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
			  <input type="hidden" name="para" value="">
			  <%            
                String tdClass="blue";
        %>
	    <tr>  
     	<td align="left" class="<%=tdClass%>" width=12% >通话次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=callTimes%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >总的通话时长</td>
     	<td align="left" class="<%=tdClass%>"  width=12%><%=callTime%></td>
     	<td align="left" class="<%=tdClass%>" width=12% >工作态时长</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap1.get("27")!=null)?pMap1.get("27"):"00:00:00"%></td>
     	<td align="left" class="<%=tdClass%>"  >上班次数</td>
     	<td align="left" class="<%=tdClass%>"  ><%=Integer.parseInt((String)((pMap.get("0")!=null)?pMap.get("0"):"0"))+Integer.parseInt((String)((pMap.get("1")!=null)?pMap.get("1"):"0"))%>次</td>
     	</tr>
     	
    	<tr>
     	<td align="left" class="<%=tdClass%>" width=12% >工作时长</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=workTime%></td>
     	<td align="left" class="<%=tdClass%>" width=12% >转接次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=tranTime%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >人工转移自动次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("13")!=null)?pMap.get("13"):"0"%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >内部呼叫次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("41")!=null)?pMap.get("41"):"0"%>次</td>
     	</tr>
     	
    	<tr>
     	<td align="left" class="<%=tdClass%>" width=12% >呼出次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=callOut%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >示忙次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=Integer.parseInt((String)((pMap.get("3")!=null)?pMap.get("3"):"0"))+Integer.parseInt((String)((pMap.get("31")!=null)?pMap.get("31"):"0"))%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >示闲次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("30")!=null)?pMap.get("30"):"0"%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >保持次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("38")!=null)?pMap.get("38"):"0"%>次</td>
     	</tr>
     	
    	<tr>
     	<td align="left" class="<%=tdClass%>" width=12% >内部求助次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("40")!=null)?pMap.get("40"):"0"%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >示忙时长</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=busyTime%></td>
     	<td align="left" class="<%=tdClass%>" width=12% >监听次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("20")!=null)?pMap.get("20"):"0"%>次</td>
     	<td align="left" class="<%=tdClass%>" width=12% >拦截次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("43")!=null)?pMap.get("43"):"0"%>次</td>
     	</tr>
     	
    	<tr>  	
     	<td align="left" class="<%=tdClass%>" width=12% >强制签出次数</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap.get("29")!=null)?pMap.get("29"):"0"%>次</td> 
     	<td align="left" class="<%=tdClass%>" width=12% >监听时长</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=(pMap1.get("20")!=null)?pMap1.get("20"):"00:00:00"%></td>
     	<td align="left" class="<%=tdClass%>" width=12% >平均通话时长</td>
     	<td align="left" class="<%=tdClass%>" width=12% ><%=avgcallTime%></td>     
     	<td align="left" class="<%=tdClass%>" colspan='2' >&nbsp;</td>     		
    </tr>
  </table>   
</div>
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>