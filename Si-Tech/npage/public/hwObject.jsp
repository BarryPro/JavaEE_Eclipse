<%
String workNOAccountType = (String)session.getAttribute("accountType");
System.out.println(" zhouby + workNOAccountType " + workNOAccountType);
if(!"2".equals(workNOAccountType)) { //“2”代表客服
%>
  <OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
  <OBJECT  height="0" width="0" id="IdrControl1" codebase="/ocx/card02.cab#version=1,0,1,1" classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF"></OBJECT>
  <OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<%
}
%>


