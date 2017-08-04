<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String iLoginPwd = (String) session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");

%>

  <script language="javascript">
   
   		 function qry() {	 	
						    var getdataPacket = new AJAXPacket("fm092_qry.jsp","正在获得数据，请稍候......");
					      var phoneNo =$("#phoneNo").val();
					     	getdataPacket.data.add("phoneNo",phoneNo);
								core.ajax.sendPacketHtml(getdataPacket,squerys,true);
								getdataPacket = null;
			}

		function frmCfm(){
      frm.submit();
      return true;
    }
    
    function deleteoffer(phoneno,tixingphone){
    	
			 if(confirm("确定删除此条记录？"))
			{
			document.frm.action="fm092Cfm.jsp?phoneNo="+phoneno+"&tixingphone="+tixingphone+"&optype=del";
			document.frm.submit(); 
			}else {

			}	
}

     function add() {	 	
				var phoneNo =$("#phoneNo").val();
				var tixingphone =$("#tixingphone").val();
				
				if(tixingphone.trim()=="") {
					rdShowMessageDialog("增加时提醒号码不能为空！",1);
					return false;
				}
				
				if(checkElement(document.all.tixingphone)==false) {
					return false;
				}
				
				
				if($("#iContactAddr").val().trim()=="") {
					rdShowMessageDialog("增加时地址不能为空！",1);
					return false;
				}
				
				document.frm.action="fm092Cfm.jsp?phoneNo="+phoneNo+"&tixingphone="+tixingphone+"&optype=add";
				document.frm.submit(); 	      


			}
    
			
		function squerys(data){
				//找到添加表格的div
				var markDiv=$("#lingyinhe"); 
				markDiv.empty();
				markDiv.append(data);				
		}

    
    function reSetTab(){
      window.location.href="fm092.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
		</script>
		<body>
		  <form name="frm" method="POST" action="fm092Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="15%">数据卡号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="15%">提醒号码</td>
			      <td>
						  <input type="text" id="tixingphone" name="tixingphone"   	v_type="mobphone" maxlength="11" onblur="checkElement(this)"  value =""/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
					<tr>
						<td class="blue" width="15%">联系人地址</td>
						<td colspan="3">
						  <input type="text" id="iContactAddr" name="iContactAddr"  maxlength="120"   value ="" size="100" />
			        <font class="orange">*</font>
	          </td>
					</tr>
          
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="查询" onclick="qry()" />		
                &nbsp;
                <input type="button" name="quchoose" class="b_foot" value="增加" onclick="add()" />		
                &nbsp;
                <input type="button" name="quchoose" class="b_foot" value="清除" onclick="reSetTab()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        		<br>
		<div id="lingyinhe"></div>
		
		
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />

      </form>
    </body>
</html>