<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    /********************
     version v2.0
     ������: si-tech
     s4244Snd���д��sim�������
     gaopeng 20130107
     ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<script type="text/javascript">
onload=function()
{		

}

</script>

<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String opCode = (String)request.getParameter("opCode");		
	//String opName = (String)request.getParameter("opName");
	String opCode = "g412";
	String opName = "��ص���д��";
	String Brand = (String)request.getParameter("Brand");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String[][] pass = (String[][])arrSession.get(4);
	
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String loginNoPass = pass[0][0];

	//String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	//String errorCode="444444";
	//String[][] errCodeMsg = null;
	List al = null;
		//��ˮ��
 		String iLoginAccept = getMaxAccept();
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	String op_code = "g412";
	
		 
	String phoneNo  =request.getParameter("phoneNo");
	String iccid =request.getParameter("iccid");	 
	String imsi   =request.getParameter("imsi");
	String handFee  =request.getParameter("handFee");	
	String opNote=request.getParameter("opNote");

	String tmpBusyAccept=iccid.substring(13,19);
	String testFlag=request.getParameter("test_flag");
	String cardID=request.getParameter("cardID");
	String cust_name=request.getParameter("custName");
	String simFee=request.getParameter("simFee");
	String ifDLS=request.getParameter("ifDLS");
	String retCode2 = "";
	String retMsg2 = "";
	//MyLog.debugLog("yidisimkajihuo11111");
	//MyLog.debugLog("cust_name"+cust_name);
	//cust_name= "";
 	// al = f4244Req.doProcess(loginNo, orgCode,op_code,phoneNo,testFlag,imsi,phoneNo,iccid,handFee,simFee,opNote,tmpBusyAccept);
 	// MyLog.debugLog("yidisimkajihuo22222");
 	//s4244Snd
 		String  inputParsm [] = new String[10];
		inputParsm[0] = loginNo;
		inputParsm[1] = orgCode;
		inputParsm[2] = op_code;
		inputParsm[3] =	phoneNo;
		inputParsm[4] = testFlag;
		inputParsm[5] = imsi;
		inputParsm[6] = iccid;
		inputParsm[7] = handFee;
		inputParsm[8] = simFee;
		inputParsm[9] = opNote;
 	%>
 	<wtc:service name="s4244Snd" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
 	
 	<%
  if(ret.length<=0){
		valid = 1;
		//MyLog.debugLog("###############################################");
	}
	else
	{
		if( !"0000".equals(retCode))
		{
			valid = 2;
		}
		else
		{
			valid = 0;
		}
	}
%>

<%
	/* sim���ͺ����� */
	String  inParams [] = new String[2];
	inParams[0] = "select b.res_name from dsimres a,srescode b where a.sim_type=b.res_code and a.sim_no=:iccid ";
	inParams[1] = "iccid="+iccid;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret_simTypeName"  scope="end"/>
<%
	String simTypeName = "";
	if("000000".equals(retCode1)){
		if(ret_simTypeName.length>0){
			simTypeName = ret_simTypeName[0][0];
		}
	}
%>

<!--ȡ��ˮ�ŷ��� -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
		/*��ȡ��ǰʱ��*/
		java.util.Date sysdate = new java.util.Date();
		java.text.SimpleDateFormat sf1 = new java.text.SimpleDateFormat("yyyyMMdd");
		String init_tme = sf1.format(sysdate);
		/*��������Ѻ��ۿ���� liyang���� 2014/04/15 10:45:11 gaopeng����*/
%>
<%if("1".equals(ifDLS) && valid == 0 ){%>
<wtc:service name="s6005Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode22" retmsg="retMsg22" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=init_tme%>"/>
				<wtc:param value=""/>
				
		</wtc:service>
<wtc:array id="ret2" scope="end"/>

<%
			retCode2 = retCode22;
			retMsg2 = retMsg22;
	if(ret2.length <= 0){
		valid = 1;
	}else{
		if( !"000000".equals(retCode22) && !"0".equals(retCode22))
		{
			valid = 3;
		}
		else
		{
			valid = 0;
		}
	}
%>			
<%}%>
<%if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!");
	window.location="s4244.jsp";

</script>

<%}else if( valid == 2){%>
<script language="JavaScript">

	rdShowMessageDialog("<br>�������:["+"<%=retCode %>]</br>"+"������Ϣ:["+"<%=retMsg %>"+"]");
	window.location="s4244.jsp";

</script>
<%}else if( valid == 3){%>
<script language="JavaScript">

	rdShowMessageDialog("<br>�������:["+"<%=retCode2 %>]</br>"+"������Ϣ:["+"<%=retMsg2 %>"+"]");
	window.location="s4244.jsp";

</script>

<%}else{%>
<script language="JavaScript">

	rdShowMessageDialog("�����ɹ�!!");
	 conf();
	window.location="s4244.jsp";

	/*--------------------------��ӡ���̺���---------------------------*/


function conf()
{

   /***********************��ӡ����Ĳ���**********************************/

  								//ҵ�����
   var work_no = "<%=loginNo%>";                                 //������
         
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// ϵͳ����
   var phone = "<%=phoneNo%>";					//�ƶ�����
   var cust_name = "<%=cust_name%>";						//�ͻ�����
   var pay_money ="<%=handFee%>";					//���ѽ��
  var oldSim_no=   "";
  var tmpBusyAccept="<%=tmpBusyAccept%>";
 var newSim_no=  "<%=iccid%>";
 var simFee= "<%=simFee%>";
/* liuyl modify by 20100520
var busi_type="���ҵ��";
*/
var busi_type="��������";
   
   printfp(busi_type,work_no,date,phone,cust_name,simFee,tmpBusyAccept,oldSim_no,newSim_no);                                //���ȷ�ϣ����ô�ӡҳ��

  
 }
function printfp(busi_type,work_no,date,phone,cust_name,simFee,tmpBusyAccept,oldSim_no,newSim_no)
{
	//ҵ�����|��|��|��|������ˮ��|�ֻ�����|�ͻ�����|�û�Ʒ��|����ҵ��:��������|������ˮ|SIM����|��SIM����|��SIM����|������|����ʱ��
//����|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
		var infoStr = "";
		infoStr = work_no + "|";
		infoStr += <%=iLoginAccept%>+"|";
		infoStr += "��������|";
		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr += cust_name+"|";
		infoStr += "|";
		infoStr += phone+"|";
		infoStr += "|";
		infoStr += "|";
		infoStr += simFee+"|";
		infoStr += simFee+"|";
		var yhpp="";
		var pinpais="";
		
		//01��ȫ��ͨ��02�������У�03�����еش���09������Ʒ��
		if("<%=Brand%>"=="01")
		{
			yhpp="ȫ��ͨ";
			pinpais="gn";
		}
			if("<%=Brand%>"=="02")
		{
			yhpp="������";
			pinpais="zn";
		}
			if("<%=Brand%>"=="03")
		{
			yhpp="���еش�";
			pinpais="dn";
		}
			if("<%=Brand%>"=="09")
		{
			yhpp="����Ʒ��";
			pinpais="";
		}
		infoStr += "�û�Ʒ�ƣ�"+yhpp+"~";
		//infoStr += "��SIM���ţ�"+oldSim_no+"~";
		infoStr += "��SIM���ţ�"+newSim_no+"~";
		infoStr += "����ʱ�䣺"+date+"~";
		infoStr += "��ע����������ԭSIM���еĵ绰�����������б��ݡ�|";
		infoStr+=	work_no+"|";//��Ʊ��
	 	infoStr+=" "+"|";//�տ���
	 	infoStr+=" "+"|";

		/*
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		
		var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=�ͻ�<"+cust_name+"><%=opName%>�ѳɹ������潫��ӡ��Ʊ��";
		var loginAccept = tmpBusyAccept;
		var path = path + "&infoStr="+infoStr+"&loginAccept="+<%=iLoginAccept%>+"&opCode=<%=opCode%>&submitCfm=Single";
		var ret=window.showModalDialog(path, "", prop);
		removeCurrentTab();
		*/
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001",work_no);
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",cust_name);
		$(billArgsObj).attr("10006","<%=opName%>");
		$(billArgsObj).attr("10008",phone);
		$(billArgsObj).attr("10015",simFee);//Сд
		$(billArgsObj).attr("10016",simFee);//�ϼƽ��(��д) ��Сд������ҳת��
		$(billArgsObj).attr("10017","*");//�ֽ�
		$(billArgsObj).attr("10030","<%=iLoginAccept%>");//ҵ����ˮ
		$(billArgsObj).attr("10036","<%=opCode%>");
		$(billArgsObj).attr("10031",work_no);//��Ʊ��
		$(billArgsObj).attr("10041","SIM��");//Ʒ�����
		$(billArgsObj).attr("10061","<%=simTypeName%>");//�ͺ�
		$(billArgsObj).attr("10042","��");//��λ
		$(billArgsObj).attr("10043","1");//����
		$(billArgsObj).attr("10044",simFee);//����
		$(billArgsObj).attr("10046",simFee);//�ϼ�
		$(billArgsObj).attr("10028","");//�����Ӫ�������
		$(billArgsObj).attr("10047","");//�����
		$(billArgsObj).attr("10071","7");//ģ��
		$(billArgsObj).attr("10007",pinpais);
		$(billArgsObj).attr("10074","0");
 		$(billArgsObj).attr("10075","0");

		
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=�ͻ�<"+cust_name+"><%=opName%>�ѳɹ������潫��ӡ��Ʊ��";
		var path = path + "&infoStr="+printInfo+"&loginAccept=<%=iLoginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		removeCurrentTab();
	}
	
</script>
<%}%>








