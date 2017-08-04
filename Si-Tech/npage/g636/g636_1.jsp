<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String org_code = (String)session.getAttribute("orgCode");
		String region_code = org_code.substring(0,2);
		String [] inParas = new String[2];
		String return_code="";
		String ret_msg="";
		String return_page = "g636_1.jsp";
		inParas[0]="SELECT REGION_CODE,to_char(ILEVEL),begin_ymdh,end_ymdh,HOLIDAY_NAME,LOGIN_NO,OP_TIME,OP_NOTE FROM CHOLIDAY_UNSTOP_NEW WHERE region_code=:region_code ";
    inParas[1]="region_code="+region_code;
		String opCode = "g636";
		String opName = "节假日配置";
		String login_no = (String)session.getAttribute("workNo");
	  String sqlStr1 = "select region_code,region_name from sregioncode where region_code = '"+region_code+"'";
		
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	
	
<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="10">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>	
		</wtc:service>
<wtc:array id="tempArr" scope="end"/> 	

<%
   String region_options ="<option value=>--请选择--</option>";

   for(int i=0;i<return_result1.length;i++)
   {
      region_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
   
   /**** update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 begin ****/
   String currYear=new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime());
   int nextYear = Integer.parseInt(currYear) + 1;
   int nextTwoYear = Integer.parseInt(currYear) + 2;
   String year_options = "<option value="+currYear+">"+currYear+"</option>"+
   											"<option value="+nextYear+">"+nextYear+"</option>"+
   											"<option value="+nextTwoYear+">"+nextTwoYear+"</option>";
   String month_options = "<option value='01'>01</option>"+
   												"<option value='02'>02</option>"+
   												"<option value='03'>03</option>"+
   												"<option value='04'>04</option>"+
   												"<option value='05'>05</option>"+
   												"<option value='06'>06</option>"+
   												"<option value='07'>07</option>"+
   												"<option value='08'>08</option>"+
   												"<option value='09'>09</option>"+
   												"<option value='10'>10</option>"+
   												"<option value='11'>11</option>"+
   												"<option value='12'>12</option>";
   String day_options = "<option value='01'>01</option>"+
   											"<option value='02'>02</option>"+
   											"<option value='03'>03</option>"+
   											"<option value='04'>04</option>"+
   											"<option value='05'>05</option>"+
   											"<option value='06'>06</option>"+
   											"<option value='07'>07</option>"+
   											"<option value='08'>08</option>"+
   											"<option value='09'>09</option>"+
   											"<option value='10'>10</option>"+
   											"<option value='11'>11</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='13'>13</option>"+
   											"<option value='14'>14</option>"+
   											"<option value='15'>15</option>"+
   											"<option value='16'>16</option>"+
   											"<option value='17'>17</option>"+
   											"<option value='18'>18</option>"+
   											"<option value='19'>19</option>"+
   											"<option value='20'0>20</option>"+
   											"<option value='21'>21</option>"+
   											"<option value='22'>22</option>"+
   											"<option value='23'>23</option>"+
   											"<option value='24'>24</option>"+
   											"<option value='25'>25</option>"+
   											"<option value='26'>26</option>"+
   											"<option value='27'>27</option>"+
   											"<option value='28'>28</option>"+
   											"<option value='29'>29</option>"+
   											"<option value='30'>30</option>"+
   											"<option value='31'>31</option>";
   String hour_options = "<option value='00'>00</option>"+
   											"<option value='01'>01</option>"+
   											"<option value='02'>02</option>"+
   											"<option value='03'>03</option>"+
   											"<option value='04'>04</option>"+
   											"<option value='05'>05</option>"+
   											"<option value='06'>06</option>"+
   											"<option value='07'>07</option>"+
   											"<option value='08'>08</option>"+
   											"<option value='09'>09</option>"+
   											"<option value='10'>10</option>"+
   											"<option value='11'>11</option>"+
   											"<option value='12'>12</option>"+
   											"<option value='13'>13</option>"+
   											"<option value='14'>14</option>"+
   											"<option value='15'>15</option>"+
   											"<option value='16'>16</option>"+
   											"<option value='17'>17</option>"+
   											"<option value='18'>18</option>"+
   											"<option value='19'>19</option>"+
   											"<option value='20'>20</option>"+
   											"<option value='21'>21</option>"+
   											"<option value='22'>22</option>"+
   											"<option value='23'>23</option>";
   											String tV = "02";
   /**** update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 end ****/
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("请选择地市名称!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
	
  if(document.frm.level.value=="")  {
     rdShowMessageDialog("请输入客户等级!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.level.value < 3)  {
     rdShowMessageDialog("客户等级为3－7，三星至五星钻!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.level.value > 7)  {
     rdShowMessageDialog("客户等级为3－7，三星至五星钻!");
     document.frm.level.value = "";
     document.frm.level.focus();
     return false;
  }
	
  if(document.frm.holiday_name.value=="")  {
     rdShowMessageDialog("请输入假日名称!");
     document.frm.holiday_name.value = "";
     document.frm.holiday_name.focus();
     return false;
  }
	
  if(document.frm.op_note.value=="")  {
     rdShowMessageDialog("请输入操作说明!");
     document.frm.op_note.value = "";
     document.frm.op_note.focus();
     return false;
  }
  /*
  if(document.frm.year.value=="")  {
     rdShowMessageDialog("请输入年份!");
     document.frm.year.value = "";
     document.frm.year.focus();
     return false;
  }*/
 /*
  if(document.frm.year.value.length < 4)  {
     rdShowMessageDialog("年份为4位!");
     document.frm.year.value = "";
     document.frm.year.focus();
     return false;
  }
*/	
/*
 if(!isNaN(document.frm.year.value) )  {
 	
 	if(document.frm.year.value.indexOf(".") > -1){
	     rdShowMessageDialog("年份为4位数字或1个*!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
 	if(document.frm.year.value.length < 4){
	     rdShowMessageDialog("年份为4位数字或1个*!!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
 }
 
  if(isNaN(document.frm.year.value) )  {
 	if(document.frm.year.value!="*"){
	     rdShowMessageDialog("年份为4位数字或1个*!!!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	}
  }
 */
 /*************************************************/ 
 /*
 if(document.frm.month.value=="")  {
     rdShowMessageDialog("请输入月份!");
     document.frm.month.value = "";
     document.frm.month.focus();
     return false;
 }
 if(!isNaN(document.frm.month.value) )  {
 	
 	if(document.frm.month.value.indexOf(".") > -1){
	     rdShowMessageDialog("月份为2位数字或1个*!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
 	if(document.frm.month.value.length < 2){
	     rdShowMessageDialog("月份为2位数字或1个*!!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
	
	if(document.frm.month.value > 12){
	     rdShowMessageDialog("月份应小于12!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
 }
 
  if(isNaN(document.frm.month.value) )  {
 	if(document.frm.month.value!="*"){
	     rdShowMessageDialog("月份为2位数字或1个*!!!");
	     document.frm.month.value = "";
	     document.frm.month.focus();
	     return false;
	}
  }
 */
 /************************************************/

  /*
  if(document.frm.begin_time.value=="")  {
     rdShowMessageDialog("请输入开始时间!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.length < 4)  {
     rdShowMessageDialog("开始时间为4位!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.substring(0,2) > 31)  {
     rdShowMessageDialog("开始日期应该小于等于31!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.begin_time.value.substring(2) > 24)  {
     rdShowMessageDialog("开始时间应该小于等于24!");
     document.frm.begin_time.value = "";
     document.frm.begin_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value =="")  {
     rdShowMessageDialog("请输入结束时间!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value.length < 4)  {
     rdShowMessageDialog("结束时间为4位!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
    if(document.frm.end_time.value.substring(0,2) > 31)  {
     rdShowMessageDialog("结束日期应该小于等于31!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  
  if(document.frm.end_time.value.substring(2) > 24)  {
     rdShowMessageDialog("结束时间应该小于等于24!");
     document.frm.end_time.value = "";
     document.frm.end_time.focus();
     return false;
  }
  */
 
 	/**** update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 begin ****/
  if(document.frm.begin_year.value > document.frm.end_year.value) {
     rdShowMessageDialog("开始时间年份不能大于结束时间年份!");
     return false;
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value > document.frm.end_month.value) {
  		rdShowMessageDialog("开始时间月份不能大于结束时间月份!");
  		return false;
  	}
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value == document.frm.end_month.value) {
  		if(document.frm.begin_day.value > document.frm.end_day.value) {
  			rdShowMessageDialog("开始时间日期不能大于结束时间日期!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.begin_month.value == "02") {
  	if((document.frm.begin_year.value%4==0 && document.frm.begin_year.value%100!=0)||(document.frm.begin_year.value%100==0 && document.frm.begin_year.value%400==0)) {
  		if(document.frm.begin_day.value > 29) {
  			rdShowMessageDialog("开始时间2月份日期不能大于29天!");
  			return false;
  		}
  	} else {
  		if(document.frm.begin_day.value > 28) {
  			rdShowMessageDialog("开始时间2月份日期不能大于28天!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.end_month.value == "02") {
  	if((document.frm.end_year.value%4==0 && document.frm.end_year.value%100!=0)||(document.frm.end_year.value%100==0 && document.frm.end_year.value%400==0)) {
  		if(document.frm.end_day.value > 29) {
  			rdShowMessageDialog("结束时间2月份日期不能大于29天!");
  			return false;
  		}
  	} else {
  		if(document.frm.end_day.value > 28) {
  			rdShowMessageDialog("结束时间2月份日期不能大于28天!");
  			return false;
  		}
  	}
  }
  
  if(document.frm.begin_month.value == "04" || document.frm.begin_month.value == "06" || document.frm.begin_month.value == "09" || document.frm.begin_month.value == "11") {
		if(document.frm.begin_day.value > 30) {
			rdShowMessageDialog("开始时间为4, 6, 9, 11月时日期不能大于30天!");
			return false;
  	}
  }
  
  if(document.frm.begin_month.value == "04" || document.frm.begin_month.value == "06" || document.frm.begin_month.value == "09" || document.frm.begin_month.value == "11") {
  	if(document.frm.end_day.value > 30) {
			rdShowMessageDialog("结束时间为4, 6, 9, 11月时日期不能大于30天!");
			return false;
  	}
  }
  
  if(document.frm.begin_year.value == document.frm.end_year.value) {
  	if(document.frm.begin_month.value == document.frm.end_month.value) {
  		if(document.frm.begin_day.value == document.frm.end_day.value) {
  			if(document.frm.begin_hour.value > document.frm.end_hour.value) {
  				rdShowMessageDialog("开始时间小时不能大于结束时间小时!");
  				return false;
  			}
  		}
  	}
  }
  /**** update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 end ****/
  
	document.frm.submit();
	            
}
function doclear() {
 	frm.reset();
}

 </script> 
 
<title>黑龙江BOSS-节假日配置</title>
</head>
<BODY>
<form action="g636_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">节假日配置</div>
		</div>  
  <table cellspacing="0">
  	<tr>
  	  <td align="left" class="blue" width="15%">地&nbsp;&nbsp;市&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
          	<%=region_options%>                   
          </select><font color="#FF0000">*</font>
      </td>     
      <td align="left" class="blue" width="15%">客&nbsp;&nbsp;户&nbsp;&nbsp;等&nbsp;&nbsp;级:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="level" size="10" maxlength="1" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*（3－7，三星至五星钻）</font>
      </td>        
    </tr>
    <!---- update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 begin ---->
    <tr>
    	<td align="left" class="blue">开&nbsp;&nbsp;始&nbsp;&nbsp;时&nbsp;&nbsp;间:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="begin_year"><%=year_options%></select> 年 
    		<select style="width:8%" name="begin_month"><%=month_options%></select> 月 
    		<select style="width:8%" name="begin_day"><%=day_options%></select> 日 
    		<select style="width:8%" name="begin_hour"><%=hour_options%></select> 时 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		例&nbsp;&nbsp;如:&nbsp;&nbsp;&nbsp;2016050100(2016年5月1日0点开始)
    	</td>
    	<td align="left" class="blue">结&nbsp;&nbsp;束&nbsp;&nbsp;时&nbsp;&nbsp;间:&nbsp;&nbsp;&nbsp;
    		<select style="width:10%" name="end_year"><%=year_options%></select> 年 
    		<select style="width:8%" name="end_month"><%=month_options%></select> 月 
    		<select style="width:8%" name="end_day"><%=day_options%></select> 日 
    		<select style="width:8%" name="end_hour"><%=hour_options%></select> 时 
    		<font color="#FF0000">*</font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		例&nbsp;&nbsp;如:&nbsp;&nbsp;&nbsp;2016050323(2016年5月3日23点59:59结束)
    		<!--
    		<select>
    			<option <% if(tV=="01"){out.print("selected='selected'");}%>>01</option>
    			<option <% if(tV=="02"){out.print("selected='selected'");}%>>02</option>
    		</select>-->
    	</td>
    </tr>
    <!---- update by zhangleij 2016-02-15 关于星级客户节假日免停机前台界面优化的需求 end ---->
    
    <!--
    <tr>
      <td align="left" class="blue" width="15%">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="year" size="10" maxlength="4" ><font color="#FF0000">*</font>格式：YYYY可配置为*
      </td>
      <td align="left" class="blue" width="15%">月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="month" size="10" maxlength="2" ><font color="#FF0000">*</font>格式：MM可配置为*
      </td>   
    </tr>
    
    <tr>
      <td align="left" class="blue" width="15%">开始日期时间:&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="begin_time" size="10" maxlength="4" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>例如：0501(5日1点开始)
      </td>
      <td align="left" class="blue" width="15%">结束日期时间:&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="end_time" size="10" maxlength="4" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>例如：0524(5日24点结束)
      </td>   
    </tr>
    -->
    
    <tr>
      <td align="left" class="blue" width="15%">假&nbsp;&nbsp;日&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="holiday_name" size="20" maxlength="10" >
        <font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">操&nbsp;&nbsp;作&nbsp;&nbsp;说&nbsp;&nbsp;明:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="op_note" size="20" maxlength="20" >
        <font color="#FF0000">*</font>
      </td>   
    </tr>
    
    
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="确认" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
  <div class="title">
			<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>地市名称</th>
        <th>客户等级</th>   
        <th>开始日期时间</th>    
        <th>结束日期时间</th> 
        <th>假日名称</th> 
        <th>录入工号</th>  
        <th>操作时间</th> 
        <th>备注</th> 
        <th>操作</th>          
      </tr>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   if(return_code.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][0]%></td>
        <td><%=tempArr[i][1]%></td>
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
        <td><%=tempArr[i][7]%></td>
        <td><a href="g636_3.jsp?region_code=<%=tempArr[i][0]%>&ilevel=<%=tempArr[i][1]%>&begin_ymdh=<%=tempArr[i][2]%>&end_ymdh=<%=tempArr[i][3]%>" onclick= "return   confirm( '确定删除选中的记录吗？ '); "> 删除</a>
            <a href="g636_4.jsp?region_code=<%=tempArr[i][0]%>&ilevel=<%=tempArr[i][1]%>&begin_ymdh=<%=tempArr[i][2]%>&end_ymdh=<%=tempArr[i][3]%>" onclick= "return   confirm( '确定修改选中的记录吗？ '); "> 修改</a></td>
      </tr>
<%}}

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("信息查询出错!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}
%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

