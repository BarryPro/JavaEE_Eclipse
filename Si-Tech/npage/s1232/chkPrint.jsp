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
<%@ page contentType= "text/html;charset=gb2312" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>

<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<% 
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	String op_code = "1210";
	String nopass = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[37];

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gb2312");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>
<SCRIPT type=text/javascript>

function doPrint()
{
  var infoStr="<%=retInfo%>";
  
  try
  {
     //��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var startCol=20;
    var startRow=7;
      
  	    //printctrl.Print(startCol-2,startRow,0,0,oneTok(infoStr,"|",1));      //֤������ 
        printctrl.Print(startCol+10,startRow+1,10,0,oneTok(infoStr,"|",2));      //��
		printctrl.Print(startCol+18,startRow+1,10,0,oneTok(infoStr,"|",3));      //��
		printctrl.Print(startCol+23,startRow+1,10,0,oneTok(infoStr,"|",4));      //��

        printctrl.Print(startCol-5,startRow+3,10,0,oneTok(infoStr,"|",5));      //�ֻ����� 
        printctrl.Print(startCol+30,startRow+3,10,0,oneTok(infoStr,"|",6));   //��ͬ����  

        printctrl.Print(startCol-10,startRow+4,10,0,oneTok(infoStr,"|",7));     //�ͻ����� 

        printctrl.Print(startCol-10,startRow+6,10,0,oneTok(infoStr,"|",8));     //��ϵ��ַ

		printctrl.Print(startCol-10,startRow+8,10,0,oneTok(infoStr,"|",9));     //���ʽ

        //��Сд���
		printctrl.Print(startCol,startRow+10,10,0,chineseNumber(oneTok(infoStr,"|",10)));
		printctrl.Print(startCol+35,startRow+10,10,0,oneTok(infoStr,"|",10));     

        //ҵ����Ŀ
	    var busiStr=oneTok(infoStr,"|",11);
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
          printctrl.Print(startCol-15,startRow+12+i*1,9,0,oneTok(busiStr,"*",i+1));  
       
	    //����Ա���տ�Ա
	    printctrl.Print(10,32,9,0,"<%=work_no%>");
		printctrl.Print(35,32,9,0,"<%=work_no%>");
         
 
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	//rdShowMessageDialog("��ӡ�����ϣ��޷���ӡ��Ʊ��");
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}

 </SCRIPT>
<!--**************************************************************************************-->
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY  onload="doPrint()">
          
    </BODY>
</FORM>
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
