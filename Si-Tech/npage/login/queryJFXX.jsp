<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>      
<%
	String phoneNo = request.getParameter("phoneNo");
	String idNo = request.getParameter("idno");
%>

<HTML>
<HEAD>
<TITLE>缴费记录查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>
	<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<script language = "javascript">
function query(){
 
		 
		var phoneNo= document.frm.phone_no.value;
		var path = 'showJFXX.jsp?phoneNo=<%=phoneNo%>'+'&beginDate='+document.frm.beginDate.value+'&endDate='+document.frm.endDate.value+'&idNo=<%=idNo%>';
		//alert('path is '+path); 
		document.frames["iFrame1"].document.body.innerText = "";
		document.getElementById("iFrame1").src = path;         
        document.all.showCustWTab1.style.display="";
 
	    
}
function getDate(){
	var date = new Date();//.format("yyyyMMdd");
	
	//document.getElementById("edate").value = date.getYear()+date.getMonth()+date.getDate();
	//alert(date.getYear()+date.getMonth()+date.getDate);
}
//test
function GetDateT()
 {
	  var d,s;
	  d = new Date();
	  s = d.getYear().toString() ;             //取年份
	  
	  //取月份
	  if(d.getMonth()<9){
		s = s + "0"+((d.getMonth() + 1).toString()) ;
	  }
	  else{
		s = s + ((d.getMonth() + 1).toString()) ;
	  }
	           //取日期
	  if(d.getDate()<10){
		  s = s+"0"+d.getDate().toString() ;
	  }
	  else{
		  s = s+d.getDate().toString() ;
	  }
	  document.getElementById("edate").value=s ; 
	  //开始时间 超级麻烦的算法
	  var s1,s2;
	  
	  
		  if(d.getMonth()>5 ){ // 这个值 稍后再算下
			s2 = d.getMonth() + 1-6;
			if(s2<10){
			 s2 = "0"+s2.toString();
			}
			s1 = d.getYear().toString() ; 
		  }
		  else if(d.getMonth()< 5){
		    s2 = d.getMonth() + 1+12-6;
			if(s2<10){
				s2 = "0"+s2.toString();
			}
			s1 = (d.getYear()-1).toString() ; 
		  }
	      else{
			  s2 = 12;
			  s1 = (d.getYear()-1).toString() ; 
		  }
  
  s1 = s1 + s2 ;//取月份
   	
           //取日期
  if(d.getDate() <10 ){
	s1 = s1+ "0"+d.getDate().toString() ;
  }
  else{
	s1 = s1+ d.getDate().toString() ;
  }
  document.getElementById("bdate").value=s1 ; 
  //alert('full is '+s);	
 } 
	function query2(){
		var path = "f1500_wPayQry.jsp?phoneNo=<%=phoneNo%>&id_no=<%=idNo%>&beginTime="+document.frm.beginDate.value+"&endTime="+document.frm.endDate.value;
		document.getElementById("iFrame2").src = path;
		document.all.showCustWTab2.style.display="";
	}
</script>
<BODY onload = "GetDateT(),query()">
<form name="frm" method="post" action="" >      
 
	<DIV id="Operation_Table">      	
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>
      <table cellspacing="0">
      <tr align="center"> 
        <td>查询号码</td>
		<td><input name="phone_no" type="text" value = "<%=request.getParameter("phoneNo")%>"  readonly="readonly"></td>
		 
		<td>开始日期</td>
		<td><input name="beginDate" type="text" id="bdate"  onclick="selectDateNew(beginDate)" onkeydown ="if(event.keyCode==13)
     {
        document.getElementById('enter').focus();
	 }"></td>
		 
		<td>结束日期</td>
		<td><input name="endDate" type="text"  id="edate"   onclick="selectDateNew(endDate)"  onkeydown ="if(event.keyCode==13)
     {
        document.getElementById('enter').focus();
	 }"></td>
		<td>
		<input type="button" class="b_text" id="enter" value="查询" onclick="query()">
		</td>
      </tr>

	  
      <td id="footer" colspan="7"> 
       
      </td>
    </tr>
  </table>
    </DIV>
			<div id="showCustWTab1" style="display:none">
				<iframe name="iFrame1" id="iFrame1" src=""  width="100%" height="350px" frameborder="0" >
				</iframe>	 
			</div>

<input type="button" class="b_foot_long" value="用户交费信息明细" onclick="query2()" style="margin-left:10px" /> 
<!------------------------>	
<div id="showCustWTab2" style="display:none">
	<iframe name="iFrame2" id="iFrame2" src=""  width="100%" height="350px" frameborder="0" onload=""  ></iframe>	 
</div>
<input type = "hidden" name = "contractNo" value = "<%=request.getParameter("contactNo")%>">
<input type = "hidden" name = "phone_no" value = "<%=request.getParameter("phone_no")%>">
</form>	
</body>
</html>
