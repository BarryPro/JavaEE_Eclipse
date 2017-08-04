<%
  /*
   * ����: 4G��������¼�� m036
   * �汾: 1.0
   * ����: 2014/1/13 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String stypesql = "select t.group_id,t.region_name from sregioncode t where t.use_flag = 'Y' order by t.group_id";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_type" retmsg="retMsg_type" outnum="2"> 
	<wtc:param value="<%=stypesql%>"/>
</wtc:service>  
<wtc:array id="result1"  scope="end"/>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
// �б�
function query(){
	var region_code = $("#region_code").val();
	if(region_code==""){
		rdShowMessageDialog("��ѡ��������ƣ�");
		return false;
  }
	var myPacket = new AJAXPacket("fm036_ajax_qryInfo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
  myPacket.data.add("region_code",region_code);
  myPacket.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacketHtml(myPacket,doQuery);
  getdataPacket = null;
}

function doQuery(data){
	$("#simNo").val("");
	$("#simNoTr").css("display","none");
  //�ҵ���ӱ���div
	var markDiv=$("#intablediv"); 
	markDiv.empty();
	markDiv.append(data);
	/* ������н�����ʽ */
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
			
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
			
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});
	
  var retCode = $("#retCode").val();
  var retMsg = $("#retMsg").val();
  if(retCode!="000000"){
		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		window.location.href="fm036_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }
}

function showSimNo(){
	$("#simNo").val("");
	$("#simNoTr").css("display","");
}

function subInfo(){
	var simNo = $("#simNo").val();
	if(simNo==""){
		rdShowMessageDialog("������sim���ţ�");
		return false;
  }
  
  var v_phoneNo = $("input[@name=qryRadio][@checked]").attr("v_phoneNo"); 
  var v_simType = $("input[@name=qryRadio][@checked]").attr("v_simType"); 
  var v_hlrCode = $("input[@name=qryRadio][@checked]").attr("v_hlrCode"); 
	var myPacket = new AJAXPacket("fm036_ajax_subInfo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
  myPacket.data.add("simNo",simNo);
  myPacket.data.add("opCode","<%=opCode%>");
  myPacket.data.add("v_phoneNo",v_phoneNo);
  myPacket.data.add("v_simType",v_simType);
  myPacket.data.add("v_hlrCode",v_hlrCode);
  core.ajax.sendPacket(myPacket,doSubInfo);
  getdataPacket = null;
}

function doSubInfo(packet){
	var retCode = packet.data.findValueByName("retCode2");
	var retMsg =  packet.data.findValueByName("retMsg2");
	if(retCode != "000000"){
		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		window.location.href="fm036_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}else{
		rdShowMessageDialog("�ύ�ɹ���",2);
		window.location.href="fm036_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}

</script> 
 
<title>4G��������¼��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f4242Cfm.jsp" method="post" name="frm4242"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">4G��������¼��</div>
	</div>
	<table cellspacing="0">           
    <tr>
    	<td class="blue" width="8%" nowrap>��������</td>
    	<td>
	    	<select name="region_code" id="region_code" class="button"  >
	    		<option value="">--��ѡ��--</option>
	    		<option value="ALL">ȫʡ</option>
	    		<%
	    			if("000000".equals(retCode_type)){
	    				if(result1.length>0){
	    					for (int i = 0; i < result1.length; i++){
	    		%>
		      		<option value="<%=result1[i][0]%>"><%=result1[i][1]%></option>
		      <%
	    					}
	    				}
		    		}else{
		    	%>
		    			<script language="JavaScript">
		    				rdShowMessageDialog("��ѯ��������ʧ�ܣ�<br>������룺<%=retCode_type%><br>������Ϣ��<%=retMsg_type%>",0);
		    				removeCurrentTab();
		    			</script>
		    	<%
		    		}
		    	%>
	    	</select>
    	</td>
	  </tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn"  class="b_foot" value="��ѯ" onclick="query()">
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<div id="intablediv"></div>
	<table cellspacing="0" id="simNoTr" style="display:none">     
		<tr >
    	<td class="blue" width="8%" nowrap>SIM����</td>
    	<td>
	    	<input type="text" id="simNo" name="simNo" v_type="0_9" value="" />
    	</td>
	  </tr>
	  <tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="subBtn"  class="b_foot" value="ȷ��" onclick="subInfo()">
				&nbsp;
				<input type="button" name="closeBtn2" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>