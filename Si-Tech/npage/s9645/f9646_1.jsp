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
    
 		String opCode = "9646";
 		String opName = "ע���������Ϣ��ѯ";
 		
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
%>
<html>
	<head>
	<title>������BOSS-��˼�¼��ѯ</title>
	<script language="javascript">
		<!--
		
			function doQuery(){					
					var begin_time = document.all.begin_time.value;
					var end_time = document.all.end_time.value;					
					//var prompt_type = document.all.prompt_type.value;
					var login_no = document.all.login_no.value;
					var op_code = document.all.op_code.value;
					if(op_code=="")
					{
						rdShowMessageDialog("�������벻��Ϊ�գ�");
						return;
					}
					document.getElementById("qryOprInfoFrame").style.display="block";

					document.qryOprInfoFrame.location = "f9646_getAuditByFunctionCode.jsp?begin_time="+begin_time+"&op_code="+op_code+"&end_time="+end_time+"&login_no="+login_no;
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
				  if(e[i].type=="text"){
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
			<div id="title_zi">ע���������Ϣ��ѯ</div>
		</div>
		<!--
			/*@service information
			 *@name						s9616
			 *@description				��˼�¼��ѯ
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept ��ѯ��ˮ
			 *@inparam			op_time      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			 *@inparam			op_code      ��������
			
			 *@inparam			prompt_type  ��ʾ����
			 *@inparam			login_no     �����˹��ţ��������ˡ��޸��ˡ�ɾ���ˣ�
			 *@return SVR_ERR_NO 
 			 */
		-->
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue" nowrap>��ѯ����</td>
					<td width="35%"><input type="text" name="op_code" id="op_code"  size="18" value=""><font class="orange">*(ALL����ȫ������)</font>&nbsp;&nbsp;</td>
					<td width="15%" class="blue" nowrap>��������</td>
					<td width="35%">
					<input type="text" name="login_no" value="">&nbsp;&nbsp;	</tr>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>��ʼʱ��</td>
					<td width="35%"><input type="text" name="begin_time" id="begin_time"  size="18" value=""><font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;</td>
					<td width="15%" class="blue" nowrap>����ʱ��</td>
					<td width="35%">
					<input type="text" name="end_time" id="end_time"  size="18" value=""><font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;				
				</tr>
				<tr style="display:none">
					<td width="15%" class="blue" nowrap>��ʾ����</td>
					<td width="35%">
						<select name="prompt_type">
							<option value="" selected>��ѡ��</option>
							<option value="11">11->��ǰ��ʾ</option>
							<option value="12">12->������ʾ</option>
							<option value="13">13->�º���ʾ</option>
							<option value="14">14->�ʷ�˵��</option>
						</select>	
					</td>					
					<input type="hidden" name="opNote" value="����Ա��<%=workNo%> ����˵���ע���������Ϣ����" size="90" maxlength="60">
					</td>		
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

     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:99%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

