<%
  /*
   * �������ƶ�ʡ���̻�ϵͳ
   * �ƶ��̳ǿ���������� 
   * ����: 2013/11/29
   * ����: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

/**
sg530Qry
*@         iLoginAccept              	��ˮ
 *@        iChnSource              	   	������ʶ
 *@        iOpCode                 		��������
 *@        iLoginNo              	   	����
 *@        iLoginPwd                   	��������
 *@        iPhoneNo              	   	�ֻ�����
 *@        iUserPwd              	   	��������
 *@        iOpNote              	   	��ע
 *@        iFlag              	   		0д��1��д��������2����¼��3���4���ʧ��5����ʧ�ܻ��û���������
*/
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<wtc:service name="sg900Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:param value="<%=accept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value=""/>
  	<wtc:param value=""/>
</wtc:service>

<wtc:array id="result" scope="end" />

<title><%=opName%></title>

<script language="javascript">
  var records = [];

  var Constants = {
  		CURRENT_MONTH: '<%=currentMonth%>',
  		CURRENT_YEAR: '<%=currentYear%>',
  		OP_CODE			: '<%=opCode%>',
  		CUST_NAME   : '',
  		ACCEPT   : '<%=accept%>'
  };
  
  function Page(){
      this.initOthers();
  }
  
  Page.prototype.initOthers = function () {
      var self = this;
      
			$("#closeBtn").click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.closeWindow();
      });
      
      $('.draw').click(function(e){
 			e.stopPropagation();
            e.preventDefault();
            
            self.drawOrder($(this));
 	  });
  }
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }
  
 	
  Page.prototype.drawOrder = function (button) {
  		var t = '',self = this;
  		
  		var myPacket = new AJAXPacket("orderDraw.jsp","���������ύ�����Ժ�...");
			myPacket.data.add("accept",Constants.ACCEPT);
			myPacket.data.add("opCode", '<%=opCode%>');
			myPacket.data.add("phoneNo", $(button).attr('phoneNo'));
			
			core.ajax.sendPacket(myPacket, function(packet){
					$(button).attr('disabled', 'true');
					
					var errorCode = packet.data.findValueByName('errorCode');
					var errorMsg = packet.data.findValueByName('errorMsg');
					
					if ("000000" == errorCode){
							rdShowMessageDialog("�����ɹ���");
					} else {
							rdShowMessageDialog("����ʧ�ܣ�" + errorCode + errorMsg, 1);
					}
			});
			
			myPacket = null;
  }

  $(function(){
      var page = new Page();
  });
  
	function doreturn(){
		window.location.href = "/npage/sm001/fm002Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</head>
<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">������Ϣ</div>
  </div>
  
  <table cellspacing="0">
		<tr> 
			<th>�ֻ�����</th>		
			<th>����</th>
		</tr>
		
		<tbody id="targetArea">
 	      <%for(int i = 0; i < result.length; i ++){%>
 	      <tr>
			<td><%=result[i][0]%></td>
			<td>
			  <input type="button" value="����" class="b_text draw" phoneNo="<%=result[i][0]%>" line="<%=i%>"/>	
			</td>
		  </tr>
		  <%}%>
		</tbody>
		
    <tr>
      <td colspan="6" align="center" id="footer">
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>