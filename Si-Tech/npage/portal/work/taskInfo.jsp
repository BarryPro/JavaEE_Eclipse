<%
   /*
   * ����: ��������
�� * �汾: v1.0
�� * ����: 2008��7��26��
�� * ��Ȩ: sitech
   * ���ߣ�hejwa
   * �޸�����      �޸���  
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.util.page.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
       //��ֹIE����ҳ��
	  response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	  response.setHeader("Pragma","no-cache"); //HTTP 1.0
	  response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String themePath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
		
		//����ʱ��־
		String flag = request.getParameter("flag")==null?"":request.getParameter("flag");
	
		//�Ӷ�������ʱ��־
	  String ishelper = request.getParameter("ishelper")==null?"":request.getParameter("ishelper");
	  String funcName = request.getParameter("funcName")==null?"showInWeek":request.getParameter("funcName");
		
		int iPageNumber = request.getParameter("pageNumber") == null ? 1: Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber - 1) * iPageSize;
    int iEndPos = iPageNumber * iPageSize;
    
    String sql = "";
    
    //����ʱ�����
    String selectDate = request.getParameter("selectDate") == null ? "": request.getParameter("selectDate");
    if("".equals(selectDate)){//��������ʱ�����������ͨ��������
	    if("more".equals(flag)){
	 	 		sql = "select * from (select a.*, rownum id from(select  to_char(t.login_accept),t.title,t.content,to_char(t.selDate,'yyyy-mm-dd HH24:MI:SS'),to_char(t.op_time,'yyyy-mm-dd HH24:MI:SS'),t.tskrank from dTaskmsg t where login_no='"+workNo+"'order by t.seldate desc) a)where id <= " + iEndPos + " and id > " + iStartPos;
	 	 	}else{
	  			sql = "select *  from (select to_char(t.login_accept), "+
               		  			   "t.title, "+
					               "t.content, "+
					               "to_char(t.selDate, 'yyyy-mm-dd HH24:MI:SS'), "+
					               "t.login_no,t.tskrank "+
					          "from dTaskmsg t "+
					         "where sysdate-1 < t.end_time "+
					           "and login_no = '"+workNo+"' "+
					         "order by t.seldate desc) "+
					 "where rownum <= 5 ";
	  	}
  	}else{//������ʱ�����������ͨ��������
  				sql = "select * from (select a.*, rownum id from(select  to_char(t.login_accept),t.title,t.content,to_char(t.selDate,'yyyy-mm-dd HH24:MI:SS'),to_char(t.op_time,'yyyy-mm-dd HH24:MI:SS'),t.login_no,t.tskrank from dTaskmsg t where login_no='"+workNo+"' and to_char(seldate,'yyyy-mm-dd')='"+selectDate+"' order by t.seldate desc) a)where id <= " + iEndPos + " and id > " + iStartPos;
  	}
  	
  	String sqlCount = "select  to_char(count(*)) from dTaskmsg t where login_no='"+workNo+"'";
%>

	<link href="/nresources/<%=themePath%>/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="/nresources/<%=themePath%>/css/font_color.css" rel="stylesheet" type="text/css">
<style>	
.b_text_n{
	height:18px;
	border:1px solid #417db3;
	font-size:12px;
	color:#1E245E;
	background-image: url(../images/button_1.jpg);
	background-repeat: repeat-x;
	background-position: left bottom;
	text-align: center;
	background-color: #fcfdff;
	padding-top: 1px;
	cursor: hand;
	margin: 0px;
}
</style>
	<%if("more".equals(flag)){%>
		<script type="text/javascript" src="/njs/extend/jquery/portalet/jquery114_pack.js"></script>
		<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
		<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
	<%}
	if("".equals(selectDate)){
	%>
	<title>������ʾ</title>
	<%}else{%>
	<title><%=selectDate%>��ʾ</title>
	<%}%>
<wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" retcode="retCode" retmsg="retMsg" routerValue="<%=regionCode%>">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />

<wtc:pubselect name="sPubSelect" outnum="1" retcode="Code" retmsg="Msg" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlCount%></wtc:sql>
</wtc:pubselect>
<wtc:array id ="resultCount" scope = "end"/>
	<div class="itemContent">
		<%
		String dateArr = "";//������ʾ����������
		if(!"more".equals(flag)){
		
				//��ȡ������ܰ��ʾ��ʱ��
				String getDateSql = "select to_char(selDate,'yyyy-mm-dd') from dTaskmsg where sysdate-1 <end_time and login_no=:workNo";
				String dateParam = "workNo="+workNo;
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>" retcode="dateCode" retmsg="dateMsg" >
			<wtc:param value="<%=getDateSql%>" />
			<wtc:param value="<%=dateParam%>" />
		</wtc:service>
		<wtc:array id="dateResult" scope="end"/>
			
		<%		
		 
		 if("000000".equals(dateCode)){
		 		for(int i=0;i<dateResult.length;i++){
		 			if(i<dateResult.length-1){
						dateArr += "'"+dateResult[i][0]+"',";
					}else{
						dateArr += "'"+dateResult[i][0]+"'";
					}
		 		}
		 		System.out.println("��ܰ��ʾ����  dateArr=="+dateArr);
		 }
		%>
		<table  width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td>
						<div id="cal"></div>
					</td>
					<td valign="top" width="100%">
						
			<%}%>
			
		<div id="form">
		    <table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr> 					
						<th>��&nbsp;��</th> 
						<th>��ʾʱ��</th>
						<th>��&nbsp;��</th>
				</tr>
<%
if(retCode.equals("000000"))
{
	for(int i=0;i<result.length;i++){
	
		String classes="";
		if(i%2==1){classes="grey";}
		String title = result[i][1];
		
		String isFlag = result[i][5].trim();
   		String imgStr1 = "";
   		 if(isFlag.equals("1")){//��Ҫ����
   		 	imgStr1 = "<img src='../../../nresources/"+themePath+"/images/impor.gif' alt='dot' width='14' height='14'>";
   		 }
   		 
		if(!"more".equals(flag)){
			if(title.length()>15){
				 title = title.substring(0,15)+"...";
			}
		}else{
			if(title.length()>20){
				 title = title.substring(0,20)+"...";
			}
		}
%>         
              <tr>
                <td class="<%=classes%>" align="left">
                	<div class="titleNotice" title="<%=title.trim()%>">
                	<img src="../../../nresources/<%=themePath%>/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> 
                	<a href="javascript:showPromptContent('<%=result[i][0]%>')"><%=title%></a> 
                	<%=imgStr1%>
                	</div>
                </td>
                <td class="<%=classes%>" align="left"><a href="javascript:showPromptContent('<%=result[i][0]%>')"><%=result[i][3]%></a> </td>
              	<td class="<%=classes%>" align="left"><img src="../../../images/ico_edit.gif"  onclick="editPrompt('<%=result[i][0]%>')" style='cursor:hand' alt="�޸�"/>&nbsp;&nbsp;&nbsp;<img src="../../../images/ico_delete.gif"  style='cursor:hand' alt="ɾ��" onclick="delPrompt('<%=result[i][0]%>')"/></td>
               </tr>
<%
}
    if("more".equals(flag)){
%>
						<tr>
            		<td colspan="3" align="right">
                <%
                		int iQuantity = 0;
                    if(Code.equals("000000")||Code.equals("0"))
                    {
                     if(resultCount.length!=0)
                     {
                     iQuantity=Integer.parseInt(resultCount[0][0].trim());
                     }
                    }                
                    Page pg = new Page(iPageNumber, iPageSize, iQuantity);
                    PageView view = new PageView(request, out, pg);
                    view.setVisible(true, true, 0, 0);
                %>
            		</td>
        		</tr>
        		<tr>
        			<td colspan="3" align="center"><input type="button" value="�ر�" class="b_text_n" onclick="window.close();"></td>
        		</tr>
<%
	}
}
else
{
out.println("<tr><td>��ȡ��ܰ��ʾʧ��</td></tr>");
}
if(!"more".equals(flag)){
%>
						<tr> 
							<th colspan="3" align="left">
								<input class="b_text" type="button" id="morePrompt"  style='cursor:hand' name="morePrompt" value="����"/>
							</th>					 
						</tr>
<%}

%>
            </table>
		  </div>
		  
		  <%if(!"more".equals(flag)){%>
		   </td>
					</tr>
				</table>	
				<%}%>
		</div>
		
<%if(!"more".equals(flag)){%>
<script>
   $("#wait3").hide();		   
</script>		
<%}%>

<script language="JavaScript">
   function showPromptContent(promptSeq){
   	   window.open('showPrompt.jsp?promptSeq='+promptSeq,'_blank','height=300,width=500,top=300,left=500,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
   } 
   
   function editPrompt(promptSeq){
   	  var flag = "";
   		<%if("more".equals(flag)){%>
  				 flag = "more";
		  <%}%>
		var pro = "height=540,width=530,top=125,left=380,toolbar=no,menubar=no, scrollbars=no, resizable=no, location=no, status=no"
   		window.open("updTask.jsp?funcName=<%=funcName%>&promptSeq="+promptSeq+"&flag="+flag+"&ishelper=<%=ishelper%>",'_blank',pro);
   		///window.open("prompt_mod.jsp?promptSeq="+promptSeq);
   }
   
   function delPrompt(promptSeq){
   	
   	  if(rdShowConfirmDialog("ȷ��Ҫɾ����")==1){
	   	  	var packet = new AJAXPacket("delTask_cfm.jsp");
	   	  	packet.data.add("promptSeq" ,promptSeq);
			core.ajax.sendPacket(packet,doDelPrompt,true);
	  		packet =null;
   	  	}
   	}
   	function doDelPrompt(packet){
   		  var retCode = packet.data.findValueByName("retCode"); 
  			var retMsg = packet.data.findValueByName("retMsg");
  			if(retCode!="000000"){//��ѯʧ��
  					rdShowMessageDialog("��ѯʧ��<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
  					return false;
  			}else{
  				  rdShowMessageDialog("ɾ���ɹ���",2);
  				  <%if(!"more".equals(flag)){%>
  				  $("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
  				  //����ҳ����Ҫ������ܰ��ʾ��Ϣ
						showPrompt();
					<%}else{
							if("helper".equals(ishelper)){
						%>
								location.reload();
								window.opener.frames["ifram"].$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
								window.opener.frames["ifram"].showPrompt();
						<%}else{%>
								location.reload();
								window.opener.$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
								window.opener.showPrompt();
						<%}
					}%>
  			}  	
   	}
   	
  <%if(!"more".equals(flag)){%>
   $('#morePrompt').click(function(){
			window.open("taskInfo.jsp?funcName=<%=funcName%>&flag=more",'_blank',"height=380,width=610,top=250,left=200,toolbar=no,menubar=no, scrollbars=no, resizable=no, location=no, status=no");
			//window.open("getNotice2.jsp?flag=more");
	});
	<%}%>
	
</script>


<%if(!"more".equals(flag)){%>
<script type="text/javascript">
if("<%=funcName%>"=="showInWeek"){
	showInWeek();
}else{
	showInMonth();
}
//����������ʾ��Ĭ�ϰ���
function showInWeek(){
	var str = new Array(<%="".equals(dateArr.trim())?"'null'":dateArr.trim()%>);
	
	WdatePicker({eCont:'cal',highLineWeekDay:false,isShowWeek:true,specialDates:str,onpicked:function(dp){
			var selectDate = dp.cal.getDateStr();
			var dateExist = false;
			//��ѡ�е�ʱ������ʾ���򵯳�������������ʾ���򵯳�����������ʾ��Ϣ����
			for(var i=0;i<str.length;i++){
				if(str[i]==selectDate){
					dateExist = true;
				}
			}
			if(dateExist){
				window.open("taskInfo.jsp?funcName=<%=funcName%>&flag=more&selectDate="+selectDate,'_blank',"height=380,width=610,top=250,left=200,toolbar=no,menubar=no, scrollbars=no, resizable=no, location=no, status=no");
			}else{
				if(rdShowConfirmDialog("��ǰ�����޴��������Ƿ���ӣ�")==1){				
					//$("#layer6").show();
				  var pro = "height=540,width=530,top=125,left=380,toolbar=no,menubar=no, scrollbars=no, resizable=no, location=no, status=no"
				  window.open("addTask.jsp?funcName=<%=funcName%>&selectDate="+selectDate,'_blank',pro);
				}
			}
		}
	});
}

//����������ʾ
function showInMonth(){
		var str = new Array(<%="".equals(dateArr.trim())?"'null'":dateArr.trim()%>);
		WdatePicker({eCont:'cal',specialDates:str,onpicked:function(dp){
					var selectDate = dp.cal.getDateStr();
					var dateExist = false;
					//��ѡ�е�ʱ������ʾ���򵯳�������������ʾ���򵯳�����������ʾ��Ϣ����
					//alert("str|"+str+"\nselectDate|"+selectDate);
					for(var i=0;i<str.length;i++){
						if(str[i]==selectDate){
							dateExist = true;
						}
					}
					if(dateExist){
						window.open("taskInfo.jsp?funcName=<%=funcName%>&flag=more&selectDate="+selectDate,'_blank',"height=380,width=610,top=250,left=200,toolbar=no,menubar=no, scrollbars=no, resizable=no, location=no, status=no");
					}else{
						rdShowMessageDialog("��ǰ��������ʾ��Ϣ��",1);
					}
			}
	});
}
 </script>
 <%}%>
