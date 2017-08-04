	<%
  /* *********************
   * 功能: 检测用户是否已经办理了相关业务
   * 版本: 1.0
   * 日期: 2013/03/11
   * 作者: zhouby
   * 版权: si-tech
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
		result[0][0]="游戏玩家半年包30元/半年";  
		result[0][1]="YXWJBN"; 
		result[0][2]="B";
		result[0][3]="30";
		result[0][4]="701001";
		result[0][5]="500230544000";
		result[1][0]="游戏玩家包年60元/年";  
		result[1][1]="YXWJYN"; 
		result[1][2]="Y";
		result[1][3]="60";
		result[1][4]="701001";
		result[1][5]="500230544000";
		}
		else if(bigclasscode.equals("SJDM")) {
	  result =new String[2][6];  
		result[0][0]="手机动漫漫赏包30元/半年";  
		result[0][1]="SJDMBN"; 
		result[0][2]="B";
		result[0][3]="30";
		result[0][4]="698025";
		result[0][5]="2300000005";
		result[1][0]="手机动漫漫赏包60元/年";  
		result[1][1]="SJDMYN"; 
		result[1][2]="Y";
		result[1][3]="60";
		result[1][4]="698025";
		result[1][5]="2300000005";
		}
		else if(bigclasscode.equals("SJSP")){
		result =new String[4][6];   
		result[0][0]="v+3元喜乐包半年包18元/半年";  
		result[0][1]="SJSPV3BN"; 
		result[0][2]="B"; 
		result[0][3]="18";
		result[0][4]="699019";
		result[0][5]="30830001";
		result[1][0]="v+3元喜乐包包年36元/年";  
		result[1][1]="SJSPV3YN"; 
		result[1][2]="Y";
		result[1][3]="36";
		result[1][4]="699019";
		result[1][5]="30830001";		
		result[2][0]="v+5元精选包半年包30元/半年";  
		result[2][1]="SJSPV5BN"; 
		result[2][2]="B";
		result[2][3]="30";
		result[2][4]="699019";
		result[2][5]="30830003";		
		result[3][0]="v+5元精选包包年60元/年";  
		result[3][1]="SJSPV5YN"; 
		result[3][2]="Y";
		result[3][3]="60";
		result[3][4]="699019";
		result[3][5]="30830003";		
		}
				else if(bigclasscode.equals("WXYY")){
		result =new String[2][6];   
		result[0][0]="无线音乐特级会员包半年36元/半年";  
		result[0][1]="WXYYBN"; 
		result[0][2]="B"; 
		result[0][3]="36";
		result[0][4]="wxyybn";
		result[0][5]="FK";
		
		result[1][0]="无线音乐特级会员包年72元/年";  
		result[1][1]="WXYYYN"; 
		result[1][2]="Y";
		result[1][3]="72";
		result[1][4]="wxyybn";
		result[1][5]="FK";	
		}
		else if ( bigclasscode.equals("DZTC") )
		{
			result =new String[4][6];   
			result[0][0]="WLAN大众240元包年";  
			result[0][1]="WLAN01"; 
			result[0][2]="360"; 
			result[0][3]="240";
			result[0][5]="00006";//企业代码
			result[0][4]="WLAN01";	//业务代码
			
			result[1][0]="WLAN大众360元包年";  
			result[1][1]="WLAN01"; 
			result[1][2]="360"; 
			result[1][3]="360";
			result[1][5]="00001";
			result[1][4]="WLAN01";
				
			result[2][0]="WLAN大众600元包年";  
			result[2][1]="WLAN01"; 
			result[2][2]="360"; 
			result[2][3]="600";
			result[2][5]="00002";
			result[2][4]="WLAN01";	
			
			result[3][0]="WLAN大众1200元包年";  
			result[3][1]="WLAN01"; 
			result[3][2]="360"; 
			result[3][3]="1200";
			result[3][5]="00003";
			result[3][4]="WLAN01";	
		}		
		else if ( bigclasscode.equals("GXTC") )
		{
			result =new String[6][6];   
			result[0][0]="WLAN校园50元包学期(5个月)";  
			result[0][1]="WLAN05"; 
			result[0][2]="150"; 
			result[0][3]="50";
			result[0][5]="10001";
			result[0][4]="WLAN05";	
			
			result[1][0]="WLAN校园100元包学期(5个月)";  
			result[1][1]="WLAN05"; 
			result[1][2]="150"; 
			result[1][3]="100";
			result[1][5]="10002";
			result[1][4]="WLAN05";
				
			result[2][0]="WLAN校园200元包学期(5个月)";  
			result[2][1]="WLAN05"; 
			result[2][2]="150"; 
			result[2][3]="200";
			result[2][5]="10003";
			result[2][4]="WLAN05";	
			
			result[3][0]="WLAN校园120元包年";  
			result[3][1]="WLAN05"; 
			result[3][2]="360"; 
			result[3][3]="120";
			result[3][5]="10001";
			result[3][4]="WLAN05";	
			
			result[4][0]="WLAN校园240元包年";  
			result[4][1]="WLAN05"; 
			result[4][2]="360"; 
			result[4][3]="240";
			result[4][5]="10002";
			result[4][4]="WLAN05";
				
			result[5][0]="WLAN校园480元包年";  
			result[5][1]="WLAN05"; 
			result[5][2]="360"; 
			result[5][3]="480";
			result[5][5]="10003";
			result[5][4]="WLAN05";				
		}
		else if(bigclasscode.equals("SJB")){
				result = new String[2][6];   
				result[0][0]="新闻早晚报半年包18元/半年";  
				result[0][1]="XWZWBBN"; 
				result[0][2]="B";
				result[0][3]="18";
				result[0][4]="110301";
				result[0][5]="801234";
				
				result[1][0]="新闻早晚报包年36元/年";
				result[1][1]="XWZWBYN"; 
				result[1][2]="Y";
				result[1][3]="36";
				result[1][4]="110301";
				result[1][5]="801234";
		}
		else if(bigclasscode.equals("CYZL")){
			result = new String[3][6]; 
			result[0][0]="车友助理包季业务30元";  
			result[0][1]="CYZLBJ"; 
			result[0][2]="90";
			result[0][3]="30";
			result[0][5]="20140103";
			result[0][4]="300008";
			
			result[1][0]="车友助理包半年业务60元";  
			result[1][1]="CYZLBBN"; 
			result[1][2]="B";
			result[1][3]="180";
			result[1][5]="20140103";
			result[1][4]="300008";
			
			result[2][0]="车友助理包年业务100元";
			result[2][1]="CYZLBN"; 
			result[2][2]="360";
			result[2][3]="100";
			result[2][5]="20140103";
			result[2][4]="300008";
		}
		else if(bigclasscode.equals("HLY")){
			result = new String[1][6];   
			result[0][0]="和留言包年业务36元/年";  
			result[0][1]="HLYBN"; 
			result[0][2]="360";
			result[0][3]="36";
			result[0][5]="YYXX2013";//业务代码
			result[0][4]="919015";//企业代码
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
		response.data.add("retMsg", "查询成功");
		response.data.add("backArrMsg1", arrMsg);
		core.ajax.receivePacket(response);