<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-24 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
java.util.Random r = new java.util.Random();
	 int ran = r.nextInt(9999);
	 int ran1 = r.nextInt(10)*1000;
	 if((ran+"").length()<4){
	  	ran = ran+ran1;
	 }
	 int key = 99999;
	 int realKey = ran ^ key;
  ArrayList arr = (ArrayList)session.getAttribute("allArr");
  ArrayList resultList = (ArrayList)session.getAttribute("resultList1111");
System.out.println("====resultList====" + resultList.size());
  String[][] baseInfo = (String[][])arr.get(0);
  String[][] pass = (String[][])arr.get(4);
	String orgCode = baseInfo[0][16];
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String nopass = pass[0][0];
	String TPrintDate = request.getParameter("TPrintDate");
	String dateStr=TPrintDate;
	String yy=dateStr.substring(0,4);
	String mm=dateStr.substring(4,6);
	String dd=dateStr.substring(6,8);
	String busy_type=request.getParameter("busy_type");
	String yearMonth = request.getParameter("SBillDate");
	String beginCon = request.getParameter("TBeginContract");
	String endCon = request.getParameter("TEndContract");
	String beginBank = request.getParameter("bank1");
	String endBank = request.getParameter("bank2");
	String TNote = request.getParameter("TNote");
	String belongcode = request.getParameter("SDisCode");
	String TNote1 = workno + "," + nopass + "," + TNote;
String[] inParas = new String[10];
    inParas[0] = yearMonth;
    inParas[1] = belongcode;
    inParas[2] = beginBank;
    inParas[3] = endBank;
    inParas[4] = beginCon;
    inParas[5] = endCon;
    inParas[6] = orgCode;
		inParas[7] = workno;
    inParas[8] = nopass;
	  inParas[9] = busy_type;

  %>
  <wtc:service name="se633Print"   retcode="retCode1" retmsg="retMsg1" outnum="21" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
  <%
  String[][] result = new String[][]{};
    
 
	//String errorCode = "";
	int resultSize=0;
	if(result!=null)
	{
		result=sVerifyTypeArr;
		resultSize = result.length;
	}
	//xl add
	result = (String [][])resultList.get(0); 
	String errorCode = "";
	resultSize = result.length;
    if (resultSize != 0) {
	    errorCode = result[0][0];
	}
	// add end
    if (resultSize != 0) {
	    errorCode = result[0][0];
	}
	%>
		<script language="javascript">
			//alert("1 test result is "+"<%=result%>"+" and resultSize is "+"<%=resultSize%>"+" and errorCode is "+"<%=errorCode%>");
		</script>
	<%
%>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%if(resultSize == 0){%>
<script language="JavaScript">
	rdShowMessageDialog("��ӡʧ�ܣ����յ�����Ϊ0��",0);
	document.location.replace("e633_1.jsp");
</script>
<%}%>

<SCRIPT language="JavaScript">

function ifprint(){
try {
<%

for (int i=0;i<result.length;i++) {
  /*int colnumber = 0;
  String date = result[i][5];
  out.println("printctrl.Setup(0)");
  out.println("printctrl.StartPrint()");
  out.println("printctrl.PageStart()");
  
 //��һ��
  colnumber += 2 ;
  out.println("printctrl.Print(13,"+(colnumber)+",9,0,'"+workno+"')");
  out.println("printctrl.Print(65,"+(colnumber)+",9,0,'"+date.substring(0,4)+"')");
  out.println("printctrl.Print(74,"+(colnumber)+",9,0,'"+date.substring(4,6)+"')");
  out.println("printctrl.Print(80,"+(colnumber)+",9,0,'"+date.substring(6,8)+"')");
  
  //�ڶ���                    �к�  �к�                ����
  colnumber += 3;
  out.println("printctrl.Print(18,"+colnumber+",9,0,'"+result[i][2].trim()+"')");
  colnumber += 5; //����Ҫ�� ����һ�� 
  out.println("printctrl.Print(18,"+colnumber+",9,0,'"+result[i][18].trim()+"')");
  out.println("printctrl.Print(40,"+colnumber+",9,0,'"+"("+result[i][19].trim()+")"+"')");
  out.println("printctrl.Print(70,"+colnumber+",9,0,'"+result[i][20].trim()+"')");
  
  //������
  colnumber += 4;
  out.println("printctrl.Print(18,"+colnumber+",9,0,'�ͻ���ͬ��:"+result[i][3].trim()+"')");
  // ԭ������û���� �� Ҫ�� phone_no
  out.println("printctrl.Print(42,"+colnumber+",9,0,'�ֻ�����:"+result[i][4].trim()+"')");
  
  
  //������ ����ܺ��� �����ܺ���20 ȡ��16��
  colnumber += 4;
  out.println("printctrl.Print(20,"+colnumber+",9,0,'��������(��д)"+result[i][17].trim()+"')");
  out.println("printctrl.Print(60,"+colnumber+",9,0,'��������(Сд)"+result[i][6].trim()+"')");
  //������
  colnumber += 4;  
   
	if(result[i][7].substring(0,1)!="|" &&!((result[i][7].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][7]+")");<%
	}
   
  
	if(result[i][8].substring(0,1)!="|" &&!((result[i][8].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][8]+")");<%
	}
  	  
  
   
  colnumber += 4;
    
	if(result[i][9].substring(0,1)!="|" &&!((result[i][9].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][9]+")");<%
	}
  
  
	if(result[i][10].substring(0,1)!="|" &&!((result[i][10].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][10]+")");<%
	}
  
  colnumber += 4;
 
	if(result[i][11].substring(0,1)!="|" &&!((result[i][11].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][11]+")");<%
	}
 
 
	if(result[i][12].substring(0,1)!="|" &&!((result[i][12].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][12]+")");<%
	}
 
  colnumber += 4;
 
	if(result[i][13].substring(0,1)!="|" &&!((result[i][13].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][13]+")");<%
	}
  
	if(result[i][14].substring(0,1)!="|" &&!((result[i][14].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][14]+")");<%
	}
 
  colnumber += 4;
 
	if(result[i][15].substring(0,1)!="|" &&!((result[i][15].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][15]+")");<%
	}
 
	if(result[i][16].substring(0,1)!="|" &&!((result[i][16].substring(0,1)).equals("|")) )
	{
		%>out.println("printctrl.Print(20,"+colnumber+",9,0,"+result[i][16]+")");<%
	}
 */
  int colnumber = 0;
  String date = result[i][5];
  out.println("printctrl.Setup(0)");
  out.println("printctrl.StartPrint()");
  out.println("printctrl.PageStart()");
  
  out.println("printctrl.Print(20, 10, 9, 0,'"+date.substring(0,4)+date.substring(4,6)+date.substring(6,8)+"')");
  out.println("printctrl.Print(50, 10, 9, 0,'�ʵ�ͨ��ҵ')");
  out.println("printctrl.Print(13, 12, 9, 0,'"+"��α�룺"+ran+"')");

  out.println("printctrl.Print(13, 13, 9, 0,'"+"��    �ţ�"+workno+"')");	
  out.println("printctrl.Print(37, 13, 9, 0,'������ˮ')");
  out.println("printctrl.Print(60, 13, 9, 0,'ҵ�����ƣ��������մ�ӡ��Ʊ')");	

  out.println("printctrl.Print(13, 14, 9, 0,'�ͻ����ƣ�"+result[i][2].trim()+"')");	
  out.println("printctrl.Print(60, 14, 9, 0,'��    �ţ�')");


  out.println("printctrl.Print(13, 15, 9, 0,'�ֻ����룺"+result[i][4].trim()+"')");
  out.println("printctrl.Print(37, 15, 9, 0,'Э����룺"+result[i][3].trim()+"')");
  out.println("printctrl.Print(60, 15, 9, 0,'֧Ʊ���룺"+result[i][20].trim()+"')");
  
  
  out.println("printctrl.Print(13, 16, 9, 0,'�ϼƽ�(��д)"+result[i][17].trim()+"')");
  out.println("printctrl.Print(60, 16, 9, 0,'(Сд)"+result[i][6]+"')");
  out.println("printctrl.Print(13, 17, 9, 0,'(��Ŀ)')");
  out.println("printctrl.Print(13, 19, 9, 0,'����ѣ�"+result[i][7]+"')");
  out.println("printctrl.Print(60, 19, 9, 0,'�ط��ѣ�"+result[i][8]+"')");

  out.println("printctrl.Print(13, 20, 9, 0,'�л��ѣ�"+result[i][9]+"')");
  out.println("printctrl.Print(60, 20, 9, 0,'��;�ѣ�"+result[i][10]+"')");

  out.println("printctrl.Print(13, 21, 9, 0,'���ηѣ�"+result[i][11]+"')");
  out.println("printctrl.Print(60, 21, 9, 0,'��Ϣ�ѣ�"+result[i][12]+"')");

  out.println("printctrl.Print(13, 22, 9, 0,'Ƶռ�ѣ�"+result[i][13]+"')");
  out.println("printctrl.Print(60, 22, 9, 0,'IP���ѣ�"+result[i][14]+"')");

  out.println("printctrl.Print(13, 23, 9, 0,'�����ѣ�"+result[i][15]+"')");
  out.println("printctrl.Print(60, 23, 9, 0,'Ԥ�滮����"+result[i][16]+"')");
  
 
  out.println("printctrl.Print(13,24,9,0,'�������ƣ�"+result[i][18].trim() +"')");
  out.println("printctrl.Print(60,24,9,0,'���д��룺"+result[i][19].trim()+"')");


 
  out.println("printctrl.Print(13, 30, 9, 0,'��Ʊ��')");
  out.println("printctrl.Print(32, 30, 9, 0,'�տ')");
  out.println("printctrl.Print(60, 30, 9, 0,'���ˣ�')"); 
  
  out.println("printctrl.PageEnd()");
  out.println("printctrl.StopPrint()");
 
}
%>
} catch(e) {
  } finally {
  }
  
  rdShowMessageDialog("��ӡ�ɹ�!");
  document.location.replace("e633_1.jsp");
}


</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>