<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2011-7-26
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	  String regionCode     = (String)session.getAttribute("regCode");
	  String workNo = (String)session.getAttribute("workNo");
	  String opName="�޸�����";
	  String promptSeq = request.getParameter("promptSeq");
	  String flag = request.getParameter("flag")==null?"":request.getParameter("flag");
	  String ishelper = request.getParameter("ishelper")==null?"":request.getParameter("ishelper");
	  String funcName = request.getParameter("funcName")==null?"showInWeek":request.getParameter("funcName");
%>
<wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		select t.title,
		       t.content,
		       to_char(t.selDate, 'yyyy-mm-dd'),
		       to_char(t.op_time, 'yyyy-mm-dd'),
		       t.login_no,
		       to_char(t.begin_time, 'yyyymmdd'),
		       to_char(t.end_time, 'yyyymmdd'),
		       t.tskrank
		  from dTaskmsg t
		 where to_char(t.login_accept) = '<%=promptSeq%>'
		   and login_no = '<%=workNo%>'
	</wtc:sql>
</wtc:pubselect>
<wtc:array id ="result" scope = "end"/>
<%
String title     = "";
String content   = "";
String startTime = "";
String endTime   = "";
String tskRank   = "";
String selDate   = "";
if(result.length>0){
	title     = result[0][0];
	content   = result[0][1];
	selDate   = result[0][2];
	startTime = result[0][5];
	endTime   = result[0][6];
	tskRank   = result[0][7];
}
%>	
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript">
	var windowShow = window.dialogArguments; 
  
function saveTsk(){
	var promptContentLen = document.all("promptContent").value.length;
	if(promptContentLen>2000){
		rdShowMessageDialog("���ݳ��Ȳ��ܳ���2000���ַ�");
		return;
	}
	
	var title     = document.all.promptTitle.value.trim();
	var content   = document.all("promptContent").value.trim();
	var startTime = document.all.promptTime.value.trim();
	var endTime   = document.all.promptTimend.value.trim();
	var tskRank   = document.all.tskRank.value;
	//alert("title|"+title+"\ncontent|"+content+"\nstartTime|"+startTime+"\nendTime|"+endTime+"\ntskRank|"+tskRank);
	
	if(title==""){
		rdShowMessageDialog("������ⲻ��Ϊ��");
		document.all.promptTitle.focus();
		return;
	}
	
	if(content==""){
		rdShowMessageDialog("�������ݲ���Ϊ��");
		document.all("promptContent").focus();
		return;
	}
	
	if(startTime==""){
		rdShowMessageDialog("����ʼʱ�䲻��Ϊ��");
		document.all.promptTime.focus();
		return;
	}
	
	if(endTime==""){
		rdShowMessageDialog("�������ʱ�䲻��Ϊ��");
		document.all.promptTimend.focus();
		return;
	}
	
	if(parseInt(startTime)>parseInt(endTime)){
		rdShowMessageDialog("�������ʱ��Ӧ�ô�������ʼʱ��");
		document.all.promptTime.value="";
		document.all.promptTimend.value="";
		document.all.promptTimend.focus();
		return;
	}
	
	var mm = /<|>|\\|\"|#|&/;
	
	if(mm.test(title)){
		rdShowMessageDialog("������ⲻ����������� < > \\ \" # &amp;");
		document.all.promptTitle.value="";
		document.all.promptTitle.focus();
		return;
	}
	
	if(mm.test(content)){
		rdShowMessageDialog("�������ݲ������������ < > \\ \" # &amp;");
		document.all.promptContent.value="";
		document.all.promptContent.focus();
		return;
	}
		
	var tskPacket = new AJAXPacket("updTask_cfm.jsp","����ִ��,���Ժ�...");
		tskPacket.data.add("id",        "<%=promptSeq%>");
		tskPacket.data.add("title",     title    );
		tskPacket.data.add("content",   content  );
		tskPacket.data.add("startTime", startTime);
		tskPacket.data.add("endTime",   endTime  );
		tskPacket.data.add("tskRank",   tskRank  );
		core.ajax.sendPacket(tskPacket,doSaveTsk);
		tskPacket = null; 
}
function doSaveTsk(packet){
	 var retCode = packet.data.findValueByName("retCode"); 
	 
	 if(retCode=="000000"){
	 	rdShowMessageDialog("�����޸ĳɹ�",2);
	 }else{
	 	rdShowMessageDialog("�����޸�ʧ��",0);
	 }
<%	if("more".equals(flag)){
		if("helper".equals(ishelper)){
%>			window.opener.opener.frames["ifram"].$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
  			window.opener.location.reload();
  			window.opener.opener.frames["ifram"].showPrompt();
<%	
		}else{
%>
			window.opener.opener.$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
			window.opener.location.reload();
			window.opener.opener.showPrompt();
<%
		}
	}else{
%>
	window.opener.$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
	window.opener.showPrompt();
<%
	}
%>
	 window.close();
}
	    
</script>
<title>�޸�����</title>
</head>

<body onload="" style="overflow-y:auto; overflow-x:hidden;">
			<form id="layer6_form" method="post" action="">
				<%@ include file="/npage/include/header_pop.jsp" %>
				<div class="title"><div id="title_zi">�޸�����</div></div>
				<table width=90% >
					<tr >
			 			<td class="blue">
            	��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�⣺
            </td>
						<td >
							<INPUT type="text" id="promptTitle" name="promptTitle" value="<%=title%>" size="21" maxlength="50"/>
						</td>
					</tr>
						<tr >
			 			<td class="blue">
            	���񼶱�
            </td>
						<td >
							<select id="tskRank" name="tskRank">
								<option value="0" <%if(tskRank.equals("0")) out.print("selected");%>>һ������</option>
								<option value="1" <%if(tskRank.equals("1")) out.print("selected");%>>��Ҫ����</option>
							</select>
						</td>
					</tr>
			 		<tr >
			 			<td class="blue">
            	����ʼʱ�䣺
            </td>
						<td >
							<INPUT type="text" id="promptTime" name="promptTime" value="<%=result[0][5]%>" size="21" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})"  readOnly />
						</td>
					</tr>
					<tr >
			 			<td class="blue">
            	�������ʱ�䣺
            </td>
						<td >
							<INPUT type="text" id="promptTimend" name="promptTimend"  value="<%=result[0][6]%>" size="21" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" readOnly />
						</td>
					</tr>
					<tr>
        		<td class="blue">
            	�������ݣ�
            </td>
            <td>
		          <textarea name="promptContent"  rows=10 cols= 40  ><%=content%></textarea>
            </td>
			 		</tr>
					<tr >
						<td id="footer" colspan=2>
								<input  type="button" id=save66 name="submit" class="b_foot" value="ȷ��" onclick="saveTsk()">&nbsp;
								<input  type="button" id=cls name="cls" class="b_foot" value="�ر�" onclick="window.close()">
						</td>
					</tr>
				</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
		</form>
	</body>
</html>
 
 
 