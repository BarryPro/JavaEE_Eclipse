<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���Źܿ� d344
   * �汾: 1.0
   * ����: 2011/3/25
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String hdpowerright =(String)session.getAttribute("powerRight");//��ɫȨ��
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String hdwork_pwd =(String)session.getAttribute("password");//��������		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//��½IP	
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���	
	String regionCode = (String)session.getAttribute("regCode");
%>

<%
	String opCode="d344";
	String opName="���Źܿ�";
	String phoneNo = request.getParameter("phoneNo");
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=hdorg_code.substring(0,2)%>"  id="retListString1"/>	
<head>
<SCRIPT language="javascript">
function turnit()
{
	document.all.better.style.display="";
}
function checkexpDays()
{
	if(document.form1.expDays.value <= 0)
    {
        rdShowMessageDialog("����ȷ��������,��������Ϊ����0�죡");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }
	if(document.form1.expDays.value > 365)
    {
        rdShowMessageDialog("����ȷ��������,�������ܳ���365�죡");
        document.form1.expDays.value = "";
        document.form1.expDays.focus();
        return false;
    }

}

/*----------------���ô�ӡҳ�溯��---------------------*/
	function showPrtdlg1246()
	{  
		getAfterPrompt();
		var op_note=document.all.opNote.value;
		var preMsg=document.all.preMsg.value;
		thesysnote =op_note.trim()+"��"+preMsg+"��";      //����ϵͳ��ע    
		document.all.opNote.value= thesysnote;                      //����ҳ����ʾ��ϵͳ��ע
		
	/*����ģʽ�Ի��𣬲����û��������д���*/
		var h=105;
		var w=260;
		var t=screen.availHeight-h-20;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
		var ret=rdShowConfirmDialog("�Ƿ��ӡ���������");
		if(typeof(ret)!="undefined")
		{
			if(ret==1)                      //����Ͽ�
			{
				conf();                          
			}
			else if(ret==0)                 //���ȡ��,���Ƿ��ύ
			{    
				crmsubmit();                     
			}
		}
	}	

</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<form action="" method=post name="form1"> 
	<input type="hidden" name="oret_code" value="">
	<%@ include file="/npage/include/header.jsp" %>

<%      
 	String outList[][] = new String [][]{{"0","26"}};
%>
<%
/***********************************���巵�ز���*********************************************/

	String oret_code="";              // �������               
	String oret_msg="";		          // ������Ϣ
	String oid_no="";		  		  //0  �û�id                
	String custName="";		      //1  �ͻ�����             
	String statusCode="";		      //2  ״̬����          
	String statusName="";		      //3  ״̬����  
	String custAddr="";		      //4  �ͻ�סַ          
	String idType="";		          //5  ֤������          
	String oid_name="";		          //6  ֤������          
	String idIccid="";		      //7  ֤������         
	String onew_run="";		          //8  ��״̬����        
	String onew_runname="";           //9  ��״̬���� 
	String smName="";           //10  ��Ʒ����
	String preMsg="";	           //11  �Ƿ���ԤԼ�ط�����ʾ��Ϣ
	String noteMsg=""	;           //12  ������ע��Ϣ
/**************************����s1246Init�����****************************/
  String loginAccept = "";                                //������ˮ
  String chnSource = "01";                                //������ʶ
	String workNo = hdword_no;                                 //��������
	String passWord = hdwork_pwd;                                 //��������	
	String custWord = "";                                          //�û����� 
	String ChOpRunCode  = ReqUtil.get(request,"opFlag");                //��������״̬
%>
	<wtc:service name="sd344Init" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=custWord%>"/>
		<wtc:param value="<%=ChOpRunCode%>"/>			
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
		oret_code = retCode;
		oret_msg = retMsg;
		            
		if(!oret_code.equals("000000"))
	 	{
%>
<script language="javascript">
	rdShowMessageDialog("<%=String.valueOf(oret_code)%>:"+"<%=oret_msg%>",0);
	history.go(-1);
</script>
<%
		}
		else{
		oid_no=result[0][0];		  		  //0  �û�id                
		custName=result[0][1];		      //1  �ͻ�����             
		statusCode=result[0][2];		      //2  ״̬����          
		statusName=result[0][3];		      //3  ״̬����  
		custAddr=result[0][4];		      //4  �ͻ�סַ          
		idType=result[0][5];		          //5  ֤������          
		oid_name=result[0][6];		          //6  ֤������          
		idIccid=result[0][7];		      //7  ֤������         
		onew_run=result[0][8];		          //8  ��״̬����        
		onew_runname=result[0][9];           //9  ��״̬���� 
		smName=result[0][10];           //10  ��Ʒ����
		preMsg=result[0][11];	           //11  �Ƿ���ԤԼ�ط�����ʾ��Ϣ
		noteMsg=result[0][12];           //12  ������ע��Ϣ
		System.out.println("---------------------------------"+preMsg);
		if(!"".equals(preMsg))
		{
%>
				<script language="javascript">
					rdShowMessageDialog("<%=preMsg%>"+"��");
				</script>
<%				
    }
   }%> 
<div class="title">
		<div id="title_zi">�ͻ�����</div>
</div>

<table cellspacing="0">
	<tr> 
		<td class="blue">������� </td>
		<td>
			<input name="phoneNo" value="<%=ReqUtil.get(request,"phoneNo")%>" size="20" v_type="mobphone" 
				 v_must=1 onBlur="if(this.value!=''){if(checkElement('phoneNo')==false){return false;}}" 
				 Class="InputGrey" readOnly>
		</td>
		<td class="blue">�ͻ����� </td>
		<td >
			<input name="custName" size="20"  value="<%=custName%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue">Ʒ������  </td>
		<td >
			<input name="smName" size="20"  value="<%=smName%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">�ͻ���ַ</td>
		<td >
			<input name="custAddr" size="20"  value="<%=custAddr%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<tr > 
		<td class="blue">֤������</td>
		<td ><input name="idType" value="<%=idType%>" size="20" Class="InputGrey" readOnly>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="idIccid" size="20"  value="<%=idIccid%>"   Class="InputGrey" readOnly >
		</td>
	</tr>
	<tr> 
		<td class="blue">״̬����</td>
		<td >
			<input name="statusCode" size="20"  value="<%=statusCode%>" Class="InputGrey" readOnly>
		</td>
		<td class="blue">״̬���� </td>
		<td >
			<input name="statusName" size="20"  value="<%=statusName%>" Class="InputGrey" readOnly>
		</td>
	</tr>
	<%
		String strsql = "";
		String favor_code = "";
		String hand_fee = "";

		strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1246'";
	%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:sql><%=strsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeArr" scope="end" />
	<%
		if(retCode.equals("000000")){
			if(handFeeArr.length>0){
				hand_fee = handFeeArr[0][0];
				favor_code = handFeeArr[0][1];				
			}
		}
	%>
	<tr >
		
			<input name="ohand_cash" v_name='������' type="hidden" size="20" maxlength=20 value="0">
			<input type="hidden" name="ishould_fee" size="20" maxlength=20 value="0" Class="InputGrey" readOnly>
		
		<td class="blue">���ػ������ </td>
		<td nowrap colspan="3">
			<input name="icmd_code" value="<%=onew_runname%>" size="4" Class="InputGrey" readOnly>
			<span id=better style="DISPLAY: none">
				<input name="expDays" size="12" v_type="0_9" onChange="checkexpDays()" maxlength=20 value="1"  onblur="if(this.value!=''){if(checkElement(this)==false){return false;}}">��
			</span>
		</td>
	</tr>
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" size="80" value="<%=phoneNo%><%=onew_runname%>">
		</td>
	</tr>

	<tr> 
		<td align=center colspan="4">
			<input class="b_foot_long" name=sure  type=button value="ȷ��&��ӡ" onclick="if(checknum(ohand_cash,ishould_fee)) if(check(form1)) showPrtdlg1246();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
		</td>
	</tr>
</table>
	   <!-----------------------------------����������----------------------------------------------->
	   <input type="hidden" name="stream" value="<%=retListString1%>">
	   <input type="hidden" name="oid_no" value="<%=oid_no%>">
	   <input type="hidden" name="onew_run" value="<%=onew_run%>">
	   <input type="hidden" name="preMsg" value="<%=preMsg%>">	   

	   <!-------------------------------------------------------------------------------------------->
	  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

<script language="javascript">
	onload=function()
	{
		<%if(onew_runname.trim().equals("ǿ��")){%>
		turnit();
		<%}%>
	}
/*-----------------------------ҳ����ת����-----------------------------------------------*/
	function pageSubmit(page){
		document.form1.action="<%=request.getContextPath()%>/npage/"+page;
		form1.submit();
		/*if(flag==1){
		document.form1.action="<%=request.getContextPath()%>/npage/change/f1274_3.jsp";  
		form1.submit();
		}*/
	}
/*--------------------------������У�麯��--------------------------*/	  

	function checknum(obj1,obj2)
	{
	
		var num2 = parseFloat(obj2.value);
		var num1 = parseFloat(obj1.value);
		if(num2<num1)
		{
			var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
			rdShowMessageDialog(themsg,0);
			obj1.focus();
			return false; 
		}
		
		if(document.all.icmd_code.value== "ǿ��")
		{	
			var tmpDays = parseInt(document.all.expDays.value,10);
		
			if( tmpDays <= 0 || tmpDays > 365 || (document.all.expDays.value).trim().length==0)
			{
				rdShowMessageDialog("ǿ��ʱ��������ȷ��ǿ��ʱ��,ǿ��ʱ����0-365֮��!",0);
				return false;
			}
		}
		return true;
	} 
	
	var thesysnote = ""; //����ȫ�ֱ�����ϵͳ��ע
	
	function printInfo(printType)
	{
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
		
		cust_info+="�ֻ����룺"+'<%=ReqUtil.get(request,"phoneNo")%>'+"|";
		cust_info+="�ͻ�������"+'<%=custName%>'+"|";         	
		cust_info+="�ͻ���ַ��"+'<%=custAddr%>'+"|";
		cust_info+="֤�����룺"+'<%=idIccid%>'+"|";
		
		opr_info+="ҵ�����ͣ����Źܿ�"+"|";
		opr_info+="ҵ����ˮ��"+document.all.stream.value+"|";
		note_info1+="��ע: "+document.all.opNote.value+"|";
	
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		
	  return retInfo;	
	}

/*-------------------------��ӡ�����ύ������-------------------*/
	function conf()
	{ 
		var h=200;
		var w=400;
		var t=screen.availHeight/2-h/20;
		var l=screen.availWidth/2-w/2;
		
		var DlgMessage = "ȷʵҪ���е��������ӡ��?";
		var submitCfm = "Yes";
	
		var pType="subprint";                                     // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                         //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept=document.all.stream.value;                  // ��ˮ��
		var printStr=printInfo("Detail");                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var phoneNo="<%=phoneNo%>"              						//�ͻ��绰
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=1246&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret_value=window.showModalDialog(path,printStr,prop);

	/**********************��ӡ����Ĳ�����֯���****************************/
      if (typeof(ret_value) != "undefined") {
			crmsubmit();
		}
	
	}
	
	function crmsubmit()
	{
		if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1){
			form1.action="fd344Cfm.jsp";
			form1.submit();
		 }else{
			return false;
		 }
	}

 </script>

