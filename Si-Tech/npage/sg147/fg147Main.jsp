<%
  /*
   * ����:УѶͨapn���ܿ�ͨ
   * �汾: 1.0
   * ����: 2012/09/25
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String custName=""; 
		//��ѯ�ͻ���Ϣsql
		String custSql = "select doc.cust_name from dcustdoc doc,dcustmsg msg where doc.cust_id = msg.cust_id and msg.phone_no=:phoneNo";
		String srv_params = "phoneNo=" + phoneNo;
		//��ѯҵ���ʷ�sql
		String TariffSql = "SELECT c.offer_id, c.offer_name,c.offer_comments FROM product_offer_scene a,region b,product_offer c,dloginmsg d"+
		" WHERE     a.offer_id = b.offer_id AND c.offer_id = a.offer_id AND a.op_type = 1 and d.login_no='"+sWorkNo+
		"' and D.POWER_RIGHT>=B.RIGHT_LIMIT AND b.GROUP_ID IN (SELECT parent_group_id FROM dchngroupinfo WHERE GROUP_ID ='"+groupID+"' ) and a.op_code='"+opCode+"'";
		//��ѯ��ǰ�ֻ����Ƿ�ͨ����ص�УѶͨapn����sql
		String ifOpenSql = "select b.offer_id,b.offer_name,a.school,a.class from dteacherinfo a,product_offer b,dcustmsg c"+
		" WHERE a.offer_id=b.offer_id AND a.id_no=c.id_no AND c.phone_no='"+phoneNo+"'";
		boolean openFlag=false;
		String oTraiff="";
		String oSchool = "";
		String oClass = "";
		String offerId = "";
		//��ˮ��
 		String PrintAccept = getMaxAccept();
 		
 		String ip = (String)session.getAttribute("ipAddr");
 		String ssss = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
%>

  <wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=PrintAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=sWorkNo%>"/>
      <wtc:param value="<%=dNopass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

<wtc:array id="result11" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:sql><%=TariffSql%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result22" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="4">
		<wtc:sql><%=ifOpenSql%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result33" scope="end" />
	<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			window.location = '/npage/sg147/fg147Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
		else
		{
			custName=result11[0][5];
				//System.out.println("zhouby ++ fg147Main.jsp " + custName);
		}
%>
<%
	if(result33.length <= 0)
		{
			openFlag=false;
		}
	else
		{
			openFlag=true;
			oTraiff = result33[0][0]+"--"+result33[0][1];
			oSchool=result33[0][2];
			oClass=result33[0][3];
			offerId = result33[0][0];
		}
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			if("<%=opCode%>"=="g148")
			{
				if(!<%=openFlag%>)
				{
					rdShowConfirmDialog("���û�δ��ͨУѶͨapn���ܣ����ܰ���ȡ�����ܣ�",0);
					removeCurrentTab();
				}
			}
			
			//init
			$("#custName").val("<%=custName%>");
			$("#phoneNo").val("<%=phoneNo%>");
			$("#loginAccept").val("<%=PrintAccept%>");
			$("#workNo").val("<%=sWorkNo%>");
			$("#noPass").val("<%=dNopass%>");
			$("#iopCode").val("<%=opCode%>");
			$("#iopName").val("<%=opName%>");
			
		});
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
				var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				var sysAccept ="<%=PrintAccept%>";
				var printStr =  printInfo(printType);
				var mode_code=null;           							//�ʷѴ���
				var fav_code=null;                				 		//�ط�����
				var area_code=null;             				 		//С������
				var opCode=document.all.iopCode.value ;                   			 		//��������
				var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode="+opCode+"&sysAccept="+sysAccept+
					"&phoneNo="+document.f1.phoneNo.value+
					"&submitCfm="+submitCfm+"&pType="+
					pType+"&billType="+billType+ "&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;   
			}
		
		function printInfo(printType)
			{
				var cust_info="";  				//�ͻ���Ϣ
				var opr_info="";   				//������Ϣ
				var note_info1=""; 				//��ע1
				var note_info2=""; 				//��ע2
				var note_info3=""; 				//��ע3
				var note_info4=""; 				//��ע4
				var retInfo = "";  				//��ӡ����
				
				cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
				cust_info+="�ͻ�������"+document.all.custName.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				opr_info+="ҵ�����ͣ�"+document.all.iopName.value+"|";
			  opr_info+=document.all.iopName.value.replace("УѶͨapn����","")+"APN�����ƣ�"+"hljxxt.hl|";
				opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";				
		    var beizhu = $("select[name='opTariff']").find("option:selected").val();
		    if(beizhu.length==0)
		    {
		    	note_info1+="��ע��|"
		    }
		    else{
		    note_info1+="��ע��"+$("select[name='opTariff']").find("option:selected").val().split("|")[1]+"|";
				}
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		
			
		function doCommit(){
			if(!subObjMaxlength("belongSchool"))
			{
				rdShowConfirmDialog("����ѧУ�������ֵΪ199�ַ���",1);
				return false;
				
			}
			if(!subObjMaxlength("belongClass"))
			{
				rdShowConfirmDialog("���ڰ༶�������ֵΪ199�ַ���",1);
				return false;
			}
			if($("select[name='opTariff']").find("option:selected").val().length==0 && ($("input[name='opFlag']:checked").val()=="0") )
			{
				rdShowConfirmDialog("��ѡ��ҵ���ʷѣ�",1);
				return false;
			}
			if(check(f1)){
 			 var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
						if(typeof(ret)!="undefined")
						  {
						    if((ret=="confirm"))
						    {
						      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
						      {
							   		frmCfm1();
						      }
								}
							if(ret=="continueSub")
							{
						      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
						      {
							    	frmCfm1();
						      }
							}
						  }
						else
						  {
						     if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
						     {
							     frmCfm1();
						     }
						  }	
						  return true;
						}
				
			
  }
  function frmCfm1()
  {
  	var iopcode = $("#iopCode").val();
	  document.f1.action="f"+iopcode+"Cfm.jsp";
		document.f1.submit();
		$("#Button1").attr("disabled",true);
		return true;
  }
  function changeOpCode(temp)
  {
  	if(temp=="0")
  	{
  		$("#iopCode").val("g147");
  		$("#iopName").val("УѶͨapn���ܿ�ͨ");
  	}
  	else if(temp=="1")
  		{
  			
  			if(!<%=openFlag%>)
  			{
  				rdShowConfirmDialog("���û�δ��ͨУѶͨapn���ܣ����ܰ���ȡ�����ܣ�",0);
  				window.location.reload();
  			}
  			else{
  			$("#iopCode").val("g148");
  			$("#iopName").val("УѶͨapn����ȡ��");
  			
  			}
  		}
  }
  //У�鳤�ȵķ���
	  function subObjMaxlength(obj)
			{
			var maxlen =199;
			var strValue = $("#"+obj).val();
			if(strValue.length!=0){
			var strTemp ="";
			var i,sum;
			sum=0;
			for(i=0;i<strValue.length;i++)
			{
			   if ((strValue.charCodeAt(i)>=0) && (strValue.charCodeAt(i)<=255))
			   sum=sum+1;
			   else
			    sum=sum+2;
			}
			if(sum>maxlen)
			{
				return false;
			}
			else
			{
				return true;
			}
			}
			else 
				{
					return true;
				}
			}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table id="koManage">
		<tr>
			<td width="25%" class="blue">��������</td>
			<td width="75%" colspan="3">
				<input type="radio" name="opFlag" value="0" data-bind="checked:offerId" onclick="changeOpCode(this.value)"/>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="1" data-bind="checked:offerId" onclick="changeOpCode(this.value)"/>ȡ��
			</td>
		</tr>
		<tr>
			<td width="25%" class="blue">�������</td>
			<td width="75%" colspan="3">
				<%=phoneNo%>
			</td>
		</tr>
		<%
			if(openFlag){
		%>
		<tr data-bind="visible:offerId()==1">
			<td width="25%" class="blue">
				����ѧУ
			</td>
			<td width="25%">
				<%=oSchool%>
			</td>
			<td width="20%" class="blue">
				���ڰ༶
			</td>
			<td width="30%">
				<%=oClass%>
			</td>
		</tr>
		<tr data-bind="visible:offerId()==1">
			<td width="25%" class="blue">
				��ͨAPN�ڵ�����
			</td>
			<td width="25%">
				hljxxt.hl
			</td>
			<td width="20%" class="blue">
				ҵ���ʷ�
			</td>
			<td width="30%">
				<%=oTraiff%>
			</td>
		</tr>
		<%
				}
		%>
		<tr data-bind="visible:offerId()==0">
			<td width="25%" class="blue">
				����ѧУ
			</td>
			<td width="25%">
				<input type="text" name="belongSchool" id="belongSchool"  value="" style="width:175px" /><span style="color:red">&nbsp;�199�ַ�</span>
			</td>
			<td width="20%" class="blue">
				���ڰ༶
			</td>
			<td width="30%">
				<input type="text" name="belongClass" id="belongClass" value="" style="width:175px"/><span style="color:red">&nbsp;�199�ַ�</span>
			</td>
		</tr>
		<tr data-bind="visible:offerId()==0">
			<td width="25%" class="blue">
				��ͨAPN�ڵ�����
			</td>
			<td width="25%">
				hljxxt.hl
			</td>
			<td width="20%" class="blue">
				ҵ���ʷ�
			</td>
			<td width="30%">
				<select name="opTariff" >
					<option value="">--��ѡ��--</option>
						<%
            		for(int i=0;i<result22.length;i++){
            %>
  			        <option value="<%=result22[i][0]%>|<%=result22[i][2]%>"><%=result22[i][0]%>--<%=result22[i][1]%></option>
  			    <%
  			    }
  			    %> 
				</select>
				<span style="color:red">*</span>
			</td>
		</tr>
	</table>
	
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��" onclick="doCommit()" id="Button1">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="���" onclick="javascript:window.location.href='/npage/sg147/fg147Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	<!--�ֻ����� -->
	<input type="hidden" name="phoneNo" id="phoneNo" value=""/>
	<!--�ͻ����� -->
	<input type="hidden" name="custName" id="custName" value=""/>
	<!--��ˮ�� -->
	<input type="hidden" name="loginAccept" id="loginAccept" value=""/>
	<!--���� -->
	<input type="hidden" name="workNo" id="workNo" value=""/>
	<!--���� -->
	<input type="hidden" name="noPass" id="noPass" value=""/>
	<!--opcode -->
	<input type="hidden" name="iopCode" id="iopCode" value=""/>
	<!--opname -->
	<input type="hidden" name="iopName" id="iopName" value=""/>
	<!--offerid -->
	<input type="hidden" name="iofferId" id="iofferId" value="<%=offerId%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko���� script����-->
<script language="javascript">

var iopcode = "<%=opCode%>"
if(iopcode=="g147")
{
	var myViewModel = {
					offerId:ko.observable(0)
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
	
}
else if(iopcode=="g148")
	{
		var myViewModel = {
					offerId:ko.observable(1)
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
	}
		
</script>

</html>
