<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!-------------------------------------------->
<!---����:  2003-10-23                    ---->
<!---����:  sunzhe                        ---->
<!---����:  fPubSimpSel.jsp               ---->
<!---���ܣ� ��ӡȷ�Ͻ���                  ---->
<!---�޸ģ�                               ---->
<!--
Setup ��ʾ��ӡ���öԻ��� 1 ��ʾ 0 ����ʾ
StartPrint ��ʼ��ӡ
PageStart �µ�ҳ
Print 
����1 x���꣨0 - 100��һ�����꣩
����2 y���꣨0 - 100��һ�����꣩
����3 �ֺţ�0 - 100��0Ϊϵͳȱʡ�ֺţ�
����4 �ִ�ϸ��0 - 10��0Ϊϵͳȱʡ��
����5 Ҫ��ӡ���ַ���

PageEnd ҳ����
StopPrint ֹͣ��ӡ
<!-------------------------------------------->
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<% 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1984";
	String nopass = (String)session.getAttribute("password");
	String paraStr[]=new String[37];
	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gbk");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>

<!--**************************************************************************************-->
<body onload = "ifprint();">
<FORM method=post name="spubPrint">

<!------------------------------------------------------>
</FORM>
</body>
<!-------�����ӡ�ؼ�---------->
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</HTML> 


<script language="javascript">
function ifprint()
{

 doPrint();
 rdShowMessageDialog('��ӡ�ɹ�!',2);

 window.returnValue=1;
// window.close();

}

function doPrint()
{
  var infoStr="<%=retInfo%>";
  
  try
  {
     //��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();
	

	var startRow=5;
	var startCol=10;
	// printctrl.Print(startCol+35,startRow+0,12,1,"����ʱ�䣺oneTok(infoStr,"|",3)��");//��
	// printctrl.Print(startCol+52,startRow+0,12,5,"oneTok(infoStr,"|",4)");//��
	// printctrl.Print(startCol+57,startRow+0,12,7,"oneTok(infoStr,"|",5)");//��
	
	// printctrl.Print(startCol+35,startRow+9,12,9,"�ֻ����룺oneTok(infoStr,"|",4)");//�ƶ�����
	// printctrl.Print(startCol+35,startRow+11,12,11,"�ƶ���Ϣ���񿪹�����"); 
	// printctrl.Print(startCol+35,startRow+43,12,13,"�����ţ�oneTok(infoStr,"|",1)");//������
	
	printctrl.Print(13,5,9,0,oneTok(infoStr,"|",1));  //����
	printctrl.Print(20,5,9,0,oneTok(infoStr,"|",2));  //����Ա
	//printctrl.Print(30,5,9,0,oneTok(infoStr,"|",3));//��
	//printctrl.Print(40,5,9,0,oneTok(infoStr,"|",4));//��
	//printctrl.Print(50,5,9,0,oneTok(infoStr,"|",5));//��
	printctrl.Print(60,5,9,0,oneTok(infoStr,"|",3));  //��������	
	printctrl.Print(20,10,18,0,oneTok(infoStr,"|",4));//Э�����
	printctrl.Print(60,10,18,0,"�ƶ���Ϣ���񿪹�����");//Э�����

         
 
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
	

	
  }
  catch(e)
  {
 	rdShowMessageDialog("��ӡ����!",0);
  }
  finally
  {
  	 removeCurrentTab();
     //location="<%=dirtPage%>";
  }
}

 </SCRIPT>

   

