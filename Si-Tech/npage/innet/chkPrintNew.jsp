<%
/********************
 version v2.0
������: si-tech
update:liutong@20080919
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
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html;charset=GB2312"%>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>

<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<% 
    /**
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	String op_code = "1210";
	String nopass = ((String[][])arrSession.get(4))[0][0];
	**/
	String op_code = "1210";
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");
	
	
	String paraStr[]=new String[37];
	

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gb2312");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
	String phone = request.getParameter("activePhone");
	dirtPage = dirtPage + "&activePhone=" + phone;
 %>
<SCRIPT type=text/javascript>
	function chineseNumber(num)
{
if(parseFloat(num)<=0.01) return "��Բ��"
if (isNaN(num) || num > Math.pow(10, 12)) return ""
var cn = "��Ҽ��������½��ƾ�"
var unit = new Array("ʰ��Ǫ", "�ֽ�")
var unit1= new Array("����", "")
var numArray = num.toString().split(".")
var start = new Array(numArray[0].length-1, 2)

	function toChinese(num, index)
	{
	var num = num.replace(/\d/g, function ($1)
	{
	return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1)
	})
	return num
	}

for (var i=0; i<numArray.length; i++)
{
var tmp = ""
for (var j=0; j*4<numArray[i].length; j++)
{
var strIndex = numArray[i].length-(j+1)*4
var str = numArray[i].substring(strIndex, strIndex+4)
var start = i ? 2 : str.length-1
var tmp1 = toChinese(str, i)
tmp1 = tmp1.replace(/(��.)+/g, "��").replace(/��+$/, "")
tmp1 = tmp1.replace(/^Ҽʰ/, "ʰ")
tmp = (tmp1+unit1[i].charAt(j-1)) + tmp
}
numArray[i] = tmp 
}

numArray[1] = numArray[1] ? numArray[1] : ""
numArray[0] = numArray[0] ? numArray[0]+"Բ" : numArray[0], numArray[1] = numArray[1].replace(/^��+/, "")
numArray[1] = numArray[1].match(/��/) ? numArray[1] : numArray[1]+"��"
return numArray[0]+numArray[1]
}

	
/**���ַ�������tok�ֽ�ȡֵ**/
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }
  /**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	function getTokNums(str,tok){
	   var temStr=str;
	   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
	   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
	
	   var temLen;
	   var temNum=1;
	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length;
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
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
		/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� begin*/
		<%
			if(printLogoFlag.equals("N"))
			{
				%>
				//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					printctrl.DrawImage(localPath,8,10,40,18);//��������
				<%
			}
		%>
		var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
		/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� end*/
		
		/*liujian 2012-3-24 9:36:20 ��Ʊ�Ż� begin */
		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",2));
 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ʵ�ͨ��ҵ");
		printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���η�Ʊ���룺<%=bill_number%>");

		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺");
		
		printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�"+oneTok(infoStr,"|",1));//����
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"������ˮ��");//��ˮ
		printctrl.PrintEx(100, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"ҵ�����ƣ�");//ҵ������
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͻ����ƣ�"+oneTok(infoStr,"|",3));//�û�����
		printctrl.PrintEx(100,rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�"+oneTok(infoStr,"|",4));//����
		
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ֻ����룺"+oneTok(infoStr,"|",5));//�ƶ�����
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Э����룺"+oneTok(infoStr,"|",6));//Э�����
		printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"֧Ʊ���룺"+oneTok(infoStr,"|",7));//֧Ʊ����
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ϼƽ�(��д)"+chineseNumber(oneTok(infoStr,"|",8)));//�ϼƽ��(��д)
		printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(Сд)��"+oneTok(infoStr,"|",8));//���(Сд)
		
		printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(��Ŀ)");//��Ŀ
		
		var busiStr=oneTok(infoStr,"|",9);
		var row = 0;
		var f = 0;
		for(var i=0;i<getTokNums(busiStr,"~");i++) {
			if (i % 2 == 0) {
				f = 1;
				printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
			} else if (i % 2 == 1) {
				f = 0;
				printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				row ++;
			}
		}
		    
		if(f == 1) {
		  row++;
		}
	  busiStr=oneTok(infoStr,"|",10);
		for(var i=0;i<getTokNums(busiStr,"~");i++) {
			if (i % 2 == 0) {
				printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
			} else if (i % 2 == 1) {
				printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				row ++;
			}
		}
		
		printctrl.PrintEx(13,27,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",11));
		
		printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ʊ��" +��oneTok(infoStr,"|",12)); //����Ա
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�տ"); //�տ�Ա 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ˣ�");
		/*liujian 2012-3-24 9:36:20 ��Ʊ�Ż� end */
		
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
<FORM method=post name="spubPrint">
<!------------------------------------------------------>

    <BODY  onload="doPrint()">
          
    </BODY>
    
</FORM>
<!-------�����ӡ�ؼ�---------->
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
		codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</HTML>    
