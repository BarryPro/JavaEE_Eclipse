<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%/*����ǰ�������ͨ�ʷ���36725��36726����֤�Ƿ��ǺͰ����ֻ�������ͬ�ĵ���*/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	
		String phone_no = request.getParameter("phone_no");	
		String flagtype = request.getParameter("flagtype");	
		String addnestr = request.getParameter("addnestr");/*1239���ӵĺ��봮*/
		String addnestr2 = request.getParameter("addnestr2");/*1239ԭ���еĺ��봮*/
		String updatenestr = request.getParameter("updatenestr");/*1239�޸ĵĺ��봮*/
		String offerid = request.getParameter("offerid");
		String phoneRegion ="";
		String sqlstr1="";
		String sqlstr2="";
		String sqlstr3="";
		String sqlstr4="";
		String sqlstr5="";
		String sqlstr6="";
		String outnums1="";
		String booleanflag="yes";
		String bendihaoma="������������������룺";
		String changtuhaoma="����������;������룺";
		String bendiupdate="����������룺";
		String changtuupdate="��;������룺";
		int ie=0;
		int iu=0;
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "SELECT SUBSTR (belong_code, 1, 2) FROM dcustmsg WHERE phone_no =:phone_noL";
	inParamsss1[1] = "phone_noL="+phone_no;
	
System.out.println(phone_no+"=======wanghyd");
System.out.println(addnestr+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(retCode1ss.equals("000000")) {
if(dcust.length>0) {
phoneRegion=dcust[0][0];
}
}
System.out.println(phoneRegion+"=======wanghyd");
	if(flagtype.equals("00")) {/*����������������*/
				if(addnestr.length()>0) {
	      String list1[] =addnestr.split(",");
	      outnums1=list1.length+"";
        for(int i=0;i <list1.length;i++) 
				{
					if(list1[i].equals("")) {
					break;
					}
					System.out.println("---"+list1[i]+"----");
					sqlstr1+=" phone_no=:phone_no"+i;
					sqlstr2+="phone_no"+i+"="+list1[i];
					if(i!=list1.length-1) {
					sqlstr1+=" or";
					sqlstr2+=", ";
					}
				}
				System.out.println(sqlstr1+"=======wanghyd");
				System.out.println(sqlstr2+"=======wanghyd");
				}
				
				if(addnestr2.length()>0) {/*�����ԭ�����������*/
	      String list2[] =addnestr2.split(",");
	      //outnums1=list2.length+"";
        for(int i=0;i <list2.length;i++) 
				{
					if(list2[i].equals("")) {
					break;
					}
					System.out.println("---"+list2[i]+"----");
					sqlstr3+=" phone_no=:phone_no"+i;
					sqlstr4+="phone_no"+i+"="+list2[i];
					if(i!=list2.length-1) {
					sqlstr3+=" or";
					sqlstr4+=", ";
					}
				}
				System.out.println(sqlstr3+"=======wanghyd");
				System.out.println(sqlstr4+"=======wanghyd");
				
	String[] inParamsss3 = new String[2];
	inParamsss3[0] = "SELECT SUBSTR (belong_code, 1, 2) , phone_no FROM dcustmsg WHERE"+sqlstr3;
	inParamsss3[1] = sqlstr4;
%>	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="2">			
	<wtc:param value="<%=inParamsss3[0]%>"/>
	<wtc:param value="<%=inParamsss3[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust3" scope="end" />
<%
		if(retCode3ss.equals("000000")) {
		if(dcust3.length>0) {
		System.out.println(dcust3.length+"=======wanghyd");
		 for(int is=0;is<dcust3.length;is++) {
		 		if(!dcust3[is][0].equals(phoneRegion)) {
		 			ie++;
		 		}
		 		System.out.println(dcust3[is][0]+"=======wanghyd");
		 
		 }
		}
		}
				}
	
	String[] inParamsss2 = new String[2];
	inParamsss2[0] = "SELECT SUBSTR (belong_code, 1, 2) , phone_no FROM dcustmsg WHERE"+sqlstr1;
	inParamsss2[1] = sqlstr2;
	

%>		
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="2">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust2" scope="end" />
  	

  	
<%

if(retCode2ss.equals("000000")) {
if(dcust2.length>0) {
System.out.println(dcust2.length+"=======wanghyd");
 for(int is=0;is<dcust2.length;is++) {
 		if(!dcust2[is][0].equals(phoneRegion)) {
 			ie++;
 			changtuhaoma+=dcust2[is][1]+"��";
 		}
 	  else {
 	  	bendihaoma+=dcust2[is][1]+"��";
 		}
 		System.out.println(dcust2[is][1]+"===ssss====wanghyd");
 
 }
}
}


System.out.println(bendihaoma+"=======wanghyd");
System.out.println(changtuhaoma+"=======wanghyd");
if(offerid.equals("36725")) {
 if(ie>1) {/*�����B�ƻ������ֻ��һ��ʡ�ڳ�;��*/
 	booleanflag="no";
 }
}
if(offerid.equals("36726")) {
 if(ie>2) {/*�����C�ƻ������ֻ�ж���ʡ�ڳ�;��*/
 	booleanflag="no";
 }
}
}
System.out.println(ie+"=======wanghyd"); 

	if(flagtype.equals("01")) {/*������޸��������*/
					if(updatenestr.length()>0) {
	      String list1[] =updatenestr.split(",");
        for(int i=0;i <list1.length;i++) 
				{
					if(list1[i].equals("")) {
					break;
					}
					System.out.println("---"+list1[i]+"----");
					sqlstr5+=" phone_no=:phone_no"+i;
					sqlstr6+="phone_no"+i+"="+list1[i];
					if(i!=list1.length-1) {
					sqlstr5+=" or";
					sqlstr6+=", ";
					}
				}
				System.out.println(sqlstr5+"=======wanghyd");
				System.out.println(sqlstr6+"=======wanghyd");
				}
	String[] inParamsss4 = new String[2];
	inParamsss4[0] = "SELECT SUBSTR (belong_code, 1, 2) , phone_no FROM dcustmsg WHERE"+sqlstr5;
	inParamsss4[1] = sqlstr6;
	%>		
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4ss" retmsg="retMsg4ss" outnum="2">			
	<wtc:param value="<%=inParamsss4[0]%>"/>
	<wtc:param value="<%=inParamsss4[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust4" scope="end" />
 	
<%
if(retCode4ss.equals("000000")) {
if(dcust4.length>0) {
System.out.println(dcust4.length+"=======wanghyd");
 for(int is=0;is<dcust4.length;is++) {
 		if(!dcust4[is][0].equals(phoneRegion)) {
 			iu++;
 			changtuupdate+=dcust4[is][1]+"��";
 		}
 	  else {
 	  	bendiupdate+=dcust4[is][1]+"��";
 		}
 		System.out.println(dcust4[is][1]+"===ssss====wanghyd");
 
 }
}
}
System.out.println(bendiupdate+"=======wanghyd");
System.out.println(changtuupdate+"=======wanghyd");
if(offerid.equals("36725")) {
 if(iu>1) {/*�����B�ƻ������ֻ��һ��ʡ�ڳ�;��*/
 	booleanflag="no";
 }
}
if(offerid.equals("36726")) {
 if(iu>2) {/*�����C�ƻ������ֻ�ж���ʡ�ڳ�;��*/
 	booleanflag="no";
 }
}
	}
%>  	
  	
	
  	
	var response = new AJAXPacket();
	response.data.add("booleanflag","<%=booleanflag%>");
	response.data.add("flagtype","<%=flagtype%>");
<%
	if(flagtype.equals("00")) {/*����������������*/
%>	
  response.data.add("bendihaoma","<%=bendihaoma%>");
  response.data.add("changtuhaoma","<%=changtuhaoma%>");
  response.data.add("offerid","<%=offerid%>");
<%
  }

	if(flagtype.equals("01")) {/*������޸��������*/
%>	
  response.data.add("bendiupdate","<%=bendiupdate%>");
  response.data.add("changtuupdate","<%=changtuupdate%>");
  response.data.add("offerid","<%=offerid%>");
<%
  }
%>
	core.ajax.receivePacket(response);
	