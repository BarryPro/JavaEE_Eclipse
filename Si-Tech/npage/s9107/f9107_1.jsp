<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    String opCode = "9107";
    String opName = "SP业务信息审核";
        //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); //定义session
        //String[][] baseInfoSession = (String[][])arrSession.get(0);
        //String[][] otherInfoSession = (String[][])arrSession.get(2);
        //String[][] pass = (String[][])arrSession.get(4);
    String loginPasswd  = (String)session.getAttribute("password");       //取操作员密码
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String op_name ="SP业务信息审核"; 
    
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    
    String region_Code = orgCode.substring(0,2);
    
    String currentYear = (String)session.getAttribute("currentYear");
    //获取当前年月日
    Date currentDate = new Date(System.currentTimeMillis());
    SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
    String systemTime = formatter.format(currentDate);
    
   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<script language=javascript>
	
	function conf()
{		  
  if(document.frm.verify_code.value==0){
	frm.action="f9107_2.jsp";
  frm.submit();
  }
 if(document.frm.verify_code.value==1){
	frm.action="f9107_3.jsp";
  frm.submit();
  }
  if(document.frm.verify_code.value==2){
	frm.action="f9107_4.jsp";
  frm.submit();
  }
}
</script>	
</head>
<BODY>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">SP业务信息审核</div>
</div>
<table cellSpacing="0">      
          <tr> 
            <td class=blue> 
            <div align="left">操作类型</div>
            </td>
            <td colspan="4"> 
              <div align="left"> 
               <select size=1 name=verify_code >                
                <!-- <option value="0">修改</option>-->
                 <option value="1">单条审核</option>
                 <option value="2">批量审核</option>
               </select>
              </div>
            </td>
          </tr>         
          	<td nowrap id="footer" colspan="5">
          		 <div align="center">
          	   <input name="select" class="b_foot" type="button"  value="下一步" onClick="conf()">
               </div>
             </td>
          </tr>
</table>          	
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
