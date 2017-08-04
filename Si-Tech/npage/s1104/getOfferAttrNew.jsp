<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
System.out.println("----------------------------getOfferAttr.jsp-------------------------------------");  
	System.out.println("<<------------查询销售品属性开始------------>>");

	String OfferId = request.getParameter("OfferId") == null?"":request.getParameter("OfferId");	
	String[] v_code = (String[])request.getParameterValues("v_code") == null?new String[]{}:(String[])request.getParameterValues("v_code");	
	String[] v_text = (String[])request.getParameterValues("v_text") == null?new String[]{}:(String[])request.getParameterValues("v_text");	
	System.out.println("# offerId= "+OfferId);
	
	String myActivePhone = request.getParameter("OfferId") == null?"":request.getParameter("myActivePhone");	
	
	
%>
<table>
	<tr>
    		<td class="blue">小区名称</td>
      	<td><input type="text" id="attrName" name="attrName" value=""/>&nbsp;&nbsp;
      			<input type="button" name="mhBtn" class="b_text" value="模糊查询" onclick="mhSelectFunc();"/>	
      	</td>
    	</tr>
  <TR>
    <TD class='blue' id='template_0' >
      <span class='orange' >*小区代码</span>
    </TD>
    <TD name="0">
      <select v_readonly="N" id="newAttrIds" name="s_60001" v_type="5" v_preci="2" v_flag="N" v_name="小区代码"  v_selVal="100" v_optionFlag="Y" style="width:300px"/>
    </TD>
  </TR>
</table>
<script>
	var v_code = new Array();
	var v_text = new Array();
	
	$().ready(function(){
		//$("#OfferAttribute :input").not(":button").each(chkDyAttribute);
		<%
		if(v_code.length>0){
	  %>
	  	/*2015/4/1 14:17:04 gaopeng  先清空*/
	 		$("#newAttrIds").empty();
	    var tempStr = "";
	  <%
	    for(int i = 0;i<v_code.length;i++){
	  %>
				tempStr += "<option value='<%=v_code[i]%>' ><%=v_text[i]%></option>";
		<%
			}
		%>
			$("#newAttrIds").append(tempStr);
	  <%
		}
		%>
	});
	
	function getAttrCode(v_code,v_text){
		
	 	if(v_code.length>0){
	 		/*2015/4/1 14:17:04 gaopeng  先清空*/
	 		$("#newAttrIds").empty();
	 		
      var tempStr = "";
			for(var i = 0;i<v_code.length;i++){
				tempStr += "<option value='"+v_code[i]+"' >"+ v_text[i] + "</option>";
			}
			$("#newAttrIds").append(tempStr);
			
	  }

}
	/*2015/4/1 13:24:29 gaopeng 增加模糊查询方法*/
function mhSelectFunc()
{
	var attrName = $.trim($("#attrName").val());
	if(attrName.length == 0){
		rdShowMessageDialog("请输入小区名称!");
		return false;
	}
	/*ajax start*/
	var getdataPacket = new AJAXPacket("/npage/sm237/fm237Qry.jsp","正在获得数据，请稍候......");
	
	getdataPacket.data.add("offerId","<%=OfferId%>");
 	getdataPacket.data.add("phoneNo","<%=myActivePhone%>");
	getdataPacket.data.add("opCode","1104");
	getdataPacket.data.add("offerName",attrName);
	
	
	core.ajax.sendPacket(getdataPacket,doRetRegion);
	getdataPacket = null;
	
	
}
function doRetRegion(packet){
						var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var codeArray = new Array();
			var textArray = new Array();
			
			if(retCode == "000000"){
				for(var i=0;i<infoArray.length;i++){
					codeArray[i] = infoArray[i][0];
					textArray[i] = infoArray[i][1];
				}
				v_code = codeArray;//window.dialogArguments.v_code;
				v_text = textArray;//window.dialogArguments.v_text;
				
				getAttrCode(v_code,v_text);//获取小区代码
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
			
}

</script>


