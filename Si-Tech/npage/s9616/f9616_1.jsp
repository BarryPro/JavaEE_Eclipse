<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9616";
 		String opName = "��˼�¼��ѯ";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
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
	/*zhangyan add ��������,���������˹��ͷ�*/
	String accountType=(String)session.getAttribute("accountType");		
	String sqlChn="select Channels_Code,Channels_Name "
		+"	from sChannelsCode "
		+"	where root_distance >="+loginRootDistance;
		
	if (accountType.equals("2"))
	{
		sqlChn+=" and Channels_Code='08' ";
	}		
	else
	{
		sqlChn+=" and Channels_Code<>'08' ";
	}
	sqlChn+="	order by Channels_Code  ";		
				
%>
<html>
	<head>
	<title>������BOSS-��˼�¼��ѯ</title>
	<script language="javascript">
		<!--
			/**��ʾ"���ݽ�������"**/
			function showOprInfo(){
				doReset();
				oprDiv.style.display="block";
				fieldDiv.style.display="none";
				document.all.confirmFlag.value="oprPromptConfirm";
				document.getElementById("qryFieldInfoFrame").style.display = "none";
				//document.getElementById("promulgateNodeFrame").style.display = "none";
				
			}

			/**��ʾ"����ҵ������"**/
			function showFieldInfo(){
				doReset();
				oprDiv.style.display="none";
				fieldDiv.style.display="block";
				document.all.confirmFlag.value="fieldPromptConfirm";
				document.getElementById("qryOprInfoFrame").style.display="none";
				//document.getElementById("promulgateNodeFrame").style.display = "none";
				
			}

			/**����л���ǩ�����¼�**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					//���ݽ�������
					showOprInfo();
				}else if(flag==2){
					//����ҵ������
					showFieldInfo();
				}
			}		
			
			/**�ı䷢���ڵ����ʹ������¼�
			function changePromNodeType(){
				document.all.townByRegionTr.style.display = "none";
				var promulgateNodeType = document.all.promulgateNodeType;
				if(promulgateNodeType.value==""){
					document.getElementById("promulgateNodeFrame").style.display="none";
					return false;
				}
				document.getElementById("promulgateNodeFrame").style.display = "block";

				if(promulgateNodeType.value=="1"){
					document.promulgateNodeFrame.location = "f9611_getPromNodeByRegion.jsp";
				}else if(promulgateNodeType.value=="2"){
					document.all.townByRegionTr.style.display = "block";
					document.promulgateNodeFrame.location = "f9611_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value;
				}
			}		
			**/
			/**"���ղ��������ѯ"ʱ�����ڵ�������"����"ʱ,ѡ��"����"���õĺ���
			function doChangeTownByRegion(){
				document.promulgateNodeFrame.location = "f9611_getPromNodeByTown.jsp?prom_group_id="+document.all.townByRegionSelect.value;
			}
			**/
			/**ѡ�����
			function getFieldClassCode(){
				document.getElementById("iClassCodeFrame").style.display = "block";
				document.iClassCodeFrame.location = "f9611_getFieldClassCode.jsp?iClassCode="+jtrim(document.all.iClassCode.value)+"&iClassName="+jtrim(document.all.iClassName.value);
			}
			**/
			/**��ʼ��ѯ**/
			function doQuery(){
				if(document.all.confirmFlag.value=="oprPromptConfirm"){
					
					var audit_accept = document.all.audit_accept.value;
					var op_time_begin = document.all.op_time_begin.value;
					var op_time_end = document.all.op_time_end.value;
					var op_code = document.all.op_code.value;
					var bill_type = document.all.bill_type.value;
					var prompt_type = document.all.prompt_type.value;
					var login_no = document.all.login_no.value;
					var Channels_Code = document.all.Channels_Code.value;
					
					if(op_code=="")
					{
						rdShowMessageDialog("�������벻��Ϊ�գ�");
						return;
					}
						
					/*
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("��ʾ�������ܴ��벻��Ϊ��!");
						document.all.sFunctionCode.focus();
						return false;
					}		
					if(iPromptType==""||iPromptType=="none"){
						rdShowMessageDialog("��ѡ����ʾ����!");
						document.all.iPromptType.focus();
						return false;
					}					
					if(iBillType==""||iBillType=="none"){
						rdShowMessageDialog("��ѡ��Ʊ������!");
						document.all.iBillType.focus();
						return false;
					}	
					if(sGroupId==""||sGroupId.length==0){
						rdShowMessageDialog("�����ڵ㲻��Ϊ��,���ѯ!");
						document.all.promulgateNodeType.focus();
						return false;
					}				
					*/
								
					document.getElementById("qryOprInfoFrame").style.display="block"; 
					document.qryOprInfoFrame.location = "f9616_getAuditByFunctionCode.jsp?audit_accept="+audit_accept+"&op_time_begin="+op_time_begin+"&op_time_end="+op_time_end+"&op_code="+op_code+"&bill_type="+bill_type+"&prompt_type="+prompt_type+"&login_no="+login_no+"&Channels_Code="+Channels_Code+"&rootDistance=<%=loginRootDistance%>";
				}
				
				if(document.all.confirmFlag.value=="fieldPromptConfirm"){
					var audit_accept01 = document.all.audit_accept01.value;
					var op_time01_begin = document.all.op_time01_begin.value;
					var op_time01_end = document.all.op_time01_end.value;
					var op_code01 = document.all.op_code01.value;
					var bill_type01 = document.all.bill_type01.value;
					var prompt_type01 = document.all.prompt_type01.value;
					var login_no01 = document.all.login_no01.value;
					var class_code = document.all.class_code.value;
					var Channels_Code2 = document.all.Channels_Code2.value;
		      		var class_value = document.all.class_value.value;

					if(op_code01=="")
					{
						rdShowMessageDialog("�������벻��Ϊ�գ�");
						return;
					}
					
					
					/*
					if(sFunctionCode==""||sFunctionCode.length==0){
						rdShowMessageDialog("��ʾ�������ܴ��벻��Ϊ��!");
						document.all.sFunctionCode2.focus();
						return false;
					}	
					if(iPromptType==""||iPromptType=="none"){
						rdShowMessageDialog("��ѡ����ʾ����!");
						document.all.iPromptType2.focus();
						return false;
					}					
					if(iBillType==""||iBillType=="none"){
						rdShowMessageDialog("��ѡ��Ʊ������!");
						document.all.iBillType2.focus();
						return false;
					}
					if(sGroupId==""||sGroupId.length==0){
						rdShowMessageDialog("�����ڵ㲻��Ϊ��,���ѯ!");
						document.all.promulgateNodeType.focus();
						return false;
					}									
					*/
					
					document.getElementById("qryFieldInfoFrame").style.display = "block";
					document.qryFieldInfoFrame.location = "f9616_getAuditByClassCode.jsp?audit_accept01="+audit_accept01+"&op_time01_begin="+op_time01_begin+"&op_time01_end="+op_time01_end+"&op_code01="+op_code01+"&bill_type01="+bill_type01+"&prompt_type01="+prompt_type01+"&login_no01="+login_no01+"&class_code="+class_code+"&class_value="+class_value+"&Channels_Code="+Channels_Code2+"&rootDistance=<%=loginRootDistance%>";					
				}
			}
			
			/**����ҳ��**/
			function doReset(){
				//��Ϊdocument.all.confirmFlag.value�����л�ӵ�в�ͬ��ֵ
				//���frm.reset(),�����״���.
				//�ɷ������µĴ���,�޸ĳ�:window.location.reload()����window.location.href="xxxx"
				var e = document.forms[0].elements;
				for(var i=0;i<e.length;i++){
				  if(e[i].type=="select-one"){
				  	e[i].value="";
				  	e[i].disabled=false;
				  }
				  if(e[i].type=="text"&&e[i].name!="confirmFlag"){
				  	e[i].value="";
				  	e[i].disabled=false;
				  }
				}
				
				//�������е���ʾ��iframe
				var iframes = document.getElementsByTagName("iframe");
				for(var i=0;i<iframes.length;i++){
					iframes[i].style.display = "none";	
				}
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

<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">

		<div class="title">
			<div id="title_zi">��ѡ���������</div>
		</div>
		
		<!--�л���ǩ,����и����ʵı�ǩ,,�����滻-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>���ݽ����ѯ</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>����ҵ���ѯ</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
	
		<!--
			/*@service information
			 *@name						s9616
			 *@description				��˼�¼��ѯ
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept ������ˮ
			 *@inparam			op_time      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			 *@inparam			op_code      ��������
			 *@inparam			bill_type    Ʊ������
			 *@inparam			prompt_type  ��ʾ����
			 *@inparam			login_no     �����˹��ţ��������ˡ��޸��ˡ�ɾ���ˣ�
			 *@return SVR_ERR_NO 
 			 */
		-->
		<div id="oprDiv" style="display:block">
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%"><input type="text" name="op_code" id="op_code"  size="18" value=""><font class="orange">*(ALL����ȫ������)</font>&nbsp;&nbsp;</td>
					<td width="15%" class="blue" nowrap>������ˮ</td>
					<td><input type="text" name="audit_accept" id="audit_accept"  size="18" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>����ʱ��</td>
					<td><input type="text" name="op_time_begin" id="op_time_begin" size="10" value="">&nbsp;-&nbsp;<input type="text" name="op_time_end" size="10" value=""><span>(��ʽ��yyyymmdd)</span></td>
					<td width="15%" class="blue" nowrap>Ʊ������</td>
					<td width="35%">
						<select name="bill_type">
							<option value="" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>	
					</td>
				</tr>
					<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td width="35%">
						<select name="prompt_type">
							<option value="" selected>��ѡ��</option>
							<option value="11">11->��ǰ��ʾ</option>
							<option value="13">13->�º���ʾ</option>
						</select>	
					</td>
					<td width="15%" class="blue" nowrap>�����˹���</td>
					<td width="35%"><input type="text" name="login_no" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td  class="blue" nowrap>��������</td>
					<td>
						<select name="Channels_Code">
							<%

							if (!accountType.equals("2"))
							{
							%>
								<option value="" selected>��ѡ��</option>
							<%
							}
							else
							{
							%>
								<option value="2" selected>��ѡ��</option>
							<%
							}
							%>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>				
						  <input type="hidden" name="Channels_CodeHidden" value="">									
					</td>	
					<td>&nbsp;</td>	
					<td>&nbsp;</td>		
				</tr>				
			</table>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
		        </td>
		      </tr>
		    </table>
		</div>
		<!--
			/*@service information
			 *@name						s9616Cfm1
			 *@description				��˼�¼��ѯ
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept ������ˮ
			 *@inparam			op_time      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			 *@inparam			op_code      ��������
			 *@inparam			bill_type    Ʊ������
			 *@inparam			prompt_type  ��ʾ����
			 *@inparam			login_no     �����˹��ţ��������ˡ��޸��ˡ�ɾ���ˣ�
			 *@inparam			class_code   ����
			 *@inparam			class_value  �ֶ���ֵ
			 *@return SVR_ERR_NO 
 			 */
		-->
		<div id="fieldDiv" style="display:none">
			<table cellspacing="0">
			<tr>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%"><input type="text" name="op_code01" value="" size="18"><font class="orange">*(ALL����ȫ������)</font>&nbsp;&nbsp;</td>
					<td width="15%" class="blue" nowrap>������ˮ</td>
					<td><input type="text" name="audit_accept01" value="" size="18">&nbsp;&nbsp;</td>
			</tr>
				<tr>
					<td width="15%" class="blue" nowrap>����ʱ��</td>
					<td><input type="text" name="op_time01_begin" size="10" value="">&nbsp;-&nbsp;<input type="text" name="op_time01_end" size="10" value=""><span>(��ʽ��yyyymmdd)</span></td>
					<td width="15%" class="blue" nowrap>Ʊ������</td>
					<td width="35%">
						<select name="bill_type01">
							<option value="" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select bill_type,bill_type||'->'||bill_name from sPrintBillType where bill_type = '1'</wtc:sql>
							</wtc:qoption>
						</select>	
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td width="35%">
						<select name="prompt_type01">
							<option value="" selected>��ѡ��</option>
							<option value="2">11->�ʷ�����</option>
							<option value="12">12->������ʾ</option>
							<option value="13">13->�º���ʾ</option>
						</select>	
					</td>
					<td width="15%" class="blue" nowrap>�����˹���</td>
					<td width="35%"><input type="text" name="login_no01" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>����</td>
					<td width="35%">
						<select name="class_code">
							<option value="" selected>��ѡ��</option>
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select class_code,to_char(class_code)||'->'||class_name from sClass where class_code in (10431,10442,10702)</wtc:sql>
							</wtc:qoption>
						</select>
					</td>
					<td width="15%" class="blue" nowrap>�ֶ���ֵ</td>
					<td width="35%"><input type="text" name="class_value" value="">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td  class="blue" nowrap>��������</td>
					<td>
						<select name="Channels_Code2">
							<%
							if (!accountType.equals("2"))
							{
							%>
								<option value="" selected>��ѡ��</option>
							<%
							}
							else
							{
							%>
								<option value="2" selected>��ѡ��</option>
							<%
							}
							%>
							
							<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql><%=sqlChn%></wtc:sql>
							</wtc:qoption>
						</select>				
						  <input type="hidden" name="Channels_Code2Hidden" value="">									
					</td>	
					<td>&nbsp;</td>	
					<td>&nbsp;</td>		
				</tr>				
			</table>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="doReset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
		        </td>
		      </tr>
	     	</table>
	    	</div>
     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryFieldInfoFrame" align="center" name="qryFieldInfoFrame" scrolling="yes" style="height:300px  ;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
					</td>
				</tr>
			</table>
			<!--����Ϊ��������-->
			<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryFieldAuditInfoFrame" align="center" name="qryFieldAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryFieldInfoFrame').style.height=qryFieldInfoFrame.document.body.scrollHeight+50+'px'"></iframe>
					</td>
				</tr>
			</table>
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

