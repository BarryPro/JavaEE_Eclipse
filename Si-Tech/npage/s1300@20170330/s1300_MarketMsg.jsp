<%
/********************
 version v2.0
������: si-tech
baixf 20080309 061@2008 �������ƾ���ϵͳӪ������ƽ̨Ŀ��ͻ�Ⱥ��ȡ�������ӿڹ��ܵ�����
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
 <%
 	String opCode = "1302";
	String opName="�˺Žɷ�";
  String workNo = (String)session.getAttribute("workNo");         
  String sqlStr = ""; 
  String sqlStr1 = ""; 
	String inPhoneNo = request.getParameter("phoneNo"); 
	String MarketCounts = request.getParameter("MarketCounts");   
	String busyName ="";       //Ӫ�������
  String phoneName ="";       //�û�����
  String contractCounts ="";       //�Ѿ��Ӵ�����
  String lastContractTime="";       //�ϴ�Ӫ��ʱ��
  String maxCounts ="";       //���Ӵ�����
  String intervalCycle ="";       //�Ӵ��������
  String marketingTerms ="";       //Ӫ����Ϣ
  String returnMessage ="";       //�û�������Ϣ
  
  String marketingGroup ="";       // Ӫ��������ʶ	
  String marketingId ="";       // Ӫ�����ʶ	    
  String instalment ="";       // �����
  String printFlag="";         //��ӡ��ʶ huangrong 2010-9-9 16:38
  String printMsg="";          //�����ӡ���� huangrong 2010-9-9 16:38
  String[] inParas2 = new String[2];
                        
  /*ȡ�û�����*/
  inParas2[0] = "SELECT cust_name FROM dcustdoc WHERE cust_id =(SELECT cust_id FROM dcustmsg WHERE phone_no=:phone_no)";
  inParas2[1]="phone_no="+inPhoneNo;	
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=inPhoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%	
	if(result1!=null&&result1.length>0){
		phoneName = (result1[0][0]).trim();
	}
  /*ȡӪ����Ϣ */  
  /*sqlStr="SELECT TRIM(b.marketing_name),TRIM(a.contact_counts),TRIM(a.last_contract_time), " +
               " TRIM(b.max_counts),TRIM(b.interval_cycle),TRIM(b.marketing_terms) ," +
               " TRIM(b.Marketing_group),TRIM(b.Marketing_id),TRIM(b.Instalment)" +    
               " FROM dmarketcustmsg a,dmarketmsg b WHERE a.marketing_id=b.marketing_id " +
               " AND a.marketing_group=b.marketing_group AND a.phone_no='"+inPhoneNo+"'" +
               " AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg " +
               " WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no='"+inPhoneNo+"' AND accepted_degree  in ('2','3'))";*/
	inParas2[0]="SELECT TRIM(b.marketing_name),TRIM(a.contact_counts),TRIM(a.last_contract_time), TRIM(b.max_counts),TRIM(b.interval_cycle),TRIM(b.marketing_terms) ,TRIM(b.Marketing_group),TRIM(b.Marketing_id),TRIM(b.Instalment)   FROM dmarketcustmsg a,dmarketmsg b WHERE a.marketing_id=b.marketing_id AND a.marketing_group=b.marketing_group AND a.phone_no= :phone_no AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no=:phone_no AND accepted_degree  in ('2','3')) ";
	inParas2[1]="phone_no="+inPhoneNo+",phone_no="+inPhoneNo;
%>
 
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=inPhoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="9">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />
<%
 	
	sqlStr1="";
	/*
  sqlStr1="SELECT TRIM(b.is_label),TRIM(b.label_content)" +    
               " FROM dmarketcustmsg a,dmarketmsg b WHERE a.marketing_id=b.marketing_id " +
               " AND a.marketing_group=b.marketing_group AND a.phone_no='"+inPhoneNo+"'" +
               " AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg " +
               " WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no='"+inPhoneNo+"' AND accepted_degree  in ('2','3'))";*/
  inParas2[0]="SELECT TRIM(b.is_label),TRIM(b.label_content) FROM dmarketcustmsg a,dmarketmsg b WHERE a.marketing_id=b.marketing_id AND a.marketing_group=b.marketing_group AND a.phone_no=:phone_no AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg  WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no=:phone_no AND accepted_degree  in ('2','3')) ";
  inParas2[1]="phone_no="+inPhoneNo+",phone_no="+inPhoneNo;
%>	


<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=inPhoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="result3" scope="end" />	
		
<%
	 
	if(result2!=null&&result2.length>0){
	  busyName = (result2[0][0]).trim();
	  contractCounts = (result2[0][1]).trim(); 
	  lastContractTime = (result2[0][2]).trim();  
	  maxCounts = (result2[0][3]).trim();
	  intervalCycle = (result2[0][4]).trim();
	  //marketingTerms = (result2[0][5]).trim();
	  marketingGroup = (result2[0][6]).trim();
	  marketingId = (result2[0][7]).trim();
	  instalment = (result2[0][8]).trim();
 
	}
	
	if(result3!=null&&result3.length>0){

	  printFlag = (result3[0][0]).trim();//ȡ��ӡ��ʶhuangrong 2010-9-9 16:40
	  printMsg = (result3[0][1]).trim();//ȡ��ӡ����huangrong 2010-9-9 16:40  
	}
	
	

    String[] inPutArray = new String[2];
		inPutArray[0] = workNo;
		inPutArray[1] = inPhoneNo;
%>
	<wtc:service name="sPopupWin" routerKey="phone" routerValue="<%=inPhoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="5" >
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=inPhoneNo%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
		String strReturnCode = "999999";
		if(result!=null&&result.length>0){
			strReturnCode=result[0][0];
		}
	  String hUserCheckCond = "";
		if (strReturnCode.equals("000000")){
       hUserCheckCond = result[0][1].trim();
    }
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=inPhoneNo%>" id="sLoginAccept"/>

<HTML>
<HEAD>

<script LANGUAGE="JavaScript">
//begin��ӡ��� huangrong 2010-9-9 16:38	
var is_print=0;
function acceptthis(imarketingGroup,imarketingId,iinstalment,ibusyName,y) {	
	if("1"=="<%=printFlag%>")
	{	
		printCommit();
		if(is_print!=1){
			return false;
		}
	}
	accept(imarketingGroup,imarketingId,iinstalment,ibusyName);
	disableButton(y);	
}

function printCommit()
{          
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="print";
	var billType="1";
	var sysAccept = <%=sLoginAccept%>;
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
	var printStr = printInfo(printType);
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=1300&sysAccept="+sysAccept+"&phoneNo=&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	if(typeof(ret)!="undefined")
	{
	    if((ret=="confirm")&&(submitCfm == "Yes"))
	    {
	        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
	        {
						is_print=1;
	        }
	    }
	    if(ret=="continueSub")
	    {
	        if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
	        {
	        	is_print=1;
	        }
	    }
	}
	else
	    {
	        if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
	        {
	          is_print=1;
	        } 
	    }        
    }
//��ӡ��Ϣ    
function printInfo(printType)
{          
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  var retInfo = "";		
  cust_info+="�ͻ�������"+"<%=phoneName%>"+"|";		
  cust_info+="�ֻ����룺"+<%=inPhoneNo%>+"|";
	
  opr_info+="��ˮ��"+"<%=sLoginAccept%>"+"|";
  opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	note_info1="��ע�����Ų��񼤻�|";
	note_info2+="<%=printMsg%>"+"|";
  //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
  return retInfo;
}   
//end 
function accept(imarketingGroup,imarketingId,iinstalment,ibusyName)
{
	  var pathfile="s1300_MarketMsgCfm.jsp?Phone_no=<%=inPhoneNo%>";
    pathfile+="&Marketing_group="+imarketingGroup+"&Marketing_id="+imarketingId;
    pathfile+="&Accepted_degree=2&Instalment="+iinstalment+"&Marketing_name="+ibusyName;
    pathfile+="&Return_message=����";
 
 		var returnValue = window.open(pathfile,"","height=600,width=400,scrollbars=yes");
    document.frm.is_deal.value=parseInt(document.frm.is_deal.value) +parseInt("1") ;
}

function refusethis(imarketingGroup,imarketingId,iinstalment,ibusyName) {
 

 var pathfile="s1300_MarketMsgCfm.jsp?Phone_no=<%=inPhoneNo%>";
      pathfile+="&Marketing_group="+imarketingGroup+"&Marketing_id="+imarketingId;
     pathfile+="&Accepted_degree=3&Instalment="+iinstalment+"&Marketing_name="+ibusyName;
     pathfile+="&Return_message=Ӫ��ʧ�ܣ�";
 
 var returnValue = window.open(pathfile,"","height=600,width=400,scrollbars=yes");               
 document.frm.is_deal.value=parseInt(document.frm.is_deal.value) +parseInt("1") ;
}


function Closethis1() {
  if(parseInt(document.frm.is_deal.value)<parseInt(document.frm.marketCounts.value))
  {
     var pathfile="s1300_MarketMsgCfm.jsp?Phone_no=<%=inPhoneNo%>";
      pathfile+="&Marketing_group=nousing&Marketing_id=nousing";
     pathfile+="&Accepted_degree=1&Instalment=nousing&Marketing_name=nousing";
     pathfile+="&Return_message=�Ӵ���δӪ��";
 
   	var returnValue = window.open(pathfile,"","height=600,width=400,scrollbars=yes");                       
  	window.close();
  }
  else
  {
  	window.close();
  }
}

function disableButton(index)
{
	var acceptButton = document.getElementById("Acceptthis"+index);	
	if(acceptButton)
	{
		acceptButton.disabled = true;
	}
	var refuseButton = document.getElementById("Refusethis"+index);
	if(refuseButton)
	{
		refuseButton.disabled = true;	
	}
}


</script>
<TITLE>Ӫ����Ϣ��ѯ</TITLE>
</head>

<BODY onunload="Closethis1()">
<form  name="frm" method="post" action="">      
 <input type="hidden" name="is_deal"  value="0">
 <input type="hidden" name="marketCounts"  value="<%=MarketCounts%>" >
 <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">Ӫ����Ϣ</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
          <tr align="center">
            <th>����</th>
            <th>˵��</th>
            <th>����</th>
            <th>����</th>
          </tr>
<%	    
			 String tbClass="";
       for(int y=0;y<result2.length;y++){
			    if(y%2==0){
						tbClass="Grey";
					}else{
						tbClass="";
					}
%>
	        <tr align="center">
	          <td class="<%=tbClass%>"><%= result2[y][0]%></td>
            <td class="<%=tbClass%>"><%= result2[y][5]%></td>
            <td class="<%=tbClass%>"> 
             	<input type="button" name="Acceptthis<%=y%>" id="Acceptthis<%=y%>" class="b_text" value="����" onClick="acceptthis('<%= result2[y][6]%>','<%= result2[y][7]%>','<%= result2[y][8]%>','<%= result2[y][0]%>','<%=y%>')">
	          </td>
	          <td class="<%=tbClass%>"> 
             	<input type="button" name="Refusethis<%=y%>" id="Refusethis<%=y%>" class="b_text" value="�ܾ�" onClick="disableButton('<%=y%>');refusethis('<%= result2[y][6]%>','<%= result2[y][7]%>','<%= result2[y][8]%>','<%= result2[y][0]%>')">
	          </td>
	         </tr>
<%	      
				}
%>
              </TBODY>
	       </TABLE>
 
   <table cellspacing="0">
   
  <%
    	String varString="";
   		for(;hUserCheckCond.indexOf("|") > 0;){
				varString = hUserCheckCond.substring(0,hUserCheckCond.indexOf("|"));
	%>
 	   		<CENTER><TR align="center" >�� <%=varString%></tr></CENTER>
 	<%
 	  		hUserCheckCond= hUserCheckCond.substring(hUserCheckCond.indexOf("|")+1,hUserCheckCond.length());
		}
 	%>
 	 	&nbsp;&nbsp;&nbsp;&nbsp;
  	<CENTER><INPUT TYPE="BUTTON" class="b_foot" VALUE="�ر�" onClick="Closethis1()"></CENTER>
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>