<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.*"%>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String currentTime =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());//当前日期
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept" /> 
<HEAD><TITLE>异常订单处理</TITLE>
</HEAD>
<SCRIPT type=text/javascript>	
function g(objectId) 
{
	if (document.getElementById && document.getElementById(objectId))
	{
		return document.getElementById(objectId);
	}
	else if (document.all && document.all[objectId])
	{
		return document.all[objectId];
	}
	else if (document.layers && document.layers[objectId])
	{
		return document.layers[objectId];
	}
	else 
	{
		return false;
	}
}

function doSearch(){
	var ordernum = g("ordernum").value.trim(); //查询条件
	var servno = document.all.servno.value; //条件值
	var login_no = document.all.login_no.value; //条件值
	var optime = document.all.optime.value; //条件值
	var func_code = document.all.func_code.value; //条件值
	var orderid = document.all.orderid.value; //条件值
	var ordervalue = document.all.ordervalue.value; //条件值
	
	//if(ordernum==""){
	//    rdShowMessageDialog("条件值不能为空！",0);
	//    document.all.ordernum.focus();
	//    return false;
	//}
	//$("#searchResult").toggle();
	var packet = new AJAXPacket("searchData.jsp","请稍后...");
	packet.data.add("ordernum",ordernum); 
	packet.data.add("servno",servno); 
	packet.data.add("login_no",login_no); 
	packet.data.add("optime",optime); 
	packet.data.add("func_code",func_code); 
	packet.data.add("orderid",orderid); 
	packet.data.add("ordervalue",ordervalue);
	core.ajax.sendPacketHtml(packet,doSearchData);
	packet = null;
}
	
function doSearchData(data){
	$("#searchResult").html(data);
}
	
function doSee(orderid){
		//var ordernum = g("ordernum").value.trim(); //查询条件
		//$("#searchResult").toggle();
		var packet = new AJAXPacket("searchDatadetail.jsp","请稍后...");
		packet.data.add("ordernum",orderid); 
		core.ajax.sendPacketHtml(packet,doSeeData);
		packet = null;
	}
	
	function doSeeData(data){
		$("#searchResultDetail").html(data);
	}
	
	function doRedo(){
		
		if(rdShowConfirmDialog("请确认是否重新执行？")==1){
		
		var ordernum = g("ordernum").value.trim(); //查询条件
		var packet1 = new AJAXPacket("ajax_doRedo.jsp","请稍后...");
			packet1.data.add("retType" ,"queryPrt");
      packet1.data.add("ordernum",ordernum); 
			core.ajax.sendPacket(packet1);
			packet1 =null;
			
		}
	}
	
function doModify(flag){	  
	  var structvalue=$("#searchResultDetail tr:eq("+flag+")").find("td:eq(5)").html();
	  var CONTENTID=$("#searchResultDetail tr:eq("+flag+")").find("td:eq(1)").html();
	  var ordernum = g("ordernum").value.trim(); //查询条件
	  var newstructvalue="";
	  
	  var h=300;
		var w=600;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; scroll:no;resizable:no;location:no;status:no;help:no";
		var ret=window.showModalDialog("modifyInfo.jsp?&structvalue="+structvalue,"",prop);
		if(typeof(ret) != "undefined" && ret != ""){		
			newstructvalue=ret;
		}else{
			return false;
		}

		var packet1 = new AJAXPacket("ajax_doModify.jsp","请稍后...");
			packet1.data.add("retType" ,"Modify");
      packet1.data.add("ordernum",ordernum); 
      packet1.data.add("CONTENTID",CONTENTID); 
      packet1.data.add("newstructvalue",newstructvalue); 
			core.ajax.sendPacket(packet1);
			packet1 =null;
	}

function doProcess(packet){
	var retType=packet.data.findValueByName("retType");
	var retCode=packet.data.findValueByName("retCode");
	var retMsg=packet.data.findValueByName("retMsg");

	if(retType == "queryPrt"){
 		if(parseInt(retCode) != '0'){
				rdShowMessageDialog("["+retCode+":] "+retMsg);
			}else{
				rdShowMessageDialog("订单重新执行成功！",2);
				location = location; //冲正成功后刷新页面取得新流水
			}
	}
	if(retType == "Modify"){
 		if(parseInt(retCode) != '0'){
				rdShowMessageDialog("["+retCode+":] "+retMsg);
			}else{
				rdShowMessageDialog("订单修改成功！",2);
        doSee();
			}
	}
}
  
</SCRIPT>
<body>
<FORM method=post name="frm1102">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询条件</div>
</div>
          <table cellspacing=0>
                <TR> 
                	<td class='blue' nowrap>订单编号</Td>
                  <TD> 
                  	 <input type="text" name="ordernum"  onchange="" value="" />
	                  
                  </TD>
	                	 <td class='blue' nowrap>服务号码</Td>
	                  <TD colspan='3'> 
	                    <input type="text" name="servno"  onchange="" value="" />
	                  </TD>
                </TR>
                <tr id="">
                	<td class='blue' nowrap>操作工号</Td>
                  <TD> 
                   	 <input type="text" name="login_no"  onchange="" value="" />
	                    <!--&nbsp;<font class='orange'>*</font>-->
                  </TD>
                  <td class='blue' nowrap>业务代码</Td>
                  <TD> 
                    <input type="text" name="func_code"   value="" >
                  </TD>
                  <td class='blue' nowrap>受理日期</Td>
                  <TD> 
                    <input type="text" name="optime"  v_type='day' value="<%=currentTime%>" maxlength="8">
                  </TD>
                </tr>
                <tr id="">
                	<td class='blue' nowrap>订单节点ID</Td>
                  <TD  > 
                   	 <input type="text" name="orderid"  onchange="" value="" />
	           
                  </TD>
                  <td class='blue' nowrap>订单节点值</Td>
                  <TD  colspan='3'> 
                    <input type="text" name="ordervalue" id="modeFlag"  value="" >
                  </TD>
                </tr>
           </table>
        </div>
       <div id="footer">                
          <input class="b_foot" onclick="doSearch()"  type=button value="查询"/>
          <!--input class="b_foot" id="confirm" onclick="qryContent()"  type=button value="确认&打印"/-->
          <input class="b_foot" name="quit"  onclick="removeCurrentTab()"  type=button value="关闭"/>
	  	</div>
    	<div id="searchResult"></div>
    	<div id="searchResultDetail"></div>


  <!------------------------> 
<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
</html> 	