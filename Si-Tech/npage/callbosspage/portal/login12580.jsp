<%
  /*
   * ����: 12580������ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/02/22
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
   * �޸����� 2009-06-12     �޸���  donglei     �޸�Ŀ�� �޸ķ���
�� */
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<style type="text/css">
		body {
			FONT: 12px Arial, Helvetica, sans-serif;
		}
		</style>
	<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	</head>
	<%
		//������룬ԭʼ����
		
		String phone_no = (String)request.getParameter("activePhone")==null?"":request.getParameter("activePhone");//ԭʼ����
		//��������
		String calltype = (String)request.getParameter("calltype")==null?"":request.getParameter("calltype");
		//���к���
		String caller = (String)request.getParameter("caller")==null?"":request.getParameter("caller");
		//���к���
		String called = (String)request.getParameter("called")==null?"":request.getParameter("called");
		
		String callinfo = "";
		
		if("0".equals(calltype)){
			callinfo = "��ͨ "+called;
			session.setAttribute("capn",phone_no);
		}else{
			callinfo = "��ת "+called;
			session.setAttribute("catype","Z");
			session.setAttribute("capn",phone_no);			
		}
		//1258��1259�ƶ�����
	
		//���ж��Ƿ�ͨ���ƶ��������
    String ynHasSql = "select to_char(count(*)) from dsrvmsg " +
				"where id_no=(select id_no from dcustmsg where phone_no='"+phone_no+"') " +
						"and (service_code='tf31' " +
						"or service_code='tf32' " +
						"or service_code='tf90' " +
						"or service_code='tf91' " +
						"or service_code='tf92' " +
						"or service_code='tf93')";
						
		//���жϿ�ͨ���ƶ���������Ƿ���Ч
		String ynAvaSql = "select to_char(count(*)) from dsrvmsg " +
				"where id_no=(select id_no from dcustmsg where phone_no='"+phone_no+"') " +
						"and (service_code='tf31' " +
						"or service_code='tf32' " +
						"or service_code='tf90' " +
						"or service_code='tf91' " +
						"or service_code='tf92' " +
						"or service_code='tf93') " +
						"and begin_time<=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm') " +
						"and end_time>=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm')";
	
	%>
	<body>
		<wtc:service name="sKFLogin1258" outnum="6" routerKey="phone" routerValue="<%=phone_no %>">
			<wtc:param value="<%=phone_no%>"/>
		</wtc:service>
		<wtc:array id="rows" scope="end"/>
			<%				
				String cust_name = "";
				String card_name = "";
				String town_name = "";
				String sm_name = "";
				String avaNum = "";
				String hasNum = "";
			  if(retCode.equals("000000"))
			  {
					cust_name      = rows[0][0];					
					card_name      = rows[0][1];
					town_name      = rows[0][2];
					sm_name		     = rows[0][3];
					avaNum         = rows[0][4];
					hasNum         = rows[0][5];					
			  }
			%>
			<DIV class="Info">
		   <DIV class="groupItem_no" >
				 <DIV class="itemHeader">
				  	<DIV id="zi">�ҵ���Ϣ</DIV>
				  	<DIV id="tu">
					   <DIV id="sub">
				     <DIV class="li"><img id=reload0 src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' onClick="location.reload();"></DIV>    
					  </DIV>
					</DIV>
				 </DIV>
				 <div id="blueBG">
					<div id="Info_table">
						<table border="0" cellpadding="0" " cellspacing="1" width="100%">
						<tr height="22px">
							<th height="22px" nowrap>�������:<%=phone_no %>&nbsp;&nbsp;���к���:<%=caller %></th>
							<th width="30%" colspan="2">��������:<%=callinfo %></th>
						</tr>						
						<tr height="22px">
							<th height="22px" nowrap >�û�����:<%=cust_name%></th>
							<td width="30%" colspan="2">&nbsp;</td>
						</tr>
						<tr height="22px">
							<th height="22px" nowrap >������:<%=town_name%></th>
							<td width="30%" colspan="2">&nbsp;</td>
						</tr>
						<tr height="22px">
							<th height="22px" nowrap >�ͻ�����:<%=card_name%></th>
							<td width="30%" colspan="2">&nbsp;</td>
						</tr>
						<tr height="22px">
							<th height="22px" nowrap >�ͻ�Ʒ��:<%=null == sm_name?"" : sm_name%></th>
							<td width="30%" colspan="2">&nbsp;</td>
						</tr>
						<%
						String[][] dataRows = new String[][] {};
						
						%>					
						<wtc:service name="sPubSelect" outnum="1">
							<wtc:param value="<%=ynAvaSql %>" />
						</wtc:service>
						<wtc:array id="queryList" start="0" length="1" scope="end" />
						<%
						
						dataRows = queryList;
						if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
							session.setAttribute("KFTF32","availability");
							out.println("<tr><th height='22px' nowrap >���� "+phone_no+" �ѿ�ͨ�ƶ��������</th><td colspan='2'>&nbsp;</td></tr>");
						}else{
							
						%>
							<wtc:service name="sPubSelect" outnum="1">
								<wtc:param value="<%=ynHasSql %>" />
							</wtc:service>
							<wtc:array id="queryList" start="0" length="1" scope="end" />
							<%
							dataRows = queryList;
							if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
								session.setAttribute("KFTF32","abate");
								out.println("<tr><th height='22px' nowrap >���� "+phone_no+" �ѿ�ͨ�ƶ����������ʧЧ��</th><td colspan='2'>&nbsp;</td></tr>");
							}else{
								session.setAttribute("KFTF32","notf32");
								out.println("<tr><th height='22px' nowrap >���� "+phone_no+" ��δ��ͨ�ƶ��������</th><td colspan='2'>&nbsp;</td></tr>");
							}
						}
						
						%>
						<%
						String lwSqlv = "select msg_content,to_char(begin_time,'yyyy-MM-dd'),to_char(end_time,'yyyy-MM-dd'),to_char(begin_time,'HH24:mi:ss'),to_char(end_time,'HH24:mi:ss') from DTAKEMSG where msg_type = '1' and accept_no = '"+phone_no+"' and begin_time <= sysdate and end_time >= sysdate";
						%>
						<wtc:service name="s151Select" outnum="5">
								<wtc:param value="<%=lwSqlv %>" />
						</wtc:service>
						<wtc:array id="lwListv" start="0" length="5" scope="end" />
						<%
								dataRows = lwListv;
								if(dataRows.length > 0){
									out.println("<tr><th height='22px' nowrap >���������ԣ���������Ϊ��<span class='style1'>"+dataRows[0][0]+"</span></th><td colspan='2'>&nbsp;</td></tr>");
									out.println("<tr><th height='22px' nowrap >�������ڷ�Χ��<span class='style1'>"+dataRows[0][1]+" "+dataRows[0][3]+"~"+dataRows[0][2]+" "+dataRows[0][4]+"</span></th><td colspan='2'>&nbsp;</td></tr>");
									
								}else{
									out.println("<tr><th height='22px' nowrap >��δ��������</th><td colspan='2'>&nbsp;</td></tr>");
								}						
						%>
						<tr>
				        <th>
				        	<a href=javascript:parent.parent.parent.L("2","1213","�ۺϱ��","PersonChange/s1213/f1213.jsp","000")  ><span class='orange'>[�ۺϱ��]</span></a>
				        </th> 	  		   	
				  	   	<th colspan="2">
				  	   		<a href=javascript:parent.parent.parent.L("2","1351","�ʵ���ʷ��ѯ","../npage/portal/kfuser/f1351_kf.jsp?phoneNo=<%=phone_no%>","000")  ><span class='orange'>[�ʵ���ʷ��ѯ]</span></a>
				  	   	</th>
				  	</tr>
				  	<tr>
				  	    <th>
				  	    	<a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperHistoryInfo.jsp');"><span class='orange'>[��ʷ��Ϣ]</span></a>
				  	    </th>  	    
				  	    <th colspan="2">
				  	    	<a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fKFPointMonth.jsp');"><span class='orange'>[���ְ��²�ѯ]</span></a>
				  	    </th>
				  	</tr>
				  	<tr>
				  	    <th>
				  	    	<a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fPayHistoryInfo.jsp');"><span class='orange'>[�ɷѲ�ѯ]</span></a>
				  	    </th>  	    
				  	  	<th colspan = "2">
				  	  		<a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fKFPointDetail.jsp');"><span class='orange'>[������ϸ��ѯ]</span></a>
				  	  	</th>
				  	</tr>
					  <tr>
					      <th>
					      	<a href=javascript:parent.parent.parent.L("2","1515","��ѷ�������ѯ","MessageQuery/s1515/f1515_1.jsp","000")><span class='orange'>[��ѷ�������ѯ]</span></a>
					      </th>  	   
				  	    <td colspan = "2">
				  	    	&nbsp;
				  	    </td>	    
				  	</tr>						
		      	</table>
		      </div>
		     </div>
		   </DIV>
			</DIV>
			<div id="sort1" class="groupWrapper">
			  <div id="div13_show" class="groupItem">
				    <div class="itemHeader">
						<div id="zi">�ʻ���������</div>
						<DIV id="tu">
						   <div id="sub">
						   	<DIV class="li"><img id="KFConInfo_reload" extend_attr="KFConInfo" onclick="func_reload(this);return false;"src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
							 	<div class="li"><img id="KFConInfo_closeEl" extend_attr="KFConInfo" onclick="upAndDown(this);return false;" class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
							 	<div class="li"><img id="fKFConInfo" extend_attr="KFConInfo" onclick= "openBigPage(this);return false;" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						   </div>
						</DIV>
						</div>
						<div class="KFConInfo_itemContent"style="display:none"  id="KFConInfo">
				      	<iframe id="KFConInfo_framer" name="KFConInfo_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
						</div>
			  </div>
				<div id="div11_show" class="groupItem">
				   <div class="itemHeader">
							<div id="zi">��ͻ�������Ϣ</div>
							<DIV id="tu">
							   <div id="sub">
							   <DIV class="li"><img id="bigQuery_reload" extend_attr="bigQuery" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
								 <div class="li"><img id="bigQuery_closeEl" extend_attr="bigQuery" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
								 <div class="li"><img id="fbigQuery" extend_attr="bigQuery" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
							   </div>
							</DIV>
					 </div>
					 <div class="itemContent"  style="display:none" id="bigQuery">
							  <iframe id="bigQuery_framer" name="bigQuery_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
					 </div>
				</div>

		  </div>
		  <div id="sort1" class="groupWrapper">
		  <div id="div7_show" class="groupItem">
			    <div class="itemHeader">
						<div id="zi">������������</div>
						<DIV id="tu">
						   <div id="sub"> 	
						   <DIV class="li"><img id="KFOrgInfo_reload" extend_attr="KFOrgInfo" onclick="func_reload(this);return false;"src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
							 <div class="li"><img id="KFOrgInfo_closeEl" extend_attr="KFOrgInfo" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
							 <div class="li"><img id="fKFOrgInfo" extend_attr="KFOrgInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>					
						   </div>
						</DIV>
						</div>
						<div class="itemContent" style="display:none"  id="KFOrgInfo">
						  <iframe id="KFOrgInfo_framer" name="KFOrgInfo_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>			     
						</div>
				</div>
				<div id="div5_show" class="groupItem">
					   <div class="itemHeader">
							<div id="zi">��Ʒ��Ϣ</div>
							<DIV id="tu">
							   <div id="sub">							   	      
							     <DIV class="li"><img id="product_reload" extend_attr="product" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
									 <div class="li"><img id="product_closeEl"extend_attr="product" onclick="upAndDown(this);return false;" class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
									 <div class="li"><img id="fproduct_sel" extend_attr="product" onclick= "openBigPage(this);return false;" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
									</div>
								</DIV>
						</div>
						<div class="product_itemContent" style="display:none"  id="product">
						  <iframe id="product_framer" name="product_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe> 
						</div>
				</div>
			</div>
				
<form name="par_form" method="post">
	<input type="hidden" name="activePhone" value="<%=phone_no %>">
</form>
	</body>
</html>
<script>
function keydown_release(){
			  if (window.event.keyCode==119){
			     //ʹ��F8���һ�
			     if(parent.parent.document.getElementById('K013') != undefined){
			      
			      parent.parent.document.getElementById('K013').click();
			     
			     }   
			     event.returnValue=false;
			  }
			}

    var obj = document.getElementsByTagName("body");

		if(window.addEventListenner){
		  obj[0].addEventListenner("keydown",keydown_release,false);
		}
		else
		 obj[0].attachEvent("onkeydown",keydown_release);

function showPageInfo(tagUrl)
{
	var height = 400;
	var width = screen.availWidth-220;
	var top = screen.availHeight/2 - height/2+120;
	var left = screen.availWidth/2 - width/2+100;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=yes resizable=yes,location=no, status=yes ";
	window.open(tagUrl,'',winParam);
}

  var loadHash = new Object();
  loadHash["#product"] = "../../portal/kfuser/fproduct_sel.jsp";
  loadHash["#bigQuery"] = "../../portal/kfuser/fbigQuery.jsp";
  loadHash["#KFConInfo"] = "../../portal/kfuser/fKFConInfo.jsp";
  loadHash["#KFOrgInfo"] = "../../portal/kfuser/fKFOrgInfo.jsp";
  //����
  function upAndDown(ob){
  	
  	var ext_id=ob.getAttribute("extend_attr");
  	var par_ob=document.getElementById(ext_id);
  	if(par_ob.style.display=='none'){
  		ob.src="../../../nresources/default/images/jian.gif";
  		par_ob.style.display="block";
  		document.forms[0].action=loadHash['#'+ext_id]
  		document.getElementById(ext_id+'_framer').style.display="block"
  		document.forms[0].target=ext_id+'_framer'
  		document.forms[0].submit();
  	}else{
  		ob.src="../../../nresources/default/images/jia.gif";
  		par_ob.style.display="none";
    }	
  }
  function func_reload(ob){
	  var ext_id=ob.getAttribute("extend_attr");
	  var par_ob=document.getElementById(ext_id);
  	if(par_ob.style.display!='none'){
  	 document.forms[0].action=loadHash['#'+ext_id]
  	 document.forms[0].target=ext_id+'_framer'
  	 document.forms[0].submit();
    }
  }
  
  var big_Opener;
	function openBigPage(value){
		var big_Url = "../../portal/kfuser/allbigpage.jsp";
		var id = value.id;
		if(big_Opener==null){
				big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
		}else{
				try{
						big_Opener.document.body.focus();
						big_Opener.location.href(big_Url+"?id="+id);
			  }catch(e){
			  		big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
			  }
				
		}
	}
</script>