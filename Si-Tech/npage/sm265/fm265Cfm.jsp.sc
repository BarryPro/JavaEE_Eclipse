<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String zr_phone = request.getParameter("zr_phone");
  
  
  String phonenos = request.getParameter("phonenos");
  String jinee = request.getParameter("jinee");
  String liushis = request.getParameter("liushis");
  String custnamess = request.getParameter("custnamess");
  String simstatuss = request.getParameter("simstatuss");


	String  inputParsm [] = new String[12];
	inputParsm[0] = liushis;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phonenos;
	inputParsm[6] = "";
  String xinliushuis="";
	
%>
	<wtc:service name="sm265Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		if(ret.length>0) {
			xinliushuis=ret[0][0];
			System.out.println("xinliushuis="+xinliushuis);
		}
%>	
    <script language="javascript">
 	      rdShowMessageDialog("����SIM���ѳ��������ɹ���",2);
 	      
 	          var  billArgsObj = new Object();
						$(billArgsObj).attr("10001","<%=workNo%>");       //����
						$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10005","<%=custnamess%>"); //�ͻ�����
						$(billArgsObj).attr("10006","����SIM���ѳ���"); //ҵ�����
						$(billArgsObj).attr("10008","<%=phonenos%>"); //�û�����
						$(billArgsObj).attr("10015", "-<%=WtcUtil.formatNumber(jinee,2)%>");   //���η�Ʊ���
						$(billArgsObj).attr("10016", "-<%=WtcUtil.formatNumber(jinee,2)%>");   //��д���ϼ�	
						$(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
						$(billArgsObj).attr("10030","<%=xinliushuis%>"); //��ˮ��--ҵ����ˮ
						$(billArgsObj).attr("10036","m265"); //��������	
						$(billArgsObj).attr("10041","SIM��"); //Ʒ�����     
						$(billArgsObj).attr("10042","��"); //��λ         
						$(billArgsObj).attr("10043","1"); //����         
						$(billArgsObj).attr("10044","-<%=WtcUtil.formatNumber(jinee,2)%>"); //����         
						$(billArgsObj).attr("10061","<%=simstatuss%>"); //sim���ͺ�
						$(billArgsObj).attr("10071","7"); //ģ��
						$(billArgsObj).attr("10072","2"); //ģ��
						var h=180;
						var w=350;
						var t=screen.availHeight/2-h/2;
						var l=screen.availWidth/2-w/2;
						var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
						
						var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=���潫��ӡ��Ʊ��";
						var loginAccept = "<%=xinliushuis%>";
						var path = path + "&loginAccept="+loginAccept+"&opCode=m265&submitCfm=Single";
						var ret=window.showModalDialog(path, billArgsObj, prop);
						
 	          window.location="fm265.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("����SIM���ѳ�������ʧ�ܣ�������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
 		  window.location="fm265.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
