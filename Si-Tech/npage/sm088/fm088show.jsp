<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-06 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

  String opName = "���ӹ�������";
	String opCode=request.getParameter("opCode");
	String phone_no = request.getParameter("phone_no");
	String login_accept22 = request.getParameter("login_accept")==null?"":request.getParameter("login_accept");
  String work_no = request.getParameter("work_no");
  String work_name = (String)session.getAttribute("workName");
  String password = request.getParameter("password");
	String begin_date = request.getParameter("begin_date");
	String begin_month = "";
	if(begin_date != ""&&!"".equals(begin_date)){
		begin_month = begin_date.substring(0,6);
	}
	String end_date = request.getParameter("end_date");
	String regCode = (String)session.getAttribute("regCode");
	String iccidInfo=request.getParameter("iccidInfo")==null ? "|||":request.getParameter("iccidInfo");
	String accInfo=request.getParameter("accInfoStr")==null ? "|||":request.getParameter("accInfoStr");
	String billType="1";
	String returnPage = "fm088_main.jsp?activePhone="+phone_no;
	
	String sqlid="select to_char(id_no) as idNo from dcustmsg where phone_no='"+phone_no+"'";
	System.out.println("sqlid====="+sqlid);
	
	String regionCode = (String)session.getAttribute("regCode");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="login_accept"/>

	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>" outnum="1">
    	<wtc:sql><%=sqlid%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="idNo" scope="end"/>		
<%
  	if (idNo.length==0) {
%>
  			
<%
  	}
%>
		<wtc:service name="sm088Prt_Qry" routerKey="region" routerValue="<%=regCode%>" outnum="6" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=login_accept22%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=billType%>"/>
			<wtc:param value="<%=begin_date%>"/>
			<wtc:param value="<%=end_date%>"/>			
		</wtc:service>
		<wtc:array id="printCodeStr" scope="end"/>		
<% 
	if("000000".equals(retCode1)){
		if(printCodeStr.length==0){
%>
		  <script language="JavaScript">
		    rdShowMessageDialog("δ�ܲ�ѯ���˷������ĵ��ӹ�����ӡ��Ϣ! ");
		    window.location="fm088_main.jsp?activePhone=<%=phone_no%>";
		  </script>
<% 
			return;
		}
	}else{
%>
		  <script language="JavaScript">
		    rdShowMessageDialog("��ѯ���ӹ�����ӡ��Ϣ����!������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>");
		    window.location="fm088_main.jsp?activePhone=<%=phone_no%>";
		  </script>
<% 
			return;
	}
%>
<%
	String groupId = (String)session.getAttribute("groupId");
	String getLoginInfo = "SELECT   msg.group_name, msg.GROUP_ID, msg.root_distance"
						+" FROM dchngroupmsg msg, dchngroupinfo info"
						+" WHERE msg.GROUP_ID = info.parent_group_id"
						+" AND info.GROUP_ID = '" + groupId + "'"
						+" AND msg.root_distance > 1"
						+" ORDER BY msg.root_distance";
%>
	<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" 
		 routerValue="<%=regCode%>" retcode="retCode5" retmsg="retMsg5">
		<wtc:sql><%=getLoginInfo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret" scope="end"/>

<%
		/* add for �Ƿ�Ϊ����������� 1���� @2014/11/19  */
		String workChnFlag = "0" ;
%>	
		<wtc:service name="s1100Check" outnum="30"
			routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=work_no%>"/>
			<wtc:param value = "<%=password%>"/>
				
			<wtc:param value = ""/>
			<wtc:param value = ""/>
		</wtc:service>
		<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "����s1100Checkû�з��ؽ��!" );
			removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		removeCurrentTab();
	</script>
<%
}
    /*������ʵ����ڿ�������BOSS�Ż���������������ñ�start*/
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and flag='Y' ";
    String sql_appregionset2 = "groupids="+groupId;
    String appregionflag="0";//==0ֻ�ܽ��й�����ѯ��>0���Խ��й�����ѯ���߶���
    System.out.println(sql_appregionset1+"------------"+sql_appregionset2);
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
	System.out.println("appregionarry==length===="+appregionarry.length);
			if("000000".equals(retCodeappregion)){
				if(appregionarry.length > 0){
					appregionflag = appregionarry[0][0]; 
					System.out.println("appregionarry[0][0]======"+appregionarry[0][0]);
				}
		}
		System.out.println("appregionflag======"+appregionflag);
		/*������ʵ����ڿ�������BOSS�Ż���������������ñ�end*/
		String sql_sendListOpenFlag = "select count(*) from shighlogin where login_no='K' and op_code='m194'";
		String sendListOpenFlag = "0"; //�·��������� 0���أ�>0����
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=sql_sendListOpenFlag%>"/>
		</wtc:service>  
		<wtc:array id="ret1"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			if(ret1.length > 0){
				sendListOpenFlag = ret1[0][0]; 
			}
		}
		
		String  sql_regionCodeFlag [] = new String[2];
		sql_regionCodeFlag[0] = "select count(*) from shighlogin where op_code ='m195' and login_no=:regincode";
		sql_regionCodeFlag[1] = "regincode="+regionCode;
		String regionCodeFlag = "N"; //�����Ƿ�ɼ� �·�������ť Y�ɼ���N���ɼ�
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode2)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}
%>

<HTML>
<HEAD>
<TITLE>���ӹ�����ӡ</TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
$(document).ready(function(){
	var groupInfoArr = new Array();
	<%
		for(int retIter = 0; retIter < ret.length; retIter++){
	%>
		groupInfoArr["<%=retIter%>"] = "<%=ret[retIter][0]%>" + "|" + "<%=ret[retIter][1]%>";
	<%
		}
	%>
	if(typeof(groupInfoArr[0]) != "undefined" && groupInfoArr[0] != ""){
		$("#regionName").val(groupInfoArr[0]);
	}else{
		$("#regionName").val("|");
	}
	if(typeof(groupInfoArr[1]) != "undefined" && groupInfoArr[1] != ""){
		$("#areaName").val(groupInfoArr[1]);
	}else{
		$("#areaName").val("|");
	}
	if(typeof(groupInfoArr[2]) != "undefined" && groupInfoArr[2] != ""){
		$("#hallName").val(groupInfoArr[2]);
	}else{
		$("#hallName").val("|");
	}
	
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
	
	
		if( "<%=workChnFlag%>" == "1" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ 
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
		}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
		}	

	
});

function doPrintSubmit(){
	var slecPrint =$("input[@name=qryPrint][@checked]").val();
	if(typeof(slecPrint)=="undefined"){
		rdShowMessageDialog("��ѡ��Ҫ��ӡ����Ϣ!");
		return ;
	}
	
	var v_opTime =$("input[@name=qryPrint][@checked]").attr("v_opTime"); 
	$("#opTime").val(v_opTime);
	
	var v_accp =$("input[@name=qryPrint][@checked]").attr("v_accp"); 
	var v_opcode =$("input[@name=qryPrint][@checked]").attr("v_opcode"); 
	var v_opName =$("input[@name=qryPrint][@checked]").attr("v_opName"); 
	var phoneNo = $("input[@name=qryPrint][@checked]").attr("v_phoneNo");
	var billType = "<%=billType%>";
	
	showPrtDlg(phoneNo,billType,v_accp,v_opcode,v_opTime,v_opName);
}

function showPrtDlg(phoneNo,billType,v_accp,v_opcode,v_opTime,v_opName){  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	/* ���֤����Ϣ */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ���֤����Ϣ */
	var billType="<%=billType%>"; 
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "hljBillPrint_jc_hw_bd.jsp?phoneNo="+phoneNo+"&loginacceptJT="+$("#loginacceptJT").val()+"&billType="+billType+"&v_accp="+v_accp+"&v_opcode="+v_opcode+"&v_opTime="+v_opTime+"&v_opName="+v_opName+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr+"&begin_month=<%=begin_month%>";
	var ret=window.showModalDialog(path,"",prop);
	//return ret;
	document.location.replace("<%=returnPage%>");
}

function goBack(){
  window.location.href="fm088_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone_no%>";
}

     	//�·�����
		  function sendProLists(){
		  	var slecPrint =$("input[@name=qryPrint][@checked]").val();
				if(typeof(slecPrint)=="undefined"){
					rdShowMessageDialog("��ѡ��Ҫ��ӡ����Ϣ!");
					return ;
				}
				
		  	var phoneNoA = $("input[@name=qryPrint][@checked]").attr("v_phoneNo");
		  	if(phoneNoA.length == 0){
		  		rdShowMessageDialog("�������Ϊ�գ��������·�������");
		  		return false;
		  	}
				var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","���ڻ�����ݣ����Ժ�......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("phoneNo","<%=phone_no%>");
				core.ajax.sendPacket(packet,doSendProLists);
				packet = null;
		  } 
		  
		  function doSendProLists(packet){
		  	var retCode = packet.data.findValueByName("retCode");
				var retMsg =  packet.data.findValueByName("retMsg");
				if(retCode != "000000"){
					rdShowMessageDialog( "�·�����ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0 );
				}else{
					rdShowMessageDialog( "�·������ɹ�!" );
				}
		  }
		  
		  //���������ѯ
			function qryListResults(){
				var h=450;
				var w=800;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
				var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
				if(typeof(ret) == "undefined"){
					rdShowMessageDialog("���û�й�����ѯ��������Ƚ����·�����������");
				}else if(ret!=null && ret!=""){
					$("#loginacceptJT").val(ret.split("~")[4]); //������ˮ
					

				}
			} 

//-->
</SCRIPT>
</HEAD>
<BODY leftmargin="0" topmargin="0">
	
<FORM name="spubPrint">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		    <div id="title_zi">���ӹ�����ϸ</div>
		</div>
		<table cellspacing="0" vColorTr='set'>
		  <tr align="center">
		       <th>ѡ��</th>
		       <th>ҵ����ˮ</th>
		       <th>��������</th>
		       <th>��������</th>
		       <th>����ʱ��</th>
		       <th>�������</th>
		   </tr>
		<% 
		
		for(int i=0; i < printCodeStr.length; i++){
			%>
				<tr align="center">
				  <td>
					  <input type="radio" name="qryPrint" value="<%=printCodeStr[i][0].trim()%>" v_accp="<%=printCodeStr[i][0]%>" v_opcode="<%=printCodeStr[i][1]%>" v_opName="<%=printCodeStr[i][2]%>" v_opTime="<%=printCodeStr[i][3]%>" v_phoneNo="<%=printCodeStr[i][5]%>" />
				  </td>
				  <td>
					<div align="center"><%=printCodeStr[i][0]%></div>
				  </td>
				   <td>
					<div align="center"><%=printCodeStr[i][1]%></div>
				  </td>
				   <td>
					<div align="center"><%=printCodeStr[i][2]%></div>
				  </td>
				  <td>
					<div align="center"><%=printCodeStr[i][3]%></div>
				  </td>
				  <td>
					<div align="center"><%=printCodeStr[i][5]%></div>
				  </td>
				</tr>
	    <%}%>
		</table>
		<table>
				<tr>
					<td>
					<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="�·�����" onclick="sendProLists()" style="display:none" />                    
			   &nbsp;&nbsp;&nbsp;
          <input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="���������ѯ" onclick="qryListResults()" style="display:none" />    
				 </TD>
				 </tr>
				 </table>
		<jsp:include page="/npage/public/hwReadCustCard.jsp">
			<jsp:param name="hwAccept" value="<%=login_accept%>"  />
			<jsp:param name="showBody" value="01"  />
		</jsp:include>
		<table>
			<tr>
			<td id="footer">
	        <input class="b_foot" name=sure type=button value=��ӡ onclick="doPrintSubmit()">&nbsp;
	        <input class="b_foot" name=doBackButton type=button value=���� onclick="goBack()">
        </td>
      </tr>
    </table>
<%@ include file="/npage/include/footer.jsp" %>       
<input type="hidden" name="beginDate"  value="<%=begin_date%>">
<!--���֤��Ч�� -->
<input type="hidden" name="idValidDate" id="idValidDate"  value="">
<input type="hidden" name="endDate"  value="<%=end_date%>">
<input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
<input type="hidden" name="loginacceptJT" id="loginacceptJT" />

</FORM>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>