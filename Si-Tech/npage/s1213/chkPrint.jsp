<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!-------------------------------------------->
<!---����: 2003-10-23 ---->
<!---����: sunzhe ---->
<!---����: fPubSimpSel.jsp ---->
<!---���ܣ� ��ӡȷ�Ͻ��� ---->
<!---�޸ģ� ---->


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
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>
<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<%
    String work_no = (String) session.getAttribute("workNo");
    request.setCharacterEncoding("gb2312");
    String retInfo = request.getParameter("retInfo");
    String dirtPage = request.getParameter("dirtPage");
    
	//Billing�ṩȡ���������
	java.util.Random r = new java.util.Random();
	int key = 99999;
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int realKey = ran ^ key;
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== ���ȡrealKey = " + realKey);
	String phone = request.getParameter("activePhone");
	String accept = request.getParameter("accept");
	String opCode = request.getParameter("opCode");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String sqlIdNo ="select id_no from dcustmsg where phone_no ='"+phone+"'";
	String idNo="";
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sqlIdNo = " + sqlIdNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeIdNo" retmsg="retMsgIdNo">
		<wtc:sql><%=sqlIdNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultIdNo" scope="end"/>
<%
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sPubSelect retCodeIdNo = " + retCodeIdNo);
	if(retCodeIdNo.equals("000000") && resultIdNo.length > 0){
		idNo=resultIdNo[0][0];
  }else {
	}
%>
<SCRIPT type=text/javascript>

function doPrint()
{
  var infoStr = "<%=retInfo%>";
	var inDbPacket = new AJAXPacket("/npage/innet/pubBillPrint_ajaxInDb.jsp","���ڽ��з�Ʊ��⣬���Ժ�......");
	inDbPacket.data.add("inParams0", "<%=realKey%>");							//�����
	inDbPacket.data.add("inParams1", "<%=accept%>");					//ҵ����ˮ
	inDbPacket.data.add("inParams2", "<%=opCode%>");								//opCode
	inDbPacket.data.add("inParams3", "<%=work_no%>");								//����
	inDbPacket.data.add("inParams4", oneTok(infoStr, "|", 2) + oneTok(infoStr, "|", 3) + oneTok(infoStr, "|", 4));	//������
	inDbPacket.data.add("inParams5", "<%=phone%>");		//�ƶ�����
	inDbPacket.data.add("inParams6", "<%=idNo%>");									//�û�idNo
	inDbPacket.data.add("inParams7", "0");		//�෢Ʊ���
	<%
	System.out.println("==== " + retInfo);
		for (int j = 1;j <= (retInfo.split("\\|").length); j ++) {
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j = " + j);
		%>
			inDbPacket.data.add("inParams<%=7+j%>", oneTok(infoStr, "|", <%=j%>));
		<%
		}
	%>
	inDbPacket.data.add("inParamsNo", "<%=retInfo.split("\\|").length + 8%>");
	core.ajax.sendPacket(inDbPacket, printIt);
	inDbPacket = null;
}


var successNo = 0;
function printIt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retCode != "000000" && retCode != "0") {
		alert("s1300PrintInDB��Ʊ���ʧ�ܣ�"+retCode+"��"+retMsg+"������ϵ����Ա�Ϳ�����Ա��");
		window.close();
		return false;
	} else {
		successNo ++;
	}
	
	if (successNo != 1) {
		return false;
	} else {
    var infoStr = "<%=retInfo%>";

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
		/*liujian 2013-3-7 9:00:35 ��ӡ��Ʊlogo�ͷ�Ʊ���� end*/
		
		/*liujian 2012-3-26 15:45:36 ��Ʊ�޸� begin */
		//              ��       ��               �����С              �����ϸ
		var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ʵ�ͨ��ҵ");
		printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "���η�Ʊ���룺<%=bill_number%>");
		
		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "��α�룺<%=ran%>");	//��Ʊ��α��
		
		printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�");//����
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"������ˮ��");//��ˮ
		printctrl.PrintEx(100,rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"ҵ�����ƣ�");//ҵ������
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͻ����ƣ�" + oneTok(infoStr, "|", 7));//�û�����
		printctrl.PrintEx(100,rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��    �ţ�");//����
		
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "�ֻ����룺" + oneTok(infoStr, "|", 5));//�ƶ�����
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Э����룺" + oneTok(infoStr, "|", 6));//Э�����
		printctrl.PrintEx(100,rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"֧Ʊ���룺");//֧Ʊ����
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ϼƽ�(��д)" + chineseNumber(oneTok(infoStr, "|", 10)));//�ϼƽ��(��д)
		printctrl.PrintEx(100,rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(Сд)��" + oneTok(infoStr, "|", 10));//���(Сд)
		
		printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(��Ŀ)");//��Ŀ
		
		var busiStr = oneTok(infoStr, "|", 11);
		var row = 0;
		for(var i=0;i<getTokNums(busiStr,"~");i++) {
			if (i % 2 == 0) {
				printctrl.PrintEx(20,rowInit + 9 + row,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
			} else if (i % 2 == 1) {
				printctrl.PrintEx(100,rowInit + 9 + row,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
				row ++;
			}
		}
		printctrl.PrintEx(20,rowInit + 15,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr, "|", 8));  //��ϵ��ַ
		
		printctrl.PrintEx(20,rowInit + 16,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr, "|", 9));  //���ʽ
		
		printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ʊ��<%=work_no%>"); //����Ա
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�տ<%=work_no%>");//�տ�Ա 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ˣ�");
		/*liujian 2012-3-26 15:45:36 ��Ʊ�޸� end */
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
        location = "<%=dirtPage%>?activePhone=<%=phone%>";
    }
  }
}

function oneTok(str, tok, loc)
{

    var temStr = str;
    if (str.charAt(0) == tok) temStr = str.substring(1, str.length);
    if (str.charAt(str.length - 1) == tok) temStr = temStr.substring(0, temStr.length - 1);

    var temLoc;
    var temLen;
    for (ii = 0; ii < loc - 1; ii++)
    {
        temLen = temStr.length;
        temLoc = temStr.indexOf(tok);
        temStr = temStr.substring(temLoc + 1, temLen);
    }
    if (temStr.indexOf(tok) == -1)
        return temStr;
    else
        return temStr.substring(0, temStr.indexOf(tok));
}

function chineseNumber(num)
{
    if (parseFloat(num) <= 0.01) return "��Բ��"
    if (isNaN(num) || num > Math.pow(10, 12)) return ""
    var cn = "��Ҽ��������½��ƾ�"
    var unit = new Array("ʰ��Ǫ", "�ֽ�")
    var unit1 = new Array("����", "")
    var numArray = num.toString().split(".")
    var start = new Array(numArray[0].length - 1, 2)

    function toChinese(num, index)
    {
        var num = num.replace(/\d/g, function ($1)
        {
            return cn.charAt($1) + unit[index].charAt(start-- % 4 ? start % 4 : -1)
        })
        return num
    }

    for (var i = 0; i < numArray.length; i++)
    {
        var tmp = ""
        for (var j = 0; j * 4 < numArray[i].length; j++)
        {
            var strIndex = numArray[i].length - (j + 1) * 4
            var str = numArray[i].substring(strIndex, strIndex + 4)
            var start = i ? 2 : str.length - 1
            var tmp1 = toChinese(str, i)
            tmp1 = tmp1.replace(/(��.)+/g, "��").replace(/��+$/, "")
            tmp1 = tmp1.replace(/^Ҽʰ/, "ʰ")
            tmp = (tmp1 + unit1[i].charAt(j - 1)) + tmp
        }
        numArray[i] = tmp
    }

    numArray[1] = numArray[1] ? numArray[1] : ""
    numArray[0] = numArray[0] ? numArray[0] + "Բ" : numArray[0],numArray[1] = numArray[1].replace(/^��+/, "")
    numArray[1] = numArray[1].match(/��/) ? numArray[1] : numArray[1] + "��"
    return numArray[0] + numArray[1]
}


  function getTokNums(str,tok)
{
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
</SCRIPT>
<!--**************************************************************************************-->
<FORM method=post name="spubPrint">
    <!------------------------------------------------------>
    <BODY onload="doPrint()">

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
