<%
  /*
   * ����: ǿ�ƿ��ػ�1246
   * �汾: 1.0
   * ����: 2008/12/23
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
 <% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1246";
	String opName="ǿ�ƿ��ػ�";
	String hdword_no =(String)session.getAttribute("workNo");//����
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String hdwork_pwd =(String)session.getAttribute("password");//��������		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//��½IP	
	String regionCode = (String)session.getAttribute("regCode");
	String ilogin_accept = ReqUtil.get(request,"stream");
%>

<%      
	/*--------------------------------��֯s1246Cfm�Ĵ������-------------------------------*/
//	String ilogin_accept = ReqUtil.get(request,"stream");             //ϵͳ��ˮ
%>
	<!--wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="ilogin_accept"/-->
<%	
	String iop_Code ="1246";                                          //��������					 
	String iwork_no = hdword_no;                                      //��������                  
	String iwork_pwd =hdwork_pwd;                                     //��������						 
	String iorg_code =hdorg_code;                                     //org_code 
	String icust_id = ReqUtil.get(request,"oid_no");                  //�ͻ�ID
	String icmd_code1 = ReqUtil.get(request,"icmd_code");
	String icmd_code = "";											  //60,61
	if(icmd_code1.trim().equals("ǿ��"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	//String icmd_code = ReqUtil.get(request,"icmd_code");             //�����
	String inew_runcode = ReqUtil.get(request,"onew_run");             //������״̬L,K.
	String ishould_fee = ReqUtil.get(request,"ishould_fee");           //Ӧ��������
	String ireal_fee = ReqUtil.get(request,"ohand_cash");              //ʵ��������
	//String isys_note = ReqUtil.get(request,"sysnote");               //ϵͳ��ע					 
	String ido_note = ReqUtil.get(request,"sysnote");                   //������ע
	String expDays = ReqUtil.get(request,"expDays");                   //���ڱ�ע
	String ithe_ip = hdthe_ip;                                         //��½IP		
	String ret_code = "";
	String ret_msg = "";
	String cardno = ReqUtil.get(request,"oid_iccid");                //���֤����
	String themob = ReqUtil.get(request,"i1");					     //�ƶ�����  
	String name =   ReqUtil.get(request,"ocust_name");               //�û�����  
	String address =  ReqUtil.get(request,"ocust_addr");			 //�û���ַ 	
	/*String themob = ReqUtil.get(request,"i1");                       //�ֻ�����					 
	String do_string=ReqUtil.get(request,"do_string_add");             //�������  1:���� 2:ȡ��
	String addcash_string=ReqUtil.get(request,"addcash_string");       //��ѡ�ʷѴ��봮
	String favour = "a017";                                            //�Żݴ���					 
	String realcash = ReqUtil.get(request,"i19");                      //ʵ��������				 
	String fircash = ReqUtil.get(request,"i20");                       //�̶�������				 
	*/
	if(ireal_fee.equals(""))
	ireal_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                     //�����ѵ�����
	
	/***zhangyan add new parm b*/
	String iforce_type=ReqUtil.get(request,"force_type");
	String ifource_reason=ReqUtil.get(request,"force_reason");
	String iforce_judgement=ReqUtil.get(request,"force_judgement");
	String ilargeticket_time=ReqUtil.get(request,"largeticket_time");
	String ilargeticket_fee=ReqUtil.get(request,"largeticket_fee");
	String iowning_fee=ReqUtil.get(request,"owning_fee");
	String isuboffice=ReqUtil.get(request,"suboffice");
	String isuboffice_phone=ReqUtil.get(request,"suboffice_phone");
	String idocument_number=ReqUtil.get(request,"document_number");
	String idocument_date=ReqUtil.get(request,"document_date");
	String ioperator_name=ReqUtil.get(request,"operator_name");
	String ioperator_phone=ReqUtil.get(request,"operator_phone");
	String icontact_name=ReqUtil.get(request,"contact_name");
	String icontact_phone=ReqUtil.get(request,"contact_phone");
	
	String svcNm = "s1246Cfm";
	String osm_code=ReqUtil.get(request,"osm_code");
	
	System.out.println("osm_code~~~"+osm_code);
	/**
	if ( osm_code.equals("PB") || osm_code.equals("PA") )
	{
		svcNm = "sWLWInterFace";
	}*/
	
	/*--------------------------------��ʼ����s1246Cfm--------------------------------*/			                      
%>	
	<wtc:service name="<%=svcNm%>" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=ilogin_accept%>"/>
		<wtc:param value="<%=iop_Code%>"/>
		<wtc:param value="<%=iwork_no%>"/>
		<wtc:param value="<%=iwork_pwd%>"/>
		<wtc:param value="<%=iorg_code%>"/>
		<wtc:param value="<%=icust_id%>"/>
		<wtc:param value="<%=icmd_code%>"/>
		<wtc:param value="<%=inew_runcode%>"/>
		<wtc:param value="<%=ishould_fee%>"/>
		<wtc:param value="<%=ireal_fee%>"/>
		<wtc:param value="<%=expDays%>"/>
		<wtc:param value="<%=ido_note%>"/>
		<wtc:param value="<%=ithe_ip%>"/>
		<wtc:param value="<%=iforce_type%>"/>      	
		<wtc:param value="<%=ifource_reason%>"/>   	
		<wtc:param value="<%=iforce_judgement%>"/> 	
		<wtc:param value="<%=ilargeticket_time%>"/>	
		<wtc:param value="<%=ilargeticket_fee%>"/> 	
		<wtc:param value="<%=iowning_fee%>"/> 		                                          
		<wtc:param value="<%=isuboffice%>"/>       	
		<wtc:param value="<%=isuboffice_phone%>"/> 	
		<wtc:param value="<%=idocument_number%>"/> 	
		<wtc:param value="<%=idocument_date%>"/>   	
		<wtc:param value="<%=ioperator_name%>"/>   	
		<wtc:param value="<%=ioperator_phone%>"/>  	
		<wtc:param value="<%=icontact_name%>"/>    	
		<wtc:param value="<%=icontact_phone%>"/>   	
	</wtc:service>
	<wtc:array id="result" scope="end"/>  
<%
	ret_code = retCode ;
	ret_msg = retMsg ;                                
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+hdword_no+"&loginAccept="+ilogin_accept+"&pageActivePhone="+themob+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
/*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
 
	String realcash = ireal_fee;   				                     //������    
	String stream = "";                                              //ϵͳ��ˮ 
	if(retCode.equals("000000")){
		if(result.length>0){
			stream = result[0][0];
		}		
	}
/***********************************************************************************************/
%>

<script language="javascript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+='<%=cardno%>'+"|";//���֤����                                                  
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=name%>'+"|";//�û�����                                                
	 infoStr+='<%=address%>'+"|";//�û���ַ 
	 infoStr+="�ֽ�"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="ǿ�ƿ��ػ���*�����ѣ�"+'<%=realcash%>'+"*��ˮ�ţ�"+'<%=stream%>'+"|";
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s1246/f1246_1.jsp?activePhone=<%=themob%>";                    
}
</script>

<%if(ret_code.equals("000000")&&handcash>0.0){%>
<script language="javascript">
	rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......',2);
	printBill();
</script>
<%}%>

<%if(ret_code.equals("000000")){%>
<script language='javascript'>
	rdShowMessageDialog('�����ɹ���',2);
	document.location.replace("f1246_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
<script language='javascript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
	history.go(-1);
</script>
<%}%>



