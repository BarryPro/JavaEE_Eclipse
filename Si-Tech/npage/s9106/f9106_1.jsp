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
    String opCode = "9106";
    String opName = "SP企业信息审核";
    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); //定义session
    //String[][] baseInfoSession = (String[][])arrSession.get(0);
    //String[][] otherInfoSession = (String[][])arrSession.get(2);
    //String[][] pass = (String[][])arrSession.get(4);
    String loginPasswd  = (String)session.getAttribute("password");       //取操作员密码
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String op_name ="SP企业信息审核"; 
    
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
    if(!check(document.frm)){
        	return false;			
        }
  if(document.frm.verify_code.value==0){
	frm.action="f9106_2.jsp";
  frm.submit();
  }
 if(document.frm.verify_code.value==1){
	frm.action="f9106_3.jsp";
  frm.submit();
  }
  if(document.frm.verify_code.value==2){
	frm.action="f9106_4.jsp";
  frm.submit();
  }
}
</script>	
</head>
<BODY>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">SP企业信息审核</div>
</div>
<table cellSpacing="0">       
          <tr> 
            <td class=blue>操作类型</td>
            <td colspan="4"> 
              <div align="left"> 
               <select size=1 name=verify_code >                
                 <!--<option value="0">修改</option>-->
                 <option value="1">单条审核</option>
                 <option value="2">批量审核</option>
               </select>
              </div>
            </td>
          </tr>
          <tr> 
            <td class=blue nowrap>查询方式</td>
            <td nowrap colspan="4"> 
              <div align="left"> 
               <select size=1 name=verify_code2 >                
                 <option value="0">SP代码</option>
                 <option value="1">SP名称</option>
                 <option value="2">全部</option>
               </select>
              </div>
            </td>
          </tr>
          <tr>
            <td class=blue nowrap>查询内容</td>
            <td nowrap colspan="4">
                <input name="message" type="text" maxlength="30" id="message" value="" v_type="string">
                </td>
          </tr>
          <tr>
          	<td nowrap colspan="5" id="footer">
          		 <div align="center">
          	   <input name="select" class="b_foot" type="button"  value="查询" onClick="conf()">
               </div>
             </td>
          </tr>
</table>          	
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
