<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.*"%>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String currentTime =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());//��ǰ����
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept" /> 
<HEAD><TITLE>�쳣��������</TITLE>
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
	var ordernum = g("ordernum").value.trim(); //��ѯ����
	var servno = document.all.servno.value; //����ֵ
	var login_no = document.all.login_no.value; //����ֵ
	var optime = document.all.optime.value; //����ֵ
	var func_code = document.all.func_code.value; //����ֵ
	var orderid = document.all.orderid.value; //����ֵ
	var ordervalue = document.all.ordervalue.value; //����ֵ
	
	//if(ordernum==""){
	//    rdShowMessageDialog("����ֵ����Ϊ�գ�",0);
	//    document.all.ordernum.focus();
	//    return false;
	//}
	//$("#searchResult").toggle();
	var packet = new AJAXPacket("searchData.jsp","���Ժ�...");
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
		//var ordernum = g("ordernum").value.trim(); //��ѯ����
		//$("#searchResult").toggle();
		var packet = new AJAXPacket("searchDatadetail.jsp","���Ժ�...");
		packet.data.add("ordernum",orderid); 
		core.ajax.sendPacketHtml(packet,doSeeData);
		packet = null;
	}
	
	function doSeeData(data){
		$("#searchResultDetail").html(data);
	}
	
	function doRedo(){
		
		if(rdShowConfirmDialog("��ȷ���Ƿ�����ִ�У�")==1){
		
		var ordernum = g("ordernum").value.trim(); //��ѯ����
		var packet1 = new AJAXPacket("ajax_doRedo.jsp","���Ժ�...");
			packet1.data.add("retType" ,"queryPrt");
      packet1.data.add("ordernum",ordernum); 
			core.ajax.sendPacket(packet1);
			packet1 =null;
			
		}
	}
	
function doModify(flag){	  
	  var structvalue=$("#searchResultDetail tr:eq("+flag+")").find("td:eq(5)").html();
	  var CONTENTID=$("#searchResultDetail tr:eq("+flag+")").find("td:eq(1)").html();
	  var ordernum = g("ordernum").value.trim(); //��ѯ����
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

		var packet1 = new AJAXPacket("ajax_doModify.jsp","���Ժ�...");
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
				rdShowMessageDialog("��������ִ�гɹ���",2);
				location = location; //�����ɹ���ˢ��ҳ��ȡ������ˮ
			}
	}
	if(retType == "Modify"){
 		if(parseInt(retCode) != '0'){
				rdShowMessageDialog("["+retCode+":] "+retMsg);
			}else{
				rdShowMessageDialog("�����޸ĳɹ���",2);
        doSee();
			}
	}
}
  
</SCRIPT>
<body>
<FORM method=post name="frm1102">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ����</div>
</div>
          <table cellspacing=0>
                <TR> 
                	<td class='blue' nowrap>�������</Td>
                  <TD> 
                  	 <input type="text" name="ordernum"  onchange="" value="" />
	                  
                  </TD>
	                	 <td class='blue' nowrap>�������</Td>
	                  <TD colspan='3'> 
	                    <input type="text" name="servno"  onchange="" value="" />
	                  </TD>
                </TR>
                <tr id="">
                	<td class='blue' nowrap>��������</Td>
                  <TD> 
                   	 <input type="text" name="login_no"  onchange="" value="" />
	                    <!--&nbsp;<font class='orange'>*</font>-->
                  </TD>
                  <td class='blue' nowrap>ҵ�����</Td>
                  <TD> 
                    <input type="text" name="func_code"   value="" >
                  </TD>
                  <td class='blue' nowrap>��������</Td>
                  <TD> 
                    <input type="text" name="optime"  v_type='day' value="<%=currentTime%>" maxlength="8">
                  </TD>
                </tr>
                <tr id="">
                	<td class='blue' nowrap>�����ڵ�ID</Td>
                  <TD  > 
                   	 <input type="text" name="orderid"  onchange="" value="" />
	           
                  </TD>
                  <td class='blue' nowrap>�����ڵ�ֵ</Td>
                  <TD  colspan='3'> 
                    <input type="text" name="ordervalue" id="modeFlag"  value="" >
                  </TD>
                </tr>
           </table>
        </div>
       <div id="footer">                
          <input class="b_foot" onclick="doSearch()"  type=button value="��ѯ"/>
          <!--input class="b_foot" id="confirm" onclick="qryContent()"  type=button value="ȷ��&��ӡ"/-->
          <input class="b_foot" name="quit"  onclick="removeCurrentTab()"  type=button value="�ر�"/>
	  	</div>
    	<div id="searchResult"></div>
    	<div id="searchResultDetail"></div>


  <!------------------------> 
<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
</html> 	