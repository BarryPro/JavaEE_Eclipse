<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
 


  
  
  String acceptss=request.getParameter("acceptss");
  String bands=request.getParameter("bands");
  String usernames=request.getParameter("usernames");
  String usericcidtypes=request.getParameter("usericcidtypes");
  String usericcid=request.getParameter("usericcid");
  String moneys=request.getParameter("moneys");
  String phoneno=request.getParameter("phoneno");
  String kuandainos=request.getParameter("kuandainos");
  String belongcode=request.getParameter("belongcode");
  String id_nos=request.getParameter("id_nos");
  String liushui=request.getParameter("liushui");
  String beizhu=workNo+"�Կ����"+kuandainos+"����Ѻ���˻����������["+moneys+"]";

%>


<wtc:service name="sm355Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
	
	<wtc:param value="<%=acceptss%>"/>
  <wtc:param value="01"/>
  <wtc:param value="m355"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneno%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=id_nos%>"/>
  <wtc:param value="<%=moneys%>"/>
	<wtc:param value="<%=bands%>"/>
	<wtc:param value="<%=beizhu%>"/>
	<wtc:param value="<%=belongcode%>"/>
	<wtc:param value="<%=liushui%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
		
<%

	if("000000".equals(retCode)){
		System.out.println(" ======== sm355Cfm ���óɹ� ========");
%>	
    <script language="javascript">
 	      rdShowMessageDialog("Ѻ�𷵻������ɹ���",2);
 	     
 	    var shuilv = 0.17;
	  	var kdZdFee = "<%=moneys%>";
	  	var danjia = 0;
	  	var shuie = 0;
	  	var  billArgsObj = new Object();
		if(Number(kdZdFee) != 0){
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;

			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=usernames%>");   //�ͻ�����
			$(billArgsObj).attr("10006","<%=opName%>");    //ҵ�����
			$(billArgsObj).attr("10008","<%=phoneno%>");    //�û�����
			$(billArgsObj).attr("10015", "-"+kdZdFee+"");   //���η�Ʊ���
			$(billArgsObj).attr("10016", "-"+kdZdFee+"");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030","<%=acceptss%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>");   //��������
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",kdZdFee+"");	                //����
			/*10045����ӡ*/
			$(billArgsObj).attr("10045","");	       //IMEI
			$(billArgsObj).attr("10072","2");	//����
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062",shuilv+"");	//˰��
			$(billArgsObj).attr("10063","-"+shuie+"");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//˰��	
	 		$(billArgsObj).attr("10076","-"+danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //����ն˽��
 			$(billArgsObj).attr("10078", "<%=bands%>"); //���Ʒ��	
 			$(billArgsObj).attr("10074","0"); 
	 		$(billArgsObj).attr("10075","0"); 		
 			$(billArgsObj).attr("10083", "<%=usericcidtypes%>"); //֤������
 			$(billArgsObj).attr("10084", "<%=usericcid%>"); //֤������
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10086", ""); //��ע
 			$(billArgsObj).attr("10041", "����ն�Ѻ�����");           //Ʒ����� ʵ���ǿ���ն�����
 			$(billArgsObj).attr("10065", "<%=kuandainos.trim()%>"); //����˺�
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			var path = path +"&loginAccept=<%=acceptss%>&opCode=m355&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			}
			
			window.location="fm355.jsp?opCode=<%=opCode%>&opName=<%=opName%>";		
		
 	  </script>
<%}else{
	  System.out.println(" ======== sm355Cfm ����ʧ�� ========");
%>
  	<script language="javascript">
 	    rdShowMessageDialog("Ѻ�𷵻�����ʧ�ܣ�������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
 		  window.location="fm355.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
