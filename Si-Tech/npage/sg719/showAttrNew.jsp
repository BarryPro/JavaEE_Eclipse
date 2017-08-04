<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<%
  String groupId = (String)session.getAttribute("regCode");
	String opCode=WtcUtil.repNull(request.getParameter("opCode"));
	String opName=WtcUtil.repNull(request.getParameter("opName"));
	String queryIdTemp = WtcUtil.repNull(request.getParameter("queryId"));	
	String effT = WtcUtil.repNull(request.getParameter("effT"));	
	System.out.println("---------effT-----------"+effT);
	System.out.println(queryIdTemp);
	
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	String attrInfo = WtcUtil.repNull(request.getParameter("attrInfo"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	String offerInstId = WtcUtil.repNull(request.getParameter("offerInstId"));
	String servId = WtcUtil.repNull(request.getParameter("servId"));

	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); //当前时间
	
	String queryTypeId = "0";					//0:销售品;1:产品
	String queryId = "";
	if(queryType.equals("prod")){
		queryTypeId = "1";
		if(queryIdTemp.indexOf("A") != -1){
			queryId = queryIdTemp.split("A")[1];
		}else{
			queryId  = queryIdTemp;
		}		
	}else{
		queryId = queryIdTemp;
	}
%>


<html>
<SCRIPT type=text/javascript>
var str = "";
$().ready(function(){
	var attributeInfo = "";
	attributeInfo = "<%=attrInfo%>";
	var v_code = window.dialogArguments.v_code;
	var v_text = window.dialogArguments.v_text;

  getAttrCode(v_code,v_text);//获取小区代码
	/*$("#attrInfo :input").not(":button").each(chkDyAttribute);	*/

	$("#operation :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
	
	if(attributeInfo !="undefined" && attributeInfo != ""){
		$.each(attributeInfo.split("$"),function(i,n){
			var temp = n.split("~");
			if(typeof(temp[1]) != "undefined"){
				if(temp[1].trim().indexOf(",") != -1){
					$("[name='s_"+temp[0]+"'] option").attr("selected",false);
					$.each(temp[1].trim().split(","),function(i,n){
						$("[name='s_"+temp[0]+"'] option[value='"+n+"']").attr("selected",true);
					});
				}else{
					$("[name='s_"+temp[0]+"']").val(temp[1].trim());	
					if($("[name='s_"+temp[0]+"']").attr("v_type") == 16 && temp[1].trim() != ""){	//获取序列的类型,按钮不可用
						$("[name='querys_"+temp[0]+"']").attr("disabled",true);
					}
				}	
			}	
		});	
	}
	
	$("#operation select").each(function(i,n){
		
	});
	/**yanpx 增加 修改小区代码显示不全**/
	$("select").css("width","300px");
	
	//alert($("body").html());
});	

function getAttrCode(v_code,v_text){
<%
  if(!queryId.equals("9001")){
%>
	 	if(v_code.length>0){
      var tempStr = "";
			for(var i = 0;i<v_code.length;i++){
				tempStr += "<option value='"+v_code[i]+"' >"+ v_text[i] + "</option>";
			}
			$("#newAttrIds").append(tempStr);
	  }
<%}else{  %>
			loadPage();
	<%}%>
}

function saveTo()
{		
	 if(!checksubmit(attrFm)) return false ;  //20091109
		str = "";
		$("#attrInfo :input").not(":button,.cls_text").each(function(){
				str+=this.name.substring(2);
				str+="~";
				str+=$(this).val()+" $";
		});
		setAttr(str);
}

function loadPage(){
 	var packet = new AJAXPacket("/npage/common/productPages/smallPage.jsp","请稍后...");
	core.ajax.sendPacketHtml(packet,doLoadPage);
	packet =null;
}

//--------设置属性----------
function setAttr(attrStr){
	var packet = new AJAXPacket("setAttr.jsp","请稍后...");
	packet.data.add("queryTypeId","<%=queryTypeId%>");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("queryId","<%=queryId%>");
	packet.data.add("offerInstId","<%=offerInstId%>");
  packet.data.add("opCode",document.all.opCodeHSa.value);
	packet.data.add("attrStr",attrStr);
	packet.data.add("effT","<%=effT%>");
	core.ajax.sendPacket(packet,doSetAttr);
	packet =null;	
}
function doSetAttr(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	//var objV1 = window.dialogArguments; 
	var objV1 = window.dialogArguments.offerChoiceFrm.attrFlagHv;
	if(errorCode == 0){
		rdShowMessageDialog("设置成功！");
		objV1.value = "0";
		window.returnValue = str;
		window.close();
		return false;	
	}else{
		rdShowMessageDialog(errorMsg);
		objV1.value = "1";
		return false;	
	}
}

function doLoadPage(data){
	$("#attrInfo").html(data);
}
</SCRIPT>	

<body onkeydown="if(event.keyCode=='13')return false">
<div id="operation">
<FORM name="attrFm" action="" method=post>
<%@ include file="/npage/include/header_pop.jsp" %>	
<div id="operation_table">	
<DIV class="title"><div class="text">属性信息</div></DIV>	
<div class="input" id="attrInfo">
  <TABLE>
    <TBODY>
      <TR>
        <TD class=blue><SPAN class=orange>*小区代码</SPAN></TD>
        <TD name="0">
          <SELECT style="WIDTH: 300px" class="required" id="newAttrIds" name="s_60001"  v_name="小区代码"  v_type="5"  v_optionFlag="Y" v_selVal="100" v_flag="N" v_preci="2" v_type="5" v_readonly="N">
          </SELECT>
        </TD>
      </TR>
    </TBODY>
  </TABLE>
</div>
</div>
<div id="operation_button">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
</div>
<input type="hidden" name="regionCode" value="<%=regionCode%>"/>
<input type="hidden" name="groupId" value="<%=groupId%>"/>
<input type="hidden" name="offId" value="<%=queryId%>"/>
<input type="hidden" name="opCodeHSa" value="<%=opCode%>"/>
<input type="hidden" name="effT" value="<%=effT%>"/>
	
<%@ include file="/npage/include/footer_pop.jsp"%>
</FORM>
</DIV>
</BODY>
</HTML>
