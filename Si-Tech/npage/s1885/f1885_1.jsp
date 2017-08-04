   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-3-17
********************/
%>
              
<%
  String opCode = "1885";
  String opName = "身份证扫描件稽核报表";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.text.SimpleDateFormat"%> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	SimpleDateFormat sdf =   new SimpleDateFormat( "yyyyMMdd" );
    String c_datec = sdf.format(new java.util.Date());
    
%>
  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>身份证扫描件稽核报表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
	function DoList()
	{
		var begindate=document.frm.opdate1.value;					
		var enddate=document.frm.opdate2.value;
		
		var begindate_c = (begindate+"").substring(0,6);
		var enddate_c = (enddate+"").substring(0,6);
		var c = enddate_c - begindate_c;

		if(((begindate+"").substring(6,8))>31||((begindate+"").substring(4,6))>12)
		{
			rdShowMessageDialog("请输入正确的日期",0);
	 					document.frm.opdate1.focus();
            return false;
		}
		
		if(((enddate+"").substring(6,8))>31||((enddate+"").substring(4,6))>12)
		{
			rdShowMessageDialog("请输入正确的日期",0);
	 					document.frm.opdate2.focus();
            return false;
			}
					
 		if((c>=6&&c<89)||c>=95)
 		{
 				rdShowMessageDialog("日期不能相差六个月",0);
	 					document.frm.opdate1.focus();
            return false;
 		}
 			
		if(document.frm.op_code.value=="")
		{
				rdShowMessageDialog("请填写业务代码",0);
	 	document.frm.op_code.focus();
            return false;
			}
  	if(document.frm.workno.value=="")
		{
				rdShowMessageDialog("请填写工号",0);
	 	document.frm.workno.focus();
            return false;
			}
		var cdatec = <%=c_datec%>;
		
			 if(document.frm.opdate2.value>cdatec){
			 	rdShowMessageDialog("结束日期不能大于当前时间",0);
	 	document.frm.opdate2.focus();
            return false;
			}
		
	 if(!forDate(document.frm.opdate1)){
	 	document.frm.opdate1.focus();
            return false;
			}
	 if(!forDate(document.frm.opdate2)){
	 	document.frm.opdate2.focus();
            return false;
			}
			
		if(dateCompare(begindate,enddate)>0)
		{
			rdShowMessageDialog("开始时间不能大于结束时间",0);
			return false;
			}
			
			frm.action="f1885lis.jsp";
			frm.submit();
	}
 function dateCompare(sDate1,sDate2){	
			if(sDate1>sDate2)	//sDate1 早于 sDate2
				return 1;
			if(sDate1==sDate2)	//sDate1、sDate2 为同一天
				return 0;
			return -1;		//sDate1 晚于 sDate2
		}

				
//-->
</script>

</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">身份证扫描件稽核报表</div>
	</div>


        
  <table  cellspacing="0">
    <tr> 
           <td class="blue">业务代码</td>
      <td><input type="text" name="op_code"  id="op_code" value="1100"><font class="orange"> *</font> 
      <td class="blue" width=18%>工号</td>
      <td width=32%>
      	<input type="text" name="workno" type="text"  id="workno"   >  <font class="orange"> *</font> 
      	    
      </td>
    </tr>
    <tr> 
      <td class="blue">操作开始日期</td>
      <td><input name="opdate1"  id="opdate1"  v_format="yyyyMMdd"> <font class="orange"> *&nbsp;格式为:yyyyMMdd</font> 
       </td>
    <td class="blue">操作结束日期</td>
      <td><input name="opdate2"  id="opdate2"  v_format="yyyyMMdd"> <font class="orange"> *&nbsp;格式为:yyyyMMdd</font> 
       </td>
    </tr>
      <td colspan="4" id="footer"> <div align="center" > 
          <input name="IList" type="button"  id="IList" value="列表" onClick="DoList()" class="b_foot">
  
          &nbsp; 
          <input name="back" onClick="removeCurrentTab()" type="button"  value="关闭" class="b_foot">
          &nbsp; </div></td>
    </tr>
  </table>
 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
