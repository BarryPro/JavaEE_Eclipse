	<%
  /* *********************
   * ����: ����û��Ƿ��Ѿ����������ҵ��
   * �汾: 1.0
   * ����: 2013/03/11
   * ����: zhouby
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String opCode = (String)request.getParameter("opCode");
		String phoneNo = (String)request.getParameter("phoneNo");
		String bigclasscode = (String)request.getParameter("bigclasscode");
		String strArray="var arrMsg; ";
		System.out.println("bigclasscode============"+bigclasscode);
		String[][] result=null;
		if(bigclasscode.equals("YXWJ")) {
	  result =new String[2][6];  
		result[0][0]="��Ϸ��Ұ����30Ԫ/����";  
		result[0][1]="YXWJBN"; 
		result[0][2]="B";
		result[0][3]="30";
		result[0][4]="701001";
		result[0][5]="500230544000";
		result[1][0]="��Ϸ��Ұ���60Ԫ/��";  
		result[1][1]="YXWJYN"; 
		result[1][2]="Y";
		result[1][3]="60";
		result[1][4]="701001";
		result[1][5]="500230544000";
		}
		else if(bigclasscode.equals("SJDM")) {
	  result =new String[2][6];  
		result[0][0]="�ֻ��������Ͱ�30Ԫ/����";  
		result[0][1]="SJDMBN"; 
		result[0][2]="B";
		result[0][3]="30";
		result[0][4]="698025";
		result[0][5]="2300000005";
		result[1][0]="�ֻ��������Ͱ�60Ԫ/��";  
		result[1][1]="SJDMYN"; 
		result[1][2]="Y";
		result[1][3]="60";
		result[1][4]="698025";
		result[1][5]="2300000005";
		}
		else if(bigclasscode.equals("SJSP")){
		result =new String[4][6];   
		result[0][0]="v+3Ԫϲ�ְ������18Ԫ/����";  
		result[0][1]="SJSPV3BN"; 
		result[0][2]="B"; 
		result[0][3]="18";
		result[0][4]="699019";
		result[0][5]="30830001";
		result[1][0]="v+3Ԫϲ�ְ�����36Ԫ/��";  
		result[1][1]="SJSPV3YN"; 
		result[1][2]="Y";
		result[1][3]="36";
		result[1][4]="699019";
		result[1][5]="30830001";		
		result[2][0]="v+5Ԫ��ѡ�������30Ԫ/����";  
		result[2][1]="SJSPV5BN"; 
		result[2][2]="B";
		result[2][3]="30";
		result[2][4]="699019";
		result[2][5]="30830003";		
		result[3][0]="v+5Ԫ��ѡ������60Ԫ/��";  
		result[3][1]="SJSPV5YN"; 
		result[3][2]="Y";
		result[3][3]="60";
		result[3][4]="699019";
		result[3][5]="30830003";		
		}
				else if(bigclasscode.equals("WXYY")){
		result =new String[2][6];   
		result[0][0]="���������ؼ���Ա������36Ԫ/����";  
		result[0][1]="WXYYBN"; 
		result[0][2]="B"; 
		result[0][3]="36";
		result[0][4]="wxyybn";
		result[0][5]="FK";
		
		result[1][0]="���������ؼ���Ա����72Ԫ/��";  
		result[1][1]="WXYYYN"; 
		result[1][2]="Y";
		result[1][3]="72";
		result[1][4]="wxyybn";
		result[1][5]="FK";	
		}
		else if ( bigclasscode.equals("DZTC") )
		{
			result =new String[4][6];   
			result[0][0]="WLAN����240Ԫ����";  
			result[0][1]="WLAN01"; 
			result[0][2]="360"; 
			result[0][3]="240";
			result[0][5]="00006";//��ҵ����
			result[0][4]="WLAN01";	//ҵ�����
			
			result[1][0]="WLAN����360Ԫ����";  
			result[1][1]="WLAN01"; 
			result[1][2]="360"; 
			result[1][3]="360";
			result[1][5]="00001";
			result[1][4]="WLAN01";
				
			result[2][0]="WLAN����600Ԫ����";  
			result[2][1]="WLAN01"; 
			result[2][2]="360"; 
			result[2][3]="600";
			result[2][5]="00002";
			result[2][4]="WLAN01";	
			
			result[3][0]="WLAN����1200Ԫ����";  
			result[3][1]="WLAN01"; 
			result[3][2]="360"; 
			result[3][3]="1200";
			result[3][5]="00003";
			result[3][4]="WLAN01";	
		}		
		else if ( bigclasscode.equals("GXTC") )
		{
			result =new String[6][6];   
			result[0][0]="WLANУ԰50Ԫ��ѧ��(5����)";  
			result[0][1]="WLAN05"; 
			result[0][2]="150"; 
			result[0][3]="50";
			result[0][5]="10001";
			result[0][4]="WLAN05";	
			
			result[1][0]="WLANУ԰100Ԫ��ѧ��(5����)";  
			result[1][1]="WLAN05"; 
			result[1][2]="150"; 
			result[1][3]="100";
			result[1][5]="10002";
			result[1][4]="WLAN05";
				
			result[2][0]="WLANУ԰200Ԫ��ѧ��(5����)";  
			result[2][1]="WLAN05"; 
			result[2][2]="150"; 
			result[2][3]="200";
			result[2][5]="10003";
			result[2][4]="WLAN05";	
			
			result[3][0]="WLANУ԰120Ԫ����";  
			result[3][1]="WLAN05"; 
			result[3][2]="360"; 
			result[3][3]="120";
			result[3][5]="10001";
			result[3][4]="WLAN05";	
			
			result[4][0]="WLANУ԰240Ԫ����";  
			result[4][1]="WLAN05"; 
			result[4][2]="360"; 
			result[4][3]="240";
			result[4][5]="10002";
			result[4][4]="WLAN05";
				
			result[5][0]="WLANУ԰480Ԫ����";  
			result[5][1]="WLAN05"; 
			result[5][2]="360"; 
			result[5][3]="480";
			result[5][5]="10003";
			result[5][4]="WLAN05";				
		}
		else if(bigclasscode.equals("SJB")){
				result = new String[2][6];   
				result[0][0]="�������������18Ԫ/����";  
				result[0][1]="XWZWBBN"; 
				result[0][2]="B";
				result[0][3]="18";
				result[0][4]="110301";
				result[0][5]="801234";
				
				result[1][0]="������������36Ԫ/��";
				result[1][1]="XWZWBYN"; 
				result[1][2]="Y";
				result[1][3]="36";
				result[1][4]="110301";
				result[1][5]="801234";
		}
		else if(bigclasscode.equals("CYZL")){
			result = new String[3][6]; 
			result[0][0]="�����������ҵ��30Ԫ";  
			result[0][1]="CYZLBJ"; 
			result[0][2]="90";
			result[0][3]="30";
			result[0][5]="20140103";
			result[0][4]="300008";
			
			result[1][0]="�������������ҵ��60Ԫ";  
			result[1][1]="CYZLBBN"; 
			result[1][2]="B";
			result[1][3]="180";
			result[1][5]="20140103";
			result[1][4]="300008";
			
			result[2][0]="�����������ҵ��100Ԫ";
			result[2][1]="CYZLBN"; 
			result[2][2]="360";
			result[2][3]="100";
			result[2][5]="20140103";
			result[2][4]="300008";
		}
		else if(bigclasscode.equals("HLY")){
			result = new String[1][6];   
			result[0][0]="�����԰���ҵ��36Ԫ/��";  
			result[0][1]="HLYBN"; 
			result[0][2]="360";
			result[0][3]="36";
			result[0][5]="YYXX2013";//ҵ�����
			result[0][4]="919015";//��ҵ����
	}
		
	
	strArray = WtcUtil.createArray("arrMsg",result.length);	
%>

<%=strArray%>

<%
for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){

if(result[i][j].trim().equals("") || result[i][j] == null){
   result[i][j] = "";
}
System.out.println("||---------" + result[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
<%
  }
}
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "000000");
		response.data.add("retMsg", "��ѯ�ɹ�");
		response.data.add("backArrMsg1", arrMsg);
		core.ajax.receivePacket(response);