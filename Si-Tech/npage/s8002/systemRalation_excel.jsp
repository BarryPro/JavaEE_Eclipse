<%
  /*
   * 功能: 功能关系维护
　 * 版本: 1.8.2
　 * 日期: 2008/10/10
　 * 作者: tancf
　 * 版权: sitech
	 *update:zhanghonga@2008-04-23
　*/
%>
<%
		String opCode = "K60"  ;
		String opName = "功能关系维护" ;

%>
<%@ page contentType="text/html;charset=gb2312"%>
<% response.setContentType("application/vnd.ms-excel;charset=GBK"); 
   response.setHeader("Content-disposition","inline;   filename=regierSt.xls"   ); 
   String xh="序号";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%   
		String    errCode ="";
		String    errMsg = " ";
		String return_sequence_no = "";
		String return_sequence_no1 = "";
%>	

	<wtc:service name="sRK160SelAll" outnum="7">
	</wtc:service>
	<wtc:array id="rows"  start="2"  length="2" scope="end"/>	
	<wtc:array id="rows1"  start="4"  length="3" scope="end"/>
	<%
 errCode=retCode;
 errMsg = retMsg;
   if((rows != null) && rows.length!=0)
  {
	return_sequence_no =rows[0][0];
	return_sequence_no1 =rows[0][1];  
  }
  
  %>
  


<html>
<head>
<title>吉林BOSS-功能关系维护</title>
<script language="JavaScript">
	$(document).ready(
	function()
	{
		$("td").not("[input]").addClass("blue");
		$("td:not(#footer) input:button").addClass("b_text");
		$("#footer input:button").addClass("b_foot");
		$("input:text[@readonly]").addClass("InputGrey");
		}
	);
function gohome()
{
document.location.replace("s2200.jsp");
}
</script>

<script language="javaScript">
	 
	 function doProcess(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("处理成功!");
	    	}else{
	    		alert("处理失败!");
	    		return false;
	    	}
	    }
	 }
	 
   function doCheck(box)
	 {   
	 var funcid = box.name;
	  var funcrel= box.value;
	  if(box.checked)
	 {
	 var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/systemRalation_save.jsp","正在处理,请稍后...");
	 }
	 else
	 {
	 var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/systemRalation_Del.jsp","正在处理,请稍后...");
	 }
     chkPacket.data.add("retType" ,  "chkExample");
     chkPacket.data.add("funcid" ,   funcid );
     chkPacket.data.add("funcrel" ,   funcrel );
     core.ajax.sendPacket(chkPacket);
	 chkPacket =null;
		
	}
	
	function submitConfig()
	 {   
	   var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/getRalationArray.jsp","正在处理,请稍后...");
       chkPacket.data.add("retType" ,  "chkExample");
       core.ajax.sendPacket(chkPacket);
	   chkPacket =null;
	 }
	
</script>
</head>
<body>
<form action="publicContactId_save.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
   <div id="Operation_Table">
   	<div class="title">功能关系维护
   	<div align="right">
    <input class="b_text" name="button1" type="button" value="生成js文件" onclick="submitConfig()">
   	</div>
   	</div>
    <table cellspacing=0>
        
       <%
    	for(int i=0;i<rows.length;i++){
    	int k=0;
		%>
      <tr>
        <td width=1% class="blue" ><%=rows[i][1] %></td>
        <td width=99% class="blue">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			<%
				 for(int j=i*(rows.length-1);j<(i+1)*(rows.length-1);j++){
					if(k%5==0){
			%>
			 <tr>
			<%
			}
			%>
				<td>
					<input type ="checkbox" name='<%=rows[i][0] %>' value='<%=rows1[j][0] %>' 
					<%if(rows1[j][2].equals("1")){%> checked<%}%>
					onclick="doCheck(this);" 
					> <%=rows1[j][1]%>
				</td>
			 <% 
			 k++;
			 if(k%5==0){
			 %>
			 </tr>
			 <%
						}
			} 
         %>
         </table>
        </td>
      </tr>
      <%
		}
	  %>
  </table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>
</html>

