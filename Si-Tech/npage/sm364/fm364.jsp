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
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");

%>
  
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
  onload=function()
  {

  
  }
				
 
    
		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
			


 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	
	
		function doquery()
		{
		
		  var querymsg = $("#querymsg").val();
		  var querymsg2 = $("#querymsg2").val();
			if(querymsg2.trim()==""){
				rdShowMessageDialog("请输入查询条件信息！",1);
				return false;
			}
    
        var myPacket = new AJAXPacket("fm364Qry.jsp","正在查询信息，请稍候......");
        myPacket.data.add("querymsg",querymsg);
        myPacket.data.add("querymsg2",querymsg2.trim());
				core.ajax.sendPacketHtml(myPacket,querinfo,true);
				getdataPacket = null;		
		
		}
		
		
				function schange()
		{
			  $("#showTab").empty();
				$("#querymsg2").val("");
		}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
              
       <table id="add" style="display:block">
       	        <tr>
					        <td class='blue' width=16%>查询条件</td>
					        <td>
					        <select align="left" id="querymsg"  width=50 onchange="schange()">
									<option class="button" value="1">手机号码</option>
									<option class="button" value="2">流量卡序号</option>   
									<option class="button" value="3">集团编码</option>       
								 </select>

					        </td>					        

					        </tr>  
					        
       	        <tr>
					        <td class='blue' width=16%>条件信息</td>
					        <td>

								<input type="text" value="" name="querymsg2" id="querymsg2" size="30"   maxlength="40" />
								<font class="orange">*</font>
								<input  name="quchoose" id="quchoose" class="b_text" type=button value=查询  onclick="doquery()" >

					        </td>
					        


					        </tr>					          			
   							        	
        			
        				
              </table>

        				  

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
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