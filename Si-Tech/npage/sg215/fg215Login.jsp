<%
  /*
   * ����:�������״̬��Ϣ��ѯ--��ѯ����ҳ��
   * �汾: 1.0
   * ����: 20121015
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		//String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		//��ˮ��
 		String PrintAccept = getMaxAccept();
 		//��ѯ��ǰ�����Ƿ���Ӫҵ��(��֯��������ͼ�)
 		String gruopSQL="SELECT t.group_id,t.group_name,t.root_distance FROM dchngroupmsg t,dloginmsg t2"+
 		" WHERE t.group_id=t2.group_id AND t2.login_no='"+sWorkNo+"'";
 		//Ԥ��Ӫҵ����֯����id
 		String lvlGrpId="";
 		//Ԥ��Ӫҵ������
 		String lvlGrpName="";
 		//�Ƿ�����Ӫҵ��
 		boolean lvlFlag=false;

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=gruopSQL%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result11" scope="end" />
<%
		if(result11.length<=0)
		{
				lvlFlag=false;
%>

<script language="JavaScript">
			rdShowMessageDialog("��ѯ������֯������Ϣʧ�ܣ�",0);
			removeCurrentTab();
</script>

<%
		}
else if("4".equals(result11[0][2])){
		lvlGrpId   =  result11[0][0];
		lvlGrpName =	result11[0][1];
		lvlFlag    =  true;
}
else
	{
		lvlFlag    =  false;
	}
%>

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			//�����Ӫҵ������
			if(<%=lvlFlag%>)
			{
				$("input[name='getGroupTree']").attr("disabled",true);
				$("#addObjectId").val("<%=lvlGrpId%>--<%=lvlGrpName%>");
				$("input[name='iGroupId']").val("<%=lvlGrpId%>");
			}
			//����
			else if(!<%=lvlFlag%>)
			{
				$("input[name='getGroupTree']").attr("disabled",false);
				$("#addObjectId").val("");
				$("input[name='iGroupId']").val("");
			}
			
		});
		//չ����֯�������νṹ
		function queryObjectId()
		{
			var path = "tree/groupTree.jsp";
			window.open(path + "?grouptype=form_g215&grpId=addObjectId","","height=600,width=300,scrollbars=yes");
		}
		//�ύ����
		function doSubmit()
		{
			if(check(form_g215))
			{
				var opFlag = $("input[name='opFlag']:checked").val();
				var startTime = $("#startCust").val().trim();
				var endTime = $("#endCust").val().trim();
				//���������˺Ų�ѯ
				if(opFlag=="0")
				{
					//���¸�ֵΪ�ɼ�
					var skdUser = $("input[name='sKdUser']").val();
					$("input[name='iSKdUser']").val(skdUser);
					if(skdUser.length==0)
					{
						rdShowMessageDialog("���������˺ţ�",1);
						return false;
					}
					//���ö���״̬
					$("input[name='sErrFlag']").val("0");
					form_g215.action="/npage/sg215/fg215QryZh.jsp";
				}
				//�������ֹʱ���ѯ
				if(opFlag=="1")
				{
					//���û��ѡ����֯�ڵ�
					if($("#addObjectId").val().trim().length==0)
					{
						rdShowMessageDialog("��ѡ����֯�ڵ㣡",1);
						return false;
					}
					if(startTime.length==0)
					{
						rdShowMessageDialog("��ѡ��ʼʱ�䣡",1);
						return false;
					}
					if(endTime.length==0)
					{
						rdShowMessageDialog("��ѡ�����ʱ�䣡",1);
						return false;
					}
					if(startTime.length!=0)
					{
						startTime = startTime.replace("��-","");
						startTime = startTime.replace("��-","");
						startTime = startTime.replace("��","");
						$("input[name='iStartTime']").val(startTime);
					}
					if(endTime.length!=0)
					{
						endTime = endTime.replace("��-","");
						endTime = endTime.replace("��-","");
						endTime = endTime.replace("��","");
						$("input[name='iEndTime']").val(endTime);
					}
					//������˺�������ֵΪ�գ��Ա��ڲ�Ӱ�찴ʱ���ѯ������
					$("input[name='iSKdUser']").val("");
					form_g215.action="/npage/sg215/fg215Qry.jsp";
				}
				
				form_g215.submit();
			}
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="form_g215">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table id="koManage">
		<tr>
			<td class="blue" width="20%">��������</td>
			<td colspan="3">
				<input type="radio" name="opFlag" value="0" data-bind="checked:offerId"/>������˺Ų�ѯ
				<input type="radio" name="opFlag" value="1" data-bind="checked:offerId"/>����ֹʱ���ѯ
			</td>
		</tr>
		<tr data-bind="visible:offerId()==0">
			<td class="blue" width="20%">����˺�</td>
			<td colspan="3"><input type="text" name="sKdUser" style="width:220px" value="" maxlength="25"/>
				&nbsp;<font color="red">(��󳤶�25�ַ�)</font></td>
		</tr>
		<tr data-bind="visible:offerId()==1">
			<td class="blue">��ʼʱ��</td>
				<td>
				<input type="text" id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'startCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'endCust\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" id="endCust"  name="endCust" readOnly onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'endCust',startDate:'%y-%M-%d',dateFmt:'yyyy��-MM��-dd��',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startCust\')}',maxDate:'%y-%M-%d'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			</td>
		</tr>
		<tr data-bind="visible:offerId()==1">
			<td class="blue" width="20%">��֯�ڵ�</td>
			<td width="30%"><input type="text" name="addObjectId" id="addObjectId"  value="" readonly/>&nbsp;&nbsp;
				<input type="button" class="b_text" name="getGroupTree" value="ѡ��" onclick="queryObjectId()"/> 
			&nbsp;<font color="red">*</font>
			</td>
			<td class="blue" width="15%" >��������</td>
			<td  width="35%" >
				<select name="sErrFlag">
					<option value="0" selected>ȫ������</option>
					<option value="1">�쳣����</option>
					</select>
			</td>
			</td>
		</tr>
		
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="��ѯ" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot"  value="����" onclick="javascript:window.location.reload();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<!--��֯�������� -->
	<input type="hidden" name="iGroupId" value=""/>
	<!--��ˮ�� -->
	<input type="hidden" name="iLoginAccept" value=""/>
	<!--������ʶ -->
	<input type="hidden" name="iChnSource" value="01"/>
	<!--�������� -->
	<input type="hidden" name="iOpCode" value="<%=opCode%>"/>
	<!--�������� -->
	<input type="hidden" name="iOpName" value="<%=opName%>"/>
	<!--���� -->
	<input type="hidden" name="iLoginNo" value="<%=sWorkNo%>"/>
	<!--�������� -->
	<input type="hidden" name="iLoginPwd" value="<%=dNopass%>"/>
	<!--�ֻ����� -->
	<input type="hidden" name="iPhoneNo" value=""/>
	<!--�������� -->
	<input type="hidden" name="iUserPwd" value=""/>
	<!--��ʼʱ�� -->
	<input type="hidden" name="iStartTime" value=""/>
	<!--����ʱ�� -->
	<input type="hidden" name="iEndTime" value=""/>
	<!--����˺� -->
	<input type="hidden" name="iSKdUser" value=""/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko���� script����-->
<script language="javascript">

	var myViewModel = {
					offerId:ko.observable(0)
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
		
</script>

</html>
