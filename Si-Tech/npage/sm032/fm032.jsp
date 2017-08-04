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
      	rdShowMessageDialog('����������һ����ѯ������',1);
      	return false;
      }
      if(!check(frm))  return false;
			var getdataPacket = new AJAXPacket("fm032_qry.jsp","���ڻ�����ݣ����Ժ�......");
     	getdataPacket.data.add("phoneNo",phoneNo);
		  getdataPacket.data.add("opCode",seleType);
		  getdataPacket.data.add("cardNo",cardNo);
			core.ajax.sendPacketHtml(getdataPacket,lingyinhequery,true);
			getdataPacket = null;
    }
    function lingyinhequery(data){
			//�ҵ���ӱ���div
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
			      <td class="blue" width="15%">��ѯ��ʽ</td>
			      <td colspan="3">
						  <select id="seleType">  
						  	<option value="m033">ͼƬ��Ϣ��ѯ</option>
						  	<option value="m034">������Ϣ��ѯ</option> 
						  </select>
	          </td>
		      </tr>
					<tr>
						<td class="blue" width="15%">�ֻ�����</td>
						<td width="35%">
							<input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" value="" />
						</td>
			    	<td class="blue" width="15%">֤������</td>
						<td width="35%">
							<input type="text" id="cardNo" name="cardNo" value="" />
						</td>
		      </tr>
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="ȷ��" onclick="querys()" />		
                &nbsp;
                 <input type="button" name="reset" class="b_foot" value="���" onclick="returnmsg()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
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