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
  String regionCode= (String)session.getAttribute("regCode");
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

  <script language="javascript">
    function querys(){
    	var phoneNo =$("#phoneNo").val();
      var seleType =$("#seleType").val();
      var cardNo =$("#cardNo").val();
      if(phoneNo == "" && cardNo == ""){
      	rdShowMessageDialog('请输入至少一个查询条件！',1);
      	return false;
      }
      if(!check(frm))  return false;
			var getdataPacket = new AJAXPacket("fm032_qry.jsp","正在获得数据，请稍候......");
     	getdataPacket.data.add("phoneNo",phoneNo);
		  getdataPacket.data.add("opCode",seleType);
		  getdataPacket.data.add("cardNo",cardNo);
			core.ajax.sendPacketHtml(getdataPacket,lingyinhequery,true);
			getdataPacket = null;
    }
    function lingyinhequery(data){
			//找到添加表格的div
			var markDiv=$("#lingyinhe"); 
			markDiv.empty();
			markDiv.append(data);
		}
    
    function returnmsg() {
    	window.location.href="fm032.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }

		</script>
		<body>
		  <form name="frm" method="POST" action="fm012Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="15%">查询方式</td>
			      <td colspan="3">
						  <select id="seleType">  
						  	<option value="m033">图片信息查询</option>
						  	<option value="m034">完整信息查询</option> 
						  </select>
	          </td>
		      </tr>
					<tr>
						<td class="blue" width="15%">手机号码</td>
						<td width="35%">
							<input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" value="" />
						</td>
			    	<td class="blue" width="15%">证件号码</td>
						<td width="35%">
							<input type="text" id="cardNo" name="cardNo" value="" />
						</td>
		      </tr>
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="确定" onclick="querys()" />		
                &nbsp;
                 <input type="button" name="reset" class="b_foot" value="清除" onclick="returnmsg()" />		
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
      	<input type="hidden" id="ioprcode" name="ioprcode"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">

      </form>
    </body>
</html>