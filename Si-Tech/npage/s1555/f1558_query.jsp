 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		
  	 String opCode = request.getParameter("opCode");
  	 String opName = request.getParameter("opName");	
	
	  String loginNo = (String)session.getAttribute("workNo");
	  String loginName = (String)session.getAttribute("workName");  
	  String IccId = ""; 
	  String mark = ""; 
	  String shorttype = "";		
%>
<%
  	String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
	/****************���ƶ�����õ����롢���������� ����Ϣ s1251Init***********************/
  	
  	String[][] temp=new String[][]{};  
  	String[][] tmpresult2= new String[][]{};
  	String[][] tmpresult3= new String[][]{};
  	String[][] tmpresult4= new String[][]{};
  	String[][] tmpresult5= new String[][]{};
  	String[] paraAray1 = new String[3];
  	String phoneNo = request.getParameter("srv_no");
  	shorttype = request.getParameter("shorttype");
  	mark = shorttype;
  	String passwordFromSer="";
  	int j=0;
  
 
  	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  	paraAray1[1] = loginNo; 	/* ��������   */
  	paraAray1[2] = shorttype;
	for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
	  }
  	//retList = impl.callFXService("s1558Init", paraAray1, "10","phone",phoneNo);
  %>
  	<wtc:service name="s1558Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>	
	<wtc:array id="result" start="0" length="10" scope="end"/>	
	<wtc:array id="tmpresult1" start="5" length="5" scope="end"/>
  <%
  	String  bp_name="";  	  	
  	String errCode=retCode1;
  	String errMsg = retMsg1;
  	if(result == null){
	 	if(!retFlag.equals("1")){
	   		retFlag = "1";
	   		retMsg = "s1294_Valid��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
     	}}else if(!(result == null)){
		if (errCode.equals("000000")){
      			//temp=(String[][])retList.get(2);  
      			temp=result;
      			if(temp!=null&&temp.length>0){			
		  		//bp_name=temp[0][0];	//��������
		  		bp_name=result[0][2];
		  		//temp=(String[][])retList.get(3);
		  		passwordFromSer=temp[0][3];//����
		  		//temp=(String[][])retList.get(4);
		  		IccId=temp[0][4];//���֤��	
	  		}  
	}else{
		if(!retFlag.equals("1")){
	         retFlag = "1";
	         retMsg = "s1294_Valid��ѯ���������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
        }
	}
  }
 
  	/****�õ���ӡ��ˮ****/
  	String printAccept="";
  	printAccept = getMaxAccept();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>�������콱</title>
	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="/npage/s1400/pub.js"></script>	
	  <%if(retFlag.equals("1")){%>
	  	<script language="JavaScript">
		    	rdShowMessageDialog("<%=retMsg%>");
		    	history.go(-1);
	    	</script>
	  <%}%>
	  <script language="JavaScript">
	<!--
	  //����Ӧ��ȫ�ֵı���
	  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	  var YE_SUCC_CODE = "0000";	 	//����Ӫҵϵͳ������޸�
	
	  var oprType_Add = "a";
	  var oprType_Upd = "u";
	  var oprType_Del = "d";
	  var oprType_Qry = "q";
	
	  onload=function()
	  {		
	  }
	  
	  //***
	  function frmCfm(){
		document.frm.action = "f1558_print.jsp";
		document.frm.submit();
		return true;
	  }
	  //***//У���Ƿ�ѡ���콱��¼
	   function checkIfSelect(){
	   var radio1 = document.getElementsByName("radio1");
		  var doc = document.forms[0];
		  var flag = 0;
		  for(var i=0; i<radio1.length; i++)
		  {
		      if(radio1[i].checked)
			  {
			        var vFlag = eval("doc.flag"+radio1[i].value+".value.substr(0,4)");
			     
					if(vFlag=="�Ѿ���ȡ")
					{
						rdShowMessageDialog("��Ʒ�Ѿ���ȡ��"); 
						return false;
					}
					document.frm.awardId.value=eval("doc.awardId"+radio1[i].value+".value");
					document.frm.flag.value=eval("doc.flag"+radio1[i].value+".value");
					document.frm.inTotal.value=eval("doc.inTotal"+radio1[i].value+".value");
					document.frm.payAccept.value=eval("doc.payAccept"+radio1[i].value+".value");
	
					flag=1;
					break;
			   }		   
		  }
		  if(flag==0)
		  {
		      rdShowMessageDialog("��ѡ��һ���콱��¼��"); 
			  return false;
		  }
		  return true;
	  }
	
	  
	/******Ϊ��ע��ֵ********/
	function setOpNote(){
		if(document.frm.opNote.value=="")
		{
		  document.frm.opNote.value = "��Ʒ;"+document.frm.phoneNo.value+";"+document.frm.awardNo.value; 
		}
		return true;
	}
	
	function printCommit()
	{ 
		getAfterPrompt();
		with(document.frm)
		{
		  if(awardNo.value=="")
		  {
		      rdShowMessageDialog("�����뽱Ʒ"); 
			  awardNo.focus();
			  return false;
		  }
		}
		if(!(checkIfSelect())) return false;
		setOpNote();//��ע��ֵ
		//��ӡ�������ύ��
	    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	    if(typeof(ret)!="undefined")
	    {
	      if((ret=="confirm"))
	      {
	        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
	        {
		      frmCfm();
	        }
		  }
		  if(ret=="continueSub")
		  {
	        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	        {
		      frmCfm();
	        }
		  }
	    }
	    else
	    {
	       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	       {
		     frmCfm();
	       }
	    }	
		return true;
	}
	//---------------------------------------------------
	function printInfo(printType)
	{
  
		  	var cust_info=""; //�ͻ���Ϣ
	      	  	var opr_info=""; //������Ϣ
	      		var retInfo = "";  //��ӡ����
	      		var note_info1=""; //��ע1
	      		var note_info2=""; //��ע2
	      		var note_info3=""; //��ע3
	      		var note_info4=""; //��ע4 
	      		
	      		cust_info+="�ͻ�������   "+document.frm.bp_name.value+"|";
      			cust_info+="�ֻ����룺   "+document.frm.phoneNo.value+"|";
      			
      			if(document.frm.mark.value == "0" ){
		  		opr_info+="ҵ������:       ����ʮ�����ܽ��콱"+"|";
		  	}else if (document.frm.mark.value == "4" ){
		  		opr_info+="ҵ������:       �����͸��콱"+"|";
		  	}else if (document.frm.mark.value == "7" ){
		  		opr_info+="ҵ������:       �������ؽ��콱"+"|";
	   		}else if (document.frm.mark.value == "8" ){
		  		opr_info+="ҵ������:       ������ף��"+"|";
		  	}	      		
		    	note_info1+="����:           "+document.frm.awardInfo.value+"|";		  
		  	note_info1+="��ˮ:             "+"<%=printAccept%>"+"|";
		    	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	      		return retInfo;		      		
		  
	}
	//-----------------------------------------------------
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{  	
		//��ʾ��ӡ�Ի��� 		
		var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	     	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept ="<%=printAccept%>";                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = <%=phoneNo%>;                           //�ͻ��绰		
	   	var h=180;
	   	var w=350;
	   	var t=screen.availHeight/2-h/2;
	   	var l=screen.availWidth/2-w/2;
	   	
	   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
	  
	}
	/**��ѯ��Ʒ**/
	function getAwardInfo()
	{ 
	  	//���ù���js�õ���Ʒ
	    var pageTitle = "��Ʒ�����ѯ";
	    var fieldName = "��Ʒ����|��Ʒ����|��Ʒ����";//����������ʾ���С�����
	   	var sqlStr ="select award_id,trim(short_type)||award_id as award_no,award_name from sShortMsgAwardInfo where award_id = '"+document.frm.awardId.value+"' and short_type ='"+document.frm.mark.value+"' order by award_id,award_name";
		//	alert(sqlStr); 
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "2|1|2";//�����ֶ�
	    var retToField = "awardInfo|awardNo";//���ظ�ֵ����
	    
	    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	}
	//-->
	</script>
</head>
	<form name="frm" method="post">	
		<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">�ͻ���Ϣ</div>
			</div>	
			<input name="mark" type="hidden"  id="mark" size="40" value="<%=mark%>" readonly class="InputGrey">
      	<table cellspacing="0">
		<tr> 
            		<td class="blue" width="18%">�ֻ�����</td>
            		<td>
			    	<input name="phoneNo" type="text"  id="phoneNo" value="<%=phoneNo%>" readonly class="InputGrey"> 
			 </td>
            		<td class="blue">�ͻ�����</td>
            		<td>
			  	<input name="bp_name" type="text"  id="bp_name" size="40" value="<%=bp_name%>" readonly class="InputGrey"> 
			</td>  
          	</tr>
      	</table>
     	<table  id="mainOne" cellspacing="0" >
     		<tr> 
            		<td  class="blue"  width="18%">���֤��</td>
            		<td colspan="3">
				<input name="IccId" type="text"  id="IccId" value="<%=IccId%>" readonly class="InputGrey"> 
			</td>    
			 
          	</tr>
      	</table> 
      	<br>
      	<div class="title">
		<div id="title_zi">��Ʒ��Ϣ</div>
	</div>	
	<TABLE cellspacing="0">          			  	
		  	<tr>		  		
			      		<th>ѡ��</th>
				  	<th>����</th>
				  	<th>��ȡ��־</th>
				  	<th>��Ʒ����</th>
				  	<th>�н�����</th>
			  		<th>��ע</td>			  	
		  	</tr>
          <% 		     
			 if(tmpresult1!=null&&tmpresult1.length>0) {                                     
			 	for(j=0;j<tmpresult1.length;j++){
		  %>
				  <tr>
				  	<td align=center><input type="radio"  name="radio1" value="<%=j%>"></td>
					<TD align=center><%=tmpresult1[j][0]%></TD>
					<TD align=center><%=tmpresult1[j][2]%></TD>
					<TD align=center><%=tmpresult1[j][1]%></TD>
					<TD align=center><%=tmpresult1[j][3]%></TD>
					<TD align=center><%=tmpresult1[j][4]%>
					 <input name="awardId<%=j%>" type="hidden" value="<%=tmpresult1[j][0]%>">
					 <input name="flag<%=j%>" type="hidden" value="<%=tmpresult1[j][2]%>">
					 <input name="inTotal<%=j%>" type="hidden" value="<%=tmpresult1[j][3]%>">
					 <input name="payAccept<%=j%>" type="hidden" value="<%=tmpresult1[j][4]%>">
				 </TD>
					
				 </tr>	
							
			<%
				}
			}
			%>  
         
      </TABLE>			 
      <table  id="mainOne" cellspacing="0">
	        <tr> 
			<td class="blue">��Ʒ����</td>
			<td colspan="3">
				<input type="text"  name="awardNo" size="8" maxlength="8" v_must=1>
			      	<input type="text"  name="awardInfo" size="30" v_must=1 >&nbsp;&nbsp;
				<font class="orange">*</font>
			        <input name=awardInfoQuery type=button  class="b_text"  style="cursor:hand" onClick="if(checkIfSelect()) getAwardInfo()" value=��ѯ> 
            		</td>
            	</tr>
	        <tr>
              		<td class="blue">��ע</td>
              		<td colspan="3">
                		<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" onFocus="setOpNote();" readonly class="InputGrey">
              		</td>
          	</tr>
      </table>
       <table  cellspacing="0">
    	  	<tr> 
               		<td id="footer"> 
				<input name="confirm" class="b_foot" id="confirm" type="button"   value="ȷ��&��ӡ" onClick="printCommit()" >
				&nbsp;  
				<input name="reset" class="b_foot" type="reset"  value="���" >
				&nbsp; 
				<input name="back" class="b_foot" onClick="history.go(-1);" type="button"  value="����">
				&nbsp; 	
			  </td>
            	</tr>
      </TABLE>    

  <input type="hidden" name="awardId" value="">
  <input type="hidden" name="flag" value="">
  <input type="hidden" name="inTotal" value="">
  <input type="hidden" name="payAccept" value="">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="opCode" value="<%=opCode%>">
   <%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>
</html>

