function getInfoFromCode(flag,code){
  var info ;
  switch(flag){
    case "acntStat"://�û�ʹ��״̬
	    if (code == "1")
		   info = "��Ч";
	    else if (code == "2")
		   info = "������";
		else if (code == "3")
		   info = "ͷ��ʹ��";
		else if (code == "4")
		   info = "��ʧ";
		else if (code == "5")
		   info = "HLR����";
	    else if (code == "6")
		   info = "����";
		else if (code == "7")
		   info = "ͷ��ʹ�ù�ʧ";
		else if (code == "8")
		   info = "��������ʧ";
		else if (code == "9")
		   info = "��������";
	    break;
     case "ctFlg"://���в���־
	    if (code == "0")
		   info = "�����";
	    else if (code == "1")
		   info = "�������";
		else if (code == "2")
		   info = "�������";
	    break; 	
     case "cmFlg"://�������α�־
	    if (code == "0")
		   info = "������";
	    else if (code == "1")
		   info = "����";
	    break;
     case "ciFlg"://���������־
	    if (code == "0")
		   info = "������";
	    else if (code == "1")
		   info = "����";
	    break; 
    case "colmtFlg"://��������״̬
	    if (code == "0")
		   info = "������";
	    else if (code == "1")
		   info = "��������";
		else if (code == "2")
		   info = "���ƹ��ں͹��ʳ�;";
		else if (code == "3")
		   info = "�����ƹ��ʳ�;";
	    break;
    case "crdFlg"://��ֵ��״̬
	    if (code == "0")
		   info = "��Ч";
	    else if (code == "1")
		   info = "��ʹ";
		else if (code == "2")
		   info = "����";
		else if (code == "3")
		   info = "����";
		else if (code == "4")
		   info = "���״̬";
	    break;
    case "tradeType"://��ֵ��ʽ
	    if (code == "1")
		   info = "Ԥ�����ֻ���ֵ";
	    else if (code == "2")
		   info = "�̶��绰��ֵ";
		else if (code == "3")
		   info = "��Ԥ�����ֻ���ֵ";
		else if (code == "4")
		   info = "�ֹ���ֵ";
		else if (code == "5")
		   info = "Ԥ�����ֻ���س�ֵ";
		else if (code == "6")
		   info = "Ԥ��ֵ";
		else if (code == "A")
		   info = "PPIP�绰��ֵ";
		else if (code == "B")
		   info = "PPIP�ֹ���ֵ";
	    break;
    case "subState"://ҵ���û�״̬
	    if (code == "0")
		   info = "δ����";
	    else if (code == "1")
		   info = "����";
		else if (code == "2")
		   info = "��Ԥ�����ֻ���ֵ";
		else if (code == "3")
		   info = "����δ��ɣ����ݼ��ص�SMP";
		else if (code == "4")
		   info = "����δ��ɣ��Ѽ��ص�SCP";
	    break;

  }
  return info;
}
//�ֽ��ַ���
function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

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
  //��ʱ���ư�ť�Ŀ�����
  var subButt2;
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }