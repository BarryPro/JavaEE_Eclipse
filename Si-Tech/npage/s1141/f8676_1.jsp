<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "8676";
 		String opName = "��e��G3�ʼǱ��󶨹�ϵ��ѯ";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/**�����������������"����"��ʱ��,ҳ����ʾ�Ĳ�������**/
		String confirmFlag = WtcUtil.repNull(request.getParameter("confirmFlag"));
		
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
		
		/**�鿴���ŵļ���,�����Ӫҵ���ļ�����С,��������޸�ҳ��**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		/**������ŵļ�������ظ�С,���ܽ����޸Ĳ���;1.�жϹ��ŵļ���,���root_distance==1,ʡ��,==2,����,==3,����,>3,Ӫҵ�����С�ļ���**/
		if(loginRootDistance>3){
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(�˹������޸�Ȩ��)</font>
						</td>
					</tr>
				</table>
				<script language="javascript">
					<!--
					rdShowMessageDialog("�˹������޸�Ȩ��");
					window.close();
					//-->
				</script>		
<%
			return;
		}
%>
<html>
	<head>
	<title>������BOSS-��e��G3�ʼǱ��󶨹�ϵ��ѯ</title>
	<!--����js��-->
	<script language="javascript">
		<!--

				
			onload = function(){
				
				/**������δ�������������"����"��,ҳ����ʾ�ǲ�������.����ɾ����δ���,���Ҳ�Ӱ��ҳ��**/
				var confirmFlag = "<%=confirmFlag%>";
				if(confirmFlag=="fieldPromptConfirm"){
					showMessage(2);
				}else{
					showMessage(1);
				}	
				/***������Ϊֹ***/
			}
			
			/**��ʾ"���ݽ�������"**/
			function showOprInfo(){
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
			}

			/**��ʾ"����ҵ������"**/
			function showFieldInfo(){
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
			}	
			
			
			/**����л���ǩ�����¼�**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//���ݽ����޸�
					showOprInfo();
				}else if(flag==2){
					//����ҵ���޸�
					showFieldInfo();
				}
			}	
			
			/**���"��ѯ"��ť�������¼�**/
			function doQuery(){
				var phoneNo = "";
				var imeiNo = "";

				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					phoneNo = jtrim(document.all.phoneNo.value);
					
					if(phoneNo==""||phoneNo.length==0){
						rdShowMessageDialog("�ֻ����벻��Ϊ��!");
						return;							
					}
	
					if(phoneNo.length!=11){
						rdShowMessageDialog("��������ֻ����볤������!");
						return;							
					}
	
					if(!checkElement(document.all.phoneNo)){
						document.frm.phoneNo.value = "";
						return;
					}
							
					document.frm.queryButton.disabled = true;
					document.frm.phoneNo.disabled = true;
				
					document.getElementById("qryOprInfoFrame").style.display="block";
					document.qryOprInfoFrame.location.href = "f8676_2.jsp?phoneNo="+phoneNo+"&imeiNo"+imeiNo+"&rootDistance=<%=loginRootDistance%>";
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					imeiNo = jtrim(document.all.imeiNo.value);
					
					if(imeiNo==""||imeiNo.length==0){
						rdShowMessageDialog("IMEI�벻��Ϊ��!");
						return;							
					}
	
					if(!checkElement(document.all.imeiNo)){
						document.frm.imeiNo.value = "";
						return;
					}
					
					document.frm.queryButton.disabled = true;
					document.frm.phoneNo.disabled = true;
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location.href = "f8676_3.jsp?imeiNo="+imeiNo+"&phoneNo"+phoneNo+"&rootDistance=<%=loginRootDistance%>";						
				}
			}
			
			/**�����ַ����ҵĿո�**/
			function jtrim(str){
				if(str==null){
					return "";	
				}
				return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
			}		
				
			/**����ҳ��**/
			function doReset(){
				//window.location.reload();
				//��"����"ҳ��ʱ,���������־�Զ���ת������ǰ���Ǹ�ҳ��
				window.location.href = "f8676_1.jsp?confirmFlag="+document.all.confirmFlag.value;
			}
			
			/**�ر�ҳ��**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			//-->
	</script>
	
	<!--���css��ʽ�����������л���ǩ����ʽ,,,����и��õ��л���ǩ���滻,,,��ɾ�������ʽ,��Ӱ��ҳ����������-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>
</head>

<!--
	������������,1,����,2,�ջ�,3,����
	/**
		����ӡ����Ϊ"1,��ʾ"��ʱ��,��ʾ����:12-����
		����ӡ����Ϊ"2,��ӡ"��ʱ��,��ʾ����:13-�º�2-�ʷ�˵��
		����ӡ����Ϊ"3,��ӡ����ʾ"��ʱ��,��ʾ����:12-����
	**/
-->
			
<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		<!--���������ǳ���Ҫ.��Ҫ��ͨ������������"���ݽ����޸�"����"����ҵ���޸�"-->
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">

		<input type="hidden" name="createLogin" value="">
		<!--����Ϊ��������-->
		
		<div class="title">
			<div id="title_zi">��ѡ���������</div>
		</div>
		
		<!--�л���ǩ,����и����ʵı�ǩ,,�����滻-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>���ݿͻ��ֻ������ѯ</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>���ݱʼǱ�IMEI���ѯ</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<div id="oprDiv" style="display:block">
			<table cellspacing="0" align="center">
				<tr>
					<td width="15%" class="blue" nowrap>�������ֻ�����</td>
					<td width="35%">
						<input type="text" name="phoneNo" value="" onKeyDown="if(event.keyCode==13){doQuery();}">&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showOprInfoFrame" align="center" name="showOprInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showOprInfoFrame').style.height=showOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>

		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>������ʼǱ�IMEI��</td>
					<td width="35%">
						<input type="text" name="imeiNo" value="">&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
							<iframe frameBorder="0" id="iClassCodeFrame" align="center" name="iClassCodeFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('iClassCodeFrame').style.height=iClassCodeFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>	
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:0;">
						<iframe frameBorder="0" id="showFieldInfoFrame" align="center" name="showFieldInfoFrame" scrolling="no" style="height:100%; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('showFieldInfoFrame').style.height=showFieldInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<!--����Ϊ��������-->
		<table cellSpacing="0">
      <tr> 
        <td id="footer"> 
        	 <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()">&nbsp;
           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
        </td>
      </tr>
     </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
