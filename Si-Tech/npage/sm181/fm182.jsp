<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {

  }
  

 function doCfm(){
 		

				 if(!checkElement(document.all.srv_no)){
						return false;
					}   
	     
         var banlitype = $("#banlitype").val();
	  
	var myPacket = new AJAXPacket("fm182Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("banlitype",banlitype);

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
	
	    

 }
 
  				function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
		
 	function resetPage(){
 		window.location.href = "fm182.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">转让人手机号码</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text"  class="InputGrey" name="srv_no" id="srv_no" v_must=1 v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value ="<%=activePhone%>" onBlur="checkElement(this)" readonly> 
                </div>
            </td>
         
       
         </tr>
         		       <TR  > 
	          <TD width="16%" class="blue">受让人状态</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" >
						<option value="00">全部</option>
						<option value="01">已生效</option>
						<option value="02">待生效</option>
						<option value="03">停用</option>

							</select>
	          </TD>
	        
         </TR> 
         
       



	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="查询" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>