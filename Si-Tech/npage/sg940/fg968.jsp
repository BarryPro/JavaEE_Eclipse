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
	String beizhu=activePhone+"�������п�����ǩԼ��ѯ";
	String password    = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

  <script language="javascript">
    var ioprcode="";
    function save(){
    	
		  var fuphoneNo = $("#fuphoneNo").val();
		  if(fuphoneNo.trim() ==""){//����֤
		  rdShowMessageDialog("���Ų���Ϊ�գ�",1);
		  return false;
		  }

    frmCfm();
    
  }
    function frmCfm(){
      frm.submit();
      return true;
    }

	function save() {
		  var fuphoneNo = $("#fuphoneNo").val();
		  if(fuphoneNo.trim() ==""){//����֤
		  rdShowMessageDialog("���Ų���Ϊ�գ�",1);
		  return false;
		  }
			frmCfm();
	}
	
			function frmCfm(){
      frm.submit();
      return true;
    }

 
 function checkfh() {
		  var yhzh = $("#yhzh").val();
		  var phoneNo = $("#phoneNo").val();
		  var fuphoneNo = $("#fuphoneNo").val();
		  

		  if(fuphoneNo.trim() ==""){//����֤
		  rdShowMessageDialog("���Ų���Ϊ�գ�",1);
		  return false;
		  }
		  
        var packet = new AJAXPacket("fg968_check.jsp","���ڻ�����ݣ����Ժ�......");
      	packet.data.add("phoneNo","<%=activePhone%>");
      	packet.data.add("fuphoneNo",fuphoneNo);
      	packet.data.add("opCode","<%=opCode%>");
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;
      
			
	}
function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      if(retcode != "000000"){
        rdShowMessageDialog("������룺" + retcode + "��������Ϣ��" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
      	rdShowMessageDialog("У��ɹ�",2);
 				document.all.quchoose.disabled=false;
      }
    }
    
		</script>
		<body>
		  <form name="frm" method="POST" action="fg968Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
			    
          <tr>
          				      <td class="blue" width="15%">���ź���</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			           </td>
	          
	                    	<td class="blue" width="15%">���ź���</td>
			      <td>
						  <input type="text" id="fuphoneNo" name="fuphoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" />
			         </td>
	        </tr>
         
          
        </table>

        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">
              	<input type="button" name="jiaoyan" class="b_foot" value="У��" onclick="checkfh()" />		
                &nbsp;	
                <input type="button" name="quchoose" class="b_foot" value="ȷ��&��ӡ" onclick="save()" disabled/>		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      </form>
    </body>
</html>